#!/bin/bash
ALLRFCS=true

if [ "$#" -ne 1 ]; then
  rfc=`git status | head -n 1 | cut -d ' ' -f3`
else
  rfc=$1
fi

if [[ $rfc =~ "RFC-[0-9]+" || ALLRFCS ]]; then
  echo "Making patch for $rfc"
else
  echo "Invalid RFC-number '$rfc'"
  exit 1
fi

curbr=`git status | head -n 1 | cut -d ' ' -f3`
git branch -D tmpsquash
git checkout -b tmpsquash STABLE
git merge --squash $rfc
git commit
mkdir ./temp1234
git format-patch STABLE -o ./temp1234
mv ./temp1234/* /home/pvn/patches/$rfc.patch
rm -rf ./temp1234
git checkout $curbr && git pull
pvn@XXXhuracanPVNXXX:/usr/bin$ cat apply_patch
#!/bin/bash
ALLRFCS=true

if [ "$#" -ne 2 ]; then
       echo "Need 2 args: RFC-num and STABLE/TEST/UAT"
       exit 1
fi
rfc=$1
branch=$2

if [[ $rfc =~ "RFC-[0-9]+" || ALLRFCS ]]; then
  echo "Applying patch for $rfc"
else
  echo "Invalid RFC-number '$rfc'"
  exit 1
fi

curbr=`git status | head -n 1 | cut -d ' ' -f3`
git checkout $branch
git pull
echo "APPLYYYIIIINNNNG"
git am --3way /home/pvn/patches/$rfc.patch && git push && git checkout $curbr && git pull || echo "You now have merge conflicts, FIX DAT. ITS A BUCK"

