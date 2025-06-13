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

## Installation verification

Please note that packages which do not expose assign and aggregate methods may be installed correctly on the system, but will not appear in the list of installed packages in the `Administration` > `DataSHIELD` > `(Profile)` > `Packages` section of the Opal UI. This is to avoid displaying other installed packages and dependencies, while focusing solely on DataSHIELD items.

In the case of `oracle.resourcer`, users can verify the installation in the `Administration` > `R` > `(Profile)` > `Packages` section of the Opal UI. This section lists all installed packages and can be filtered by name.

## Example Dockerfile

For educational purposes, we have provided a comprehensive Dockerfile to set up a rock instance with all the necessary dependencies for using `oracle.resourcer`. Additionally, we have included the [`dsOMOP`](https://github.com/isglobal-brge/dsOMOP) package and its extension for Oracle databases [`dsOMOP.oracle`](https://github.com/isglobal-brge/dsOMOP.oracle) (which is built on top of `oracle.resourcer`). 

You can find the Dockerfile at the following link: [oracle.resourcer Dockerfile](inst/docker/Dockerfile)

## Acknowledgements

- The development of dsOMOP has been supported by the **[RadGen4COPD](https://github.com/isglobal-brge/RadGen4COPD)**, **[P4COPD](https://www.clinicbarcelona.org/en/projects-and-clinical-assays/detail/p4copd-prediction-prevention-personalized-and-precision-management-of-copd-in-young-adults)**, **[CADSET](https://www.ersnet.org/science-and-research/clinical-research-collaboration-application-programme/cadset-chronic-airway-diseases-early-stratification/)**, and **[DATOS-CAT](https://datos-cat.github.io/LandingPage)** projects. These collaborations have not only provided essential financial backing but have also affirmed the project's relevance and application in significant research endeavors.
- This project has received funding from the **[Spanish Ministry of Education, Innovation and Universities](https://www.ciencia.gob.es/en/)**, the **[National Agency for Research](https://www.aei.gob.es/en)**, and the **[Fund for Regional Development](https://ec.europa.eu/regional_policy/funding/erdf_en)** **(PID2021-122855OB-I00)**. We also acknowledge support from the grant **CEX2023-0001290-S** funded by **MCIN/AEI/10.13039/501100011033**, and support from the **[Generalitat de Catalunya](https://web.gencat.cat/en/inici/index.html)** through the **[CERCA Program](https://cerca.cat/en/)** and the **Consolidated Group on HEALTH ANALYTICS (2021 SGR 01563)**.
- Additionally, this project has received funding from the **[Instituto de Salud Carlos III (ISCIII)](https://www.isciii.es/)** through the project **"PMP21/00090,"** co-funded by the **[European Union's](https://european-union.europa.eu/index_en)** **Resilience and Recovery Facility**. It has also been partially funded by the **"Complementary Plan for Biotechnology Applied to Health,"** coordinated by the **[Institut de Bioenginyeria de Catalunya (IBEC)](https://ibecbarcelona.eu/)** within the framework of the **Recovery, Transformation, and Resilience Plan (C17.I1)** – Funded by the **[European Union](https://european-union.europa.eu/index_en)** – **[NextGenerationEU](https://next-generation-eu.europa.eu/index_en)**.

## Contact

For further information or inquiries, please contact:

- **Juan R González**: juanr.gonzalez@isglobal.org
- **David Sarrat González**: david.sarrat@isglobal.org

For more details about **DataSHIELD**, visit [https://www.datashield.org](https://www.datashield.org).

For more information about the **Barcelona Institute for Global Health (ISGlobal)**, visit [https://www.isglobal.org](https://www.isglobal.org).