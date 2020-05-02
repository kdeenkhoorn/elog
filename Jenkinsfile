pipeline {

    agent {
        label 'armhf'
    }

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    }

    stages {
        stage ('Build elog docker image') {
            steps {
                /* Build elog image */
                sh "docker build -f ./Dockerfile -t kdedesign/elog:latest ."

                /* Docker push buildresult */
                withDockerRegistry(credentialsId: 'dockerhubaccount', url: 'https://registry.hub.docker.com/') {
                    sh "docker push kdedesign/elog:latest"
                }
            }
        }
    }
}