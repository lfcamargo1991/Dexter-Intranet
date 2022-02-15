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
        sh "${scanner}/bin/sonar-scanner -Dsonar.projectKey=java -Dsonar.sources=${WORKSPACE} -Dsonar.projectVersion=${BUILD_NUMBER} -Dsonar.java.binaries=${WORKSPACE}/* -X"
      }
    }
  }
  
  stage('Quality Gate') {
    steps{
      waitForQualityGate abortPipeline: true
          }
  }

  stage('Deploy'){
    steps{
      echo 'Atualizando imagem'
      docker build -t lfcamargo/dexter .
      docker push lfcamargo/dexter

      echo 'Iniciando Deploy'
      docker container run -d --name dexter-intranet -p 80:80 lfcamargo/dexter
    }
  }
}
}