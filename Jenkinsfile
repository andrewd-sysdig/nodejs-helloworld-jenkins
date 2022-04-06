node {
      def app   
      
      environment {
          registry = "registry.hub.docker.com"
          image = "fernii/nodejs-helloworld-jenkins"
        }
      
      stage('Clone repository') {
            checkout scm    
      }
      
      stage('Build image') {         
            app = docker.build("${image}")
            sh "echo ${registry}/${image}:${env.BUILD_NUMBER} > sysdig_secure_images"
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
            docker.withRegistry("https://${registry}", 'docker-hub-credentials') {       
            app.push("${env.BUILD_NUMBER}")            
            app.push("latest")        
              }    
           }
        }
