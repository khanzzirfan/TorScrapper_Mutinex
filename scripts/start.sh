#!/bin/sh
DIR=$( cd "$(dirname "$0")" ; pwd -P )
. $DIR/env.sh
(
cd $BASEDIR/init
echo "--- Shutdown services ---"
./down_proxy.sh
echo "--- Restart privoxy service ---"
./restart_privoxy.sh
echo "--- Start tor instance ---"
./start_tor.sh
echo "\nTo check if all the links are working, test these command with a valid onion website. If you can see the page of your onion, you're all good."
echo "curl --socks5-hostname 127.0.0.1:9051 http://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/"
echo "curl --socks5-hostname 127.0.0.1:9054 http://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/"
echo "curl --proxy 127.0.0.1:3129 http://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/"
echo "curl --proxy 127.0.0.1:3132 http://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/"
)


