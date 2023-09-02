pipeline {

  environment {
    dockerimagename = "aks0207/notejam-jenkins"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/aksingh02/notejam-jenkins.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('setup kubeconfig') {
          steps {
            withCredentials([file(credentialsId: 'my_config', variable: 'my_config')]) {
                sh "cp \${my_config} ${WORKSPACE}/my_config"
            }
          }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v1")
          }
        }
      }
    }

    stage('deploying notejam') {
      steps {
        sh "kubectl --kubeconfig ${WORKSPACE}/my_config config set-context --current --user=jenkins-admin"
        sh "kubectl apply -f deployment.yaml --kubeconfig ${WORKSPACE}/my_config"
      }
    }

  }

}