#!groovy​
node('devel8-head') {
    def app
    checkout scm

    stage('build'){
        sh 'python3 setup.py bdist_wheel'
        def tag = 'dbc-recomole'
        app = docker.build("$tag:${env.BUILD_NUMBER}", '--pull --no-cache .')
    }

    stage('push') {
        docker.withRegistry('https://docker.dbc.dk', 'docker') {
            app.push()
            app.push('latest')
        }
    }
}