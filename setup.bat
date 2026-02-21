@echo off
REM CloudGuard AI Local Development Setup for Windows

echo.
echo 🚀 CloudGuard AI - Setup Script
echo ================================

REM Check prerequisites
echo.
echo. Checking prerequisites...

python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python 3 is required
    exit /b 1
)

node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is required
    exit /b 1
)

REM Setup Python backend
echo.
echo. 📦 Setting up backend...
cd backend

if not exist "venv" (
    python -m venv venv
    echo ✓ Virtual environment created
)

call venv\Scripts\activate.bat

pip install -r requirements.txt
echo ✓ Backend dependencies installed

cd ..

REM Setup frontend
echo.
echo. 🎨 Setting up frontend...
cd frontend

npm install
echo ✓ Frontend dependencies installed

cd ..

echo.
echo. ✅ Setup complete!
echo.
echo To start development:
echo   1. Backend:  cd backend ^&^& venv\Scripts\activate.bat ^&^& uvicorn api.main:app --reload
echo   2. Frontend: cd frontend ^&^& npm run dev
echo.
echo Or use Docker Compose:
echo   docker-compose up
