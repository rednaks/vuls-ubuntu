#!/bin/bash
echo -e "Updating CVE DB:"

for i in `seq 2002 $(date +"%Y")`; do $GOPATH/bin/go-cve-dictionary fetchnvd -years $i; done

echo -e "Updating OVAL:"
$GOPATH/bin/goval-dictionary fetch-ubuntu 14
$GOPATH/bin/goval-dictionary fetch-ubuntu 16
$GOPATH/bin/goval-dictionary fetch-ubuntu 18

echo -e "Updating Gost"
$GOPATH/bin/gost fetch debian

echo -e "Updating Exploits DB"
$GOPATH/bin/go-exploitdb fetch

