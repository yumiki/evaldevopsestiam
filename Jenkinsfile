node {
   // Sans commentaires
    def colorMap = [ 'STARTED': '#F0FFFF', 'SUCCESS': '#008B00', 'FAILURE': '#FF0000' ]

   stage('Preparation') {
     slackSend color: colorMap['STARTED'], message: "Build Started - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
     checkout scm
   }
   stage('install') {
        sh 'echo instal'
   }
   stage('test') {
       try{
            sh 'echo test'
	        slackSend color: colorMap['SUCCESS'], message: "Les tests du job ${env.JOB_NAME} sont passés"	
        } catch (exc)  {
            slackSend color: colorMap['FAILURE'], message: "Les tests du job ${env.JOB_NAME} ont échoués - ${exc}"
	        throw exc
        }
   }
}