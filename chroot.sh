mount -t proc proc /home/jeremy/workspace/proc/
mount -t devpts devpts /home/jeremy/workspace/dev/pts/
mkdir -p /home/jeremy/workspace/.X11-unix /home/jeremy/workspace/root/.ssh
mount --rbind /tmp/.X11-unix/ /home/jeremy/workspace/.X11-unix/
mount --rbind /home/jeremy/.ssh /home/jeremy/workspace/root/.ssh
xhost +
chroot /home/jeremy/workspace /bin/bash --login
