# dockerized-jenkins-pypeline

##About

This is docker inside of docker version of jenkins with the 
[pypeline python package]( https://github.cerner.com/JA048043/pypeline "pypeline") added to the image.

This allows you to run pypeline code inside of Jenkins.

If you want to run pypeline code on your existing jenkins machine, just follow the 4 install steps below.

##Install
>git clone https://github.cerner.com/JA048043/dockerized-jenkins-pypeline

>cd dockerized-jenkins-pypeline

>docker build -t docker-jenkins-pypeline .

>docker run --name myjenk --privileged -d -p 8080:8080 docker-jenkins-pypeline

##Setup
You can now visit jenkins in your browser, using your docker machine ip address. (docker-machine ip)

Jenkins will ask for the password, to get it, run the command:

>docker exec myjenk cat /var/jenkins_home/secrets/initialAdminPassword

Copy and paste the output into the password field.

##Write code
Start a new freestyle project in jenkins.

Under 'Build', select 'Add Build Step' and 'Execute shell'

In the shell script, add:

```python
#!/usr/bin/python3

from pypeline.pipeline import Pipeline
from pypeline.config import clientsetup

clientsetup(docker_base_url='unix://var/run/docker.sock')
with Pipeline() as pipe:
    image = pipe.pull('busybox:latest')
    with image.container(echo '"hello world"') as container:
        container.run()
```

Now build. It should all work. Now you can use [pypeline]( https://github.cerner.com/JA048043/pypeline "pypeline") code to write something.
