#! /bin/bash

git add .
git commit -m "Moar"
git push
bundle exec cap production deploy