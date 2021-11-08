# rutorrent-auto-install
<div align="center">
    <a href="https://insentrica.net/" target="_blank">
        <img alt="lamp" src="https://github.com/Valikahn/rutorrent-auto-install/blob/main/img/logo.PNG?raw=true">
    </a>
</div>

## Script Description
This script is for the installation of Apache, PHP, OpenSSL, MySQL, phpMyAdmin and Webmin.  There are a few sections that require human input listed below in the [Script Process](#script-process) section, please read this section to ensure you understand what the program is asking of you.

* [Tested Operating Systems](#tested-operating-systems)
* [Installed Software Module Versions](#installed-software-module-versions)
* [Install Commands](#install-commands)
* [Roadmap](#roadmap)
* [Copyright](#copyright)
* [Bugs & Issues](#bugs--issues)
* [Licence](#licence)

## Tested Operating Systems

* Ubuntu 18.x (Bionic Beaver)

## Installed Software Module Versions
| Install Modules               | Version
|-------------------------------|-------------------------------|
| Apache                        | 2.4.46 (Ubuntu)
| Apache                        | 2.4.46 (Ubuntu)
| Apache                        | 2.4.46 (Ubuntu)
| PHP                           | 7.4.9
| SSL                           | OpenSSL/1.1.1f
| MySQL                         | 8.0.23-0ubuntu0.20.10.1
| phpMyAdmin                    | 4.9.7deb1
| Webmin                        | 1.973
| FTP server (vsftpd)           | 3.0.3

## Install Commands
#### Install Git and clone the "lamp" package
```
sudo -i
sudo apt-get -y install wget git > /dev/null
git clone https://github.com/Valikahn/rutorrent-auto-install.git
```

#### Execute Script

```
cd rutorrent-auto-install
chmod +x rutorini.install-insentrica
sudo ./rutorini.install-insentrica
```

## Roadmap
* Incorporate Encrypt SSL Certificates
* Ubuntu 20.04.x (Focal Fossa)
* Ubuntu 20.10.x (Groovy Gorilla)
* Ubuntu 21.04.x (Hirsute Hippo)

## Bugs & Issues
Please feel free to report any bugs or issues to us.
* Email:  git@insentrica.net 
* Issues:  <a href="https://github.com/Valikahn/lamp/issues">Via GitHub</a>
* Website:  https://www.insentrica.net
* Github:   https://github.com/Valikahn/lamp

## Licence | Copyright
Copyright (C) 2020 - 2021 Valikahn <git@insentrica.net><br />
Program v1.4-alpha - Code Name: Anubis<br />

Licensed under the GPLv3 License.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 
GPLv3 Licence:  https://www.gnu.org/licenses/gpl-3.0.en.html 
