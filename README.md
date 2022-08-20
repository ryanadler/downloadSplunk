# Download Splunk
This repository was created to aid in downloading Splunk and the Splunk Universal Forwarder. The `bash.sh` script creates wget statements based on your version of choice. 

For Linux and MacOS:
`./bash.sh` should work natively.

For Windows:
You may need to install the Windows Subsystem for Linux (WSL) in order to utilize `./bash.sh` through powershell. 

The `update.sh` and `version.list` files are used to update the repo's list of versions and builds that Splunk has produced. Some are now unsupported, deprecated, or no longer available. In some cases, it may be necessary to download an older version in order to properly upgrade or remove a version of Splunk.

Download and install with caution, and behave responsibly.