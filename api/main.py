import sys
import os
from pathlib import Path
from fastapi import FastAPI
from mangum import Mangum
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware

sys.path.append(str(Path(__file__).resolve().parent.parent))

from database import database
from api.endpoints import professor, department, rating


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Manage startup and shutdown events using a context manager."""
    database.initialize_connection_pool()
    database.initialize_database()
    yield
    database.close_pool()


app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def root():
    return {"message": "Welcome to the Rate my Professor API"}


app.include_router(professor.router)
app.include_router(department.router)
app.include_router(rating.router)

# Lambda container CMD: ["api.main.handler"]
handler = Mangum(app, lifespan="on")
