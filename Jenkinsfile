node {    
      def app     
      stage('Clone repository') {
            checkout scm    
      }
      
      stage('Build image') {         
            app = docker.build("docker.io/fernii/nodejs-helloworld-jenkins")
            sh "echo docker.io/fernii/nodejs-helloworld-jenkins:latest > sysdig_secure_images"
       }
      
      stage('Scan image with Sysdig Secure') {           
          script {
          // Scan from local image recently built
          sysdig engineCredentialsId: 'sysdig-secure-api-credentials', name: 'sysdig_secure_images', inlineScanning: true, bailOnFail: false
          // Scan from repository image recently pushed
          // sysdig engineCredentialsId: 'sysdig-secure-api-credentials', name: 'sysdig_secure_images', inlineScanning: false bailOnFail: false
          // Stop pipeline based on Sysdig Analysis
          // sysdig engineCredentialsId: 'sysdig-secure-api-credentials', name: 'sysdig_secure_images', inlineScanning: true, bailOnFail: true
          // Pull Image to scan and Stop pipeline based on Sysdig Analysis
          // sysdig engineCredentialsId: 'sysdig-secure-api-credentials', name: 'sysdig_secure_images', inlineScanning: false, bailOnFail: true
          }
        }     
       stage('Push image') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-creds') {            
            app.push("${env.BUILD_NUMBER}")            
            app.push("latest")        
              }    
           }
        }
