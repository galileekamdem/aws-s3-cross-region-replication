#!/bin/bash

# Variables
SOURCE_BUCKET="bucket-virginia-bootcamp"
DEST_BUCKET="my-replica-bucket-california"
ROLE_NAME="s3-replication-role"
REGION_SOURCE="us-east-1"
REGION_DEST="us-west-1"

echo " Création du rôle IAM pour la réplication..."
aws iam create-role --role-name $ROLE_NAME \
  --assume-role-policy-document file://trust-policy.json

aws iam put-role-policy --role-name $ROLE_NAME \
  --policy-name S3ReplicationPolicy \
  --policy-document file://replication-policy.json

echo " Activation du versioning sur les buckets..."
aws s3api put-bucket-versioning --bucket $SOURCE_BUCKET \
  --versioning-configuration Status=Enabled --region $REGION_SOURCE

aws s3api put-bucket-versioning --bucket $DEST_BUCKET \
  --versioning-configuration Status=Enabled --region $REGION_DEST

echo " Configuration de la règle de réplication..."
aws s3api put-bucket-replication --bucket $SOURCE_BUCKET \
  --replication-configuration file://replication-config.json \
  --region $REGION_SOURCE

echo " Réplication configurée avec succès !"
