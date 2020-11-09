:warning: **This repo has been migrated to https://git.netflux.io/rob/remotedebug-ios-webkit-adapter-docker**

------

# remotedebug-ios-webkit-adapter-docker

A Docker container containing everything needed to run Chrome devtools against an iOS device.

Relies on the [remotedebug-ios-webkit-adapter project](https://github.com/RemoteDebug/remotedebug-ios-webkit-adapter), which in turn relies on libimobiledevice, libusbmuxd, libplist and ios-webkit-debug-proxy.

Tested with iOS 13.5.1 on an 2018 iPad Pro 11 inch and 2018 iPhone 8 Plus.

## Usage

1. Plug iOS device in to Linux box via USB
2. Ensure device is trusted
3. Launch the Docker container:

```
docker run --privileged \
  -p 9000:9000 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /var/run:/var/run \
  netfluxio/remotedebug-ios-webkit-adapter-docker
```

4. Open Chrome and  visit `chrome://inspect`
5. Next to _Discover network targets_ click _Configure_
6. Ensure `localhost:9000` is included in the list

![Chrome Devtools](https://git.netflux.io/rob/remotedebug-ios-webkit-adapter-docker/raw/branch/dev/images/remotedebug-chrome.png)

## Troubleshooting

If you see this error:

```
remotedebug-ios-webkit-adapter failed to run with the following error: adapter.spawnProcess.close, code=255
```

then the device is probably either not plugged in or not trusted (see also Debugging, below.)

## Debugging

Run docker with argument `-e DEBUG=remotedebug`
