#!/usr/bin/fish

git fetch
set changedfiles (git diff --name-only HEAD..origin/master)
for i in $changedfiles
    echo File changed: $i
    if test -e $i.sig
        echo Deleting signature because the file was changed.
        rm -v $i.sig
    end
end
git merge origin/master
echo (date +%s) > /srv/ftp/lastupdate
echo (date +%s) > /srv/ftp/lastsync
