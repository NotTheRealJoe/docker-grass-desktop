# grass desktop for docker

## What is it?
This repository contains the code for building a docker image that can run the Grass Desktop application for getgrass.io.

**[Get this image from Docker Hub!](https://hub.docker.com/r/nottherealjoe/grass-desktop)**

In contrast to other Grass docker images, this one uses the **Grass Desktop** application. This means:
- You'll get 2x the points you would with the Grass Lite Chrome extension.
- Because the image doesn't run a full copy of Chrome, it is significantly smaller in size and uses significantly less memory at runtime.

## How to use
Most users will simply pull the image from docker hub to run it.

### Command line
```sh
docker run docker.io/nottherealjoe/grass-desktop \
  --env VNC_PASSWORD="mypasswd" \
  --env GRASS_USERNAME="getgrassusername@example.com" \
  --env GRASS_PASSWORD="supersecret" \
  --port-forward 5900:5900/tcp
```

### docker-compose.yml
```yaml
services:
  grass:
    image: docker.io/nottherealjoe/grass-desktop
    environment:
      VNC_PASSWORD: mypasswd
      GRASS_USERNAME: "getgrassusername@example.com"
      GRASS_PASSWORD: supersecret
    ports:
      - 5900:5900/tcp
    restart: unless-stopped
```

- Set `VNC_PASSWORD` to your desired password for the internal VNC server. Note that this password can only be **up to 8 characters long**. Longer passwords get truncated and will confuse you when you try to log in! If you don't plan to use the VNC server, it still needs to be set to something.
- Set `GRASS_USERNAME` and `GRASS_PASSWORD` to your credentials created on getgrass.io. If you don't have a username and password yet, [use my referral link to sign up](https://app.getgrass.io/register/?referralCode=sqKqTw8JHScyGFY).
- The port forward shown above will allow you to access the internal VNC server on the host's port 5900. Change the port as needed. You may omit it completely if you don't want to access the VNC server. Access isn't required and would only be used for troubleshooting.

## Notices
The creator of this project is not affiliated with Grass or its owners. The Grass and getgrass.io names are used here only to indicate technical compatibility, and should not be considered to be any kind of endorsement or approval of this project by Grass.

When you use this project, you're choosing to use an automated system to install the Grass Desktop client. This is an action that may affect your legal relationship with Grass. You are still subject to Grass's terms and policies.

The code in this project interacts with the Grass network in compliance with Grass's terms.

## License
Files in this repository are part of docker-grass-desktop. Please note that docker-grass-desktop contains code to download third party software that is **not** property of the docker-grass-desktop creators and not provided under the same license as docker-grass-desktop itself.

docker-grass-desktop is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

docker-grass-desktop is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with docker-grass-desktop. If not, see <https://www.gnu.org/licenses/>.
