from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional , List



class Token(BaseModel):
    access_token: str
    refresh_token : str
    token_type: str
    role : str
    

class LoginResponse(BaseModel):
    access_token: str
    refresh_token: str
    expires_in: int
    token_type: str = "Bearer"
    

    

class UserOut(BaseModel):
    id: int
    email: EmailStr
    created_at: datetime
    
    
    class Config:
        orm_mode = True
        
class UserPassword(BaseModel):
    password: str
    user :List[UserOut] = []
    
    class Config:
        orm_mode = True
        
class UserLogin (BaseModel):
    email: EmailStr
    password: str