pipeline {

    agent {
        label 'armhf'
    }

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    }

    stages {
        stage ('Build docker elog image') {
            steps {
                /* git clone repository */
                git credentialsId: 'gogs_user_klaas', url: 'https://gogs.int.kdedesign.nl/kdedesign/elog.git'

                /* Build base image */
                sh "./build.sh"
            }
        }
    }
}