# Howest Prime Infrastructure

Production infrastructure for the Howest Prime movies platform, managed as code with Terraform.

This repository provisions the shared Azure and GitHub foundation that supports the client-facing web app, back office application, movies microservice, and ticketing microservice.

## Overview

The project is designed to create a repeatable, environment-based deployment for the Howest Prime ecosystem. It handles:

- Azure resource provisioning
- Shared security and secret management
- Container platform setup
- Database provisioning for backend services
- Event messaging integration
- GitHub Actions pipeline configuration for downstream repositories

## What this infrastructure includes

### Azure platform
- Resource group for the production environment
- Azure Key Vault for secret storage
- Azure Container Registry for image hosting
- Azure Container Apps environment for service hosting
- Azure Log Analytics workspace for operational monitoring
- Managed identity for Azure resource access
- Linux Web Apps for the client-facing site and back office app

### Application data and messaging
- PostgreSQL Flexible Server for the movies microservice
- Azure Cosmos DB with MongoDB API for the ticketing microservice
- CloudAMQP message broker for asynchronous communication

### CI/CD and GitHub integration
- GitHub organization/owner configuration
- GitHub Actions variables and secrets for the movies and ticketing repositories
- Azure service principal setup for CI/CD automation

## Repository structure

- `main.tf` — Terraform version and providers
- `variables.tf` — shared input variables
- `variables.auto.tfvars` — non-sensitive environment configuration
- `variables.sensitive.auto.tfvars` — sensitive environment values (keep local/private)
- `howestprime_wide_resource_group.tf` — resource group definition
- `howestprime_wide_key_vault.tf` — Azure Key Vault setup and access control
- `howestprime_wide_container_registry.tf` — container registry definition
- `howestprime_wide_container_environment.tf` — Azure Container Apps environment
- `howestprime_wide_log_analytics.tf` — monitoring workspace
- `howestprime_wide_managed_identity.tf` — managed identity
- `howestprime_wide_message_broker.tf` — CloudAMQP broker configuration
- `howestprime_microservice_movies.tf` — PostgreSQL and GitHub settings for movies service
- `howestprime_microservice_ticketing.tf` — Cosmos DB and GitHub settings for ticketing service
- `howestprime_client_web_app.tf` — client web application hosting
- `howestprime_client_backoffice.tf` — back office hosting
- `howestprime_wide_github_build_pipeline_service_principal.tf` — CI/CD identity and permissions

## Requirements

Before running Terraform, make sure you have:

- Terraform v1.14.5 or newer
- Azure CLI configured with access to the target subscription
- A valid Azure service principal for Terraform deployment
- A GitHub personal access token with repository access
- CloudAMQP API credentials
- The required environment variables or `.auto.tfvars` values populated

## Configuration

This project uses a combination of:

- `variables.tf` for required input definitions
- `variables.auto.tfvars` for environment-specific names and URLs
- `variables.sensitive.auto.tfvars` for secret values such as Azure credentials and API keys

The environment is configured around a shared Azure resource group and shared secrets in Key Vault, so application repositories can consume generated values securely.

## Deployment flow

Run the following from the repository root:

```bash
terraform init
terraform plan
terraform apply
```

After deployment, Terraform updates the GitHub repositories with generated variables and secrets so the backend services and front-end apps can build and deploy correctly.

## Security notes

- Database access is intentionally open for this educational/project environment. The configuration includes a broad firewall rule because the exact allowed corporate/public IP ranges were not known.
- Sensitive values should never be committed to source control.
- The Key Vault integration is used to store generated credentials such as database passwords and message broker credentials.

## Purpose of this repository

This is the infrastructure layer behind the Howest Prime platform. It does not contain the application business logic itself; instead, it creates and connects the cloud resources that application repositories depend on.

## Status

This repository is set up for production-style Azure provisioning and GitHub automation within the Howest Prime project context.
