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
    OWNER = 'phi'
    PROJECT_NAME = 'phi-k3s-server'
  }
   stages {

     stage ('build') {

            steps {
                //sh "make init"
              container ("packer") {

                sh "make build"
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
