pipeline{
    agent { label 'dev' }
    stages{
        stage("Code clone"){
            steps{
                git url:"https://github.com/Amit-Dev03/docker-6-projects.git", branch:"main"
            }
        }
        stage("Build image"){
            steps{
                sh "docker build -t flask-app:v1 -f Dockerfile.pro ."
            }
        }
        stage("Test"){
            steps{
                echo "Testing done"
            }
        }
        stage("Push to Dockerhub"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:"amitdev03",
                    usernameVariable: "dockerhubUsername",
                    passwordVariable: "dockerhubPassword"
                )]){
                    sh '''
                        echo "$dockerhubPassword" | docker login -u "$dockerhubUsername" --password-stdin
                        docker tag flask-app:v1 $dockerhubUsername/flask-app:v1
                        docker push $dockerhubUsername/flask-app:v1
                    '''
                }
            }
        }
        stage("Deploy"){
            steps{
                echo "docker compose up --build flask-app, need to make docker-compose now"
            }
        }
    }
}
