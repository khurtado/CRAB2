#!/bin/bash
#
# make new Crab2 release
#
rel=$1
echo "Will create new Crab2 release for ${rel}"

# something to make sure release exists (beware typos)



pushd /tmp/belforte > /dev/null
rm -rf newcrab2
mkdir newcrab2
cd newcrab2
. $CRABPYTHON/PrepareTarBall.sh $rel
if [ -f ${rel}.tgz ]
then
  echo "tarball created, copy to AFS area"
else
  echo "tarball creation failed"
  exit
fi

cp -v ${rel}.tgz /afs/cern.ch/cms/ccs/wm/scripts/Crab
cd -P /afs/cern.ch/cms/ccs/wm/scripts/Crab

tar xf ${rel}.tgz
cd ${rel}
./configure
cd ..
ln -sf ${rel}/crab.sh ./crab_new.sh
ln -sf ${rel}/crab.csh ./crab_new.csh

cd /afs/cern.ch/cms/ccs/wm/www/Crab/Docs
ln -sfv ../../../scripts/Crab/${rel}.tgz .
ln -sfv ${rel}.tgz CRAB_new.tgz

popd
