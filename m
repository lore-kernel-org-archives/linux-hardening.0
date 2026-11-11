Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381821;
	b=YHFo4d8dcqsrJBVObkuKjvaaHjp5y79jt/K1fxjlL3F5NRCOEnKn0vsJoLj5S507O5x0
	 MhXq1cmduH5bpC/KS8F8ie9PeNjlD8dsnB+xgMrifbf9JSUhFIxo3+gVR7hptJyl8AYeK
	 m0i5vCa/TurDq2gG+krs1zTIgCplw8jZLWWAD0MY+E2gTdbBbECvDpKo/kGmfbKgDEkIS
	 a3SlhqJv3i3sAn2wDLyhTvhCuvTvDbqJfqvvdhmCVqcPfjzoVfQurM6wl+lRvCl5WLcJ4
	 08jRIvl7zE7Ln8XzlVK9V92CteC3tAVQtdn6SdrZ+EKkvr//xwHIeNRbNlq+bwVO3rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381821;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=odS9dUZ49Y1hnEJ2Hafe1Z2f0ZFLLtT1Wk3Kza1w0Js=;
	b=vzgKO3WctUyzsoUQGXfk7SUoP35iEFl/alcWSkGcP1TK18/E2JQ4nJNK4Wn7JBrlmV7Z
	 71Y3CJYC4KwuKWSoXS3Iag3VyF5SMh7LvE5DvS2GnsVixUj7duaMPego4sIXTPQLsrdjD
	 7QIdFMueBF8NxERmo4tF0eRPB+4zWmehTkCtNoaY1J3TpfEnFToFub2dX0XX0w1XzCiXp
	 jAYn9uVqDtkNMOqmFaANg8wZJTeMrME808xQxlSCKPbe3LhNWejCU1NqM4FRE8YUcsPvx
	 iV1VZl7qS6lnxNhRu+4ZMt1n/tG61ryWG7ySaXKievuhgxyweeXiPMlaCnd6/M7+Heg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dyFNnaHa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="k9h8/QQa";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2306606A32D;
	Wed, 11 Nov 2026 07:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2306606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dyFNnaHa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=k9h8/QQa
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odS9dUZ49Y1hnEJ2Hafe1Z2f0ZFLLtT1Wk3Kza1w0Js=;
	b=dyFNnaHaUahcJgmTQ7BrXOIlvGRv5+u2NQ/a6mPzok5SnJR6YCjODMJMj4eO9/kpQjYcCh
	CFfjTA8W2ZNPToNFuXkHt9Pn+1Nag+yylFr8/57iWSwdCXRyhpO+QTpSQx6WyRhngJeqix
	el8/fhR/TSzpKcqGFpFGHfQdwd047i8DRAcyiroDOG1JcAwT7M5MOaECRMCGV/cHED/fK3
	GolJ59tkJjsuZV2rjlvaYvDU6/kUp1AvFW+MC1QnIm9RUnKpvsAJtyBOynwKhPQYrQY7WR
	xTBKXjVjofQ7L9dv3WKD8BAphQzgyjbjue5N59jDIaLnES77T8K8TaCXPpEoGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odS9dUZ49Y1hnEJ2Hafe1Z2f0ZFLLtT1Wk3Kza1w0Js=;
	b=k9h8/QQauglzQlVLDlon8f1QMDQU3t/mCAIYMZz10NZBnrokQ5g2YZqFaup6P0ug9VSaqy
	mBc68rMS/z+UzsCg==
Subject: [PATCH v9 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Wed, 11 Nov 2026 08:23:22 +0100
Message-Id: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoX9GoC/33QwU7DMAwG4FeZcibIcZM42Yn3QBy2xGVBqK3Sr
 hqa9u4kQ4KKFo6/Yn+OfRUj58Sj2O+uIvOcxtR3JfiHnQinQ/fKMsWSBQJa0OBkHpLsp0HGnGb
 OkkwbWMXQthRFaRoyt+lyB59fvvJ4Pr5xmKpSK05pnPr8cZ84q1r3Jz4rCZIBo4pHtgDu6T115
 yn3Xbo8RhZ1wIw/hAGzIrASXpHlQOga2iKaJWFXRFMI9NqWd9tYb7YIvSTWi+hChNZFQhOdQ7V
 FmAWBsCJMIY5o2XhwzIewRdglgSvCVgJKr6eoNG6ek74JpdT6F1Rv0WgTgdmaFrYI9z/hCkGeG
 AxR1Er/Jm632yc6NgjFlwIAAA==
X-Change-ID: 20260408-rpi-otp-driver-75fce1dcff7d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=4167;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=VfIy4FLtZv0a1ofEANZ8yvngWryhENrSGrWxkcSNePQ=;
 b=a04wkBm/1kWxXttsq5LuFGAv3zRQE/kvoLZUI851HeO+Z7X1H5Eq1iFBLpP2l33BfULNDn8h0
 IO4f8SdbXLdAshTFQDZSed9uzroVDyMDQyFTbQ3XW+I2avzkABMeikR
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
Changes in v9:
- Fix sashiko comment and use fwbuf->count instead of bytes in memcpy
- Link to v8: https://patch.msgid.link/20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de

Changes in v8:
- Really rebase to v7.4-rc2
- Add a patch to reorder rpi_firmware_property_tag enum
- Link to v7: https://patch.msgid.link/20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de

Changes in v7:
- Rebase to v7.4-rc2
- Added Patch to register rtc driver by soc enum from drvdata
- Link to v6: https://patch.msgid.link/20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de

Changes in v6:
- Use %pe in dev_err
- Include <linux/slab.h> to fix build on arm
- Add arm defconfigs: multi_v7_defconfig and bcm2835_defconfig
- Reword commit messages
- Link to v5: https://patch.msgid.link/20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de

Changes in v5:
- Move alignment check to nvmem core
- Use IS_REACHABLE to simplify Kconfig
- use root_only for private driver
- Add driver as module to arch64 defconfig
- Use MODULE_DEVICE_TABLE
- Remove some unused attributes, fix typos, minor fixups
- Link to v4: https://patch.msgid.link/20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de

Changes in v4:
- Additional patch to drop unnecessary select schema
- fix dt-bindings
- use __counted_by_le
- additional alignment check in read/write callbacks
- Link to v3: https://patch.msgid.link/20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de

Changes in v3:
- dts: add "raspberrypi,bcm2835-firmware" as fallback and fix dt-bindings
- Fix Kconfig depends
- Changed firmware data fields to __le32
- Add MODULE_ALIAS
- Link to v2: https://patch.msgid.link/20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de

Changes in v2:
- register nvmem driver from firmware driver and drop firmware sub nodes
- Use struct_size and __counted_by for dynamic array
- Drop unneeded comment in Kconfig
- Use NVMEM_DEVID_NONE
- Use kzalloc
- Update module description
- Link to v1: https://patch.msgid.link/20260408-rpi-otp-driver-v1-0-e02d1dbe6008@linutronix.de

---
Gregor Herburger (12):
      firmware: raspberrypi: reorder rpi_firmware_property_tag enum
      soc: bcm2835: Use IS_REACHABLE for function declaration
      nvmem: core: Enforce stride and alignment checks for nvmem_device functions
      dt-bindings: raspberrypi,bcm2835-firmware: Add bcm2712-firmware compatible
      nvmem: Add the Raspberry Pi OTP driver
      firmware: raspberrypi: register nvmem driver
      arm64: dts: broadcom: bcm2712: add raspberrypi,bcm2712-firmware compatible
      dt-bindings: raspberrypi,bcm2835-firmware: Drop unnecessary select
      arm64: defconfig: Enable the raspberrypi otp driver as module
      ARM: bcm2835_defconfig: Enable the raspberrypi otp driver as module
      ARM: multi_v7_defconfig: Enable the raspberrypi otp driver as module
      firmware: raspberrypi: use drvdata to register rtc driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++--
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/raspberrypi.c                     |  62 +++++++++-
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/core.c                               |  12 ++
 drivers/nvmem/raspberrypi-otp.c                    | 131 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  37 ++++--
 11 files changed, 256 insertions(+), 26 deletions(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

