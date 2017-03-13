FROM jupyter/scipy-notebook:72cca2a7f3ea

ENV PYTHONIOENCODING="UTF-8"

RUN conda install --quiet --yes \
    'bokeh=0.12*' \
    'datashader=0.4*' && \
    conda clean -tipsy

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg $CONDA_DIR/bin/python -c "import matplotlib.pyplot"

# Install a package to be able to download tcx files from garmin

RUN mkdir /home/$NB_USER/work/data /home/$NB_USER/bin

ENV PATH /home/$NB_USER/bin:$PATH

RUN wget https://github.com/daha/garmin-connect-export/archive/json-summary-dl.zip -O json-summary-dl.zip && \
    unzip json-summary-dl.zip && \
    rm -f json-summary-dl.zip && \
    mv garmin-connect-export-json-summary-dl/gcexport.py /home/jovyan/bin/ && \
    rm -rf garmin-connect-export-json-summary-dl

COPY *.ipynb /home/$NB_USER/work/

USER root

RUN chown $NB_USER /home/$NB_USER/work/*.ipynb && \
    chmod u+rw /home/$NB_USER/work/*.ipynb

USER $NB_USER
