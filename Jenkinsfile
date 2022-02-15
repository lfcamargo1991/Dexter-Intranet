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
  }
}