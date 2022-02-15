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
