from sqlalchemy import Column, Integer, Boolean, ForeignKey,NVARCHAR , DateTime , func ,Float
from datetime import datetime
from sqlalchemy.orm import mapped_column, relationship

from core.database import Base


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(NVARCHAR(150))
    role = Column(NVARCHAR(50), nullable=True, default="user")
    email = Column(NVARCHAR(255), unique=True, index=True)
    password = Column(NVARCHAR(100))
    phone = Column(NVARCHAR(12),nullable=True)
    is_active = Column(Boolean, default=False)
    updated_at = Column(NVARCHAR(255), nullable=True, default=None, onupdate=datetime.now)
    created_at = Column(NVARCHAR(255), nullable=False, server_default=func.now())
    
    tokens = relationship("UserToken", backref="user")

    def get_context_string(self, context: str):
        return f"{context}{self.password[-6:]}{datetime.utcnow().strftime('%m%d%Y%H%M%S')}".strip()
    


class UserToken(Base):
    __tablename__ = "user_tokens"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = mapped_column(ForeignKey('users.id'))
    access_key = Column(NVARCHAR(250), nullable=True, index=True, default=None)
    refresh_key = Column(NVARCHAR(250), nullable=True, index=True, default=None)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    expires_at = Column(DateTime, nullable=False)
    
class UserPredict (Base):
    __tablename__ = "user_predict"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(NVARCHAR(150) , nullable=False)
    phone = Column(NVARCHAR(12),nullable=True)
    age = Column(Integer, nullable=False)
    gender = Column(Integer, nullable=False)
    married = Column(Integer, nullable=False)
    dependents = Column(Float, nullable=False)
    education = Column(Integer, nullable=False)
    self_employed = Column(Integer, nullable=False)
    applicant_income = Column(Integer, nullable=False)
    coapplicant_income = Column(Integer, nullable=False)
    loan_amount = Column(Float, nullable=False)
    loan_amount_term = Column(Float, nullable=False)
    credit_history = Column(Float, nullable=False)
    property_area = Column(Integer, nullable=False)