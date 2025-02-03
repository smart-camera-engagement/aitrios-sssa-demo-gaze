# Gaze Estimation Demo

Digital signage is a great mechanism to communicate, however, there are challenges that may provent businesses from obtaining optimum return on investment.
This demo is to demonstrate how Computer Vision AI can help businesses to assess effectiveness of digital signage in quantifiable way. 

## Challenges

### Lack of Quality Content

You may have beautiful contents but if they are not for the right audience, or the target audience, the contents do not bring any value.  

- Mismatching audience or wrong target audience
- Poor design

Since you cannot control who will look at the signage, you have to carefully select :

- Placement of the digital signage
- Providing right contents to right audience


### Quantify with Gaze Estimation AI model 

You can quantify audience and how long people are looking at the screen with Sony's Gaze Estimateion AI Model.  The AI Model provides :

- Age Range
- Gender
- Face detection
- Head detection
- Body (or person) detection
- Stay Time statistics
- Length of time a person was watching the screen

## Demo Architecture

This demo is designed with following key points:

- Privacy  
  Since we are running AI inference on peopl,e we **do not** want ot send any images.  
- Offline usage  
  For multiple technical and business reasons, many digital signage solutions prefer to operate locally without heavy reliance on cloud connection such as  
      - The amount of metadata a given camera can generate  
      - Privacy concern  
      - Unstable Internet connection


### Architecture

As you can see in the diagram below, key points on this demo are:

- Camera runs AI inference and sends **metadata** to local HTTP server
- Local HTTP server can run post processing 

![alt text](images/demo-architecture-diagram-simple.png)

## Settings

### ```env.yaml``` for applicaiton settings

Settings are done through ```env.yaml``` file.  Make sure to update following sections.  

- ```SCS_REST_API:```
- ```DEVICE:``` 
- ```INI:```
    - ```cmd_param_mode1``` and ```cmd_param_mode2``` with your command parameter file names from ```Command Parameter files``` section below.  
      The application will create these command parameter files dynamically so you can give any name you want.  Just make sure your file names are unique in the project.

```yaml
SCS_REST_API:
  BASE_URL: <Endpoin URL for API>
  CLIENT_ID: <Client ID from AITRIOS Portal>
  CLIENT_SECRET: <Client Secret from AITRIOS Portal>
  TOKEN_URL: https://auth.aitrios.sony-semicon.com/oauth2/default/v1/token
DEVICE:
  DEVICE_ID: <Device ID from Console>
  EDGE_APP_NAME: <Name of Edge App Deployment Concig>
  EDGE_APP_VESION: <Version of Edge App Deployment Config>
  DEPLOY_CONFIG_FW_AI_MODEL: <Name of FW + AI Model Deployment Config>
HOST:
  HOST_IP: <IP Address of Host to receive Image & Metadata>
  HOST_PORT: <Port Number of Host>
INI:
   :
  cmd_param_mode1: <Command Parameter file for Metadata Only>
  cmd_param_mode2: <Command Parameter file for Metadata and Image>
```

- US Endpoint
https://us.console.aitrios.sony-semicon.com/api/v1

- JP Endpoint
https://console.aitrios.sony-semicon.com/api/v1


### Setting up Device

1. Provision T3P device to your AITRIOS project
1. Create Deployment Config for FW, AI Model, and Edge App

> [!TIP]
> If you are using SSS_PM_UStest project, you may use followings:
>
> ```yaml
> EDGE_APP_NAME: AWL_Gaze_Demo_Edge_App  
> EDGE_APP_VESION: "1.00"  
> DEPLOY_CONFIG_FW_AI_MODEL: AWL-GAZE-FW-MODEL
> ```


### Deploying FW, AI Model, and/or Edge App

You may deploy FW + AI model, and/or Edge App from UI.  

> [!IMPORTANT]
> You must create Deployment Configs in Console if you want to deploy from UI.
> Make sure following lines are updated with appropriate Deployment Configuraion names and version number.
> ```yaml
> EDGE_APP_NAME: AWL_Gaze_Demo_Edge_App  
> EDGE_APP_VESION: "1.00"  
> DEPLOY_CONFIG_FW_AI_MODEL: AWL-GAZE-FW-MODEL
> ```

### Comamnd Parameter files
1. The demo app creates Command Parameter files based on ```command_parameter_template.json``` if specified command parameters are not registered in the project.  

1. If command parameter files exist, then the app will update Host IP and Host Port, if neccesary. 

1. Update ```ModelId``` to match to your Model ID in Console. 

> [!IMPORTANT]
> If you are running container, you have to bind updated ```command_parameter_template.json``` to ```/home/sss-demo/app/command_parameter_template.json```  
> e.g.   
> ```shell
> -v <path to your command parameter template.json>:/home/sss-demo/app/command_parameter_template.json
> ```

### Capturing Background Image

You can capture a background image from the event venue.  

> [!IMPORTANT]
> The captured image will not be saved.  As a result, you must capture image everytime you start the application.
> 

## Running the app

## Linux Container
1. Install Docker Desktop
1. Pull Container  
    ```shell
    docker pull sssademo/sss-gaze-demo:amd64-v2.2.6
    ```

1. Run Container   
    ```shell
    docker run -it --rm -p 8080:8080 -v /home/pi/data/env.yaml:/home/sss-demo/env.yaml:ro sssademo/sss-gaze-demo:amd64-v2.2.6
    ```

> [!TIP]
> You can use runcontainer.sh to run Container on Linux.  
> You may need to change parameters for your environment.

### Raspbian

1. Install Docker  

    ```
    sudo apt-get update && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh && \
    sudo gpasswd -a $USER docker && \
    newgrp docker
    ```
1. Reboot  

   ```
   sudo reboot now
   ```
1. Run container with :  

    ```shell
    docker run -it --rm -p 8080:8080 -v /home/pi/data/env.yaml:/home/sss-demo/env.yaml:ro sssademo/sss-gaze-demo:arm64-v2.2.6
    ```

## Windows Container
1. Install Docker Desktop  
   https://www.docker.com/products/docker-desktop/

2. Pull container

    ```cmd
    docker pull sssademo/sss-gaze-demo:amd64-v2.2.6
    ```

1. Run Container  

    ```shell
    docker run -it --rm -p 8080:8080 -v c:\data\env.yaml:/home/sss-demo/env.yaml:ro sssademo/sss-gaze-demo:amd64-v2.2.6
    ```

1. You may need to set Port Forwarding.

    Example : 

    ```cmd
    netsh.exe interface portproxy delete v4tov4 listenaddress=192.168.10.121 listenport=8080
    netsh.exe interface portproxy add v4tov4 listenaddress=192.168.10.121 listenport=8080 connectaddress=172.24.164.75 connectport=8080
    ```

### Python App

1. Install Python 3.10 or above
1. Install npm 10.8 or above

> [!TIP]
> You can use setup-for-local-execution.sh on Linux.  
> 

1. Install Pip
1. Install libraries
    ```shell
    pip3 install -r .\container\baseOS\requirements.txt
    ```
1. Install Pakages  
    ```shell
    cd ./app/www/static/js
    npm install
    ```

1. Run the app with : 
  
    ```shell
    cd app
    python3 ./main.py
    ```

## Options

### Running container with ```--restart``` option

You may configure your container to run automatically on system boot with :

1. Start Docker daemon 

    ```shell
    sudo systemctl start docker
    ```

1. Run container with "--restart=always" option  

    ```shell
    docker run -d --restart=always -p 8080:8080 -v /home/pi/data/env.yaml:/home/sss-demo/env.yaml:ro sssademo/sss-gaze-demo:amd64-v2.2.6
    ```

### Giving an uniqu name to container

You can give your own unique name to your container with ```--name``` option.  

E.g.  

```
docker run --name my-gaze-container -d -restart=always -p 8080:8080 -v /home/pi/data/env.yaml:/home/sss-demo/env.yaml:ro sssademo/sss-gaze-demo:amd64-v2.2.6
```

### Specifying Backgroun Image

You can specify an image file to be used by mounting JPEG file.

E.g. 

```
-v <path to your image file>:/home/sss-demo/app/www/resources/bg_img.jpg:ro"
```

### Specifying Movie File for Portrait Mode

You can specify a movie file to be used by mounting MP4 file.

```
-v <path to your MP4 file>:/home/sss-demo/app/www/resources/movie.mp4:ro"
```
## Key Functionalities

You may change application for different AI models, for example.  Following files are per AI Model/Edge App.  You can change/write code for these components to customize for your AI Model.

Model and App dependent files are in 

### `model_processor.py`

This file contains functions for specific operations for :
- Demo Application Settings/behavior
- Deserializing Metadata
- Processing Metadata for UI to consume
- Process / Modify / Update Command Parameter File

### `model_process.js`

This files contains model/app specific functions for UI.

### Adding Movie for Portrait Display

You can specify a movie file with :

#### Python App

Copy a movie file to `app/www/resources/movie.mp4`

#### Container

Mount a movie file from local file system with :  

```
-v <Local Path to the movie file>:/home/sss-demo/app/www/resources/movie.mp4:ro \
```

See example in `run-container.sh`

## Remaining work in plan

- Review/cleanup Dashboard code.
- Review/cleanup env.yaml
- Add ROI setting UI (maybe?)