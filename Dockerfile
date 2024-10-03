FROM python:3.11-slim-buster

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y git && apt-get clean

# Copy requirements file first to leverage caching
COPY requirements.txt .

# Create and activate a virtual environment
RUN python3 -m venv streamlit_env

# Install Streamlit and dependencies
RUN ./streamlit_env/bin/pip install streamlit
RUN ./streamlit_env/bin/pip install -r requirements.txt

# Copy the entire project into the container
COPY . .

# Expose the port
EXPOSE 80

# Command to run the app
CMD ["streamlit_env/bin/streamlit", "run", "app.py"]





# FROM image

# ENV RANDOM1="something" \
    # RANDOM2=" something2" 

# RUN apt update -y && apt install -y xyz

# COPY ./projectfile (copy your code (or whaatever) from your local machine and put it in the container)

# WORKDIR / (where do you want to start?)

# VOLUME /myvolume

# CMD ["/command"]





# Dont forget about caching. Diocker will cache some commands that were successfully ran. 
# (like apt update - if that step was cached, might affect u when installing some external apcakge later in the file)


# create an image that will run streamlit app.
