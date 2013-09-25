#!/bin/sh
heroku pgbackups:capture --app pflag-chapter-map
curl -o latest.dump `heroku pgbackups:url --app pflag-vote` 
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U dacmanj -d chapter_map latest.dump 
rm latest.dump