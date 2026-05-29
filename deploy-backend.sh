#!/bin/bash
set -e

./gradlew :backend-server:bootBuildImage --imageName=dockerizer-backend:0.0.1
docker save -o server.tar dockerizer-backend:0.0.1
sudo ctr -n k8s.io images import server.tar
sudo kubectl rollout restart deploy -n aipub dockerizer-backend
rm -f server.tar

echo "Backend server deployed successfully."
