# MongoDB on your USB flash drive

![](image-CC0.svg)

Instructions on how to install MongoDB on your USB flash drive. A Debian-based approach with GitHub CLI & Mongodb Shell.

## Guideline

[One-Time Actions](#one-time-actions) - all you need to do to set up a MongoDB server on your USB flash drive  
[Daily routine](#daily-routine) - shows how to run the server and get internal access (non-invasive method)  
[Daily routine (alternative)](#daily-routine-alternative) - the same as above, but more comfortable (non-invasive method)  
[Run MongoDB server automatically at every system startup](#run-mongodb-server-automatically-at-every-session-system-startup) - even more comfortable (OS-invasive method)  
[Tips & Troubleshooting](#tips--troubleshooting)  
[Literature](#literature)  

## One-Time Actions

1. Mount a USB flash drive  at **`/absolute-path-to-your-usb-flash-drive/` abbreviated as `/x/`**. In most cases your OS do it automatically. You can find your actual mountpoint `/x/` by

```bash
sudo lsblk -f
```

2. Open a command window and change your CWD to `/x/`.

```bash
cd /x/
```

3. Visit [MongoDB website](https://www.mongodb.com/try/download/community "https://www.mongodb.com/try/download/community") and download archived MongoDB Community Server for Debian to `/x/`.  
(.tgz package e.g. `mongodb-linux-x86_64-debian12-8.0.0-rc20.tgz` file)
4. Visit [MongoDB Shell archive](https://github.com/mongodb-js/mongosh/releases), select a release, find in assets and download a proper archive to `/x/`.  
(e.g. `/mongosh-2.3.1-linux-x64.tgz` file)  
5. Extract both archives.

```bash
tar -xvzf mongodb-linux-x86_64-debian12-8.0.0-rc20.tgz
tar -xvzf mongosh-2.3.1-linux-x64.tgz
```

6. (Optional) Remove both archives.

```bash
rm mongodb-linux-x86_64-debian12-8.0.0-rc20.tgz
rm mongosh-2.3.1-linux-x64.tgz
```

7. (Check point 8) Create symbolic links for both directories.

```bash
ln -s mongosh-2.3.1-linux-x64 mongosh
ln -s mongodb-linux-x86_64-debian12-8.0.0-rc20 mongodb
```

8. (Alternative for point 7) Rename both directories.

```bash
mv mongosh-2.3.1-linux-x64 mongosh
mv mongodb-linux-x86_64-debian12-8.0.0-rc20 mongodb
```

6. Create empty directories `data` and `log` at `/x/mongodb/`.

```bash
cd mongodb
mkdir data
mkdir log
```

## Daily routine

7. Open a command window and overwrite your Modify Environment Variable `$PATH` (`/x/` in an alias, point 1).

```bash
export PATH="$PATH:/x/mongosh/bin"
export PATH="$PATH:/x/mongodb/bin"
```

8. Run MongoDB server.

```bash
mongod --dbpath /x/mongodb/data --logpath /x/mongodb/log/mongod.log --fork
```

10. Now you can run MongoDB Shell and do your job.

```bash
mongosh
```

11. When is done, deactivate the server and (recommended) close the command window.

```bash
mongod --dbpath /x/mongodb/data --shutdown
exit
```

## Daily routine (alternative)

12. (One-Time Action) Open a command window and clone this repository to a selected directory.

```bash
cd /selected-directory/
gh repo clone AW6RO7ZCD/mongodb-usb-flash-drive
```

13. (One-Time Action) In both scripts from cloned repository (`activate.sh` and `deactivate.sh`) replace all occurrences of /x/ with actual /absolute-path-to-your-usb-flash-drive/.

```bash
cd /that-selected-directory/mongodb-usb-flash-drive
nano activate.sh
nano deactivate.sh
exit
```

14. Open a command window, change your CWD on those scripts directory and run the `activate.sh` script.

```bash
cd /that-selected-directory/mongodb-usb-flash-drive
source activate.sh
```

15. Your MongoDB server is ready, now you can run MongoDB Shell and do your job.

```bash
mongosh
```

16. After all, run the `deactivate.sh` script.
```bash
source deactivate.sh
```

17. (Optionally) Move both scripts in selected directory or make their names shorter or just create symbolic links.

## Run MongoDB server automatically at every session (system) startup

18. Open a command window and change your CWD onto your home directory.

```bash
cd ~
```

19. Add paths for MongoDB and MongoDB Shell to the `.bashrc` file (in the code below, remember to replace all occurrences of /x/ with actual /absolute-path-to-your-usb-flash-drive/).

```bash
echo "export PATH=\"\$PATH:/x/mongodb/bin\"" >> .bashrc
echo "export PATH=\"\$PATH:/x/mongosh/bin\"" >> .bashrc
```

20. Clone this repository and switch your CWR onto it.

```bash
gh repo clone AW6RO7ZCD/mongodb-usb-flash-drive
cd mongodb-usb-flash-drive
```

21. In `mongodb.service` file, replace all occurrences of /x/ with actual /absolute-path-to-your-usb-flash-drive/.

```bash
nano mongodb.service
```

22. Log in as a super user.

```bash
su
```

23. Copy the service file into the system configuration directory.

```bash
cp mongodb.service /etc/systemd/system/mongodb.service
```

24. (Optional) Remove the repository.

```bash
cd ..
rm -rf mongodb-usb-flash-drive
```

25. Copy FSTYPE and UUID values for your USB stick from the output of

```bash
lsblk -f
```

26. Enable auto-mounting for your USB stick. In the code below, replace \<UUID> and \<FSTYPE> with value from the previous point and also /x/ with actual /absolute-path-to-your-usb-flash-drive/.

```bash
echo "# custom" >> /etc/fstab
echo "UUID=<UUID> /x/   <FSTYPE>  defaults       0  2" >> /etc/fstab
```

27. Restart the system.

28. Open a command window, type `mongosh` and do your job.

29. (Optionally) To undo all steps from this section, remove lines `export PATH="$PATH:/x/mongodb/bin"` and `export PATH="$PATH:/x/mongosh/bin"` from the `.bashrc` file.

```bash
nano ~/.bashrc
```

then log in as a super user and remove the `mongodb.service` file

```bash
su 
rm /etc/systemd/system/mongodb.service
```

also disable auto-mounting for your USB stick - remove line below "# custom" in the `fstab` file

```bash
nano /etc/fstab
```

## Tips & Troubleshooting

* use Ctrl+Shift+H in your text editor to replace /x/ with actual /absolute-path-to-your-usb-flash-drive/
* type `chmod -R 777 some-file.extension` when you have permission issues
* if you can not run MongoDB server, remove content from directories `/x/mongodb/data/` and `/x/mongodb/log/`

## Literature

<https://cli.github.com/manual/>  
<https://www.mongodb.com/docs/mongodb-shell/install/>  
<https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-debian-tarball/>  

<https://wiki.debian.org/fstab#Field_definitions>  
<https://manpages.debian.org/trixie/systemd/systemd.service.5.en.html>  
