pipeline {
  agent {
    docker {
      image 'maven:3-alpine'
      args '-v /root/.m2:/root/.m2 -m 256'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests=true clean package'
        archiveArtifacts 'target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar'
      }
    }

    stage('Tests-unit') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Tests-integration') {
      steps {
        sh 'mvn verify'
        archiveArtifacts 'target/site/jacoco-both/*.html'
      }
    }

    stage('Deploy') {
      agent {
        dockerfile {
          filename 'Dockerfile'
        }

      }
      steps {
        copyArtifacts(projectName: '${JOB_NAME}', selector: specific('${BUILD_NUMBER}'), filter: 'target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar', target: 'target/', fingerprintArtifacts: true)
        ansiblePlaybook(playbook: 'ansible/prepare_host.yml', become: true, inventory: 'ansible/hosts')
      }
    }

  }
}