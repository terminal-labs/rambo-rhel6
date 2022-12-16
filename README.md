## RHEL 6 with Rambo

This repo allows you to quickly get set up with a RHEL 6 VM on VirtualBox, using Rambo and Vagrant. There are some settings here that make using this old, EOL OS usable again. Spinning up and accessing should be as simple as `rambo up; rambo ssh`, given Rambo, Vagrant, and VirtualBox are all installed.

I needed this to run some automated testing on a RHEL instance that's fairly intensive. So I override the `rambo.conf` with:

```conf
# my_rambo.conf
[up]
cpus = 8
drive_size = 200
ram_size = 32768
```

## Quality of Life

In addition to pointing this RHEL6 to the basic, vaulted, CentOS6 package repositories, this installs:

- nano
- tree
- git (v23 at present)
- emacs v28
- ripgrep (aka `rg`) v13
