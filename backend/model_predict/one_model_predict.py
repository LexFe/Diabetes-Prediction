import joblib
import numpy as np
import warnings

warnings.filterwarnings("ignore", message="Trying to unpickle estimator.*")

def predict_loan_approval(pregnancies: int, glucose: int, bloodPressure: int, skinthickness: int, insulin: int, diabetespedigreefunction: float, bmi: float, age: int) -> str:
    # Load the trained model
    loaded_model = joblib.load('model_predict/knn_diabetes_model.pkl')

    new_data = np.array([[pregnancies, glucose, bloodPressure, skinthickness, insulin, bmi, diabetespedigreefunction, age]])

    prediction = loaded_model.predict(new_data)
    return "ມີໂອກາດເປັນໂລກເບົາຫວານ" if prediction[0] == 1 else "ບໍ່ມີໂອກາດເປັນໂລກເບົາຫວານ"