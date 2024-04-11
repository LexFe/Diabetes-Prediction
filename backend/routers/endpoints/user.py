from fastapi import APIRouter,Depends, Header
from fastapi.responses import JSONResponse ,HTMLResponse
from sqlalchemy.orm import Session 
from typing import Annotated 

from core import security
from core.model import User 
from core.database import get_db
from schema.user_schema import UserCreate ,UserActive ,UserEdit
from service.user_service import create_user_account
from response.user_response import UserOut , LoginResponse ,UserOutList 
from service.user_service import get_refredh_token ,active_user_account ,RoleChecker
from util.hash import hash_password


router = APIRouter(
    prefix="/user",
    tags=["User"],
    responses={404: {"description": "Not found"}},
)

router_token = APIRouter(
    prefix="/user",
    tags=["User"],
    responses={404: {"description": "Not found"}},
    dependencies=[Depends(security.oauth2_scheme), Depends(security.get_current_user)]
)

@router.post('/create-user', response_model= UserOut ,status_code=200)
async def create_user(data :UserCreate, db: Session = Depends(get_db)):
    return await create_user_account(data, db)

# @router.post('/active-user',response_model=UserOut)
# async def active_user(data :UserActive, db: Session = Depends(get_db)):
#     await active_user_account(data, db)
#     return JSONResponse({"message": "Account is activated successfully."})

# @router.get('/refrech' , response_model=LoginResponse,status_code=200)
# async def refrech_token(refresh_token =  Header(), db: Session = Depends(get_db)) :
#     return  await get_refredh_token(refresh_token, db)


# @router.get("/all", response_model=UserOutList, status_code=200)
# def get_data(db: Session = Depends(get_db), _: bool = Depends(RoleChecker(allowed_roles=["admin"]))):
#     users = db.query(User).all()
#     data = []
#     for user in users:
#         user_out = UserOut(
#             id=user.id,
#             name=user.name,
#             phone=user.phone,
#             role=user.role,
#             email=user.email,
#         )
#         data.append(user_out)
#     return UserOutList(data=data)

@router.get("/all")
def get_data(db: Session = Depends(get_db)):
    users = db.query(User).all()
    data = []
    for user in users:
        user_out = UserOut(
            id=user.id,
            name=user.name,
            phone=user.phone,
            role=user.role,
            email=user.email,
        )
        data.append(user_out)

    return data

@router.put("/update", response_model=UserOut, status_code=200)
def update_user(data: UserEdit, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == data.id).first()
    if not user:
        raise HTMLResponse(status_code=404, content="User not found.")
    user.name = data.name if data.name else user.name
    user.phone = data.phone if data.phone else user.phone
    user.email = data.email if data.email else user.email
    user.role = data.role if data.role else user.role
    user.password = hash_password(data.password) if data.password else user.password
    db.commit()
    db.refresh(user)
    return user

@router.delete("/delete", status_code=200)
def delete_user(id: str, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == id).first()
    db.delete(user)
    db.commit()
    return JSONResponse({"message": "User deleted successfully."})

