### Custom Docker Build for deploying a custom APIcast gateway image on OpenShift 

#### Steps to follow:

##### Pre-reqs

- OpenShift cluster running and with a Redis instance already deployed
- Persistent volume configured (tokens for client update are stored)
- User running the commands in OpenShift must be allowed to pull and build images 

***

The DockerFile is recognised by OpenShift and will initiate a Docker build in this case when deploying a new app. I have an example DockerFile in this project for installing additional dependencies to enable the dynamic client registrations feature based on the [APIcast docs](https://github.com/3scale/apicast/tree/master/examples/rh-sso)

###### Step 1

Create a new project as shown in the 3scale docs [here](https://support.3scale.net/docs/deployment-options/apicast-openshift) and the secret necessary for pulling the configuration from your 3scale account.

###### Step 2

Execute `oc new-app https://mygithub-repo/my-project/.git`, you should see a new build started success message in the output.

###### Step 3

In the build logs, either from the console or the command line you will see the build take place and after about 5-10 minutes it should be complete and you will need to take the URL you see. This URL is the location of the custom image in the internal OpenShift registry. Replace the value of the original image in the 3scale APIcast template. In [this](https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.0.0.GA/apicast-gateway/apicast.yml) template you will see the image in the DeploymentConfig object, replace this with the new value.