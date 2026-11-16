Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823853;
	b=s7E6VP7V5gckmjGk6ftWebRD/UFIBAyfmL5Fw3TrDH5MsnoccKgJGyagQ+kQEFroSkaw
	 SfT81HBX3hK18ycIOErh021EvbEQnLhEn5ObJo0w/QFPmso2QSq/PVA6XPmH5smaufu1o
	 R78cNwHIa66Zh0ttzlKbFj1hNscpTma7oujgBgcBZeCH6GZawYg509tBdlr8BV1aEVT2q
	 utF5e6EffcofxAL+8U+pPO21UiT+uwoyMWVKuSCBNLwKq2ocRo947v8uUcUf9Qscx+EhO
	 wF15o1TsP+h4xHlEu37IogkZ9dRSG+OdWOJDDeq2hKlpvUN0K5kGUkHA/AAUkq7v/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823853;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=zJI5ISYs5FVPLf6JtLTWvwRuZzcFAzkLLTbosQMoqaI=;
	b=o1oPuP4RORMFZtrQdgOSZfcDK9x4FcoJWq9RS0Ytca8h1GbnuVCfPQ66ujxj98Airaa9
	 kl8i4Qa1gwBcyhnKuOygBvDh3/WeUVmP3q97wT/Y/g8imHnOU7tmGDr++j0WCXyozb0hz
	 msoRu0I7z67Fg4sm2+yrOVaa1B86ZEO4kemdrooG1rfW9KQKmsuasPh0HYAtH/fATNWAu
	 mRbhevzK7npUSNX4Tk1hDK52xkHkZttiIyP0/bMH/flLMDYQNin6dU/lQtsD4FCJvBZjI
	 Lcon3EFKEkkAiUBXTy7UtPwtAwiN54r7Cfk/7dtO/R2QPhzrHeH3uAdhaTKa46NRPVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eYvfScX1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=COGS2wei;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF10606A323;
	Mon, 16 Nov 2026 10:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF10606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eYvfScX1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=COGS2wei
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJI5ISYs5FVPLf6JtLTWvwRuZzcFAzkLLTbosQMoqaI=;
	b=eYvfScX1z+xoSRjgPDrJ619PXHGQw5/dBm5H6sqsSZg0R28sQXFbuTMHwmNxplBAG4fRCF
	kuPVvhUM577qQfTqBHWHOJQR5j+IciWi4lvHrQuBsnZWtE2YtyFqaz7XMqmgK0vbUXOAsn
	r/DPMeGOL/yKQJGR0Gk+fm4jF1JbhuyjYw+PnjY/7ALS8wfq1IUV4gu9HUuu6Vah5IWtap
	haDIp25iCMZooQ8o4fJZ0XzKoWTJGZeJAypNvMo82q+Q/yvR9pjK+kXh+4dy24LxUSz9mp
	4ccxDtPuF0V12TYYUL9vZuQ91c9rq2jgWC2TsObvWbyR4vuLfga190R8w9Bgwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJI5ISYs5FVPLf6JtLTWvwRuZzcFAzkLLTbosQMoqaI=;
	b=COGS2weimoGDz+0aZVO7RsvX7Pv81HqRRXoBuo0UvH8h0oFZinjr3IlDV+33rp5D+1K9k6
	jy50Puoyc3fEotBw==
Subject: [PATCH v10 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Mon, 16 Nov 2026 11:10:24 +0100
Message-Id: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAJHW+moC/33QzU7EIBAA4FfZ9CxmmAIDnnwP46GFqYsx7YZ2m
 zWbfXdhTbQJ1eP8fQNzbWZOkefm6XBtEq9xjtOYAwkPh8Yfu/GNRQw50SCgAQVWpFMU03ISIcW
 VkyA9eJbBDwOFJg+dEg/xchdfXr/j+dy/s1+KUjqOcV6m9HlfucrS9ye+SgGCAYMMPRsA+/wRx
 /OSpjFeHgM3ZcGKv4QGXRFYCCfJsCe0Le0R7ZYwFdFmAp0yuW5a4/QeobZE/RGVCT/YQKiDtSj
 3CL0hECpCZ6JHw9qBZe78HmG2BFaEKQTkWUdBKtw9J/0QUsr6FVRu0SodgNnoAfYI+z9hM0GOG
 DRRUFLtEW5LyIpwmYCO0GFHne4r4na7fQHX77+j2wIAAA==
X-Change-ID: 20260408-rpi-otp-driver-75fce1dcff7d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=4454;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=GxOAvaOR2DK9AOVKVLa8PTRDOHEf803qMJPQcfGZs5Q=;
 b=IaIjfkGNEWZNp7NqzEeT1C519KcvCQj0h3ObmYbZVJ7UbQQOtrHha+35Ja1EUkD8DBrWB1QR2
 pK83s/LHsxpDkLnUU0HOvJ0RdHHOJo0mSEPU+qbIas9H42p5k4HYkbd
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
Changes in v10:
- Validate returned count in rpi_otp_read() before memcpy to avoid
  fortify panic
- Drop linux/mod_devicetable.h and fix inconsistent whitespaces as
  suggested by Uwe
- Link to v9: https://patch.msgid.link/20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de

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

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++-
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/raspberrypi.c                     |  62 +++++++++-
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/core.c                               |  12 ++
 drivers/nvmem/raspberrypi-otp.c                    | 135 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  37 ++++--
 11 files changed, 260 insertions(+), 26 deletions(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

