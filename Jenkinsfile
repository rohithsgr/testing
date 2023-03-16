pipeline{
    agent any
    
    stages{
        stage("Build"){
            steps{
                echo "We are in Build step now"
                
                git branch: 'dev', url: 'https://github.com/rohithsgr/guvi.git'
                sh 'chmod +x ./build.sh'
                sh 'sh ./build.sh'
                
            }
        }
        stage("Deploy to the site"){
            steps{
                echo "We are in deploy stage. Lets deploy the image now using docker compose"
                sh 'docker-compose up -d'
                echo "Check with ip address http://75.101.191.34:80"
        
            }
        }
        stage("Push to Docker Dev"){
            steps{
                echo "Now, lets push the image to dev repository in docker"
                withCredentials([usernamePassword(credentialsId: 'git', passwordVariable: 'docker_password', usernameVariable: 'docker_username')]) {
                    sh 'docker login --username=${docker_username} --password=${docker_password}'
                    sh 'docker tag rohithsgr/dev:${BUILD_NUMBER} rohithsgr/dev:latest'
                    sh 'docker push rohithsgr/dev:latest'
                }
                
            }
                 
            }
    }

post{
    always{
        echo "This is a normal messgae which gets printed even if success or failure. We can also use this to do any cleanup activity"
    }
    success{
        echo "Its success, congratulations"
    }
    failure{
        echo "Its failure, sorry"
    }
}
}
