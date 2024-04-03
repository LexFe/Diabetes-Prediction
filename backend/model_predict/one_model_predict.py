import pickle
import numpy as np
import warnings

warnings.filterwarnings("ignore", message="Trying to unpickle estimator.*")

def predict_loan_approval(gender : int, married : int, dependents:int, education:int, self_employed:int,
                          applicant_income : int, coapplicant_income : int, loan_amount :int , loan_amount_term : int,
                          credit_history:int, property_area :int):
    with open('model_predict\\random_forest.pkl', 'rb') as f:
        model = pickle.load(f)

    new_data = np.array([[gender, married, dependents, education, self_employed,
                           applicant_income, coapplicant_income, loan_amount, loan_amount_term,
                           credit_history, property_area]])
    prediction = model.predict(new_data)

    return "Approved" if prediction[0] == 1 else "Rejected"