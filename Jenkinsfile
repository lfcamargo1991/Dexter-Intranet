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
      sh "#ssh root@192.168.1.205 mkdir /root/repots_owasp/dexter-${BUILD_NUMBER}"
      sh "ssh root@192.168.1.205 docker rm -f dexter"

      echo 'GitClone'
      sh "ssh root@192.168.1.205 git clone https://github.com/lfcamargo1991/Dexter-Intranet.git /tmp/dexter-${BUILD_NUMBER}"
      
      echo 'Atualizando imagem'
      sh "ssh root@192.168.1.205 docker build -t lfcamargo/dexter:${BUILD_NUMBER} /tmp/dexter-${BUILD_NUMBER}"
      
      echo 'Push imagem'
      sh "#docker push lfcamargo/dexter"

      echo 'Iniciando Deploy'
      sh "ssh root@192.168.1.205 docker container run -d --name dexter -p 80:80 lfcamargo/dexter:${BUILD_NUMBER}"

      echo 'Iniciando OWASPZAP'
      sh "#docker pull owasp/zap2docker-stable"
      sh "#docker run -dt --name owasp -p 8081:8081 -i owasp/zap2docker-stable /bin/bash"
      sh "#docker exec owasp zap-baseline.py -t http://pudim.com.br/ -x report.xml -I"
      sh "ssh root@192.168.1.205 docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py -t http://192.168.1.205/ -g gen.conf -r /root/repots_owasp/dexter/dexter-${BUILD_NUMBER}.html"
      sh "ssh root@192.168.1.205 cd /root/repots_owasp/dexter/ && python3 -m ComplexHTTPServer"

      echo 'Acessar: http://192.168.1.205:8000/'
    }
  }
}
}
