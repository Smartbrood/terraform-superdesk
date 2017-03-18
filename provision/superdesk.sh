#!/usr/bin/env bash


if [ -d /opt/superdesk/server ] ; then
	echo "Superdesk already installed. Skip installation step."
else
	echo "Start Superdesk installation"
	curl -s https://raw.githubusercontent.com/superdesk/fireq/master/files/superdesk/install | sudo bash && echo "Superdesk is installed."
fi
