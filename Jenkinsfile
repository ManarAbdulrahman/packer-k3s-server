 pipeline {
  agent {
    docker {
      image "hashicorp/packer:latest"
    }
  }
  environment {
    CREDS = credentials('phi-level2-project')
    AWS_ACCESS_KEY_ID= "${CREDS_USR}"
    AWS_SECRET_ACCESS_KEY= "${CREDS_PSW}"
    OWNER = 'Phi'
    PROJECT_NAME = 'phi-k3s-server'
  }
  stages {
    stage("build") {
      steps {
        sh 'make && make build'
      }
    }
  }
 post {
       success {
           build job: "phi-k3s-agent", wait: false

          }
      }
}