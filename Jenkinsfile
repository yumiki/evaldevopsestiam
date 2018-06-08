node {
    def commit_id
    def colorMap = [ 'STARTED': '#FFFFFF', 'SUCCESS': '#008B00', 'FAILURE': '#FF0000' ]

   stage('Preparation') {
     slackSend color: colorMap['STARTED'], message: "Build Started - ${env.JOB_NAME} ${env.BRANCH_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
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
       def app = docker.build("yumiki/samplephp:${env.BRANCH_NAME}_${commit_id}", '.').push()
       slackSend color: colorMap['PUBLISHED'], message: "Le projet à bien été publier sur le hub de docker à l'adresse https://hub.docker.com/r/yumiki/samplephp/"

     }
   }
}