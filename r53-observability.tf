resource "aws_route53_zone" "observability" {
  name = "observability.ukps.digital"

  tags = merge(local.default_tags, {
    "Name" : "observability.ukps.digital",
    "Environment" : "prod"
  })
}

resource "aws_route53_record" "observability-delegated-zone" {
  zone_id         = aws_route53_zone.ukpsdigital.zone_id
  allow_overwrite = true
  name            = "observability"
  ttl             = local.standard_ttl
  type            = "NS"

  records = aws_route53_zone.observability.name_servers
}

resource "aws_route53_record" "nonprod-monitoring-delegated-zone" {
  zone_id         = aws_route53_zone.observability.zone_id
  allow_overwrite = true
  name            = "monitoring.nonprod"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-951.awsdns-54.net.",
    "ns-1032.awsdns-01.org.",
    "ns-2026.awsdns-61.co.uk.",
    "ns-88.awsdns-11.com."
  ]
}

resource "aws_route53_record" "prod-monitoring-delegated-zone" {
  zone_id         = aws_route53_zone.observability.zone_id
  allow_overwrite = true
  name            = "monitoring.prod"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1994.awsdns-57.co.uk.",
    "ns-252.awsdns-31.com.",
    "ns-1115.awsdns-11.org.",
    "ns-672.awsdns-20.net."
  ]
}

resource "aws_route53_record" "playground-delegated-zone" {
  zone_id         = aws_route53_zone.observability.zone_id
  allow_overwrite = true
  name            = "playground"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1365.awsdns-42.org.",
    "ns-961.awsdns-56.net.",
    "ns-485.awsdns-60.com.",
    "ns-1748.awsdns-26.co.uk."
  ]
}

resource "aws_route53_record" "nonprod-legacy-delegated-zone" {
  zone_id         = aws_route53_zone.observability.zone_id
  allow_overwrite = true
  name            = "legacy.nonprod"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1918.awsdns-47.co.uk",
    "ns-1219.awsdns-24.org",
    "ns-20.awsdns-02.com",
    "ns-724.awsdns-26.net"
  ]
}

resource "aws_route53_record" "nonprod-legacy-ds" {
  zone_id = aws_route53_zone.observability.zone_id
  name    = "legacy.nonprod.observability.ukps.digital"
  type    = "DS"
  ttl     = local.standard_ttl
  records = ["15998 13 2 3AEEF8ED0ACD5C17AB4E2BC0DC0376FDE12BFC1630027C17A80DF14B00BDE5CD"]
}

resource "aws_route53_record" "prod-legacy-delegated-zone" {
  zone_id         = aws_route53_zone.observability.zone_id
  allow_overwrite = true
  name            = "legacy.prod"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1583.awsdns-05.co.uk",
    "ns-1532.awsdns-63.org",
    "ns-928.awsdns-52.net",
    "ns-186.awsdns-23.com"
  ]
}

resource "aws_route53_record" "prod-legacy-ds" {
  zone_id = aws_route53_zone.observability.zone_id
  name    = "legacy.prod.observability.ukps.digital"
  type    = "DS"
  ttl     = local.standard_ttl
  records = ["6083 13 2 5DD05978FB5F60CA15FC1955F20A58BED3AD946D174DC25263942DEBAA985A73"]
}
