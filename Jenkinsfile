pipeline {
    // 1. Tells Jenkins it can run this job on any available "executor" or worker
    agent any

    // 2. Defines variables; here, it securely grabs your DockerHub login info
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {

        // 3. Downloads the latest version of your code from GitHub
        stage('Clone Repository') {
            steps {
                git 'https://github.com/joshisk-git/todo-app.git'
            }
        }

        // 4. Uses the Dockerfile we just looked at to create the "v1" image
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t joshisk/todo-app:v1 .'
            }
        }

        // 5. Logs into DockerHub using secrets and uploads the image to the cloud
        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push joshisk/todo-app:v1'
            }
        }

        // 6. Runs the container locally on the Jenkins server to ensure it doesn't crash
        stage('Run Container Test') {
 	   steps {
 	       sh 'docker rm -f todo-container || true'
       	       sh 'docker run -d -p 8000:8000 --name todo-container joshisk/todo-app:v1'
    	   }
        }

        // 7. Tells your Kubernetes Master to update the cluster with your new code
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
                sh 'kubectl apply -f ingress.yaml'
            }
        }
    }
}
