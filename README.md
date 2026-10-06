
# Prerequisites

- A project needs to exist where the workers will be deployed
- The VPC and subnet also needs to exist for the worker deployment
- A vault auth engine for gcp needs to be configured to use gce authentication for the project and a role that allows the instance group to login with its service account. 

# Using a custom image

To use a custom image provide both the custom image name and image project if it's in a different project than the workers (or just the custom image name if it's in the same project).

