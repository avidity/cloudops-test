# Avidity DevOps Engineer Test

1. Clone this repository
2. Make the necessary changes / deliverables
3. Create a Pull Request to deliver it

# I have provided a Dockerfile that sets up the environment to run the Python application.

# To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:
docker build -t app .

# To run the application in a container:
docker run -p 8000:8000 app

# This will start the container, and we can access the application in the web browser at http://localhost:8000
# Remember that it will only bind to 127.0.0.1:8000, so it won't be accessible from outside the container.
