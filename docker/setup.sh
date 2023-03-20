#!/bin/bash

[ ! -d "/var/www" ] && sudo mkdir /var/www


[ -d "/var/www/fgtacloud4u" ] && sudo rm /var/www/fgtacloud4u
sudo ln -s /home/agung/Development/fgtacloud4u/ /var/www/fgtacloud4u

GROUPNAME=$(id -gn $USER)
sudo chown $USER:$GROUPNAME /var/www/fgtacloud4u


[ -d "/var/www/fgtacloud4u/server/apps/content" ] && rm /var/www/fgtacloud4u/server/apps/content
[ -d "/var/www/fgtacloud4u/server/apps/crm" ] && rm /var/www/fgtacloud4u/server/apps/crm
[ -d "/var/www/fgtacloud4u/server/apps/deploy" ] && rm /var/www/fgtacloud4u/server/apps/deploy
[ -d "/var/www/fgtacloud4u/server/apps/ent" ] && rm /var/www/fgtacloud4u/server/apps/ent
[ -d "/var/www/fgtacloud4u/server/apps/etap" ] && rm /var/www/fgtacloud4u/server/apps/etap
[ -d "/var/www/fgtacloud4u/server/apps/finact" ] && rm /var/www/fgtacloud4u/server/apps/finact
[ -d "/var/www/fgtacloud4u/server/apps/helpdesk" ] && rm /var/www/fgtacloud4u/server/apps/helpdesk
[ -d "/var/www/fgtacloud4u/server/apps/hrms" ] && rm /var/www/fgtacloud4u/server/apps/hrms
[ -d "/var/www/fgtacloud4u/server/apps/media" ] && rm /var/www/fgtacloud4u/server/apps/media
[ -d "/var/www/fgtacloud4u/server/apps/retail" ] && rm /var/www/fgtacloud4u/server/apps/retail

ln -s /var/www/fgtacloud4u/server_apps/content /var/www/fgtacloud4u/server/apps/content
ln -s /var/www/fgtacloud4u/server_apps/crm /var/www/fgtacloud4u/server/apps/crm
ln -s /var/www/fgtacloud4u/server_apps/deploy /var/www/fgtacloud4u/server/apps/deploy
ln -s /var/www/fgtacloud4u/server_apps/ent /var/www/fgtacloud4u/server/apps/ent
ln -s /var/www/fgtacloud4u/server_apps/etap /var/www/fgtacloud4u/server/apps/etap
ln -s /var/www/fgtacloud4u/server_apps/finact /var/www/fgtacloud4u/server/apps/finact
ln -s /var/www/fgtacloud4u/server_apps/helpdesk /var/www/fgtacloud4u/server/apps/helpdesk
ln -s /var/www/fgtacloud4u/server_apps/hrms /var/www/fgtacloud4u/server/apps/hrms
ln -s /var/www/fgtacloud4u/server_apps/media /var/www/fgtacloud4u/server/apps/media
ln -s /var/www/fgtacloud4u/server_apps/retail /var/www/fgtacloud4u/server/apps/retail


declare -a arr=("fgta" "kalista" "ferrine" "tvone")
for i in "${arr[@]}"
do
   clientdir="/var/www/fgtacloud4u/server_clients/$i"
   
   echo $clientdir
   
   [ -d $clientdir/images ] && rm $clientdir/images
   ln -s /var/www/fgtacloud4u/server/public/images $clientdir/images

   [ -d $clientdir/jslibs ] && rm $clientdir/jslibs
   ln -s /var/www/fgtacloud4u/server/public/jslibs $clientdir/jslibs


   [ -d $clientdir/templates ] && rm $clientdir/templates
   ln -s /var/www/fgtacloud4u/server/public/templates $clientdir/templates

   [ -f $clientdir/index.php ] && rm $clientdir/index.php
   ln -s /var/www/fgtacloud4u/server/public/index.php $clientdir/index.php

   [ -f $clientdir/getotp.php ] && rm $clientdir/getotp.php
   ln -s /var/www/fgtacloud4u/server/public/getotp.php $clientdir/getotp.php
  
   [ -f $clientdir/getcfs.php ] && rm $clientdir/getcfs.php
   ln -s /var/www/fgtacloud4u/server/public/getcfs.php $clientdir/getcfs.php



done


./dockerdown
./dockerup

