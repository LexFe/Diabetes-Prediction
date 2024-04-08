import pickle
import numpy as np
import warnings

warnings.filterwarnings("ignore", message="Trying to unpickle estimator.*")

def predict_loan_approval(pregnancies : int, glucose : int, bloodPressure : int, skinthickness : int, insulin : int, diabetespedigreefunction : float, bmi : float ,age : int):
    with open('model_predict//one_model_predict.py', 'rb') as f:
        model = pickle.load(f)

    new_data = np.array([[pregnancies, glucose, bloodPressure, skinthickness, insulin,bmi, diabetespedigreefunction, age]])
    prediction = model.predict(new_data)

    return "Yes" if prediction[0] == 1 else "No"