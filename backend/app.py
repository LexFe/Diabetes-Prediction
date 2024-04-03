from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from watchgod import run_process
from routers.router import routers

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(routers)

@app.get("/")
def dammy():
    return {"message": "dummy response."}
        

def main():
    uvicorn.run(app, host="192.168.100.96", port="8000", reload=True)
    
if __name__ == "__main__":
    run_process("main:main", restart_delay=1)