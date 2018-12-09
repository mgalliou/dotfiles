# WORK IN PROGESS
# DON'T USE THIS FILE AS A SCRIPT

KDE_PKGS=plasma-meta kde-applications-meta networkmanager network-manager-applet
#after that disable dhcpcd, and enable NetworkManager services

#update system clock
timedatectl set-ntp true

#partitioning
parted /dev/sda
mkfs.ext4 /dev/sda1
mount /dev/sda1/mnt

#edit mirror priority
vi /etc/pacman.d/mirrorlist

#install base
pacstrap /mnt base

#fstab
genfstab -U /mnt >> /mnt/etc/fstab

#change root
arch-chroot /mnt

#time
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

#local
vi /etc/locale.gen
locale-gen

#host
echo "myhostname" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1	localhost
::1			localhost
127.0.1.1	myhostname.localdomain myhostname
EOF

#change consol font
echo "FONT=Lat2-Terminus16" > /etc/vconsole.conf

#network
systemctl enable dhcpcd.service

#setup password
passwd

#install core
#install boot loader
pacman -S intel-ucode
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#exit chroot and reboot
exit
unmount -R /mnt
reboot

#post install
echo -n "	user name: "
read USER
useradd -m -g users -s /bin/bash $USER
passwd $USER
echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

pacman -S base base-devel sudo alsa-utils mesa xorg i3 urxvt compton
