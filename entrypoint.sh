#!/bin/sh

function cleanup {
    umount /merged
	umount /unionfs
}

mergerfs -o rw,use_ino,nonempty,allow_other,statfs_ignore=nc,func.getattr=newest,category.action=all,category.create=ff,cache.files=auto-full,dropcacheonclose=true,fsname=mergerfs /disks/*: /merged


trap cleanup EXIT INT

while [[ $(ps -eo 'comm' | grep mergerfs -c) -gt 0 ]]; do
    sleep 1
done

echo mergerfs terminated