pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /home/jenkins/.m2:/root/.m2 -m 256m'
        }

      }
      steps {
        sh 'mvn -B -DskipTests=true clean package'
        archiveArtifacts 'target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar'
      }
    }

    stage('Tests-unit') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /home/jenkins/.m2:/root/.m2 -m 256m'
        }

      }
      steps {
        sh 'mvn test'
      }
    }

    stage('Tests-integration') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /home/jenkins/.m2:/root/.m2 -m 256m'
        }

      }
      steps {
        sh 'mvn verify'
        archiveArtifacts 'target/site/jacoco-both/*.html'
      }
    }

    stage('Deploy') {
      agent {
        node {
          label 'master'
        }

      }
      steps {
        copyArtifacts(projectName: '${JOB_NAME}', selector: specific('${BUILD_NUMBER}'), filter: 'target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar', target: 'target/', fingerprintArtifacts: true)
        ansiblePlaybook(playbook: 'ansible/deploy_app.yml', become: true, inventory: 'ansible/hosts')
      }
    }

  }
}