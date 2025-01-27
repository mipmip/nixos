let
  pim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEY25ZaYRuKUJuVuzqK4c8dKkSxN6Cd9yhbDTa/5Njmh";

  users = [ pim ];

  ojs   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNnavv0c8Htl2OSN9sFM/aFm6FbxvHwTLZDjgb5g1zh";
  lego1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/5cm8VDfCN5y05tcX16tZl3rR+kEgznsrEw1FAaoez";
  rodin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkMd+l2gSXGsWs4FypOt58GTgGruSHravDHPSW1w8XM";
  hurry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyh9gDCDN2rzAExllvavzVVr4XkKea63Wa+B7JO8+Qz";
  harry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmY6Jv/y1CSyVe0t1L+65NQjocDoDUShhriPp5yg6eh";

  systems = [ ojs lego1 rodin hurry harry];

in
{
  "openai-api-key.age".publicKeys = [ pim  ojs lego1 rodin];
  "openai-api-key-plain.age".publicKeys = [ pim  ojs lego1 rodin];

  "aws-credentials-copy.age".publicKeys = [ pim  ojs lego1 rodin];
  "aws-config-copy-first-time-only.age".publicKeys = [ pim];

  "aws-accounts.json.age".publicKeys = [ pim  ojs lego1 rodin];

  "wifi.age".publicKeys = [pim hurry harry];
  "vaultwarden.env.age".publicKeys = [pim hurry rodin];

  #  "hurry-smtp.age".publicKeys = [pim hurry];
  "hurry-cloudflared.pem.age".publicKeys = [pim hurry harry];
  "hurry-cloudflared-tunnel.json.age".publicKeys = [pim hurry];
  "harry-cloudflared-tunnel.json.age".publicKeys = [pim harry];

  "nextcloud-admin-pw.age".publicKeys = [pim harry];
  "piethein-samba-secrets.age".publicKeys = [pim harry];

}
