# DNS — systemd-resolved with DNS-over-TLS (Cloudflare + Quad9)
{...}: {
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "opportunistic";
    fallbackDns = [
      "1.1.1.1#cloudflare-dns.com"
      "9.9.9.9#dns.quad9.net"
      "8.8.8.8#dns.google"
    ];
  };

  networking.nameservers = [
    "1.1.1.1"
    "9.9.9.9"
  ];
}
