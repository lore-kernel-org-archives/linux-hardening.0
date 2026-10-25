Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972599;
	b=rkSxslR+oniCdnxb+03lJzz28UcO2qRxrUrRf5JUItrVjlOByhOz5K3fxk9t1NNxQ+4v
	 IBGYjUh9sdNVY1xBb8l+PbJJcbZKPVRaXlEcsrPEHsYo6lqZlQY0W0q8a8ayDfSO8uC8w
	 O81YYnl+5SYALgAwtyAwyPP8LeVYyJELx6vUFejCksVtls9KBh1dDevj6Oe4ZAf1f2OIg
	 I5IfI2grApoHwa//VkuPr5bQTlBIDqG1kAm5UfzDnTPkTWmBtR0MBsfnNOF23t6f2IX0M
	 R7dsQ7iJ5S5pB65uLve3lz6ZyDlRe6xhyCYIaDLNn4i64rImz2ZJD58ldYinjwR0JDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972599;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IfttFnFIG7HoZA/g9s8CpEWP9Egm/QlQ/rKRoYlIM6Y=;
	b=KpvCND3ezFMXtx8gvGcNuAd2J7av6s+FiBrR9KhslOPg+bnzTD5Iq0JATUKZFnradklO
	 rzhm4q+jtLmZo0oUUSs9NM6j2gXZnp/7pdincTQbVsX2Si/dEhuqkK0EhzvqgokPcEki2
	 jqHXrgIEWm6i03rMq+MuObThppA0hT1ABxeAvKpTwI4OPxqVp/9p0P1uZQVheHMjLj7BF
	 2rMCvNkyNWqzNlKuxjyvvRqtPBFhCeVxYygjdqxy5HrhCKYAXfrU1mLHRYn7nr6yZNwZG
	 BiuRE8q1fC/QWE7GjxoVhntxqoEKWX2Kro3nP+Shba0IhVZnsZSE6c1/+yCzms8Jt2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=Gu8ae8l9;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6A606A31B;
	Sun, 25 Oct 2026 23:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B6A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=Gu8ae8l9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792972596; x=1793231796;
	bh=IfttFnFIG7HoZA/g9s8CpEWP9Egm/QlQ/rKRoYlIM6Y=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gu8ae8l90NAoNZR9UU1hr/JwLJVuAlmhmL66yAiN1tRBAQ0Fd1wAxOc78aQ8ypaIX
	 x2hgdpw5XK73VKUE2RnkqPBkV/vrYCu+SobzAG8XnnReMetor64VYFDFOudRVxZkB6
	 FVGmuTGAScdZAmWPf7q11SfLryrRCjy4N4MoJdpelT5Ry48jRT6P+jla65kgE8LzEO
	 4TFn1yBH9Hr+F/PPKhZ6c4j2JOqv/9zVltkVXWOOcuYbSsCOGngh9vVxMyJN67ZbCs
	 ICvOQletdqi8BAZJFsMrTv5Gbv4dfNGH/DWJi8vwrx/6HoqQJ7a2VzOITtGKcQJUq/
	 UwEZLUzWYhayA==
X-Pm-Submission-Id: 4jCYZ81Stfz1DF5K
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Subject: [PATCH v7 0/3] (no cover subject)
Date: Mon, 26 Oct 2026 00:56:22 +0100
Message-Id: <20261026-dell-xps-9345-ec-v7-0-828ce301b839@vinarskis.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XSzWrDMAwH8FcpPs/D33F62nuMHWRbXs3apLWzk
 FH67nMT2Mow7Pi30U8C6UoK5oSF7HdXknFOJY1DDd3TjvgDDO9IU6iZCCYMk5LTgMcjXc6F9lJ
 pip6ijqoP3GE0nNSyc8aYlpV8fav5kMo05q+1w8zvrxumWAObOWUUImgPPqje4cucBsjlI5VnP
 57IHZzFI6IaiKiI77vOSw9geWwh8hexzUlkRfqoXHAadIDQQtQj0jcQVRFrJTPBOd8BtBD9g3D
 GW5PoighwXGjrrPK8hZj/ELMixoA0KmLH/iK3bXUZL5/1CKZtf8RBQVr/T2na7wZcJrq1ELJW3
 L4Bn325uT4CAAA=
X-Change-ID: 20260331-dell-xps-9345-ec-e5f49d1bef61
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: Liviu Nicoara <lnicoara@thinkoid.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6645; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=Hxch++SqWJ2+B/BmAZlvxRxCYyX/DC8aRHmln5ToaOQ=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFn3puv3Bx5wkvh8Tuuuk5FpoWjFBNUD8zS2//z//531o
 cPyS/Zs7yhlYRDjYpAVU2Tp/vM1rWvR3LUM1zW+wcxhZQIZwsDFKQATiX/NyLBxydmVk35dlLLd
 qmU5O2Ka5Lzy99lL3x54/kdPwXvFjqqXjAxTq6c026X5B2+RV2a7dF50cdW0P2WG6X59yQk373d
 FSzIDAA==
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

gpg: Signature made Sun 25 Oct 2026 11:52:52 PM CET
gpg:                using EDDSA key 8BFCF5668AA29DAD00D728F6EDAE71A20F500310
gpg: Good signature from "Aleksandrs Vinarskis <alex@vinarskis.com>" [ultimate]
gpg:                 aka "Aleksandrs Vinarskis <alex.vinarskis@gmail.com>" [ultimate]
Introduce EC driver for Snapdragon X1E based Dell XPS 13 9345

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
Changes in v7:
- Rebase on latest linux-next
- Fixed 1st, 2nd channels from AMUX3_GPIO, AMUX4_GPIO to AMUX1_GPIO,
  AMUX2_GPIO as per Michael Burch, Liviu Nicoara.
- Fixed sys_therm0..sys_therm6 to sys_therm1..sys_therm7. Initial
  convention was picked based on schematics. It is now changed to match
  most of the existing device-trees.
- Fixed dt-bindings schema to not use arch specific imports as per
  Rob Herring, sashiko.
- Adjusted thermistor label as per additional findings from reverse
  engineering investigation.
- Link to v6: https://lore.kernel.org/r/20261011-dell-xps-9345-ec-v6-0-2a66a364fe70@vinarskis.com

Changes in v6:
- Fix dts mistake due to rebase
- Link to v5: https://lore.kernel.org/r/20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com

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

 .../embedded-controller/dell,xps13-9345-ec.yaml    |  90 ++++++
 MAINTAINERS                                        |   6 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  65 ++++-
 drivers/platform/arm64/Kconfig                     |  12 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/dell-xps-ec.c               | 308 +++++++++++++++++++++
 6 files changed, 480 insertions(+), 2 deletions(-)
---
base-commit: 77cb3534193b758eaecd662a610a3a1bffde43ed
change-id: 20260331-dell-xps-9345-ec-e5f49d1bef61

Best regards,
-- 
Aleksandrs Vinarskis <alex@vinarskis.com>

