node {
        
        stage("scm"){
            cleanWs()
            // Clone the code from github:
            git url :'https://github.com/kyle11235/conan-example.git'
        }
        
        stage("config"){
            try {
                sh "conan remote add demo-conan-virtual http://182.92.214.141:8082/artifactory/api/conan/demo-conan-virtual"
                sh "conan user -p apikey_xxx -r demo-conan-virtual admin"
            } catch (e) {
                echo "demo-conan-virtual already exists in remotes"
            }

            try {
                sh "conan remote add demo-conan-local http://182.92.214.141:8082:8081/artifactory/api/conan/demo-conan-local"
                sh "conan user -p apikey_xxx -r demo-conan-local admin"  
            } catch (e) {
                echo "demo-conan-local already exists in remotes"
            }
 
        }  
        
        stage("resolve"){
            sh "conan install . -r demo-conan-virtual --build missing"
        }   

        stage("upload"){
            sh "cp -r ~/.conan/data/zlib ./"
            sh "ls ./"
            sh "conan upload zlib/1.2.11@conan/stable -r demo-conan-local --all"
        }       
}