#!/bin/bash

sh outline-short.sh

d_mo='tmp/diagram-models.jpg'
d_co='tmp/diagram-controllers.jpg'
d_gems='tmp/diagram-gems.jpg'

echo '---------------'
echo 'Using rails-erd'
bundle exec erd --attributes=foreign_keys,primary_keys,timestamps,inheritance,content --filetype=dot --filename=tmp/diagram-models --inheritance --notation=bachman
dot -Tjpg tmp/diagram-models.dot > $d_mo
echo
echo "Models diagram is at $d_mo"
echo

echo '---------------'
echo 'Using railroady'
bundle exec railroady -i -l TestLabel -v -a --all-columns -j -m -p -z -t --engine-controllers -C | dot -Tjpg > $d_co
echo
echo "Controllers diagram is at $d_co"
echo

echo '-----------------------------------------------------'
echo 'Drawing gem dependency diagram (tmp/diagram-gems.jpg)'
bundle viz --file=tmp/diagram-gems --format=jpg --requirements --version

echo '************************'
echo 'outline.sh OUTPUT FILES:'
echo $d_mo
echo $d_co
echo $d_gems
echo 'Directory trees are in the tmp directory.'
echo
