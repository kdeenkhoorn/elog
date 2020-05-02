pipeline {

    agent {
        label 'armhf' 
    }

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    }

    triggers {
       GenericTrigger (
           genericVariables: [
	            [defaultValue: '', key: 'ACTOR', regexpFilter: '', value: '$.pusher.username'],
	            [defaultValue: '', key: 'REF', regexpFilter: '', value: '$.ref'],
           ],
           causeString: 'Push by: $ACTOR on Ref: $REF',
           printPostContent: true,
           regexpFilterExpression: '',
           regexpFilterText: '',
           token: '1612d51ccb91ad61b7345e56f4f5a8b4dae70b06'
       )
    }

    stages {
        stage ('Build elog docker image') {
            steps {
                /* Build elog image */
                sh "docker build -f ./Dockerfile -t kdedesign/elog:latest ."
            }
        }
        stage ('Publish elog docker image to Docker Hub') {
            steps {
                /* Docker push buildresult to Docker Hub*/
                withDockerRegistry(credentialsId: 'dockerhubaccount', url: '') {
                    sh "docker push kdedesign/elog:latest"
                }
            }
        }
    }
}