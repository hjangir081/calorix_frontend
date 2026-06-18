pipeline {
    agent any

    environment {
        FLUTTER = "/Users/himanshu/Documents/development/sdk/flutter/bin/flutter"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Version') {
            steps {
                sh '${FLUTTER} --version'
            }
        }

        stage('Pub Get') {
            steps {
                sh '${FLUTTER} pub get'
            }
        }

        stage('Analyze') {
            steps {
                sh '${FLUTTER} analyze'
            }
        }

        stage('Build APK') {
            steps {
                sh '${FLUTTER} build apk --release'
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk'
        }
    }
}