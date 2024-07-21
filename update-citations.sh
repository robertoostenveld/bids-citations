#!/bin/bash
#
#PBS -l walltime=00:10:00
#PBS -l mem=100Mb
#
# Copyright (C) 2024, Robert Oostenveld

# set up the DCCN environment
# source /opt/optenv.sh
# module load anaconda3
# source activate citations

REPODIR=$(dirname `readlink -f $0`)
cd $REPODIR || exit

if [ "$(uname)" == "Darwin" ]; then
  STAT=$(which gstat)
  DATE=$(which gdate)
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  STAT=$(which stat)
  DATE=$(which date)
fi

LOCKFILE=$REPODIR/citations.lock
LOGFILE=$REPODIR/citations.log

# prevent concurrent execution
while [[ -e $LOCKFILE ]] ; do
  LOCKTIME=$(( $($DATE +"%s") - $($STAT -c "%Y" $LOCKFILE) ))
  if [ "$LOCKTIME" -gt "300" ]; then
    echo removing stale lock
    rm $LOCKFILE
  else
    echo waiting for previous update to complete
    sleep 10
  fi
done

# make sure that these exist
[[ -e $LOGFILE  ]] || touch $LOGFILE
[[ -e $LOCKFILE ]] || touch $LOCKFILE

$REPODIR/update-citations.py mri        27326542 PMC4978148
$REPODIR/update-citations.py meg        29917016 PMC6007085
$REPODIR/update-citations.py eeg        31239435 PMC6592877
$REPODIR/update-citations.py ieeg       31239438 PMC6592874
$REPODIR/update-citations.py genetics   33068112 PMC7568436
$REPODIR/update-citations.py asl        36068231 PMC9448788
$REPODIR/update-citations.py microscopy 35516811 PMC9063519
$REPODIR/update-citations.py pet        35236846 PMC8891322
$REPODIR/update-citations.py qmri       36002444 PMC9402561 

# git checkout master || exit
# git pull origin master || exit
# git add */*.yml
# git commit -am "added papers from Pubmed that cite BIDS"
# git push origin master

date > $LOGFILE
rm $LOCKFILE
