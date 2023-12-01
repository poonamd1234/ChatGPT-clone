pipeline {
    agent none
    environment {
        NEXUS_REGISTRY_URL = 'https://localhost:6666/'
        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
    }
    
    stages {
        
        stage("Clone Code") {
            agent {
                node {
                    label 'dockerNode' 
                }
            }
            steps{
                echo "Cloning the code"
                git url:'https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot.git', branch: 'master'
            }
        }
            
        // stage("Build") {
        //     agent {
        //         node {
        //             label 'dockerNode'
        //         }
        //     }
        //     steps{
        //         echo "Building the image"
        //         sh "docker build -t ${DOCKER_IMG_NAME} ."
               
                
        //     }
        // }

        stage ("Running Nexus Repository"){
            agent {
                node {
                    label "dockerNode"
                }
            }

            steps {
                echo "Taking care of the Business"
                sh " cp -r nexus_secure /"
                sh "cd /nexus_secure/scripts"
                sh "chmod +x ./nexus-nginxproxy.sh ./uninstall.sh"
                sh "bash ./nexus-nginxproxy.sh \"permutable\""
            }
        }

        // stage ("Pushing To Nexus Docker Private Repository"){
        //     agent {
        //         node {
        //             label 'dockerNode'
        //         }
        //     }

        //     steps {
        //         echo "Pushing to Nexus"
        //         withCredentials([usernamePassword(credentialsId: "NEXUS_CREDENTIALS_ID", usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
        //             sh "docker login -u ${NEXUS_USERNAME} -p ${NEXUS_PASSWORD} ${NEXUS_REGISTRY_URL}"
        //             sh "docker tag ${DOCKER_IMG_NAME} localhost:6666/${DOCKER_IMG_NAME}"
        //             sh "docker push localhost:6666/${DOCKER_IMG_NAME}"
        //         }              
        //     }
        // }
    }
}
