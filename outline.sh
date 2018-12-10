#!/bin/bash

sh outline-short.sh

d_gems='log/diagram-gems.jpg'

echo '-----------------------------------------------------'
echo 'Drawing gem dependency diagram (log/diagram-gems.jpg)'
bundle viz --file=log/diagram-gems --format=jpg --requirements --version

echo '************************'
echo 'outline.sh OUTPUT FILES:'
echo $d_gems
echo 'Directory trees are in the log directory.'
echo
