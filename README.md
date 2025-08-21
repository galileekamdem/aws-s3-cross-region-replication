# AWS S3 Cross-Region Replication – Architecture et Automatisation

Ce projet met en œuvre une solution de réplication interrégionale entre deux buckets Amazon S3, dans le cadre d’un laboratoire réalisé pour renforcer mes compétences en architecture cloud. Il répond à des problématiques de latence, de continuité d’activité et de conformité réglementaire dans un contexte multi-régional.

## Contexte

- **Entreprise simulée** : GlobalTech Innovations
- **Régions AWS concernées** : `us-east-1` (source) → `us-west-1` (destination)
- **Objectifs** :
  - Réduction de la latence pour les utilisateurs en Californie
  - Mise en place d’une stratégie de reprise après sinistre
  - Réplication conforme aux exigences réglementaires locales

## Architecture--- voir (diagramme s3 replication)

- Versioning activé sur les deux buckets
- Règle de réplication configurée via IAM Role
- Réplication automatique des objets avec suivi des versions

## Technologies utilisées

- Amazon S3
- IAM (roles et policies)
- AWS CLI
- Terraform (optionnel)
- GitHub Actions (validation automatisée)

Code

## Guide d'exécution

### Option 1 – Script AWS CLI

1. Configurer AWS CLI avec `aws configure`
2. Modifier `replication-config.json` avec votre ID de compte AWS
3. Exécuter le script :

bash
chmod +x setup-replication.sh
./setup-replication.sh
Vérifier la réplication en uploadant un fichier dans le bucket source

Option 2 – Déploiement Terraform
Initialiser le projet :

bash
terraform init
terraform apply
Terraform provisionne les buckets, le rôle IAM et la règle de réplication

Validation automatique (GitHub Actions)
Un workflow CI vérifie à chaque push :

L’existence des buckets

L’activation du versioning

La présence du rôle IAM

Badge de statut :

![Validate S3 Replication](https://github.com/<utilisateur>/<repo>/actions/workflows/validate-s3-replication.yml/badge.svg)

Résultat attendu
Les objets uploadés dans bucket-virginia-bootcamp sont automatiquement répliqués dans my-replica-bucket-california

Chaque version est conservée grâce au versioning

La configuration est auditable et automatisée

Auteur
Kévin Maruis Kamdem 
developpeur fullstack
DevOps Strategist 
Social Media Manager
AWS Solution Architecte
