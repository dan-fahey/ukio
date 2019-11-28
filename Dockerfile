FROM rocker/tidyverse:latest
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libreoffice \
  && Rscript -e "remotes::install_github('rstudio/renv')"
WORKDIR /home/rstudio/ukio
COPY renv.lock .
RUN Rscript -e 'renv::restore()'
COPY . .
CMD ["make"]
