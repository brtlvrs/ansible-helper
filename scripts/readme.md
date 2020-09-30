# scripts

These scripts are used as a wrapper to run the ansible docker image interactively.

## local build image

These scripts are installed automaticly when the image is build localy by using the install script in the root of this repository.

## dockerhub image

When the image is downloaded from dockerhub, the files are stored inside of the image at /2installOnHost/

To copy them to the dockerhost do

```bash
docker copy ansible:2.9.0/2installOnHost/ah* /usr/local/bin/
chmod +x /usr/local/bin/ah*
```
