Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922B367F36;
	Sun, 11 Oct 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739807; cv=none; b=RgViMahahgBIbdv65HBN0SvcnX2EpmN+GrWq5c02cq5rzXQOStNmF2H7OkqayMW26TG6Er0sGHMNf8t2WNwltVWZ2oK7s32Wq1PHjKuXZW6fp00Fi+rC4PGcwzvgRiqRnsUlHzjd51Mwn5/kpcoH709q3byq8N4zWkyQD4C+I7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739807; c=relaxed/simple;
	bh=ju34XjiFkRe+S0YJOCfISGtyJPXkZ95jr38KPwa1aWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mmtMFiavlZX7ourg5mloN3s8MohpAxjppbw6559fpzgdPWzuq/27b/aAC5z8wOswjVN6mgWQUVYtJ3Oqxv1CmwOtAU+Du8CtoGsZTjotUieyIFKDsbG20dlsPQPWqEHCqChPHI4rrI+VjgQVbrzFiHTAjxStuIMTGpEiFwFh5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=gF5WRiZz; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="gF5WRiZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1791739795; x=1791998995;
	bh=dvRS8ZPBODMWslEgJrXTw+Dm+D7O2dHvWX2P3VkoyoY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gF5WRiZz8y/Tf1bh//j5ucmNDluPDROwzYgUppngAf04BZVgGALjiznt8rPyJhFYL
	 wST613uqGt1fzMUnK6aFX434jIxYK2NUMRtOj0aIzVRyxJoASNWZQQUt8hvaw1pase
	 ugDP3rcHzcK4cOgehyApBAcUsiTWX38RrFftteGgG+X3yp11tmxBuUkt8GT/ePhgoB
	 lYz6RENDeOaCvJ/Lg9UMZ2LlRD57dF6ebFlg0jYX6GTbiIFFZrMqiekyJunj5leXh3
	 7vyVLHC2RuOVTI75OTsxci2S2st0UDwC0qbmSfgB3PKjXIYlktePPndr52w3V3lg66
	 itZD81/R4nNmw==
X-Pm-Submission-Id: 4j2nfQ1vyfz1DF4y
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Subject: [PATCH v5 0/3] (no cover subject)
Date: Sun, 11 Oct 2026 19:29:27 +0200
Message-Id: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QQW7DIBAF0KtYrEsFBmyTVe9RdTHA0KAmdgKu5
 SrK3TuOF40qln/QvEH/xgrmhIUdmhvLuKSSppGCeWmYP8L4iTwFyqwVbSeUkjzg6cTXS+FWacP
 RczRR2yAdxk4yWrtkjGl9kO8flI+pzFP+eVxY5DbdMS0q2CK54BDBePBBW4dvSxohl69UXv10Z
 hu4tM+IriAtId72vVceYJCxhqg/ZKj+RBFio3bBGTABQg3Rz4itIJqQYVCiC875HuA/ct8Ly3j
 9purnvTXmoCCn93OaD82I68y3E1IISxv3X0/WxFO0AQAA
X-Change-ID: 20260331-dell-xps-9345-ec-e5f49d1bef61
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5493; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=ju34XjiFkRe+S0YJOCfISGtyJPXkZ95jr38KPwa1aWk=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFmnj/fmzpi7Y/nT2N8/P56TNXUxU35/UdJHo1W4SkQuI
 GelTeuHjlIWBjEuBlkxRZbuP1/TuhbNXctwXeMbzBxWJpAhDFycAjCRo1kM/ytT0y2ucN7YXn3V
 79SsxqjJJ5/5sCXuWXrzvofQzwVrol4y/C/WV/4zN7l9woEOd4fg2sdmjk4W2a+ecxyLEbgZm/8
 xmQUA
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

This series adds Embedded Controller (EC) driver for Dell XPS 13 9345.
While EC appears to control most of device's peripherals, particular
driver addresses power and thermal managment issues. Key operational
principle involves initial thermistor constants configuration followed
by a periodic reporting of these onboard thermistor values from across
the motherboard to the EC. The latter then handles fan ramp-up/
ramp-down internally. Suspend/Resume must be likewise propagated to EC
for power management.

The driver was developed primarily by analyzing ACPI DSDT's _DSM and
i2c dumps of communication between SoC and EC during various stages of
operation (bootup, suspend, resume).

With EC driver in place, the following issues are addressed:
1. Fans were not properly cooling the laptop, would kick in late and
   spin lazily, resulting in heavy throttling. With EC driver fans
   start sooner and hit high RPM under heavy load.
2. Fans were not stopping once SoC temperature dropped, they would keep
   slowly spinning irrespective of suspend and/or closed lid until the
   next powercycle. With EC driver shortly after SoC temperature drops,
   thermistors temperature drops, and fans ramp-down.
3. Keyboard and touch row backlight were not turning off during
   suspend - only lid close would power off the touch row. With EC
   driver behavior matches that of Windows, suspending device with lid
   open powers off the peripherals.

As thermistor readout depends on pmic's ADCs, this series introduces
EC driver and its schema, adds missing ADC to hamoa-pmics, and finally
adds thermistor and EC nodes to x1e80100-dell-xps13-9345.dts.

Additional findings:
- Max fan speed depends on Dell's power mode settings, configurable in
  BIOS or using Windows app (relies on ACPI-WMI). It appears best
  cooling performance is achieved under 'Ultra Performance' profile.
- When the said power mode is changed using Windows app, EC IRQ is
  triggered. Windows performs what appears to be thermistor contants
  readout, though its not obvious what it is used for.
- Given similarities between Dell XPS 13 series (codename 'tributo')
  and Snapdragon-based Latitude, Inspiron ('thena'), including matching
  EC address and response to suspend/resume command the EC driver can
  be likely used for both, though in-depth testing on 'thena' is
  required.

This series depends on QCOM SPMI PMIC5 Gen3 ADC [1], which was added to
`linux-next` for v7.1, but must be picked if this series to be backported.

[1] https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/

Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
Changes in v5:
- Rebase on latest linux-next
- Re-schedule work if suspend fails as per Ilpo
- Fix comments as per Ilpo
- Link to v4: https://lore.kernel.org/r/20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com

Changes in v4:
- Change to .data struct provided via compatible, which contains expected
  thermistor arrangement and magic init sequence to make it easier to
  support new systems as per Bryan
- Change milicelsius spelling, add newline, return as per Bryan
- Link to v3: https://lore.kernel.org/r/20260801-dell-xps-9345-ec-v3-0-9f4bdb5a5dad@vinarskis.com

Changes in v3:
- Rebase on latest linux-next
- Add Neil, Stephan to CC, as they worked on ADC for PMK8550
- Drop VADC for pmk8550 as it was already merged upstream
- Rename PMK8550 registers to use newly upstreamed headers for ADC5_GEN3
  in both dt-bindings, device-tree patches
- Rename ADC labels to have meaningful for user names as per Bryan
- Drop Dmitry's RB from last patch since it was almost completely changed
  now
- Link to v2: https://lore.kernel.org/r/20260404-dell-xps-9345-ec-v2-0-c977c3caa81f@vinarskis.com

Changes in v2:
- Update cover letter to indicate dependency on QCOM ADC series, only
  relevant for backporting
- Update description of dell_xps_ec_suspend: entering suspend does not
  necessarily ramp down the fans, if thermistors still report high temps
- Add die_temp/xo_therm to pmk8550 as per Konrad Dybcio
- Add missing header imports as per Ilpo Järvinen
- Add explanation for EC reset pin being reserved
- Fix device-tree: minor issues as per Konrad Dybcio
- Fix device-tree: alingment issues as per Konrad Dybcio
- Fix driver: alingment issues as per Bjorn Andersson
- Fix driver: handle temp value as 16bit register as per Ilpo Järvinen
- Fix bindigs: description and example as per Krzysztof Kozlowski 
- Link to v1: https://lore.kernel.org/r/20260401-dell-xps-9345-ec-v1-0-afa5cacd49be@vinarskis.com

---
Aleksandrs Vinarskis (3):
      dt-bindings: platform: introduce EC for Dell XPS 13 9345
      platform: arm64: dell-xps-ec: new driver
      arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC

 .../embedded-controller/dell,xps13-9345-ec.yaml    |  91 ++++++
 MAINTAINERS                                        |   6 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  86 +++++-
 drivers/platform/arm64/Kconfig                     |  12 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/dell-xps-ec.c               | 308 +++++++++++++++++++++
 6 files changed, 502 insertions(+), 2 deletions(-)
---
base-commit: c74ef2fbf60ff7e7b956c023a881e87502c1852a
change-id: 20260331-dell-xps-9345-ec-e5f49d1bef61

Best regards,
-- 
Aleksandrs Vinarskis <alex@vinarskis.com>

