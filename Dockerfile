FROM osrf/ros:kinetic-desktop-full
LABEL Name=ros1_app Version=0.0.6

SHELL [ "/bin/bash" , "-c" ]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-kinetic-joy \
    ros-kinetic-teleop-twist-joy \
    ros-kinetic-teleop-twist-keyboard \
    ros-kinetic-laser-proc \
    ros-kinetic-rgbd-launch \
    ros-kinetic-depthimage-to-laserscan \
    ros-kinetic-rosserial-arduino \
    ros-kinetic-rosserial-python \
    ros-kinetic-rosserial-server \
    ros-kinetic-rosserial-client \
    ros-kinetic-rosserial-msgs \
    ros-kinetic-amcl \
    ros-kinetic-map-server \
    ros-kinetic-move-base \
    ros-kinetic-urdf \
    ros-kinetic-xacro \
    ros-kinetic-compressed-image-transport \
    ros-kinetic-rqt* \
    ros-kinetic-interactive-markers \
    ros-kinetic-rqt-image-view \
    ros-kinetic-gmapping \
    ros-kinetic-navigation && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y bash-completion && \
    apt-get install -y sudo && \
    apt-get install -y apt-utils && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get install -y tree && \
    apt-get install -y tmux && \
    apt-get install -y libopencv-dev && \
    apt-get install -y protobuf-compiler && \
    rm -rf /var/lib/apt/lists/*

# set-up tmux environment
RUN /bin/bash -c "wget https://raw.githubusercontent.com/FarizKesten/tmux_config/main/tmux.conf -P /etc/"

# Install TuertleBot3 packages
RUN apt-get update && \
    apt-get install -y ros-kinetic-dynamixel-sdk && \
    apt-get install -y ros-kinetic-turtlebot3-msgs && \
    apt-get install -y ros-kinetic-turtlebot3 && \
    apt-get install -y ros-kinetic-navigation && \
    apt-get install -y ros-kinetic-map-server && \
    apt-get install -y ros-kinetic-move-base && \
    apt-get install -y ros-kinetic-amcl && \
    rm -rf /var/lib/apt/lists/*

# Install PGM map creater
RUN apt-get update && \
    apt-get install libignition-math2-dev protobuf-compiler && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
# ENV CONDA_DIR /opt/conda
# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#      /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
# ENV PATH=$CONDA_DIR/bin:$PATH

# Initialize conda & restart shell
# RUN conda init bash && \
#     exec bash && \
#     conda activate base

# Install python packages
# RUN pip install empy \
#                 catkin_pkg \
#                 rospkg

RUN source /opt/ros/kinetic/setup.bash
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc