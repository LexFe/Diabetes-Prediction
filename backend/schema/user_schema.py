from typing import List, Optional
from pydantic import BaseModel, EmailStr
from typing import Optional, Union
from datetime import datetime
from fastapi import Form


class Token(BaseModel):
    access_token: str
    token_type: str

    
class TokenData(BaseModel):
    id: Optional[int] = None


class UserCreate(BaseModel):
    name: str
    phone: str
    email: EmailStr
    password: str

class UserEdit(BaseModel):
    id: int
    name: str
    phone: str
    email: EmailStr
    password: str
    
        
class UserUpdate(BaseModel):
    email: EmailStr
    password: str
    

class UserActive(BaseModel):
    token : str
    email: EmailStr
    
class UserLogin(BaseModel):
    email: EmailStr
    password: str
    



    
    
    
    
    
    
    
    