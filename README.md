# Asia-Tehran-nodst
Tehran time zone configuration without day light saving (nodst)

This script creates a file called tehran-time in your home directory, which contains the time zone configuration for Tehran. It then uses the zic command to create the necessary timezone configuration files based on this configuration, and copies them to the system's timezone folder. Finally, it backs up the current timezone configuration, and creates a symbolic link to the new configuration.
