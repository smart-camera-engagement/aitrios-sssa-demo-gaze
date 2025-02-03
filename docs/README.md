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
- Applications are packaged as a container  
    - Device Management is done through AITRIOS cloud platform
    - Local HTTP server to recieve metadata from the camera
    - Post processing (Visualization)  
      For the puropose of the demo, it runs visualization application

![alt text](images/demo-architecture-diagram-simple.png)

## Requirements

### Software and Services
- AITRIOS Account
- Console access
- Internet Connection

### Hardware
- Type3 PoE Camera  
- A PC to run container app  
  - Containers are available for Raspbian and Ubuntu
  - Recommend Raspberry Pi 5 with 8GB or more memory
- A monitor or TV
    - Recommendation : 30 inch or bigger screen in portrait mode
- Local Area Network (LAN) setup  
    - Type3 POE camera requires PoE Switch or splitter
    - Type 3 PoE camera and PC (or Raspberry Pi) must be on the same network

## Setting up Gaze Estimation Demo

``To Be Added``


## Resources