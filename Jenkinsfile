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
        sh "${scanner}/bin/sonar-scanner -Dsonar.projectKey=dexter -Dsonar.sources=${WORKSPACE}/intranet -Dsonar.projectVersion=ls -Dsonar.java.binaries=${WORKSPACE}/* -X"
      }
    }
  }
  
  stage('Deploy'){
    steps{
      echo 'Preparando ambiente'
      sh "ssh root@192.168.1.205 mkdir /tmp/dexter-${BUILD_NUMBER}"
      sh "ssh root@192.168.1.205 rm -f dexter"

      echo 'GitClone'
      sh "ssh root@192.168.1.205 git clone https://github.com/lfcamargo1991/Dexter-Intranet.git /tmp/dexter-${BUILD_NUMBER}"
      
      echo 'Atualizando imagem'
      sh "ssh root@192.168.1.205 docker build -t lfcamargo/dexter:${BUILD_NUMBER} /tmp/dexter-${BUILD_NUMBER}"
      
      echo 'Push imagem'
      sh "#docker push lfcamargo/dexter"

      echo 'Iniciando Deploy'
      sh "ssh root@192.168.1.205 docker container run -d --name dexter -p 80:80 lfcamargo/dexter:${BUILD_NUMBER}"
    }
  }
}
}
