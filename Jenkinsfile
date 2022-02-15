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
      echo 'Atualizando imagem'
      sh "docker build -t lfcamargo/dexter ."
      
      echo 'Push imagem'
      sh "#docker push lfcamargo/dexter"

      echo 'Iniciando Deploy'
      sh "#docker container run -d --name dexter-intranet -p 80:80 lfcamargo/dexter"
    }
  }
}
}
