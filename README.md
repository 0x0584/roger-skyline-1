# Table of Contents

1.	[About](#org509450a)
2.	[A Debian VM](#org858aae2)
3.	[Network and Security](#org7510d8e)
	1.	[Initial Configuration](#org1d9fd06)
	2.	[Configure Sudo](#orgd1b6e1e)
	3.	[Configure static IP](#orga9cc141)
	4.	[Configure SSH](#org4c83598)


<a id="org509450a"></a>

# About

This is a guide to do all the things described in Roger Skyline 1. This might not take so much time, or let me say it otherwise, **I DON'T HAVE MUCH TIME! I NEED TO GET OUT OF THE BLACK HOLE AS SOON AS POSSIBLE!**


<a id="org858aae2"></a>

# A Debian VM

For the moment, All of this is done on a `24-inch iMac (Late 2006)` running a Max OS X `Lion 10.7.5` using a `Debian 9.9` in `VirtualBox 4.3`

Here's a link to [Debian 10.10 Net Install](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.0.0-amd64-netinst.iso) for latest packages + minimum download/install time. Also [VirtualBox 6.0](https://download.virtualbox.org/virtualbox/6.0.10/VirtualBox-6.0.10-132072-OSX.dmg). Important thing is to allocate exactly `8 GB` with no partitioning!


<a id="org7510d8e"></a>

# Network and Security


<a id="org1d9fd06"></a>

## Initial Configuration

-	create a new non-root user using `adduser <NAME>`
-	update the system using `apt-get update -y && apt-get upgrade -y`
-	install essential tools using `apt-get install -y sudo vim apache2 portsentry ufw fail2ban mailutils net-tools`
	-	**sudo:** execute commands as `root`
	-	**vim:** the perfect text editor for servers, since their non GUI systems, mostly
	-	**fail2ban:** monitor server logs and detects any IP with a suspesious activity, after predefined number of failure, it blocks the IP for a specific duration<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>
	-	**portsentry:** port scanning utility, good for scanning port and avoiding attacks<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>
	-	**apache2:** the fucking HTTP server itself<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>
	-	**mailutils:** the swiss army knife of electronic mail handling<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>
	-	**ufw:** uncomplicated firewall<sup><a id="fnr.5" class="footref" href="#fn.5">5</a></sup>


<a id="orgd1b6e1e"></a>

## Configure Sudo

Using `vim` as `root`, add the *user's previlege specification* the file `/etc/sudoers`. Right at the comment `# User privilege specification` add `<LOGIN>	   ALL=(ALL:ALL) NOPASSWD:ALL`


<a id="orga9cc141"></a>

## Configure static IP

> *Must change the network adapter from NAT to Bridged Adapter in the VM's settings*

We need to setup the *primary network*, thus we need to edit `/etc/network/interfaces`. We find that the primary network (for my VM at least) is `enp0s3`, found under the line `#The primary network interface`.

To configure a static IP we need to create the file<sup><a id="fnr.6" class="footref" href="#fn.6">6</a></sup> `/etc/network/interfaces.d/enp0s3`.

	iface enp0s3 inet static
			address 10.11.200.247
			netmask 255.255.255.252
			gateway 10.11.254.254

Finally, we restart the network using `sudo service networking restart` and check that using `ip addr` and look for `enp0s3`


<a id="org4c83598"></a>

## Configure SSH


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> here's a [good place](https://www.linode.com/docs/security/using-fail2ban-for-security/) to document about fail2ban for serve, and [this](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-14-04) one is to secure SSH

<sup><a id="fn.2" href="#fnr.2">2</a></sup> this [debian blog](https://wiki.debian-fr.xyz/Portsentry) has a some good documentation. also [here](https://www.symantec.com/connect/articles/portsentry-attack-detection-part-one)!

<sup><a id="fn.3" href="#fnr.3">3</a></sup> [good article](https://www.hostinger.com/tutorials/what-is-apache) comparison between many web servers including NGINX and TOMCAT

<sup><a id="fn.4" href="#fnr.4">4</a></sup> good luck reading any GNU [documentation](https://mailutils.org/manual/mailutils.html)

<sup><a id="fn.5" href="#fnr.5">5</a></sup> this seems like a good [documentation](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server)

<sup><a id="fn.6" href="#fnr.6">6</a></sup> it's possible to change it at place but it's not recommended. this is a [good article](https://linuxconfig.org/how-to-setup-a-static-ip-address-on-debian-linux)
