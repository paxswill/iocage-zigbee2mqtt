# iocage-zigbee2mqtt

This is an [iocage][iocage] plugin for running [zigbee2mqtt][z2m] on TrueNAS
Core.

[iocage]: https://github.com/iocage/iocage
[z2m]: https://www.zigbee2mqtt.io/

## Requirements

* An MQTT broker is required. I use another iocage plugin for
  [Mosquitto][iocage-mqtt].
* You will also need a [supported Zigbee adapter][z2m-coordinators].
* And finally, at least one [supported Zigbee device][z2m-devices].

[iocage-mqtt]: https://github.com/tprelog/iocage-mosquitto
[z2m-coordinators]: https://www.zigbee2mqtt.io/information/supported_adapters.html
[z2m-devices]: https://www.zigbee2mqtt.io/information/supported_devices.html

## Installation

At some point in the future, this plugin should be available as a Community
Plugin.

As an alternative, the following command will install from this repository
directly:

```shell
iocage fetch -P zigbee2mqtt -g https://github.com/paxswill/iocage-zigbee2mqtt --branch 12.1-RELEASE --name zigbee2mqtt
```

The name can be modified as needed, and other properties (like setting VNET
interfaces with `interfaces="vnet0:bridge0"`) can be added at the end.

## Configuration

The data directory is located at `/usr/local/etc/zigbee2mqtt` within the jail.
After installation, it is recommended that you edit
`/usr/local/etc/zigbee2mqtt/configuration.yaml` with the name of the serial
port your Zigbee adapter is available at (the default configuration assumes
`/dev/cuaU0`). Home Assistant integration is also disabled by default, so be
sure to enable that if you plan to use that. Device and group specific
configuration is split into `devices.yaml` and `groups.yaml` by default. For
full configuration details see the [zigbee2mqtt documentation][z2m-config].

[z2m-config]: https://www.zigbee2mqtt.io/information/configuration.html

A default secure configuration is installed, with a new random network
encryption key generated and saved the first time zigbee2mqtt starts up. Device
pairing is also disabled by default, but can easily be temporarily enabled from
the web UI.

## Usage

A web interface is available on port 8080 (and can also be accessed by clicking
the "Manage" button in the TrueNAS plugin UI).

## Troubleshooting

* Logs are saved to `/var/log/zigbee2mqtt_daemon.log` within the jail. They have
  embedded color sequences, so using `less -R` can make them pretty again.
* If your configuration disappears on upgrade (a bug in earlier versions of this
  plugin), you can roll back to your pre-upgrade snapshot that iocage makes for
  you. Use `iocage snaplist zigbee2mqtt` (replacing `zigbee2mqtt` with the name
  of your jail) to list the available snapshots. Then use `iocage rollback -n
  SNAPSHOT_NAME zigbee2mqtt` to rollback the changes (replace `SNAPSHOT_NAME`
  with the name of a snapshot from the snapshot list, and change `zigbee2mqtt`
  as needed again).
