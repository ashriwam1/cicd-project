<div align="center">

# 🚀 CSE DevOps Project

### Automated CI/CD Pipeline using Git, Jenkins & Docker

[![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/)

<br/>

> A fully functional DevOps project built as part of a Computer Science Engineering course.  
> Demonstrates real-world CI/CD practices: code versioning, automated testing, containerisation, and deployment pipelines.

</div>

---

## 📌 Table of Contents

- [About the Project](#-about-the-project)
- [Technologies Used](#-technologies-used)
- [Project Structure](#-project-structure)
- [How It Works](#-how-it-works)
- [Quick Start](#-quick-start)
- [CI/CD Pipeline](#-cicd-pipeline)
- [API Endpoints](#-api-endpoints)
- [Docker Commands](#-docker-commands)
- [Jenkins Setup](#-jenkins-setup)
- [Upload to GitHub](#-upload-to-github)
- [Author](#-author)

---

## 🎯 About the Project

This project is a hands-on demonstration of a **modern DevOps workflow** used in real software companies.

The application is a simple **Node.js web server** — but the real focus is the pipeline around it:

- Every time code is pushed to GitHub, **Jenkins automatically kicks off**
- It installs dependencies, **runs tests**, and if they pass — **builds a Docker image**
- The app is then **deployed as a Docker container** — consistently, repeatably, with zero manual steps

This is exactly how production deployments work at companies like Google, Amazon, and Netflix.

---

## 🛠️ Technologies Used

| Technology | Version | Purpose |
|-----------|---------|---------|
| **Git** | Latest | Local version control — tracking all code changes |
| **GitHub** | — | Remote repository hosting + webhook triggers |
| **Jenkins** | 2.x LTS | CI/CD automation — builds, tests, deploys |
| **Docker** | 24.x | Containerises the app for consistent environments |
| **Node.js** | 18 LTS | Backend JavaScript runtime |
| **Express.js** | 4.x | Lightweight web framework for the API |
| **Jest** | 29.x | Automated unit & integration testing |

---

## 📁 Project Structure

```
cicd-project/
│
├── app/                        ← Application source code
│   ├── index.js                ← Express web server (main entry point)
│   ├── package.json            ← Node dependencies & scripts
│   ├── public/
│   │   └── index.html          ← Frontend UI (served by Express)
│   └── tests/
│       └── app.test.js         ← Automated Jest test suite
│
├── Dockerfile                  ← Multi-stage Docker build definition
├── docker-compose.yml          ← One-command local environment setup
├── Jenkinsfile                 ← Declarative CI/CD pipeline (6 stages)
├── .gitignore                  ← Files excluded from Git tracking
└── README.md                   ← This file
```

---

## ⚙️ How It Works

```
  Developer pushes code
         │
         ▼
  ┌─────────────┐
  │   GitHub    │  ← Stores code, triggers Jenkins via webhook
  └──────┬──────┘
         │
         ▼
  ┌─────────────┐
  │   Jenkins   │  ← Runs the pipeline automatically
  └──────┬──────┘
         │
    ┌────▼─────────────────────────────┐
    │  Stage 1 → Checkout Code         │
    │  Stage 2 → Install Dependencies  │
    │  Stage 3 → Run Automated Tests   │
    │  Stage 4 → Build Docker Image    │
    │  Stage 5 → Deploy Container      │
    │  Stage 6 → Health Check          │
    └──────────────────────────────────┘
         │
         ▼
  ┌─────────────┐
  │   Docker    │  ← App runs inside a container on port 3000
  └─────────────┘
         │
         ▼
  http://localhost:3000  ✅  Live!
```

---

## ⚡ Quick Start

### Option A — Run with Docker (Recommended)

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/cicd-project.git
cd cicd-project

# 2. Build and start with Docker Compose
docker-compose up --build

# 3. Open in browser → http://localhost:3000
```

### Option B — Run Locally (Node.js required)

```bash
cd app
npm install
npm start
# Open → http://localhost:3000
```

### Option C — Run Tests

```bash
cd app
npm test
```

---

## 🔄 CI/CD Pipeline

The `Jenkinsfile` defines **6 automated stages**:

| Stage | What Happens |
|-------|-------------|
| **1. Checkout Code** | Jenkins pulls the latest code from GitHub |
| **2. Install Dependencies** | Runs `npm install` to get all packages |
| **3. Run Tests** | Runs `npm test` — pipeline stops here if any test fails |
| **4. Build Docker Image** | Builds a Docker image tagged with the build number |
| **5. Deploy Container** | Stops old container, starts fresh one on port 3000 |
| **6. Health Check** | Hits `/api/health` to confirm app is running ✅ |

> If **any stage fails**, the pipeline stops immediately and the broken code never reaches production.

---

## 📡 API Endpoints

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| `GET` | `/` | Serves the frontend HTML page | HTML page |
| `GET` | `/api/hello` | Returns a JSON greeting message | `{ message, version, timestamp }` |
| `GET` | `/api/health` | Health check for Jenkins & Docker | `{ status: "OK", uptime }` |

**Example response from `/api/hello`:**
```json
{
  "message": "Hello from CSE CI/CD Project!",
  "version": "1.0.0",
  "timestamp": "2024-01-15T10:30:00.000Z",
  "author": "Your Name"
}
```

---

## 🐳 Docker Commands

```bash
# Build the Docker image manually
docker build -t cse-cicd-app .

# Run the container
docker run -d -p 3000:3000 --name cse-app cse-cicd-app

# Check running containers
docker ps

# View container logs
docker logs cse-app

# Stop and remove the container
docker stop cse-app && docker rm cse-app

# Remove the image
docker rmi cse-cicd-app
```

---

## 🔧 Jenkins Setup

### Prerequisites
- Jenkins installed and running at `http://localhost:8080`
- Docker installed on the same machine
- Node.js installed on the Jenkins agent

### Steps

**1.** Open Jenkins → Click **"New Item"**

**2.** Enter name: `cicd-project` → Select **"Pipeline"** → Click OK

**3.** Under the **Pipeline** section:
   - Definition → `Pipeline script from SCM`
   - SCM → `Git`
   - Repository URL → `https://github.com/YOUR_USERNAME/cicd-project.git`
   - Script Path → `Jenkinsfile`

**4.** Click **Save**

**5.** To trigger automatically on every GitHub push — add a **Webhook**:
   - GitHub repo → Settings → Webhooks → Add webhook
   - Payload URL: `http://YOUR_JENKINS_IP:8080/github-webhook/`
   - Content type: `application/json`
   - Trigger: **Just the push event** → Add webhook

**6.** Click **"Build Now"** to test the pipeline manually for the first time

---

## 📤 Upload to GitHub

```bash
# 1. Open Git Bash inside the project folder

# 2. Initialise Git
git init

# 3. Stage all files
git add .

# 4. First commit
git commit -m "Initial commit: CSE DevOps Project with Jenkins & Docker"

# 5. Connect to your GitHub repo (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/cicd-project.git

# 6. Push to GitHub
git branch -M main
git push -u origin main
```

> 💡 Use **Git Bash** (not CMD) for all the above commands.  
> If password login fails, use a **Personal Access Token** from GitHub → Settings → Developer Settings.

---

## 👨‍💻 Author

Shivam kumar 
B.Tech Computer Science Engineering  
Roll No: 38

[![GitHub] github.com/ashriwam1

---

<div align="center">

⭐ **If this project helped you, please give it a star on GitHub!** ⭐

*Made with ❤️ for CSE DevOps coursework*

</div>
