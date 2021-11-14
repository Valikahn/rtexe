# rutorrent-auto-install
<div align="center">
    <a href="https://insentrica.net/" target="_blank">
        <img alt="lamp" src="https://github.com/Valikahn/rutorrent-auto-install/blob/main/img/logo.PNG?raw=true">
    </a>
</div>

## Script Description
During this installation process you have to choose a system user to run rtorrent.  The script will install a total of 46 plugins for ruTorrent to function.  The script will include a init script that makes rtorrent start, at a possible reboot, in the given username's screen/tmux session.<br /><br />
This script is for the installation of Apache, PHP, OpenSSL, ruTorrent and Webmin.  There is minimal sections that require human input, please continue reading to ensure you understand what is entailed in this program.

* [Supported Operating Systems](#supported-operating-systems)
* [Installed Software Module Versions](#installed-software-module-versions)
* [Install Commands](#install-commands)
* [Roadmap | Testing](#roadmap--testing)
* [Bugs | Issues | Recommendation](#bugs--issues--recommendation)
* [Licence | Copyright](#licence--copyright)

## Supported Operating Systems

* Ubuntu 18.x (Bionic Beaver)

## Installed Software Module Versions
#### Below is the minimal version that will install on each build depending on the Operating System is being used.

| Install Modules               | Version
|-------------------------------|-------------------------------|
| Apache                        | 2.4.29 (Ubuntu)
| PHP                           | 7.2.24
| rTorrent                      | 0.9.8
| ruTorrent                     | 3.10
| XmlRpc-c                      | Revision 3138
| libtorrent                    | 0.13.8
| autodl-irssi                  | 0.0.0
| SSL                           | OpenSSL/1.1.1
| FTP server (vsftpd)           | 3.0.5

## Install Commands
#### Install Git, clone and execute "rtexe" package
```
sudo apt-get -y install wget git > /dev/null
git clone https://github.com/Valikahn/rtexe.git
cd rtexe
chmod +x rtexe
sudo ./rtexe
```
You can use the following commands respectively to start and stop the service.
```
service rtorrent-init start
```
```
service rtorrent-init stop
```

## Roadmap | Testing
#### Scripting Improvements and Upcoming Features
* Incorporate Encrypt SSL Certificates
* Improve install time
* Limited dependency lists

#### Additional Operating System Support
* Ubuntu 20.04.x (Focal Fossa)
* Ubuntu 20.10.x (Groovy Gorilla)
* Ubuntu 21.04.x (Hirsute Hippo)

## Bugs | Issues | Recommendation
Please feel free to report any bugs or issues to us.<br />
We actively encourage recommendations, suggestions, ideas, please let us know.
* Issues:  <a href="https://github.com/Valikahn/rtexe/issues">Via GitHub</a>
* Website:  https://www.insentrica.net
* Github:   https://github.com/Valikahn/rtexe

## Licence | Copyright
Copyright (C) 2020 - 2021 Valikahn<br />
Program v1.14.11 - Version Name: Nephthys<br />

Licensed under the GPLv3 License.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

GPLv3 Licence:  https://www.gnu.org/licenses/gpl-3.0.en.html 
