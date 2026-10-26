Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792974598;
	b=lUtS3SSq6aNQgiHfSp3ebZEMM5KcKtDQcrqXDCg/OiLkBGiv+spvtjQV2ivxtraE/as8
	 ZQwUHdp6LOkpytyAUXwE0Y9A2reE3yZ2pM/cl7mIuRMoMLyBrsgiTqQ/Lry4YT2tYm0sI
	 M9M3jIW2sSsN8xuqi54p+400H7TK4CZtb0CTsM9q+a0Uyri5/YnBjTpxu6flpUOuLqt70
	 FSWWRKWgBUk4GmX0QgU+1NQdees1A0iDBwFlhJkC2OWGcE7EssyMVciG0RF5wGi8tPn+H
	 0jzmw5FFr5i3Kh14Nl218wjM2WW5nrKnWi2k7jNwAw4hA/e9zQaHtX2mzdjVhooHmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792974598;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3kLZpiyAVInYzsnWS6FT3ErlcLNEMFglYc//NLf6F+U=;
	b=qE/slQxvhxXaNKQBYSAEeWKuVvWBV0aMbQEbIa5SNo8AByoAE0VWATwduP+ytZfmxz9n
	 Z25VwfA7mAJS4KsPpHMXY28g1t02PyEKbvUsyfltmIksOjMLKoimcYPklhxY8txYK92eB
	 Qiu+C0COFl89QslBfDFNcAse9cv/eX+K3RPrRtWeXijuvZ9x9Y2XETCQE5G17Vj4/OV5a
	 poaXbeo8lGjPFHRa7LAUOHWOFHo6LFKZIldtQnqiCJ35OyMLS2FeS/bGw1RwBbIgMr9h4
	 kp4h4OeTZMZH0j+AX0M1c2HgnPqRHwYsM/n0HPyICzULV8DIaTBQbgjPsWBAwVf42yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=d7u01atN;
	arc=none smtp.remote-ip=185.70.43.171
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B0606A31E;
	Mon, 26 Oct 2026 00:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=d7u01atN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792974594; x=1793233794;
	bh=3kLZpiyAVInYzsnWS6FT3ErlcLNEMFglYc//NLf6F+U=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=d7u01atNDgXx99ZWqSSjdt2Deopk/U9voljOpKyHYQZFxYKy/hp8W1MwP8ac+IwZv
	 Y6bQrcDLdlCB75D/yeEB4EHrM5NBmKiKaDSRg4NVa7BxYxacFKnFJaNgEAQoWqxj8p
	 tslicZXyYrIoyYXIhxdSqFQZpDZWavxkdklZD3Yvkw1f6gGRE07bFq9oAuN3LssAZm
	 /hqVw+VNuLDTVQXah6ceYpBqN2wwcYQUDuLLAzmvUtPMC/FEUJ4GhUhqQ1I/e1fp+2
	 l7CwdIZmpnOYzsToPZEOpORwA+ujDepeW+m0VU5LWb+hUqgTPCq6vacFAb2DAemexY
	 SgcXm3qgNfQDA==
X-Pm-Submission-Id: 4jCZJc4KBmz1DFDy
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Subject: [PATCH v8 0/3] Introduce EC driver for Snapdragon X1E based Dell
 XPS 13 9345
Date: Mon, 26 Oct 2026 01:29:39 +0100
Message-Id: <20261026-dell-xps-9345-ec-v8-0-251c2cbfbc6c@vinarskis.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XSzU4DIRAH8FfZcBbD90JPvofxMMBgie22wrqpa
 fru0q3RxpB4/EPmN0OYM6lYMlayGc6k4JJrPkwt2IeBhC1Mr0hzbJkIJgyTktOIux09HSt1Umm
 KgaJOykXuMRlOWtmxYMqnlXx+aXmb63won2uHhV9Pb5hiHWzhlFFIoAOEqJzHpyVPUOpbro/hs
 CdXcBH3iOogoiHBjWOQAcDy1EPkL2K7k8iGuKR89Bp0hNhD1D3iOohqiLWSmeh9GAF6iP5BOOO
 9SXRDBHgutPVWBd5DzH+IWRFjQBqVcGQ9ZLxDhOkg4/U5wgaUjHsr3V/kcvv/gu8fbZPm2xIQD
 xVpu9/neTNMeJrpdwvZKi5f3wLNJIMCAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6502; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=Gtlk7oWtkTWLZY1n1ZogGjUOQdSH0zFF9/uBFOODia0=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFn35jMwmtUlbo95KaQYdudVY+ljPkmlK6EzzumuuGhpH
 mdq6P+to5SFQYyLQVZMkaX7z9e0rkVz1zJc1/gGM4eVCWQIAxenAEyEp4jhD282s7fW4f4lTx+1
 BJR/MCpt313+uNrM3H/+UwvHr8+VmRkZ+sNS1nPWcvFP/foigymN90hDVh3b5G515Y1nor8c05X
 iAQA=
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
Changes in v8:
- Fixed missing semicolon, broken title. Apologies for the noise :(
  Relevant changelog in v7 below.
- Link to v7: https://lore.kernel.org/r/20261026-dell-xps-9345-ec-v7-0-828ce301b839@vinarskis.com

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

