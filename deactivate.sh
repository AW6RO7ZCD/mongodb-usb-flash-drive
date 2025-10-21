#!/bin/bash
# https://github.com/AW6RO7ZCD/mongodb-usb-flash-drive

# Modify Environment Variable $PATH (add)
# export PATH="$PATH:/x/mongosh/bin"
# export PATH="$PATH:/x/mongodb/bin"

# Run MongoDB
# mongod --dbpath /x/mongodb/data --logpath /x/mongodb/log/mongod.log --fork

# Run MongoDB Shell
# mongosh

# Stop MongoDB
mongod --dbpath /x/mongodb/data --shutdown

# Modify Environment Variable $PATH (remove)
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/x/mongosh/bin' | tr '\n' ':' | sed 's/:$//')
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/x/mongodb/bin' | tr '\n' ':' | sed 's/:$//')
