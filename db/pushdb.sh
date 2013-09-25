#!/bin/sh
pg_dump -Fc --no-acl --no-owner -h localhost -U dacmanj chapter_map > chapter-map.dump
scp chapter-map.dump pflagweb@pflag.org:/home/pflagweb/pflag.org
heroku pgbackups:restore DATABASE 'https://pflag.org/chapter-map.dump' --confirm pflag-chapter-map
ssh pflagweb@pflag.org 'rm -fr /home/pflagweb/pflag.org/chapter-map.dump'
rm chapter-map.dump