# Wisecow – Containerization and Kubernetes Deployment

## Project Overview

This project demonstrates the containerization and deployment of the Wisecow application using Docker and Kubernetes.

The application is deployed on a local Minikube Kubernetes cluster and exposed through an NGINX Ingress Controller with TLS/HTTPS communication.

GitHub Actions is used to automate the Docker image build and push process to Docker Hub, with a Kubernetes deployment stage included in the CI/CD workflow.


## Objectives

- Containerize the Wisecow application using Docker.
- Deploy the application on Kubernetes using Minikube.
- Expose the application using a Kubernetes Service.
- Configure NGINX Ingress for external access.
- Secure application communication using TLS.
- Automate Docker image build and push using GitHub Actions.
- Include Kubernetes deployment as part of the CI/CD workflow.

---

## Architecture

```text
                    Developer
                        |
                        | git push
                        v
                  GitHub Repository
                        |
                        v
                 GitHub Actions
                        |
             +----------+----------+
             |                     |
             v                     v
       Docker Build          Docker Push
             |                     |
             +----------+----------+
                        |
                        v
                    Docker Hub
                        |
                        v
                 Kubernetes
                   Minikube
                        |
                  NGINX Ingress
                        |
                    HTTPS/TLS
                        |
                        v
                Wisecow Service
                        |
                 +------+------+
                 |             |
                 v             v
              Pod 1          Pod 2


