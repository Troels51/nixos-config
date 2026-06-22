default_machine := 'twix'

switch machine=default_machine:
    sudo nixos-rebuild switch --flake .#{{machine}}

beolan-wifi:
    sudo cp config-files/BeoAccess.8021x /var/lib/iwd/BeoAcccess.8021x
