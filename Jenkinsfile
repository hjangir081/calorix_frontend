pipeline {
    agent any

    stages {

        stage('Flutter Version') {
            steps {
                sh '''
                /Users/himanshu/Documents/development/sdk/flutter/bin/flutter --version
                '''
            }
        }

        stage('Pub Get') {
            steps {
                sh '''
                /Users/himanshu/Documents/development/sdk/flutter/bin/flutter pub get
                '''
            }
        }

        stage('Analyze') {
            steps {
                sh '''
                /Users/himanshu/Documents/development/sdk/flutter/bin/flutter analyze
                '''
            }
        }

        stage('Build APK') {
            steps {
                sh '''
                /Users/himanshu/Documents/development/sdk/flutter/bin/flutter build apk --release
                '''
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk'
        }
    }
}