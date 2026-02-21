# Development Guide

## Quick Start

### Prerequisites
- Python 3.11+
- Node.js 20+
- Docker & Docker Compose (optional)
- Azure account with:
  - Azure OpenAI deployment (GPT-4)
  - Azure Monitor
  - Azure DevOps project

### Setup

#### Option 1: Local Development

**Windows:**
```bash
.\setup.bat
```

**Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

#### Option 2: Docker Compose

```bash
docker-compose up
```

### Running Services

#### Backend
```bash
cd backend
source venv/bin/activate  # or: venv\Scripts\activate on Windows
uvicorn api.main:app --reload
```

Backend will be available at `http://localhost:8000`
API docs at `http://localhost:8000/docs`

#### Frontend
```bash
cd frontend
npm run dev
```

Frontend will be available at `http://localhost:5173`

### Environment Variables

Create a `.env` file in the project root:

```env
# Azure Configuration
AZURE_SUBSCRIPTION_ID=your-subscription-id
AZURE_RESOURCE_GROUP=your-resource-group
AZURE_OPENAI_ENDPOINT=https://your-instance.openai.azure.com/
AZURE_OPENAI_API_KEY=your-api-key
AZURE_DEVOPS_ORG_URL=https://dev.azure.com/your-org
AZURE_DEVOPS_PAT=your-personal-access-token

# Environment
ENVIRONMENT=local
LOG_LEVEL=debug
```

## Project Structure

### Backend (`backend/`)

#### Agents
- **`monitoring_agent.py`** - Monitors system metrics, detects anomalies
- **`incident_agent.py`** - Analyzes incidents, proposes remediation
- **`deployment_agent.py`** - Executes deployments and rollbacks
- **`documentation_agent.py`** - Generates reports and runbooks
- **`orchestrator.py`** - Coordinates multi-agent collaboration

#### Services
- **Azure integrations** - Monitor, DevOps, Cosmos DB
- **Incident management** - Lifecycle, workflow, storage
- **Approval workflows** - Human-in-the-loop controls

#### API
- **FastAPI application** with REST endpoints and WebSockets
- Auto-generated API docs at `/docs`

### Frontend (`frontend/`)

#### Components
- **DashboardView** - Main dashboard layout
- **IncidentPanel** - Lists and manages incidents
- **RealtimeMetrics** - Live metrics charts
- **AgentStatus** - Agent health indicators
- **DeploymentStatus** - Recent deployments

#### Features
- Real-time incident updates via WebSocket
- Live metrics streaming
- One-click remediation approval
- Responsive Tailwind CSS design

## API Documentation

### Incident Endpoints

```http
GET /api/incidents
Returns list of active incidents

GET /api/incidents/{incident_id}
Returns detailed incident information

POST /api/incidents/{incident_id}/approve
Body: { "approve": true, "reason": "optional" }
Approves incident remediation
```

### WebSocket Connections

```
ws://localhost:8000/ws/incidents
Real-time incident updates

ws://localhost:8000/ws/metrics
Live metrics streaming at 5s intervals
```

### System Endpoints

```http
GET /health
Health check

GET /api/system/status
Overall system status and statistics

GET /api/agents/status
Individual agent health status

GET /api/deployments
Recent deployment history
```

## Testing

### Backend Tests
```bash
cd backend
pytest tests/ -v
```

### Frontend Tests
```bash
cd frontend
npm test
```

## Building for Production

### Docker Image
```bash
docker build -t cloudguard-ai:latest .
docker run -p 8000:8000 cloudguard-ai:latest
```

### Kubernetes Deployment
```bash
kubectl apply -f infrastructure/kubernetes.yaml
```

### Terraform Infrastructure
```bash
cd infrastructure/terraform
terraform init
terraform plan
terraform apply
```

## Architecture Decisions

### Multi-Agent Pattern
- Each agent has a single responsibility
- Agents communicate via shared state and MCP protocols
- Orchestrator coordinates workflows
- Enables scalability and testability

### Frontend-Backend Communication
- REST API for structured requests
- WebSockets for real-time updates
- Polling as fallback for agent status

### Async Processing
- Incident processing runs continuously
- Deployments execute asynchronously
- Reports generated after incident resolution

## Common Tasks

### Add a New Agent
1. Create `backend/agents/new_agent.py`
2. Implement Agent class with `get_health_status()` method
3. Register in `Orchestrator.__init__()`
4. Add methods to Orchestrator for agent interaction

### Add a New API Endpoint
1. Create route in `backend/api/main.py`
2. Add Pydantic models for request/response
3. Call orchestrator methods for business logic
4. Test with `/docs` interactive API explorer

### Deploy to Azure
1. Update `infrastructure/terraform/main.tf` with Azure settings
2. Run `terraform apply` to create infrastructure
3. Configure GitHub secrets for CI/CD
4. Push to main branch - GitHub Actions will deploy

## Troubleshooting

### Backend won't start
```bash
pip install -r requirements.txt
# Check Python version: python --version (should be 3.11+)
```

### Frontend shows blank page
```bash
# Clear browser cache
# Check browser console for errors
npm run build  # Try building for production
```

### WebSocket connection failing
- Ensure backend is running on port 8000
- Check CORS settings in `api/main.py`
- Verify frontend proxy config in `vite.config.ts`

### Azure credential errors
- Verify `.env` file exists with correct secrets
- Check Azure subscription permissions
- Run `az login` to authenticate CLI

## Contributing

1. Create feature branch: `git checkout -b feature/my-feature`
2. Make changes with tests
3. Run linting: `flake8 backend/`, `npm run lint`
4. Commit: `git commit -am "Add my feature"`
5. Push: `git push origin feature/my-feature`
6. Create Pull Request

## Performance Tips

- Use database indexes for incident queries
- Cache agent health status (5s TTL)
- Batch metric collection from Azure Monitor
- Implement incident deduplication
- Use connection pooling for database

## Security Checklist

- [ ] Secrets stored in Azure Key Vault (not in code)
- [ ] HTTPS enabled in production
- [ ] API authentication implemented
- [ ] Input validation on all endpoints
- [ ] SQL injection prevention (using ORM)
- [ ] Rate limiting on public endpoints
- [ ] Audit logging for deployments
- [ ] User permissions checked on approvals

---

For more information, see [README.md](../README.md)
