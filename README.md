# Oracle Resourcer Extension

## Description

`oracle.resourcer` is an extension of the [`resourcer`](https://github.com/obiba/resourcer) package for interacting with resources that point to Oracle databases, allowing connections to be established through [`DBI`](https://cran.r-project.org/package=DBI) using [`ROracle`](https://cran.r-project.org/package=ROracle) as the driver.

## Installation

To use the `oracle.resourcer` package, it is necessary to have Oracle Instant Client Basic and SDK installed on your system. Follow the steps below to install these dependencies:

1. Download the Oracle Instant Client Basic and SDK from the [official Oracle website](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html):
   - Instant Client Basic
   - Instant Client SDK

2. Unzip the downloaded files and move them to a directory of your choice, for example, `/opt/oracle`:
   ```sh
   mkdir -p /opt/oracle
   unzip instantclient-basic-linux.x64-21.3.0.0.0.zip -d /opt/oracle
   unzip instantclient-sdk-linux.x64-21.3.0.0.0.zip -d /opt/oracle
   ```

3. Set the environment variables to point to the Oracle Instant Client installation:
   ```sh
   export ORACLE_HOME=/opt/oracle/instantclient_21_3
   export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
   export PATH=$ORACLE_HOME:$PATH
   ```

4. Install the `ROracle` package in R:
   ```R
   install.packages('ROracle', type='source', configure.args=c('--with-oci-lib=$ORACLE_HOME', '--with-oci-inc=$ORACLE_HOME/sdk/include'))
   ```

5. Finally, install the `oracle.resourcer` package from GitHub:
   ```R
   devtools::install_github('isglobal-brge/oracle.resourcer')
   ```

By following these steps, you will have the necessary dependencies installed to use the `oracle.resourcer` package for interacting with Oracle databases.

## Example Dockerfile

For educational purposes, we have provided a comprehensive Dockerfile to set up a rock instance with all the necessary dependencies for using `oracle.resourcer`. Additionally, we have included the [`dsOMOP`](https://github.com/isglobal-brge/dsOMOP) package and its extension for Oracle databases [`dsOMOP.oracle`](https://github.com/isglobal-brge/dsOMOP.oracle) (which is built on top of `oracle.resourcer`). 

You can find the Dockerfile at the following link: [oracle.resourcer Dockerfile](inst/docker/Dockerfile)
