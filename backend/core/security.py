from jose import JWTError, jwt
from datetime import datetime, timedelta
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from typing import Annotated
from fastapi import Depends, status, HTTPException
import base64
import logging

from core import database , model
from schema import user_schema 
from core.model import User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl = "auth")

SECRET_KEY = "zta$s!s75ug0$rf(1zd2)z2ospv-ekjpvh6dyp1*5*)524#zse"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 900000


async def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes = ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM )
    return encoded_jwt


def verify_access_token(token :str ,credentials_expeption):
    try:
        payload = jwt.decode(token , SECRET_KEY , algorithms =ALGORITHM )
        id: str = payload.get("sub")
        id =  str_decode(id)
        if id is None:
            raise credentials_expeption
        token_data = user_schema.TokenData(id = id)
    except JWTError as jwt_exec:
        print(f"JWT Error: {str(jwt_exec)}")
        return credentials_expeption
    return token_data

def get_token_payload(token: str, secret: str, algo: str):
    try:
        payload = jwt.decode(token, secret, algorithms=algo)
    except Exception as jwt_exec:
        payload = None
    return payload


async def load_user(email: str, db):
    from schema.user_schema import UserLogin
    try:
        user = db.query(UserLogin).filter(UserLogin.email == email).first()
    except Exception as user_exec:
        logging.info(f"User Not Found, Email: {email}")
        user = None
    return user




def get_current_user(token:str = Depends(oauth2_scheme), db : Session = Depends(database.get_db)):
    credentials_exception = HTTPException(
        status_code = status.HTTP_401_UNAUTHORIZED,
        detail = "Could not validate credentials",
        headers = {"WWW-Authenticate": "Bearer"},
    )
    try:
        token = verify_access_token(token, credentials_exception)
        user = db.query(model.User).filter(model.User.id == token.id).first()
        return user
    except Exception as e:
        print(e)
        raise credentials_exception from e
    
async def get_current_active_user(current_user: Annotated[User, Depends(get_current_user)]):
    if current_user.disabled:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user

def str_encode(string: str) -> str:
    return base64.b85encode(string.encode('ascii')).decode('ascii')


def str_decode(string: str) -> str:
    return base64.b85decode(string.encode('ascii')).decode('ascii')

def generate_token(payload: dict, secret: str, algo: str, expiry: timedelta):
    expire = datetime.utcnow() + expiry
    payload.update({"exp": expire})
    return jwt.encode(payload, secret, algorithm=algo)



def is_password_strong_enough(password: str) -> bool:
    if len(password) < 6:
        return False
    return True