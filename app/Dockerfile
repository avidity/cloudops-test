FROM app:latest

# Set the working directory inside the container
WORKDIR /app

# Install git to clone the repository
RUN apt-get update && apt-get install -y git

# Clone the repository from the provided Git URL
ARG GIT_URL=https://github.com/avidity/cloudops-test.git
RUN git clone $GIT_URL /app

# Set the default tag to 'latest' if not provided as a build argument
ARG TAG=latest

# Install the required Python modules using pip
RUN pip install -r /app/requirements.txt

# Set the environment variable to bind to localhost only
ENV HOST=127.0.0.1

# Expose port 8000 to access the application
EXPOSE 8000

# Start the application using the provided tag or 'latest'
CMD python /app/server.py
