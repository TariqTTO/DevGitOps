# datauniverse GitOps Repository Structure

This repository demonstrates a comprehensive GitOps implementation for Kubernetes applications using multiple tools and environments.

## Repository Overview

This GitOps repository follows a structured approach with clear separation of concerns:
- **Applications**: Kubernetes application manifests
- **Clusters**: Environment-specific GitOps tool configurations
- **Infrastructure**: Cross-cutting infrastructure concerns

## Directory Structure

```
ps-implementing-gitops/
├── apps/                    # Application manifests
│   ├── base/               # Base application configuration
│   ├── dev/                # Development environment overlays
│   ├── staging/            # Staging environment overlays
│   └── prod/               # Production environment overlays
├── clusters/               # Environment-specific GitOps configurations
│   ├── dev/                # Development cluster (ArgoCD)
│   ├── staging/            # Staging cluster (Terraform)
│   └── prod/               # Production cluster (FluxCD)
└── infrastructure/         # Cross-cutting infrastructure concerns
    ├── base/               # Base infrastructure configuration
    └── overlays/           # Environment-specific infrastructure overlays
        ├── dev/
        ├── staging/
        └── prod/
```

## Applications (`apps/`)

### Base Configuration (`apps/base/`)
- **deployment.yaml**: Base deployment manifest
- **service.yaml**: Base service manifest
- **kustomization.yaml**: Kustomize configuration for base resources

### Environment Overlays
Each environment has its own overlay with environment-specific configurations:

#### Development (`apps/dev/`)
- **namespace.yaml**: Development namespace definition
- **deployment-patch.yaml**: Development-specific deployment patches
- **kustomization.yaml**: Kustomize configuration for dev environment

#### Staging (`apps/staging/`)
- **namespace.yaml**: Staging namespace definition
- **deployment-patch.yaml**: Staging-specific deployment patches
- **kustomization.yaml**: Kustomize configuration for staging environment

#### Production (`apps/prod/`)
- **namespace.yaml**: Production namespace definition
- **deployment-patch.yaml**: Production-specific deployment patches
- **kustomization.yaml**: Kustomize configuration for production environment

## Clusters (`clusters/`)

### Development Cluster (`clusters/dev/`)
Uses **ArgoCD** for GitOps:
- **applications/**: ArgoCD Application resources
- **applicationsets/**: ArgoCD ApplicationSet resources for multi-environment management

### Staging Cluster (`clusters/staging/`)
Uses **Terraform** for infrastructure management:
- **main.tf**: Terraform configuration
- **variables.tf**: Terraform variables
- **outputs.tf**: Terraform outputs

### Production Cluster (`clusters/prod/`)
Uses **FluxCD** for GitOps:
- **flux-system/**: FluxCD system components
- **kustomization.yaml**: FluxCD Kustomization resources
- **source.yaml**: FluxCD GitRepository sources

## Infrastructure (`infrastructure/`)

### Base Configuration (`infrastructure/base/`)
- **namespaces/**: Base namespace definitions
- **network-policies/**: Base network policy configurations
- **rbac/**: Base RBAC configurations
- **resource-management/**: Base resource quotas and limits
- **kustomization.yaml**: Kustomize configuration for base infrastructure

### Environment Overlays (`infrastructure/overlays/`)
Each environment has specific infrastructure requirements:

#### Development (`infrastructure/overlays/dev/`)
It follows Kustomize patching strategy at the folder level:
- **namespaces/**: Development namespace patches
- **network-policies/**: Development network policy patches
- **rbac/**: Development RBAC patches
- **resource-management/**: Development resource management patches

#### Staging (`infrastructure/overlays/staging/`)
It follows Kustomize patching strategy at the folder level:
- **namespaces/**: Staging namespace patches
- **network-policies/**: Staging network policy patches
- **rbac/**: Staging RBAC patches
- **resource-management/**: Staging resource management patches

#### Production (`infrastructure/overlays/prod/`)
It follows Kustomize patching strategy at the root level:
- All the patches are at the root level with a single kustomization.yaml file.

## GitOps Tools Used

1. **ArgoCD** (Development): Application deployment and sync
2. **FluxCD** (Production): GitOps automation and reconciliation
3. **Terraform** (Staging): Infrastructure as Code for cluster setup
4. **Kustomize**: Configuration management and environment-specific overlays

## Key Features

- **Multi-environment support**: Separate configurations for dev, staging, and production
- **Tool diversity**: Demonstrates different GitOps tools for different environments
- **Infrastructure as Code**: Comprehensive infrastructure management
- **Security**: RBAC and network policies for each environment
- **Resource management**: Quotas and limits per environment
- **Base and overlay pattern**: DRY principle with environment-specific customizations

## Usage

1. **Development**: ArgoCD monitors the repository and deploys applications to dev cluster
2. **Staging**: Terraform manages infrastructure, applications deployed via GitOps
3. **Production**: FluxCD ensures production deployments follow GitOps principles

This structure provides a complete GitOps implementation showcasing best practices for managing Kubernetes applications across multiple environments with different tooling strategies.
