# Startup notes
## pihole
### [Set up pihole locally](https://pawelurbanek.com/pihole-local-computer)

1. Install docker
2. Set up pihole docker image

```sh
cd pi-hole-docker-compose
echo "WEBPASSWORD=secret" > .env
git clone git@github.com:pawurb/pi-hole-docker-compose.git
```

3. Start pihole manually to make sure it works

```sh
docker-compose up -d
```

4. Visit [`localhost/admin`](http://localhost/admin/) in browser. Dashboard should be up
5. Change DNS in system settings to `127.0.0.1`

### [Run pihole when system starts using `launchd`](https://www.karltarvas.com/2020/09/11/macos-run-script-on-startup.html)

1. Create the script to run. For example, save the following to `start-pihole.sh`:

```
#!/bin/sh
cd ~/pi-hole-docker-compose
docker-compose up -d
cd -
```

2. Set to executable

```
chmod +x ~/start-pihole.sh
```

3. Create plist file that represents the command to be run. For example, save the following to `com.cody.startup.plist`:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.cody.startup</string>

    <key>OnDemand</key>
    <false/>

    <key>LaunchOnlyOnce</key>
    <true/>

    <key>UserName</key>
    <string>cody</string>

    <key>ProgramArguments</key>
    <array>
		<string>~/start-pihole.sh</string>
    </array>
</dict>
</plist>
```

4. Add it as a launch agent

```
sudo mv com.cody.startup.plist /Library/LaunchAgents
sudo chown root:wheel /Library/LaunchAgents/com.cody.startup.plist
sudo launchctl load /Library/LaunchAgents/com.cody.startup.plist
```
