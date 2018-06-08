node {
   // Sans commentaires
    def branchName = 'unknow' 
    def colorMap = [ 'STARTED': '#F0FFFF', 'SUCCESS': '#008B00', 'FAILURE': '#FF0000' ]

   stage('Preparation') {
     sh 'printenv'
     slackSend color: colorMap['STARTED'], message: "Build Started - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
     checkout scm
   }
   stage('install') {
        sh 'echo install'
   }
   stage('test') {
       try{
          sh 'echo test'
          sh " git rev-parse --abbrev-ref HEAD > .git/branch-name"                        
          branchName = readFile('.git/branch-name').trim()
          slackSend color: colorMap['SUCCESS'], message: "Les tests du job ${env.JOB_NAME} sur la branche ${env.GIT_BRANCH} ou ${branchName} ou ${BRANCH_NAME} sont passés"	
        } catch (exc)  {
            slackSend color: colorMap['FAILURE'], message: "Les tests du job ${env.JOB_NAME} ont échoués - ${exc}"
	        throw exc
        }
   }
}
