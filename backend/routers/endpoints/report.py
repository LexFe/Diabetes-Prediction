from fastapi import APIRouter,Depends, Header
from fastapi.responses import JSONResponse ,HTMLResponse
from sqlalchemy.orm import Session 
from typing import List, Dict, Any
from sqlalchemy import func

from core import security
from core.model import User , UserPredict
from core.database import get_db
from schema.user_schema import UserCreate ,UserActive ,UserEdit
from service.user_service import create_user_account
from response.user_response import UserOut , LoginResponse ,UserOutList 
from service.user_service import get_refredh_token ,active_user_account ,RoleChecker
from util.hash import hash_password
from model_predict.one_model_predict import predict_loan_approval



router = APIRouter(
    prefix="/report",
    tags=["Report"],
    responses={404: {"description": "Not found"}},
)

router_token = APIRouter(
    prefix="/user",
    tags=["User"],
    responses={404: {"description": "Not found"}},
    dependencies=[Depends(security.oauth2_scheme), Depends(security.get_current_user)]
)

@router.get('/employee', )
def create_user(db: Session = Depends(get_db)):
    id_count = db.query(User).count()
    return id_count

@router.get('/user', )
def create_user(db: Session = Depends(get_db)):
    id_count = db.query(UserPredict).count()
    return id_count

@router.get('/education', )
def create_user(db: Session = Depends(get_db)):
    zero_count = db.query(UserPredict).filter(UserPredict.education == '1').count()
    return zero_count

@router.get('/age')
def create_user(db: Session = Depends(get_db)) -> Dict[str, List[Any]]:
    results = db.query(UserPredict.age, func.count(UserPredict.age)).group_by(UserPredict.age).all()
    
    age_list = [result[0] for result in results]
    count_list = [result[1] for result in results]
    
    output = {"age": age_list, "count": count_list}
    
    return output

@router.get('/predict')
def create_user(db: Session = Depends(get_db)):
    data = db.query(UserPredict).all()
    predictions = {"Rejected": 0, "Approved": 0}

    for predict in data:


        # Predict loan approval
        prediction = predict_loan_approval(predict.gender, predict.married, predict.dependents, predict.education, predict.self_employed,
                                           predict.applicant_income, predict.coapplicant_income,
                                           predict.loan_amount, predict.loan_amount_term,
                                           predict.credit_history, predict.property_area)
        if prediction == "Approved":
            predictions["Approved"] += 1
        else:
            predictions["Rejected"] += 1

    # Format the result
    result = {
        "series": [predictions["Rejected"], predictions["Approved"]],
        "labels": ["ບໍ່ອະນຸຍາດ", "ອະນຸຍາດ"]
    }

    return result



