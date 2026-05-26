let troels = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAuetb5pvSdtemiYaWferXD3JPZR/RAawXdf2csIZale root@nixos";
in {
  "beoguard-key.age".publicKeys = [ troels ];
}
