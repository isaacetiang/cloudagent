# CloudGuard AI - Intelligent Multi-Agent DevOps Orchestrator

## Overview
CloudGuard AI is an intelligent, multi-agent DevOps system that automates CI/CD incident response, reliability engineering, and deployment optimization using the Microsoft Agent Framework, Azure services, and MCP protocol servers.

## Key Features
- **Multi-Agent Orchestration**: Specialized agents (Deployment, Monitoring, Incident Response, Documentation) collaborate to solve complex DevOps challenges
- **Real-time Monitoring**: Integration with Azure Monitor and Application Insights for continuous system health assessment
- **Intelligent Incident Response**: AI-powered root cause analysis and automated remediation with human approval gates
- **Production-Ready Architecture**: Deployed on Azure AKS with security controls, audit trails, and governance
- **MCP Server Integration**: Agent-to-agent communication via Model Context Protocol servers

## Technology Stack

### Backend
- **Python 3.11+** with FastAPI
- **Microsoft Agent Framework** for multi-agent orchestration
- **Azure OpenAI (GPT-4)** for intelligent decision-making
- **Azure DevOps SDK** for CI/CD integration
- **Azure Monitor & Application Insights** for observability
- **MCP Protocol** for inter-agent communication

### Frontend
- **React 18** with TypeScript
- **Vite** for fast development and builds
- **TailwindCSS** for responsive UI
- **React Query** for API data management
- **WebSocket** for real-time incident updates

### Infrastructure
- **Azure Container Registry** for image management
- **Azure Kubernetes Service (AKS)** for orchestration
- **Azure Cosmos DB** for event persistence
- **Azure Key Vault** for secrets management
- **Docker** for containerization

## Project Structure
```
cloudguard-ai/
├── backend/
│   ├── agents/
│   │   ├── monitoring_agent.py      # Monitors system health
│   │   ├── incident_agent.py        # Analyzes and responds to incidents
│   │   ├── deployment_agent.py      # Handles deployments & rollbacks
│   │   ├── documentation_agent.py   # Generates reports & runbooks
│   │   └── orchestrator.py          # Coordinates agent collaboration
│   ├── services/
│   │   ├── azure_monitor.py         # Telemetry collection
│   │   ├── devops_integration.py    # Azure DevOps API
│   │   ├── incident_manager.py      # Incident lifecycle
│   │   └── approval_manager.py      # Human approval workflows
│   ├── mcp_servers/
│   │   ├── monitoring_server.py     # MCP server for monitoring data
│   │   ├── deployment_server.py     # MCP server for deployments
│   │   └── incident_server.py       # MCP server for incident ops
│   ├── api/
│   │   └── main.py                  # FastAPI application
│   ├── tests/
│   ├── pyproject.toml
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── DashboardView.tsx    # Main dashboard
│   │   │   ├── IncidentPanel.tsx    # Incident display & controls
│   │   │   ├── DeploymentStatus.tsx # Deployment tracking
│   │   │   ├── AgentStatus.tsx      # Agent health indicators
│   │   │   └── RealtimeMetrics.tsx  # Live metrics visualization
│   │   ├── pages/
│   │   │   ├── Dashboard.tsx
│   │   │   ├── Incidents.tsx
│   │   │   ├── Deployments.tsx
│   │   │   └── Settings.tsx
│   │   ├── utils/
│   │   │   ├── api.ts              # API client
│   │   │   └── websocket.ts        # Real-time updates
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── package.json
│   └── vite.config.ts
├── infrastructure/
│   ├── helm-charts/
│   ├── terraform/
│   │   └── main.tf
│   ├── docker-compose.yml
│   └── Dockerfile.backend
└── .github/
    └── workflows/
        └── ci-cd.yml
```

## Getting Started

### Prerequisites
- Python 3.11+
- Node.js 18+
- Docker & Docker Compose
- Azure subscription with:
  - Azure DevOps project
  - Azure OpenAI deployment (GPT-4)
  - Azure Monitor
  - Azure Kubernetes Service cluster

### Backend Setup
```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

# Configure Azure credentials
export AZURE_SUBSCRIPTION_ID=<your-sub-id>
export AZURE_RESOURCE_GROUP=<your-rg>
export AZURE_OPENAI_ENDPOINT=<your-endpoint>
export AZURE_OPENAI_API_KEY=<your-key>

# Run backend
uvicorn api.main:app --reload
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### Local Docker Compose
```bash
docker-compose up
```

## Architecture

### Agent Communication Flow
```
┌─────────────┐
│ Monitoring  │
│   Agent     │ ──MCP──> Monitoring MCP Server
└─────────────┘
       │
       │ (Alerts)
       ▼
┌─────────────────────────┐
│  Orchestrator Agent     │ (Coordinator)
│ (Decision Making)       │
└─────────────────────────┘
       │         │
   MCP │         │ MCP
       ▼         ▼
┌────────────────────────────┐
│ Incident Agent & Deployment│
│ Agent (Parallel Execution) │
└────────────────────────────┘
```

## Key Workflow: Incident Detection & Response

1. **Detection Phase**
   - Monitoring Agent continuously watches Azure Monitor metrics
   - Threshold breaches trigger incident creation
   - Real-time alerts sent to frontend via WebSocket

2. **Analysis Phase**
   - Incident Agent queries logs, traces, and metrics
   - GPT-4 analyzes root causes and proposes fixes
   - Generates recommended remediation steps

3. **Decision Phase**
   - Proposed actions require human approval
   - Dashboard shows incident details and recommendations
   - Engineer reviews and approves/rejects actions

4. **Execution Phase**
   - Approved actions executed by Deployment Agent
   - Rollback capabilities available
   - Documentation Agent creates incident report and runbook

5. **Learning Phase**
   - Incident data stored in Cosmos DB
   - System learns patterns for future automation

## API Endpoints

### Core APIs
- `POST /api/incidents` - Create incident
- `GET /api/incidents` - List incidents
- `POST /api/incidents/{id}/approve` - Approve remediation
- `GET /api/agents/status` - Agent health check
- `POST /api/deployments/execute` - Trigger deployment
- `GET /api/deployments/{id}` - Deployment status

### WebSocket
- `ws://localhost:8000/ws/incidents` - Real-time incident updates
- `ws://localhost:8000/ws/metrics` - Live metrics stream

## Demo Scenario

CloudGuard AI detects and responds to a sudden spike in error rates:

1. **T+0s**: Monitoring Agent detects 50% error rate increase
2. **T+2s**: Incident created, front-end alerts engineer
3. **T+10s**: Incident Agent analyzes logs, identifies memory leak in service
4. **T+15s**: Proposes canary rollback or resource scaling
5. **T+20s**: Engineer approves resource scaling action
6. **T+25s**: Deployment Agent increases pod replicas
7. **T+45s**: Error rate drops, incident resolved
8. **T+50s**: Documentation Agent generates runbook for prevention

**Total MTTR: ~50 seconds (vs. hours with manual response)**

## Judging Criteria Alignment

✅ **Technological Implementation (20%)**
- Quality code with proper async/await patterns
- Well-documented agent orchestration logic
- Microservices architecture on AKS

✅ **Agentic Design & Innovation (20%)**
- 4 specialized agents with distinct responsibilities
- MCP protocol for seamless inter-agent communication
- Sophisticated multi-agent orchestration patterns

✅ **Real-World Impact (20%)**
- Solves genuine DevOps MTTR problem
- Reduces manual incident response overhead
- Scalable for enterprises of any size

✅ **User Experience (20%)**
- Intuitive real-time dashboard
- Clear incident visualization
- Simple approval workflows

✅ **Category Adherence (20%)**
- Grand Prize: Advanced agentic DevOps automation
- Category: Best Multi-Agent System with A2A protocols

## Deployment

### To Azure AKS
```bash
cd infrastructure
terraform init
terraform apply

# Deploy via Helm
helm install cloudguard ./helm-charts/cloudguard
```

### GitHub Actions CI/CD
- Automated tests on PR
- Build & push Docker images
- Deploy to staging/production

## Testing

```bash
cd backend
pytest tests/

cd frontend
npm test
```

## Contributing
1. Create feature branch
2. Make changes with tests
3. Submit PR with demo
4. Code review required before merge

## License
MIT License - See LICENSE file

## Support
For questions or issues, open a GitHub issue or contact the maintainers.

---
**Built for Microsoft AI Dev Days Hackathon 2026**
