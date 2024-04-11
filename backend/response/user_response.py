from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional , List

class UserOut(BaseModel):
    id :int
    name : str
    phone : str
    email: EmailStr

    class Config:
        orm_mode = True
        
        
class UserOutList(BaseModel):
    data : List[UserOut]
        
class LoginResponse(BaseModel):
    access_token: str
    refresh_token: str
    expires_in: int
    token_type: str = "Bearer"