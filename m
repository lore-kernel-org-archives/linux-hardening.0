Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58895330B30;
	Sun,  9 Aug 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786282413; cv=none; b=sbj/NQ0Xs24iRylwCR9Mq3wdik4V+IV0N8Tf2SSJkWBUZACclVXLSoLoShQnXqyw4ZilEw2SYKp+wthGOcrWswFqhc8O971UrxQWCX6Sco5jzh5HOQX0+CiuLN72/PTlNCakdVIzBkGu1D7UjRgpeUFTmBpGJcBGy9HiKNbGQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786282413; c=relaxed/simple;
	bh=Hb+JWyJHzlEtlLBgiutHAfg6QZq9unkmVOk0e9uAIE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s66w+rv5rDAeblxpKQZKjsfMu/OocHLxduNTDqWzY5iQOro+zv24xmWOIFum8IKZcJU5q3vCe5jL2kiUv+3lL3Y/ghjY7FG0q2A8rWiV3/VaueoGwxGvMm64+16Sqx2l1SWP0pzUIkThHM4hgh0os+GJMPQZKUsuvemfjZ9nSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=rCcXNM0t; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="rCcXNM0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail2; t=1786282401; x=1786541601;
	bh=5Z0a4hu3W8DWYWmXjfh6SUfvSsbMRjOeRMWqhLM+3jQ=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rCcXNM0tBtMq13WihMpKs1tTP5rjxk9wW3LTB/72nknvzYy5X2n7Wapk5OOQEMO7a
	 Pvq884vDrzMDgK6Y0oJswlttmm9t1FjDXCn7de+1q6FcBuZPhUnZ/GHuiaO0lqH3yV
	 o6ItdJj4NKjYFC+yeU9uLchfIN+Ih8zO06w/VGz6sApQPGmDTd+UhTZOpxb5Oteewm
	 iaod5n6b5VTY6lNLSwhJvgLnFWlMyMsWmLFp46iJEOkDIHGmhfkpd0rEZVvhN5Xzkx
	 g4pg2ASTTAFL0zwfQMn5EmPwpiRNl9PEj02hcll5pWUdWl4bmxjUECAnB2YfZVac9S
	 orcvNTFJyZ89w==
X-Pm-Submission-Id: 4hHzNb0tpXz1DFFP
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Subject: [PATCH v4 0/3] Introduce EC driver for Snapdragon X1E based Dell
 XPS 13 9345
Date: Sun, 09 Aug 2026 15:32:45 +0200
Message-Id: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QwW7DIAwG4FeJOM9TCNCUnvYeUw8GzGqtTVpIU
 aaq7z7aTNo05fhj+bPNTWRKTFnsmptIVDjzONSgXxrhDzh8EHCoWXRtt2mVkhDoeIT5nMEqbYA
 8kInaBukobqSobedEkecn+b6v+cB5GtPXc0KRj9cF0+0KViS0gBGNRx+0dfRWeMCUPzm/+vEkH
 mDp/iJ6Bekq4m3fe+URtzKuIeoX2a5uoipio3bBGTQBw3/kvtya6HKtvzYtBwuHmaDWTzztmoH
 mCX5G9LXj/g1SW2EgbwEAAA==
X-Change-ID: 20260331-dell-xps-9345-ec-e5f49d1bef61
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5269; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=Hb+JWyJHzlEtlLBgiutHAfg6QZq9unkmVOk0e9uAIE8=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFkVjfOuBj/TEdr/Zc6CRSJ9e/jbxFvaFKyql2w4viR2o
 /j9s5e/dZSyMIhxMciKKbJ0//ma1rVo7lqG6xrfYOawMoEMYeDiFICJnHjLyPDESl44N0XokX7N
 wvysuG22XY67PSfHz9j+/ePSf3las9cz/OH7G3vN/ImbYMH8PdN37Z3unmazZFNV44T33Sf+MIU
 8lGUEAA==
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

 .../embedded-controller/dell,xps13-9345-ec.yaml    |  91 +++++++
 MAINTAINERS                                        |   6 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  86 +++++-
 drivers/platform/arm64/Kconfig                     |  12 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/dell-xps-ec.c               | 299 +++++++++++++++++++++
 6 files changed, 493 insertions(+), 2 deletions(-)
---
base-commit: 115cd2ef86146afa47f363fedf97890575abcca4
change-id: 20260331-dell-xps-9345-ec-e5f49d1bef61

Best regards,
-- 
Aleksandrs Vinarskis <alex@vinarskis.com>

