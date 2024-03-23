# Settings
<img src="https://github.com/FarhadElahi/CF/blob/main/Info/Settings.png" width="80">

___
#### WARP ON WARP
```
./warp-plus --gool
```
#### WARP ON Psiphon
```
./warp-plus --cfon
```
#### Endpoint
```
./warp-plus -e 
```
#### Scanner Limit
```
./warp-plus -rtt
```
#### Scanner
```
./warp-plus --scan
```
#### License Key
```
./warp-plus -k
```
#### Verbose Logging
```
./warp-plus -v
```
#### Bind Address
```
./warp-plus -b
```
#### Configuration File Path
```
./warp-plus -c
```
**<details>
  <summary>More Info</summary>**
```
  -4                      only use IPv4 for random warp endpoint
  -6                      only use IPv6 for random warp endpoint
  -v, --verbose           enable verbose logging
  -b, --bind STRING       socks bind address (default: 127.0.0.1:8086)
  -e, --endpoint STRING   warp endpoint
  -k, --key STRING        warp key
      --gool              enable gool mode (warp in warp)
      --cfon              enable psiphon mode (must provide country as well)
      --country STRING    psiphon country code (valid values: [AT BE BG BR CA CH CZ DE DK EE ES FI FR GB HU IE IN IT JP LV NL NO PL RO RS SE SG SK UA US]) (default: AT)
      --scan              enable warp scanning
      --rtt DURATION      scanner rtt limit (default: 1s)
  -c, --config STRING     path to config file
  ```
