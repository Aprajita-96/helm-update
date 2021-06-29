export IMAGE_VERSION=1
export CONTAINER_REGISTRY=hackathon2021
export CLUSTER_NAME=mycluster-free
export API_KEY=3TaYlRk_xKh59hpXh--bTs62AfyFoHCI2ar_7RHB4ARi

#mine
#export REGISTER_CONTAINER=hackathon21
#export CLUSTER_NAME=hackathin-cluster
#export API_KEY=80tqkw24meH2NVfI1gU82gKQVs6FrcyW5zhx0hxzvjHe


ibmcloud login -a https://cloud.ibm.com --no-region --apikey $API_KEY
#-4LWSxEQ7LRmBuIau0pkJXqaf41O9cZVv7ju0I16kBdP

ibmcloud ks init

# CONFIGURE KUBECTL
ibmcloud ks cluster config --cluster $CLUSTER_NAME

ibmcloud cr login

docker build --no-cache --pull -f ../dockerfiles/cos-connector/Dockerfile -t us.icr.io/$CONTAINER_REGISTRY/hackathon-go:$IMAGE_VERSION ..
docker push us.icr.io/$CONTAINER_REGISTRY/hackathon-go:$IMAGE_VERSION

#docker build --no-cache --pull -f ../dockerfiles/notification/Dockerfile -t us.icr.io/hackathon21/hackathon-notification:$IMAGE_VERSION ..
docker build -f ../dockerfiles/notification/Dockerfile -t us.icr.io/$CONTAINER_REGISTRY/hackathon-notification:$IMAGE_VERSION ..
docker push us.icr.io/$CONTAINER_REGISTRY/hackathon-notification:$IMAGE_VERSION

helm upgrade -i hackathon ./helm --set image.number=$IMAGE_VERSION