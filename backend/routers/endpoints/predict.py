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
    # Convert integer values back to their respective strings
    converted_data = []
    for item in data:
        item_dict = item.__dict__
        item_dict['gender'] = 'ຊາຍ' if item_dict['gender'] == 1 else 'ຍິງ'
        item_dict['married'] = 'ແຕ່ງດອງແລ້ວ' if item_dict['married'] == 1 else 'ບໍ່ແຕ່ງດອງ'
        item_dict['education'] = 'ບໍ່ຈົບ' if item_dict['education'] == 1 else 'ຈົບ'
        item_dict['self_employed'] = 'ມີ' if item_dict['self_employed'] == 1 else 'ບໍ່ມີ'
        item_dict['credit_history'] = 'ດີ' if item_dict['credit_history'] == 1 else 'ບໍ່ດີ'
        item_dict['property_area'] = 'ໃນຕົວເມືອງ' if item_dict['property_area'] == 1 else ('ໃກ້ຕົວເມືອງ' if item_dict['property_area'] == 2 else 'ຊົນນະບົດ')
        
        converted_data.append(item_dict)
    return converted_data

@router_token.post('/add-data-predict')
def add_data_predict(data: UserPredictSchema , db: Session = Depends(get_db)):
    
    gender = 1 if data.gender == 'ຊາຍ' else 0
    married = 1 if data.married == 'ແຕ່ງດອງແລ້ວ' else 0
    education = 1 if data.education == 'ບໍ່ຈົບ' else 0
    self_employed = 1 if data.self_employed == 'ມີ' else 0
    credit_history = 1 if data.credit_history == 'ດີ' else 0
    property_area = 2 if data.property_area == 'ໃນຕົວເມືອງ' else (2 if data.property_area == 'ໃກ້ຕົວເມືອງ' else 0)
    data.gender = gender
    data.married = married
    data.education = education
    data.self_employed = self_employed
    data.property_area = property_area
    data.credit_history = credit_history
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
    user.phone = data.phone
    user.age = data.age
    user.gender = 1 if data.gender == 'ຊາຍ' else 0
    user.married = 1 if data.married == 'ແຕ່ງດອງແລ້ວ' else 0
    user.education = 1 if data.education == 'ບໍ່ບໍ່ຈົບ' else 0
    user.self_employed = 1 if data.self_employed == 'ມີ' else 0
    user.credit_history = 1 if data.credit_history == 'ດີ' else 0
    user.property_area = 2 if data.property_area == 'ໃນຕົວເມືອງ' else (2 if data.property_area == 'ໃກ້ຕົວເມືອງ' else 0)
    user.applicant_income = data.applicant_income
    user.coapplicant_income = data.coapplicant_income
    user.loan_amount = data.loan_amount
    user.loan_amount_term = data.loan_amount_term
    
    
    
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
    gender = 1 if data.gender == 'ຊາຍ' else 0
    married = 1 if data.married == 'ແຕ່ງດອງແລ້ວ' else 0
    dependents = data.dependents
    education =  1 if data.education == 'ບໍ່ບໍ່ຈົບ' else 0
    self_employed =  1 if data.self_employed == 'ມີ' else 0
    applicant_income = data.applicant_income
    coapplicant_income = data.coapplicant_income
    loan_amount = data.loan_amount
    loan_amount_term = data.loan_amount_term
    credit_history = 1 if data.credit_history == 'ດີ' else 0
    property_area = 2 if data.property_area == 'ໃນຕົວເມືອງ' else (2 if data.property_area == 'ໃກ້ຕົວເມືອງ' else 0)

    prediction = predict_loan_approval(gender,married, dependents,education, self_employed,
                                            applicant_income, coapplicant_income, loan_amount, loan_amount_term,
                                            credit_history, property_area)
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
        prediction = predict_loan_approval(predict.gender, predict.married, predict.dependents, predict.education, predict.self_employed,
                                           predict.applicant_income, predict.coapplicant_income,
                                           predict.loan_amount, predict.loan_amount_term,
                                           predict.credit_history, predict.property_area)
        
        gender = 'ຊາຍ' if predict.gender == 1 else 'ຍິງ'
        married = 'ແຕ່ງດອງແລ້ວ' if predict.married == 1 else 'ບໍ່ແຕ່ງດອງ'
        education = 'ບໍ່ຈົບ' if predict.education == 1 else 'ຈົບ'
        self_employed = 'ມີ' if predict.self_employed == 1 else 'ບໍ່ມີ'
        property_area = 'ໃນຕົວເມືອງ' if predict.property_area == 1 else ('ໃກ້ຕົວເມືອງ' if predict.property_area == 2 else 'ຊົນນະບົດ')
        credit_history = 'ດີ' if predict.credit_history == 1 else 'ບໍ່ດີ'
        prediction = 'ອະນຸຍາດ' if prediction == 'Approved' else 'ບໍ່ອະນຸຍາດ'
        
        predictions.append({"id": predict.id,
                            "name" :predict.name,
                            "gender" : gender,
                            "age" : predict.age ,
                            "phone": predict.phone,
                            "married": married,
                            "education": education,
                            "self_employed": self_employed,
                            "applicant_income": predict.applicant_income,
                            "coapplicant_income": predict.coapplicant_income,
                            "loan_amount": predict.loan_amount,
                            "loan_amount_term": predict.loan_amount_term,
                            "credit_history": credit_history,
                            "property_area": property_area,
                            "prediction": prediction})

    return  predictions

            