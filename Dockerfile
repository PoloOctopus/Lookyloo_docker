FROM ubuntu:24.04

# DEPENDANCIES
RUN apt update
RUN apt install -y curl build-essential tcl git python3-dev ffmpeg

# CLEARING APT CACHE
RUN apt clean autoclean
RUN apt autoremove --yes
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

# CREATING APP FOLDER
RUN mkdir /app
WORKDIR /app

# INSTALLATION

# INSTALL POETRY
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH" 

# INSTALL VALKEY
RUN git clone https://github.com/valkey-io/valkey
WORKDIR /app/valkey
RUN git checkout 7.2
RUN make

# INSTALL LOOKYLOO
WORKDIR /app
RUN git clone https://github.com/Lookyloo/lookyloo.git
WORKDIR /app/lookyloo
RUN poetry --no-cache install
RUN echo LOOKYLOO_HOME="'`pwd`'" > .env
RUN poetry --no-cache run playwright install-deps
RUN poetry --no-cache run playwright install

# CONFIGURATION
RUN cp config/generic.json.sample config/generic.json
RUN cp config/modules.json.sample config/modules.json

# UPDATE CONFIGURATIONS
RUN poetry run update --yes

# START COMMAND
RUN echo "poetry run start\n\
    tail -F logs/lookyloo.log" > start.sh
RUN chmod 700 start.sh
CMD ["/bin/sh", "-c", "./start.sh"]
# The "poetry run start" command exit just after the start of Lookyloo, then, the container stop immediately