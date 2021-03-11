podTemplate(containers: [
    containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', ttyEnabled: true, command: 'cat'),
  ]) {

    node(POD_LABEL) {
        stage('Get a Maven project') {
            git 'https://github.com/mysticrenji/jenkins-k8s-cluster-terraform.git'
            container('maven') {
                stage('Build a Maven project') {
                 withSonarQubeEnv('SonarQube') {
                 sh 'mvn clean package sonar:sonar'
              }
                }
            }
        }



    }
}
