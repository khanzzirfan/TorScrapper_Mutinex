#!/bin/sh
DIR=$( cd "$(dirname "$0")" ; pwd -P )
. $DIR/env.sh
LIST=`mktemp`
LIST2=`mktemp`
TOR2WEB_JSON=`mktemp`
LIST=`mktemp`
LIST2=`mktemp`
TOR2WEB_JSON=`mktemp`
http_proxy="" https_proxy="" wget --no-check-certificate -O $TOR2WEB_JSON  https://metrics.torproject.org/
#$SCRIPTDIR/import_tor2web.py $TOR2WEB_JSON > $LIST
rm $TOR2WEB_JSON

$SCRIPTDIR/push_list.sh $LIST2
rm $LIST $LIST2
