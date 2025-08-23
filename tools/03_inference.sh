#!/bin/bash

workspace=$(pwd)

shell_type=${SHELL##*/}
shell_exec="exec $shell_type"

# CAN
gnome-terminal -t "can0" -x bash -c "cd ${workspace}; cd ../../X7s/ARX_CAN/arx_can; ./arx_can0.sh; exec bash;"
sleep 0.3
gnome-terminal -t "can1" -x bash -c "cd ${workspace}; cd ../../X7s/ARX_CAN/arx_can; ./arx_can1.sh; exec bash;"
sleep 0.3
gnome-terminal -t "can5" -x bash -c "cd ${workspace}; cd ../../X7s/ARX_CAN/arx_can; ./arx_can5.sh; exec bash;"
sleep 0.3

# Body
gnome-terminal --title="body" -x $shell_type -i -c "cd ../../X7s/body/ROS2; source install/setup.bash; ros2 launch arx_lift_controller x7s.launch.py; $shell_exec"
sleep 1

# X7s
gnome-terminal --title="x7s_l" -x $shell_type -i -c "cd ../../X7s/x7s/ROS2/x7s_ws; source install/setup.bash; ros2 launch arx_x7_controller left_arm_inference.launch.py; $shell_exec"
sleep 0.5
gnome-terminal --title="x7s_r" -x $shell_type -i -c "cd ../../X7s/x7s/ROS2/x7s_ws; source install/setup.bash; ros2 launch arx_x7_controller right_arm_inference.launch.py; $shell_exec"
sleep 1

# Realsense
gnome-terminal --title="realsense" -x $shell_type -i -c "cd ${workspace}; cd ../realsense; ./realsense.sh; $shell_exec"
sleep 3

# Inference
gnome-terminal --title="inference" -x $shell_type -i -c "cd ${workspace}; cd ../act; conda activate act; python inference.py; $shell_exec"    
