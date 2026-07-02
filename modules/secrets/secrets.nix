let
  troels = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAuetb5pvSdtemiYaWferXD3JPZR/RAawXdf2csIZale root@nixos";
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0XsoeYpZA3Msk+HiGOXGQsFLyMXIgpwbQowzN/smwL";
in {
  "beoguard-key.age".publicKeys = [ troels ];
  "hetzner_api_key.age".publicKeys = [ server ];

}
