from fastapi import APIRouter,Depends , HTTPException, status
from typing import Annotated
from sqlalchemy.orm import Session

from core import security
from schema.predict_schema import LoanPredictionData ,UserPredictSchema ,UserEditPredictSchema
from model_predict.one_model_predict import predict_loan_approval
from core.database import get_db
from core.model import UserPredict



router = APIRouter(
    prefix="/predict",
    tags=["Predict"],
    responses={404: {"description": "Not found"}},
)

router_token = APIRouter(
    prefix="/predict",
    tags=["Predict"],
    responses={404: {"description": "Not found"}},
    dependencies=[Depends(security.oauth2_scheme), Depends(security.get_current_user)]
)


@router_token.get('/add-get-predict')
def get_data_predict(db: Session = Depends(get_db)):
    data = db.query(UserPredict).all()
    return data

@router_token.post('/add-data-predict')
def add_data_predict(data: UserPredictSchema , db: Session = Depends(get_db)):

    new_user = UserPredict(**data.dict())
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "Data added successfully."}

@router_token.put('/update-data-predict')
def update_data_predict(data: UserEditPredictSchema , db: Session = Depends(get_db)):
    user = db.query(UserPredict).filter(UserPredict.id == data.id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found.")
    
    user.name = data.name
    user.age = data.age
    user.pregnancies = data.pregnancies
    user.glucose = data.glucose
    user.bloodPressure = data.bloodPressure
    user.skinthickness = data.skinthickness
    user.insulin = data.insulin
    user.diabetespedigreefunction = data.diabetespedigreefunction
    user.bmi = data.bmi
    
    # Commit changes to the database
    db.commit()
    db.refresh(user)
    
    return {"message": "Data updated successfully."}


@router_token.delete('/delete-data-predict')
def delete_data_predict(id: int, db: Session = Depends(get_db)):
    user = db.query(UserPredict).filter(UserPredict.id == id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found.")
    db.delete(user)
    db.commit()
    return {"message": "Data deleted successfully."}
    

    
@router_token.post('/one-predict')
def get_one_predict(data: LoanPredictionData):
    print(data)
    prediction = predict_loan_approval(data.pregnancies, data.glucose, data.bloodPressure, data.skinthickness, data.insulin, data.diabetespedigreefunction, data.bmi, data.age)
    return {"result": prediction}
    
    
@router_token.get('/one-predict')
def get_all_predict(id:int , db: Session = Depends(get_db)):
    data = db.query(UserPredict).filter(UserPredict.id == id).first()
    return data
    
@router_token.get('/all-predict')
def get_all_predict(db: Session = Depends(get_db)):
    data = db.query(UserPredict).all()
    predictions = []
    for predict in data:
        # Convert categorical variables to numerical values


        # Predict loan approval
        prediction = predict_loan_approval(predict.pregnancies, predict.glucose, predict.bloodPressure, predict.skinthickness, predict.insulin, predict.diabetespedigreefunction, predict.bmi, predict.age)
        
        predictions.append({"id": predict.id,
                            "name" :predict.name,
                            "age": predict.age,
                            "pregnancies": predict.pregnancies,
                            "glucose": predict.glucose,
                            "bloodPressure": predict.bloodPressure,
                            "skinthickness": predict.skinthickness,
                            "insulin": predict.insulin,
                            "diabetespedigreefunction": predict.diabetespedigreefunction,
                            "bmi": predict.bmi,
                            "predict": prediction
                            })

    return  predictions

            