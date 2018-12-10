#!/bin/bash

sh pg-start.sh

echo '----------------------------------'
echo 'View page at http://localhost:3000'
echo 'If you are using Docker or Vagrant, the port'
echo 'number may be different from 3000.'

if [ -f '/home/winner/shared/ports.txt' ]; then
  cat /home/winner/shared/ports.txt;
fi

echo '------------------------------------'
echo 'heroku local -f Procfile.development'
heroku local -f Procfile.development
