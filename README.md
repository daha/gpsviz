# GPSviz

This is a project created to visualize GPS data from Garmin.

## Prerequisite
* Docker has been installed.

## Build
Build the docker image with the command below.

```
docker build -t gpsviz .
```

## Run
Run the docker image. Mount the directory data in current working
directory as a directory in the image so all the downloaded data are
available from outside the docker image.

```
docker run --rm -v $(pwd)/data:/home/jovyan/work/data -p 8888:8888 -it gpsviz
```

Open the url listed http://localhost:8888/?token=...... in your
browser. Use the notebook 01-Download-Garmin-activities to download
all your activities form Garmin. If you already have downloaded them,
you can put them in the direcory data/garmin/ relative to the current
working directory. When you have downloaded the tcx files from Garmin
you can run the notebook 10-Visualize-the-data. It contains code to
extract the GPS coordinates from the tcx files and then plot it with
datashader.

## TODO
* Upload the image to docker hub to avoid having to build it
* Add more instructions on how to use it
* Add extra instructions for Windows since the IP will differ and
  volume export also differ.
