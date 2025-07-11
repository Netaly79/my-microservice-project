pipelineJob("goit-django-docker") {
  description("Pipeline job for Django project")
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/Netaly79/my-microservice-project.git")
            credentials("github-token")
          }
          branches("*/main")
        }
      }
      scriptPath("dj_project/Jenkinsfile")  // путь до Jenkinsfile в репо
    }
  }
}
