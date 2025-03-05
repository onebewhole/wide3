# !/bin/bash

# https://stackoverflow.com/a/28938235
BGreen='\033[1;32m'
Color_Off='\033[0m'

function print() {
    echo -e $1$2$Color_Off
}

base=`git rev-parse --show-toplevel`
print $BGreen "Base folder is $base. Moving to base folder..."
cd $base

print $BGreen "Removing all the junk that was there..."
rm -rf node_modules
rm -rf dist
rm -rf .angular
rm -rf package-lock.json

print $BGreen "Installing..."
npm install

print $BGreen "Deploying..."
ng deploy --base-href=/wide3/