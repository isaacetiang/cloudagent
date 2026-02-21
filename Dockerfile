# Multi-stage build for CloudGuard AI

# Stage 1: Build backend
FROM python:3.11-slim as backend-builder

WORKDIR /app/backend
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ .

# Stage 2: Build frontend
FROM node:20-alpine as frontend-builder

WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci

COPY frontend/ .
RUN npm run build

# Stage 3: Runtime
FROM python:3.11-slim

WORKDIR /app

# Install Node runtime for mixed deployment
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy backend
COPY --from=backend-builder /app/backend /app/backend

# Copy frontend build
COPY --from=frontend-builder /app/frontend/dist /app/frontend/dist

# Install Python dependencies
WORKDIR /app/backend
RUN pip install --no-cache-dir -r requirements.txt

# Expose ports
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Start backend API
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
