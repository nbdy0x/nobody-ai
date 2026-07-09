export const domain = (() => {
  if ($app.stage === "production") return "nobody0x.com"
  if ($app.stage === "dev") return "dev.nobody0x.com"
  return `${$app.stage}.dev.nobody0x.com`
})()

export const zoneID = "430ba34c138cfb5360826c4909f99be8"
export const awsStage = $app.stage === "production" ? "production" : "dev"
export const deployAws = $app.stage === awsStage

new cloudflare.RegionalHostname("RegionalHostname", {
  hostname: domain,
  regionKey: "us",
  zoneId: zoneID,
})

export const shortDomain = (() => {
  if ($app.stage === "production") return "n0x.ai"
  if ($app.stage === "dev") return "dev.n0x.ai"
  return `${$app.stage}.dev.n0x.ai`
})()
