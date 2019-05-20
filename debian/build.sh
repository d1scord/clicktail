#!/bin/sh
export PATH=/usr/local/go/bin:$PATH

TARGET=
if [ -z "$GOPATH" ]; then
	if [ -d debian/clickmon ]; then
		D=$(pwd)/debian/clickmon/go
		mkdir -p $D
	else
		D=$(mktemp -d)
	fi
	trap "rm -rf $D" EXIT
	export GOPATH=$D
	mkdir -p $D/src/github.com/Altinity/clicktail
	#go get github.com/Altinity/libclick-go
	rsync -a --exclude debian/ ./ $D/src/github.com/Altinity/clicktail/
	TARGET=$(pwd)
	cd $D/src/github.com/Altinity/clicktail
fi
        
GOOS=linux GOARCH=amd64 go build -o $TARGET/bin/clicktail
