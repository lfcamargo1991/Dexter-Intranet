pipeline{
agent any

stages {
  stage('Git'){
    steps{
      git 'https://github.com/lfcamargo1991/Dexter-Intranet.git'
    }
  }
  
  stage('Sonarqube'){
    environment {
      scanner = tool 'sonar-scanner'
    }
    steps{
      withSonarQubeEnv('sonarqube') {
        sh "${scanner}/bin/sonar-scanner -Dsonar.projectKey=dexter -Dsonar.sources=${WORKSPACE}/intranet -Dsonar.projectVersion=${BUILD_NUMBER} -Dsonar.java.binaries=${WORKSPACE}/* -X"
      }
    }
  }
  
  stage('Deploy'){
    steps{
        script{
            def remote = [:]
            remote.name = 'debian'
            remote.host = '192.168.1.205'
            remote.user = 'root'
            remote.password = 'qwe123@'
            remote.allowAnyHosts = true
            
            echo 'Iniciando Deploy'
            sshCommand remote: remote, command: "docker container run -d --name dexter-intranet -p 80:80 lfcamargo/dexter", sudo: true
        }
    }
  }
}
}