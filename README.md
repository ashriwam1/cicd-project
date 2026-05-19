# 🚀 CSE DevOps Project — Git + Jenkins + Docker

> A complete CI/CD pipeline demonstration project for Computer Science Engineering.

---

## 📁 Project Structure

```
cicd-project/
├── app/
│   ├── index.js          ← Node.js Express server
│   ├── package.json      ← Node dependencies
│   ├── public/
│   │   └── index.html    ← Frontend UI
│   └── tests/
│       └── app.test.js   ← Automated Jest tests
├── Dockerfile            ← Containerises the app
├── docker-compose.yml    ← Easy local run
├── Jenkinsfile           ← CI/CD pipeline definition
├── .gitignore
└── README.md
```

---

## 🛠️ Technologies Used

| Tool        | Purpose                                      |
|-------------|----------------------------------------------|
| **Git**     | Version control for all source code          |
| **GitHub**  | Remote repository hosting + webhooks         |
| **Jenkins** | Automated CI/CD pipeline (build/test/deploy) |
| **Docker**  | Containerises the app for consistent deploys |
| **Node.js** | Backend runtime (Express web server)         |
| **Jest**    | Automated testing framework                  |

---

## ⚡ Quick Start (Local — No Jenkins)

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/cicd-project.git
cd cicd-project

# 2. Run with Docker Compose
docker-compose up --build

# 3. Open browser
#    http://localhost:3000
```

---

## 🔄 CI/CD Pipeline Stages

```
GitHub Push
    │
    ▼
1. Checkout Code       ← Jenkins pulls latest code
    │
    ▼
2. Install Dependencies ← npm install
    │
    ▼
3. Run Tests           ← npm test (Jest)
    │
    ▼
4. Build Docker Image  ← docker build
    │
    ▼
5. Deploy Container    ← docker run
    │
    ▼
6. Health Check        ← curl /api/health ✅
```

---

## 📡 API Endpoints

| Method | Endpoint      | Description          |
|--------|---------------|----------------------|
| GET    | `/`           | Frontend UI page     |
| GET    | `/api/hello`  | Returns JSON message |
| GET    | `/api/health` | Health status check  |

---

## 🐳 Docker Commands (Manual)

```bash
# Build image
docker build -t cse-cicd-app .

# Run container
docker run -d -p 3000:3000 --name cse-app cse-cicd-app

# View logs
docker logs cse-app

# Stop container
docker stop cse-app && docker rm cse-app
```

---

## 🔧 Jenkins Setup

1. Install Jenkins (see setup steps in the project guide)
2. Create a new **Pipeline** job
3. Under *Pipeline → Definition*, select **"Pipeline script from SCM"**
4. Set SCM to **Git**, paste your GitHub repo URL
5. Set *Script Path* to `Jenkinsfile`
6. Add a GitHub webhook (URL: `http://YOUR_JENKINS_IP:8080/github-webhook/`)
7. Click **Build Now** or push a commit — pipeline runs automatically!

---

## 👨‍💻 Author

**Your Name** — CSE Student  
GitHub: [@your_username](https://github.com/your_username)
