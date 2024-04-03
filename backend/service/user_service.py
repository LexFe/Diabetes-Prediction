from fastapi import HTTPException , status ,Depends
from datetime import datetime ,timedelta
from typing import Annotated
import logging


from util.email_context import FORGOT_PASSWORD, USER_VERIFY_ACCOUNT
from core.security import  is_password_strong_enough , str_encode , str_decode , generate_token , get_token_payload , load_user , get_current_user
from util.hash import hash_password , verify
from core.model import User ,UserToken
from util.string import unique_string


SECRET_KEY = "zta$s!s75ug0$rf(1zd2)z2ospv-ekjpvh6dyp1*5*)524#zse"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_MINUTES = 30

async def create_user_account(data, session):
    
    user_exist = session.query(User).filter(User.email == data.email).first()
    
    if user_exist:
        raise HTTPException(status_code=400, detail="Email is already exists.")
    
    if not is_password_strong_enough(data.password):
        raise HTTPException(status_code=400, detail="Please provide a strong password.")
    
    user = User()
    user.name = data.name
    user.email = data.email
    user.password = hash_password(data.password)
    user.role =  data.role
    user.phone = data.phone
    user.is_active = True
    user.updated_at = datetime.utcnow()
    session.add(user)
    session.commit()
    session.refresh(user)
    
    return user


async def active_user_account(data,session):
    
    user = session.query(User).filter(User.email == data.email).first()
    
    if not user :
        raise HTTPException(status_code= 400,detail= "This link is not valid.")
    
    user_token = user.get_context_string(context=USER_VERIFY_ACCOUNT)

    print(data.token)
    print(user_token)
    try:
        token_valid = verify(user_token, data.token)
        print(token_valid)
    except Exception as verify_exec:
        logging.exception(verify_exec)
        token_valid = False
        
    if not token_valid:
        raise HTTPException(status_code=400, detail="This link either expired or not valid.")
    
    user.is_active = True
    user.verified_at = datetime.utcnow().strftime('%m%d%Y%H%M%S')
    user.updated_at = datetime.utcnow().strftime('%m%d%Y%H%M%S')
    
    session.add(user)
    session.commit()
    session.refresh(user)
    
    return user

async def get_login_token(data,session):
    
    
    user = session.query(User).filter(User.email == data.username).first()
    
    if not user:
        raise HTTPException(status_code=400, detail="Invalid credentials")
    if not verify(data.password, user.password):
        raise HTTPException(status_code=400, detail="Invalid credentials")
    # if not user.is_active:
    #     raise HTTPException(status_code=400, detail="User not active")
    # if user.verified_at:
    #     raise HTTPException(status_code=400, detail="User not verified")
    
    return _generate_tokens(user, session)

async def get_refredh_token(refrech_token,session):
    # try:
    token_payload = get_token_payload(refrech_token , SECRET_KEY, ALGORITHM)
    if not token_payload:
        raise HTTPException(status_code=400, detail="Invalid refresh token")
            
    refrech_key = token_payload.get("t")
    access_key = token_payload.get("a")
    user_id = str_decode(token_payload.get("sub"))
    
    user_token = session.query(UserToken).filter(UserToken.refresh_key == refrech_key, UserToken.access_key == access_key, UserToken.user_id == user_id ,UserToken.expires_at > datetime.utcnow()).first()
    
    if not user_token:
        raise HTTPException(status_code=400, detail="Invalid refresh token")
            
    user_token.expires_at = datetime.utcnow()
    session.add(user_token)
    session.commit()
    return _generate_tokens(user_token.user, session)
            
      
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=400, detail="Invalid refresh token 3")
   
async def reset_user_password(data,session):
    user = await load_user (data.email, session)
    if not user.verified_at():
        raise HTTPException(status_code=400, detail="Your account is not verified. Please check your email inbox to verify your account.")
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Your account has been dactivated. Please contact support.")
    
    


def _generate_tokens(user, session):
    refresh_key = unique_string(100)
    access_key = unique_string(50)
    
    rt_expires = timedelta(days= REFRESH_TOKEN_EXPIRE_MINUTES)
    
    user_token = UserToken()
    user_token.user_id = user.id
    user_token.access_key = access_key
    user_token.refresh_key = refresh_key
    user_token.expires_at = datetime.utcnow() + rt_expires
    
    session.add(user_token)
    session.commit()
    session.refresh(user_token)
    
    at_payload = {
        "sub" : str_encode(str(user.id)),
        'p' : str_encode(str(user.role)),
        'a': access_key,
        'r': str_encode(str(user_token.id)),
        'n': str_encode(f"{user.name}")
     }
    
    at_expire = timedelta(days= ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = generate_token(at_payload , SECRET_KEY,ALGORITHM,at_expire)
    
    rt_payload = {"sub": str_encode(str(user.id)),'p' : str_encode(str(user.role)), "t": refresh_key, "a": access_key}
    refresh_token = generate_token(rt_payload, SECRET_KEY, ALGORITHM, rt_expires)
    
    return {"access_token": access_token, "token_type": "bearer", "refresh_token": refresh_token, "expires_in":  at_expire.seconds ,"role" : user.role }

async def get_current_active_user(
    current_user: Annotated[User, Depends( get_current_user)]
):
    if current_user.is_active == False:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user

class RoleChecker:
  def __init__(self, allowed_roles):
    self.allowed_roles = allowed_roles

  def __call__(self, user: Annotated[User, Depends(get_current_active_user)]):
    if user.role in self.allowed_roles:
      return True
    raise HTTPException(
status_code=status.HTTP_401_UNAUTHORIZED, 
detail="You don't have enough permissions")