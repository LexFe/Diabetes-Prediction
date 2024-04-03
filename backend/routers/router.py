from fastapi import APIRouter

from routers.endpoints.auth import router as auth_router
from routers.endpoints.user import router as user_router
from routers.endpoints.user import router_token as user_router_token
from routers.endpoints.predict import router as predict_router
from routers.endpoints.predict import router_token as predict_router_token
from routers.endpoints.report import router as report_router

routers = APIRouter()
router_list = [auth_router,user_router,user_router_token ,predict_router ,predict_router_token,report_router]

for router in router_list:
    routers.include_router(router)