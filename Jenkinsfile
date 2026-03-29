pipeline{
    agent { label 'dev' }

    stages{
        stage("Code clone"){
            steps{
                git url:"https://github.com/Amit-Dev03/docker-6-projects.git", branch:"main"
            }
        }

        stage("Trivy file system scan"){
            steps{
                sh "trivy fs . --exit-code 1 --severity CRITICAL,HIGH -f json -o results.json"
                archiveArtifacts artifacts: 'results.json', fingerprint: true
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
                echo "docker compose up --build flask-app"
            }
        }
    }

    post {
        always {
            emailext(
                to: 'pandeyamit2426@gmail.com',
                subject: "Build #${BUILD_NUMBER} - ${currentBuild.currentResult}",
                body: """
                Job: ${env.JOB_NAME}
                Build Number: ${env.BUILD_NUMBER}
                Status: ${currentBuild.currentResult}
                URL: ${env.BUILD_URL}
                """,
                attachLog: true
            )
        }

        success {
            echo "Build succeeded"
        }

        failure {
            echo "Build failed"
        }
    }
}
