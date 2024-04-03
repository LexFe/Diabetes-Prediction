from pydantic import BaseModel

class LoanPredictionData(BaseModel):
    gender: str
    married: str
    dependents: int
    education: str
    self_employed: str
    applicant_income: int
    coapplicant_income: int
    loan_amount: float
    loan_amount_term: float
    credit_history: str
    property_area: str

class UserPredictSchema(BaseModel):
    name: str
    phone: str
    age: int
    gender: str
    married: str
    dependents: float
    education: str
    self_employed: str
    applicant_income: int
    coapplicant_income: int
    loan_amount: float
    loan_amount_term: float
    credit_history: str
    property_area: str
    
class UserEditPredictSchema(BaseModel):
    id: int
    name: str
    phone: str
    age: int
    gender: str
    married: str
    dependents: float
    education: str
    self_employed: str
    applicant_income: int
    coapplicant_income: int
    loan_amount: float
    loan_amount_term: float
    credit_history: str
    property_area: str