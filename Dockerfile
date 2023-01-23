FROM osrf/ros:melodic-desktop-full
LABEL Name=ros1_app Version=0.0.3

SHELL [ "/bin/bash" , "-c" ]

# Install base utilities
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get install -y tree && \
    apt-get install -y tmux && \
    rm -rf /var/lib/apt/lists/*

#install ros relevant packages
# RUN apt-get update && \
#     rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Initialize conda & restart shell
RUN conda init bash && \
    exec bash && \
    conda activate base

# Install python packages
RUN pip install empy \
                catkin_pkg \
                rospkg

# RUN source /opt/ros/noetic/setup.bash
# RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN source /opt/ros/melodic/setup.bash
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc