pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    stattt: testing
spec:
  containers:
  - name: packer
    image: bryandollery/terraform-packer-aws-alpine
    args: ['-v','/var/run/docker.sock:/var/run/docker.sock']
    command:
    - bash
    tty: true
"""
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

     stage ('build') {

            steps {
                //sh "make init"
              container ("packer") {

                sh "make && make build"
              }
            }
        }
    }
 post {
       success {
           build job: "phi-k3s-agent", wait: false

          }
      }
}