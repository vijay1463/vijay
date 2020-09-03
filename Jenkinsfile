pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
              // Get some code from a GitHub repository
              git 'https://github.com/vijay1463/hello.git' 
                
            }
        }
        stage('Build') {
            steps {
               //Run Maven on a Unix agent.
              sh " mvn clean package"
            }
        }
        stage('Docker installing') {
            steps {
              // Installing doker.
              sh "sudo apt-get update"
              sh "sudo apt-get remove -y docker docker-engine docker.io"
              sh "sudo apt-get install -y docker.io"
              sh "sudo docker --version"
              echo " Buidnumber ${env.BUILD_NUMBER} Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }
        stage('Build Docker image') {
            steps {
              // Run Maven on a Unix agent.
              sh "sudo docker build -t vijay1211/my-app:${env.BUILD_NUMBER} ."
               
            }
        }

        stage('Push Docker image') {
            steps { 
               withCredentials([string(credentialsId: 'Dockerpass', variable: 'Dockerhub')]) {
               sh "sudo docker login -u vijay1211 -p ${Dockerhub}"
               sh "sudo docker push vijay1211/my-app:${env.BUILD_NUMBER}"
               sh "sudo docker run -p 8082:8080 -d vijay1211/my-app:${env.BUILD_NUMBER}"
          }
        }  
       }   
    }
}  
