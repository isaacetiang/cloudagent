# CloudGuard AI - DEMO SCENARIO

This document describes a realistic demo scenario showing CloudGuard AI detecting and responding to an incident.

## Demo Setup

1. Start the backend: `uvicorn api.main:app --reload`
2. Start the frontend: `npm run dev`
3. Open dashboard at `http://localhost:5173`

## Demo Scenario: High Error Rate Incident

**Time: T+0 seconds | Status: Normal**

The dashboard shows all systems healthy:
- Error Rate: 2.5%
- CPU Usage: 45%
- Memory Usage: 60%
- 0 Active Incidents
- All agents showing "healthy"

**Time: T+10 seconds | Event: Service Degradation**

A bug is deployed that causes increased processing. The Monitoring Agent detects metrics exceeding thresholds:
- Error Rate: 15% (exceeds 5% threshold)
- CPU Usage: 85% (exceeds 80% threshold)

**Dashboard Updates:**
- Alert appears in "Active Incidents" panel
- Metrics chart shows spike
- Incident ID: `inc-1708449000.123`
- Status: "open"

**Time: T+20 seconds | Analysis Phase**

Incident Agent analyzes the situation:
- Root Cause: CPU saturation causing timeouts
- Affected Services: service-a, service-b
- Confidence: 80%
- Proposed Remediation: Scale pods, enable autoscaling

**Dashboard Updates:**
- Incident status changes to "remediation_proposed"
- "Approve" button appears on incident card
- Recommended actions displayed

**Time: T+25 seconds | Human Decision**

Engineer reviews the incident and approves remediation by clicking "Approve".

**Dashboard Updates:**
- Button changes to loading state
- Incident status: "executing"
- Deployment Agent starts executing actions

**Time: T+30 seconds | Execution Phase**

Deployment Agent executes:
1. Scale pods to 8 replicas (was 5)
2. Enable Horizontal Pod Autoscaler

**Dashboard Updates:**
- "Recent Deployments" panel shows two new deployments
- Each shows status and timestamp
- Both marked as "succeeded"

**Time: T+40 seconds | Recovery**

Due to increased capacity:
- Error Rate: drops from 15% to 4%
- CPU Usage: drops from 85% to 55%
- System stabilizes

**Dashboard Updates:**
- Metrics chart shows recovery
- Incident status changes to "resolved"
- Incident moves out of "Active Incidents"
- Agent Status shows all agents healthy

**Time: T+45 seconds | Documentation**

Documentation Agent generates:
- Incident Report: Stored with full timeline and actions taken
- Runbook: For handling similar incidents in the future
- Prevention Steps: Scale better monitoring, tune thresholds

## Key Demo Points

### 1. Rapid Detection (10 seconds)
Show how quickly the Monitoring Agent detected the issue from metrics.

### 2. Intelligent Analysis (10 seconds)
Incident Agent analyzed logs and metrics to determine root cause and confidence level.

### 3. Human Approval (5 seconds)
Human remained in control - approval was required before execution.

### 4. Autonomous Execution (5 seconds)
Deployment Agent executed approved actions automatically.

### 5. Recovery (10 seconds)
System recovered in ~45 seconds from incident to resolution.

### 6. Real-time Dashboard
Throughout the demo, the dashboard updated in real-time showing:
- Metrics changing
- Incident status progression
- Agent activities
- Deployment execution

## Expected Questions & Answers

**Q: How would this scale to many microservices?**
A: Each agent is stateless and can be horizontally scaled. The orchestrator would be load-balanced across multiple instances. Incident processing would use Cosmos DB for distributed state.

**Q: What about database failures?**
A: The Incident Agent would detect increased latency in database queries. Remediation could include connection pool scaling or failover to replica.

**Q: How does it prevent cascading failures?**
A: Through circuit breakers, timeouts, and early scaling. The Deployment Agent can scale services proactively if it detects load increases coming from upstream.

**Q: Is there audit logging?**
A: Yes. All incident analysis, approvals, and deployments are logged. Reports generated include full history.

**Q: Can it handle unknown incident types?**
A: It provides recommended actions based on metrics, but always requires human approval. Users can override or reject recommendations.

## Variations

### Option A: Fast Recovery Path (2 minutes)
- Show auto-scaling immediately handling the load
- Never need manual deployment

### Option B: Rollback Path (2.5 minutes)
- Deployment of new code caused the issue
- Solution is rolling back to previous version
- Show versioning and deployment history

### Option C: Multi-Service Chain (3 minutes)
- Incident in database affects API service
- API service affects frontend
- Show how engineers trace through all affected services
- Show how deploying to database layer fixes everything upstream

### Option D: Approval Rejection (1.5 minutes)
- Engineer rejects proposed solution
- Demonstrates human oversight
- Engineer manually configures alternative solution
