# Creating a Debian package
[![Build Status](https://img.shields.io/badge/build-fail-red.svg)]
### Structure of a Debian package
```
conky-resource-config/
└── DEBIAN
    ├── changelog
    ├── compat
    ├── control
    ├── copyright
    ├── postinst
    ├── resources
    │   └── bg-ubuntu.png
    ├── rules
    ├── scripts
    │   ├── carbonSetup.sh
    │   └── ipcheck.sh
    ├── source
    │   └── format
    └── src
        └── conkyrc
```

### Requirements
-   `build-essential`
-   `devscripts`
-   `debhelper`
-   [Upstream Tarball]

### Process
Retrieve latest tarball and extract contents to `DEBIAN` folder.
```
tar xf conky-resource-config-2.0.tar.gz
```

Create the changelog. 2.0-1 is the version. The 2.0 part is the upstream version. The -1 part is the Debian version: the first version of the Debian package of upstream version 2.0. If the Debian package has a bug, and it gets fixed, but the upstream version remains the same, then the next version of the package will be called 2.0-2. Then 2.0-3, and so on.
```
dch --create -v 2.0-1 --package conky-resource-config
```

`DEBIAN/compat` specifies the "compatibility level" for the debhelper tool. We don't need to go into what that means, right now.
```
echo "10" >> DEBIAN/compat
```

The `DEBIAN/control` file describes the source and binary package, and gives some information about them, such as their names, who the package maintainer is, and so on. Below an example of what it might look like:
```
Source: conky-resource-config
Maintainer: First Last <address@email.com>
Section: misc
Priority: optional
Standards-Version: 3.9.2
Package: conky-resource-config
Architecture: any
Depends: conky-all
Description: light-weight system monitor for X, that displays any kind of information on your desktop.
Version: 2.0

```
**ENSURE BLANK LINE AT END OF FILE**

Place a blank copyright file.
```
touch DEBIAN/copyright
```

`DEBIAN/rules` should look like this:
```
#!/usr/bin/make -f
%:
    dh $@
```
**The last line should be indented by one TAB character, not by spaces. The file is a makefile, and TAB is what the make command wants**

Many packages need to perform actions before or after specific events during the package installation or uninstallation process. Debian packages accommodate for this via scripts. The `DEBIAN/postinst` is the same file as the `scripts/carbonSetup.sh` file from the tarball just renamed to `postinst`.

When all of the above is in place, creating the actual Debian package, or .deb file, is easy:
```
sudo dpkg -b conky-resource-config/ conky-resource-config_2.0-1_any.deb
```



[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[Upstream Tarball]: <https://github.com/rowland007/conky-resource-config/releases>