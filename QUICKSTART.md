"""
Quick start guide for CloudGuard AI
"""

# 🚀 CloudGuard AI - Quick Start Guide

## 5-Minute Setup

### Prerequisites
- Python 3.11+ and Node.js 20+
- Optional: Docker & Docker Compose

### Option 1: Local Development (5 minutes)

**Windows:**
```bash
.\setup.bat
```

**Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

Then in two separate terminals:
```bash
# Terminal 1: Backend
cd backend
venv\Scripts\activate  # or: source venv/bin/activate on Mac/Linux
uvicorn api.main:app --reload
```

```bash
# Terminal 2: Frontend
cd frontend
npm run dev
```

Visit: **http://localhost:5173**

### Option 2: Docker Compose (3 minutes)

```bash
docker-compose up
```

Visit: **http://localhost:5173**

## Project Structure

```
cloudguard-ai/
├── backend/              # Python FastAPI agents and orchestration
│   ├── agents/          # Monitoring, Incident, Deployment, Documentation agents
│   ├── api/             # FastAPI REST endpoints + WebSockets
│   └── tests/           # Unit tests
├── frontend/            # React + TypeScript dashboard
│   └── src/
│        ├── components/ # UI components
│        └── pages/      # Pages
├── infrastructure/      # Kubernetes + Terraform IaC
├── README.md           # Full documentation
├── DEVELOPMENT.md      # Detailed dev guide
├── DEMO.md            # Demo scenario walkthrough
└── DEPLOYMENT.md      # Production deployment
```

## Key Technologies

- **Backend**: Python 3.11, FastAPI, Pydantic, AsyncIO
- **Frontend**: React 18, TypeScript, Tailwind CSS, Recharts
- **Agents**: 4 specialized multi-agent system
- **Cloud**: Azure OpenAI, Azure Monitor, Azure AKS, Cosmos DB
- **Orchestration**: Kubernetes, Docker
- **IaC**: Terraform for Azure resources

## How It Works

1. **Monitoring Agent** continuously watches system metrics
2. **Incident Agent** analyzes issues and proposes fixes
3. **Deployment Agent** executes approved remediation
4. **Documentation Agent** generates reports and runbooks
5. **Orchestrator** coordinates multi-agent collaboration

## API Endpoints

All endpoints documented at: **http://localhost:8000/docs**

Key endpoints:
- `GET /api/incidents` - List incidents
- `POST /api/incidents/{id}/approve` - Approve remediation
- `GET /api/system/status` - System health
- `WebSocket /ws/incidents` - Real-time updates
- `WebSocket /ws/metrics` - Live metrics

## Demo Walkthrough

See [DEMO.md](DEMO.md) for:
- Complete demo scenario (45 seconds)
- Video script and timing
- FAQs and variations

## Next Steps

1. **Understand the architecture**: Read [README.md](README.md)
2. **Set up development environment**: Follow this guide
3. **Explore the code**: Start with `backend/agents/orchestrator.py`
4. **Run the demo**: Follow [DEMO.md](DEMO.md)
5. **Deploy to Azure**: See [DEVELOPMENT.md](DEVELOPMENT.md) Deployment section

## Troubleshooting

**Backend won't start?**
```bash
# Verify Python version
python --version  # Should be 3.11+

# Reinstall dependencies
pip install -r requirements.txt
```

**Frontend blank?**
```bash
# Clear cache and rebuild
npm run build
# Check localhost:8000 is running
curl http://localhost:8000/health
```

**WebSocket not connecting?**
- Ensure backend is on port 8000
- Check browser console for errors
- Verify CORS enabled in `api/main.py`

## Support

- Full docs: [README.md](README.md)
- Development: [DEVELOPMENT.md](DEVELOPMENT.md)  
- Deployment: See infrastructure/ directory
- Demo: [DEMO.md](DEMO.md)
- Checklist: [SUBMISSION.md](SUBMISSION.md)

---

**Questions?** Check the relevant documentation file or the inline code comments.

**Ready to deploy?** See infrastructure/README for Terraform and Kubernetes instructions.
