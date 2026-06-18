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
                /Users/himanshu/Documents/development/sdk/flutter/bin/flutter analyze || true
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

            emailext(
                subject: "Calorix APK Build #${BUILD_NUMBER} Successful",
                to: "developerhj001@gmail.com",
                body: """
Hello Himanshu,

Your Flutter APK build completed successfully.

Build Number: ${BUILD_NUMBER}

Download APK:
https://wilder-presume-nimbly.ngrok-free.dev/job/calorix-pipeline/lastSuccessfulBuild/artifact/build/app/outputs/flutter-apk/app-release.apk

Build Console:
${BUILD_URL}console

Regards,
Jenkins CI/CD
"""
            )
        }

        failure {
            emailext(
                subject: "Calorix APK Build #${BUILD_NUMBER} Failed",
                to: "developerhj001@gmail.com",
                body: """
Build Failed.

Check Console:
${BUILD_URL}console
"""
            )
        }
    }
}