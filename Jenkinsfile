node {
    def colorMap = [ 'STARTED': '#F0FFFF', 'SUCCESS': '#008B00', 'FAILURE': '#FF0000' ]

   stage('Preparation') {
     slackSend color: colorMap['STARTED'], message: "Build Started - ${env.JOB_NAME} ${env.BRANCH_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
     checkout scm
   }
   stage('test') {
       try{
          sh 'echo test'
          sh " git rev-parse --abbrev-ref HEAD > .git/branch-name"                        
          slackSend color: colorMap['SUCCESS'], message: "Les tests du job ${env.JOB_NAME} sur la branche ${env.BRANCH_NAME} sont passés"	
        } catch (exc)  {
            slackSend color: colorMap['FAILURE'], message: "Les tests du job ${env.JOB_NAME} ont échoués - ${exc}"
	        throw exc
        }
   }
	
   stage('docker build/push') {
     docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
       def app = docker.build("yumiki/samplephp:${env.BRANCH_NAME}", '.').push()
     }
   }
}