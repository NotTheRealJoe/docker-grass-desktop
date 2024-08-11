<!-- Content for the "Repository Overview" on Docker Hub -->

# grass desktop for docker

## What is it?
This is an image that runs the Grass Desktop Client for getgrass.io.

In contrast to other Grass docker images, this one uses the **Grass Desktop** application. This means:
- You'll get 2x the points you would with the Grass Lite Chrome extension.
- Because the image doesn't run a full copy of Chrome, it is significantly smaller in size and uses significantly less memory at runtime.

## Platforms
The Grass Desktop client is only available for **x86_64** systems; as such this image is only available for x86_64 systems.

## How to use

The image can easily be pulled from Docker hub and configured with just 3 environment variables:

### Command line:
```sh
docker run docker.io/nottherealjoe/grass-desktop \
  --env VNC_PASSWORD="mypasswd" \
  --env GRASS_USERNAME="getgrassusername@example.com" \
  --env GRASS_PASSWORD="supersecret" \
  --port-forward 5900:5900/tcp
```

### Or, docker-compose.yml:
```yaml
services:
  grass:
    image: docker.io/nottherealjoe/grass-desktop
    environment:
      VNC_PASSWORD: "changeme"
      GRASS_USERNAME: "getgrassusername@example.com"
      GRASS_PASSWORD: "supersecret"
    ports:
      - "5900:5900/tcp"
    restart: unless-stopped
```

- Set `VNC_PASSWORD` to your desired password for the internal VNC server. Note that this password can only be **up to 8 characters long**. Longer passwords get truncated and will confuse you when you try to log in! Leaving it blank will cause the container to randomly generate a password, and you will not be able to access the VNC server.
- Set `GRASS_USERNAME` and `GRASS_PASSWORD` to your credentials created on getgrass.io. If you don't have a username and password yet, [use my referral link to sign up](https://app.getgrass.io/register/?referralCode=sqKqTw8JHScyGFY).
- The port forward shown above will allow you to access the internal VNC server on the host's port 5900. Change the port as needed. You may omit it completely if you don't want to access the VNC server. Access isn't required and would only be used for troubleshooting.

## Notices
The creator of this project is not affiliated with Grass or its owners. The Grass and getgrass.io names are used here only to indicate technical compatibility, and should not be considered to be any kind of endorsement or approval of this project by Grass.

When you use this project, you're choosing to use an automated system to install the Grass Desktop client. This is an action that may affect your legal relationship with Grass. You are still subject to Grass's terms and policies.

The code in this project interacts with the Grass network only in compliance with Grass's terms.
