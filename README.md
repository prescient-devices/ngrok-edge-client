## Based on https://github.com/vincenthsu/systemd-ngrok

# Installation

Step 1: Place [`ngrok`](https://ngrok.com/download) in `/opt/ngrok/`.

Step 2: Get `authtoken` from ngrok website, then add it to `/opt/ngrok/ngrok.yml`.

Step 3. Modify your own configrations in `/opt/ngrok/ngrok.yml`.

Step 4: Add `ngrok.service` to `/lib/systemd/system/`.

Step 5: Start ngrok service by typing:

```
    systemctl enable ngrok.service
    systemctl start ngrok.service
```

or just execute `install.sh` on Arm platform.

```
    curl -O https://raw.githubusercontent.com/prescient-devices/ngrok-edge-client/master/install.sh
    chmod +x install.sh
    sudo ./install.sh <your_authtoken>
```
