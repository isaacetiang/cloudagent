#!/bin/bash
# CloudGuard AI Local Development Setup

set -e

echo "🚀 CloudGuard AI - Setup Script"
echo "================================"

# Check prerequisites
echo "✓ Checking prerequisites..."

if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required"
    exit 1
fi

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required"
    exit 1
fi

# Setup Python backend
echo ""
echo "📦 Setting up backend..."
cd backend

if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "✓ Virtual environment created"
fi

source venv/bin/activate 2>/dev/null || . venv/Scripts/activate

pip install -r requirements.txt
echo "✓ Backend dependencies installed"

cd ..

# Setup frontend
echo ""
echo "🎨 Setting up frontend..."
cd frontend

npm install
echo "✓ Frontend dependencies installed"

cd ..

echo ""
echo "✅ Setup complete!"
echo ""
echo "To start development:"
echo "  1. Backend:  cd backend && source venv/bin/activate && uvicorn api.main:app --reload"
echo "  2. Frontend: cd frontend && npm run dev"
echo ""
echo "Or use Docker Compose:"
echo "  docker-compose up"
