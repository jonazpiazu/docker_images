#!/bin/bash

cd ~/dev/workspaces/PotreeConverter/master/build/PotreeConverter
mkdir -p /usr/local/apache2/htdocs/shared_converted

for fullfile in $(find /shared -iregex '.*\.\(ply\|las\|laz\|ptx\)$')
  do echo $fullfile
  filename=$(basename -- "$fullfile")
  filename="${filename%.*}"
  echo $filename
  ./PotreeConverter $fullfile --color-range --material RGB -p $filename -o /usr/local/apache2/htdocs/shared_converted
done

# Start Supervisor
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
