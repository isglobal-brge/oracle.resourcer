# This is an example of a Dockerfile to set up a rock instance (version 6.3) compatible with the use of Oracle databases as resources. 
# The dsOMOP package and its extension for Oracle databases are also included.
FROM datashield/rock-base:6.3

# Install devtools
RUN R -e "install.packages('devtools')"

# Install necessary dependencies
RUN apt-get update && apt-get install -y libaio1 unzip wget

# Download and unzip Oracle Instant Client Basic and SDK
RUN wget https://download.oracle.com/otn_software/linux/instantclient/213000/instantclient-basic-linux.x64-21.3.0.0.0.zip \
    && wget https://download.oracle.com/otn_software/linux/instantclient/213000/instantclient-sdk-linux.x64-21.3.0.0.0.zip \
    && mkdir -p /opt/oracle \
    && unzip instantclient-basic-linux.x64-21.3.0.0.0.zip -d /opt/oracle \
    && unzip instantclient-sdk-linux.x64-21.3.0.0.0.zip -d /opt/oracle \
    && rm instantclient-basic-linux.x64-21.3.0.0.0.zip \
    && rm instantclient-sdk-linux.x64-21.3.0.0.0.zip

# Set environment variables
ENV ORACLE_HOME=/opt/oracle/instantclient_21_3
ENV LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
ENV PATH=$ORACLE_HOME:$PATH

# Set compilation options to disable format security warnings
RUN echo "CFLAGS += -Wno-format-security" >> /usr/lib/R/etc/Makeconf

# Install ROracle
RUN R -e "install.packages('ROracle', type='source', configure.args=c('--with-oci-lib=$ORACLE_HOME', '--with-oci-inc=$ORACLE_HOME/sdk/include'))"

# Install oracle.resourcer
RUN R -e "devtools::install_github('isglobal-brge/oracle.resourcer')"

# Install dsOMOP and its Oracle extension
RUN R -e "devtools::install_github('isglobal-brge/dsOMOP')"
RUN R -e "devtools::install_github('isglobal-brge/dsOMOP.oracle')"

# Change ownership of installed packages to 'rock' to avoid conflicts when using Opal UI to administrate
RUN chown -R rock /var/lib/rock/R/library/