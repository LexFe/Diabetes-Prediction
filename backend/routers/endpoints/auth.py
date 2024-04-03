from fastapi import APIRouter ,Depends ,HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from typing import Annotated
from sqlalchemy.orm import Session
from core.database import get_db
from schema import auth_schema ,user_schema
from service import user_service



router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
    responses={404: {"description": "Not found"}},
)

@router.post('', response_model=auth_schema.Token ,status_code=200) 
async def login_for_access_token(data: Annotated[OAuth2PasswordRequestForm, Depends()], db: Session = Depends(get_db)):
    return await user_service.get_login_token(data, db)
    