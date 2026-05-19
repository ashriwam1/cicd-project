// ─────────────────────────────────────────────────────────────────
//  Jenkinsfile  –  CI/CD Pipeline for CSE DevOps Project
//  Stages: Checkout → Install → Test → Build Docker → Deploy
// ─────────────────────────────────────────────────────────────────

pipeline {

    agent any   // Run on any available Jenkins agent

    // ── Environment Variables ──────────────────────────────────────
    environment {
        IMAGE_NAME   = 'cse-cicd-app'
        IMAGE_TAG    = "${BUILD_NUMBER}"          // e.g. 1, 2, 3 …
        CONTAINER_NAME = 'cse-cicd-running'
        APP_PORT     = '3000'
    }

    // ── Pipeline Stages ────────────────────────────────────────────
    stages {

        // 1. CHECKOUT — pull latest code from GitHub
        stage('1. Checkout Code') {
            steps {
                echo '📥 Checking out source code from GitHub...'
                checkout scm    // Uses the GitHub repo configured in Jenkins job
            }
        }

        // 2. INSTALL — install Node dependencies
        stage('2. Install Dependencies') {
            steps {
                echo '📦 Installing Node.js dependencies...'
                dir('app') {
                    sh 'npm install'
                }
            }
        }

        // 3. TEST — run automated Jest tests
        stage('3. Run Tests') {
            steps {
                echo '🧪 Running automated tests...'
                dir('app') {
                    sh 'npm test'
                }
            }
        }

        // 4. BUILD — build the Docker image
        stage('4. Build Docker Image') {
            steps {
                echo "🐳 Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                """
            }
        }

        // 5. DEPLOY — stop old container, start fresh one
        stage('5. Deploy Container') {
            steps {
                echo '🚀 Deploying Docker container...'
                sh """
                    # Stop & remove old container (ignore error if not running)
                    docker stop ${CONTAINER_NAME} || true
                    docker rm   ${CONTAINER_NAME} || true

                    # Run fresh container
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${APP_PORT}:3000 \
                        --restart unless-stopped \
                        ${IMAGE_NAME}:latest
                """
            }
        }

        // 6. VERIFY — hit the health endpoint
        stage('6. Health Check') {
            steps {
                echo '❤️  Verifying application is live...'
                sh """
                    sleep 5
                    curl -f http://localhost:${APP_PORT}/api/health || exit 1
                """
            }
        }
    }

    // ── Post Actions ───────────────────────────────────────────────
    post {
        success {
            echo """
            ✅ ─────────────────────────────────────
               Pipeline SUCCEEDED!
               Build #${BUILD_NUMBER} deployed.
               App: http://localhost:${APP_PORT}
            ─────────────────────────────────────
            """
        }
        failure {
            echo """
            ❌ ─────────────────────────────────────
               Pipeline FAILED on Build #${BUILD_NUMBER}.
               Check the logs above for errors.
            ─────────────────────────────────────
            """
        }
        always {
            echo '🧹 Cleaning up old Docker images...'
            sh "docker image prune -f || true"
        }
    }
}
