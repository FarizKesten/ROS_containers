xhost local:root
xhost +local:docker

XAUTH=/tmp/.docker.xauth
DIR=$(pwd)

# create a directory where the code will be persistant
mkdir -p workspace

#clone some configs
mkdir -p configs
cd configs
rm -rf .vscode || true
[ ! -d ".vscode" ] && git clone -b ros1_kinetic https://github.com/FarizKesten/vscode_configs.git .vscode
cd ..

#clone gazebo models if it doesn't exist yet
mkdir -p .gazebo && cd .gazebo
if [ -z "$(ls -A models)" ]; then
    git clone https://github.com/osrf/gazebo_models.git models
fi


docker run -it\
    --tty=true \
    --name=my_ros1_v5 \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --volume="$DIR/workspace:/home/workspace" \
    --volume="$DIR/configs/.vscode:/home/workspace/.vscode" \
    --volume="$DIR/.gazebo/models:/root/.gazebo/models" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --net=host \
    --privileged \
    ros1_app:0.0.6 \
    bash
