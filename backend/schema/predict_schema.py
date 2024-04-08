from pydantic import BaseModel

class LoanPredictionData(BaseModel):
    age: int
    pregnancies : int
    glucose: int
    bloodPressure : int
    skinthickness : int
    insulin : int
    diabetespedigreefunction : float
    bmi : float


class UserPredictSchema(BaseModel):
    name: str
    age: int
    pregnancies : int
    glucose: int
    bloodPressure : int
    skinthickness : int
    insulin : int
    diabetespedigreefunction : float
    bmi : float
    
    
class UserEditPredictSchema(BaseModel):
    id: int
    name: str
    age: int
    pregnancies : int
    glucose: int
    bloodPressure : int
    skinthickness : int
    insulin : int
    diabetespedigreefunction : float
    bmi : float