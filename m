Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327860;
	b=G0udZ7pro7jQrUt1eOJPHqsGFm2OCQXtFSjkNr0VtpJV+lnl6On8UJnYbNjYwP8PJ+On
	 eapzfeScMHGQeHmlftHLYz9cgQTPvbVsVMBvARsaJM5mO5Ukxtcfr1Wi4rgv1g+iev4BF
	 gkyeupaOnhToGemlsG+Rk7LHPNJrFCefrr+zHeD8qF5LqwV42UCYYh3cWViFf3hHQYag9
	 7VI4S5+x5haOgCCfIwI02yG2wLHgEC08i+yM6GnsG+PfonGlqf7iHGa+RMPCngo/IOTgb
	 McYHL++HPnn/Rqjt2Q36s09LEYrf9MmATHSlZjHVv7X23W6NiKpoGZ1rlg03C2FjTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327860;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=VMVsIg9meqQ62t0+CY5CMduv42wKWJXNSJQ6i89MUtU=;
	b=oYZbKIiE7hYnCUxqedFC18ELrZK1c8hKCG+xangq5nYdTBJa8Cw1z06API8/nJ9rJ+Ie
	 p2oNjqcGgnwnJzjPMLSA/z+JWbeYq2PjSMYRylaoewDwZvPCID2VrEzQsiffkU5swDFWs
	 y8ZuuVJzu0jx8lCWVL0dIz0NTEsZKyfUib57X4LonFbzahjPSfXcRS0ptD7usjFQUlr4j
	 pktb++rZgx3XTV32BBjP1ERmlxHbx4G8avlwuDmi5t6Cm7o8MbWEdX5uVFAoorsljR2Ej
	 Bf0nRdEecjQLsJtrshsv7RMT9Cuvp77h/uVtlMQFH1j6xE497WLkd0Jo8gNsXWJFzuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EENM8nu1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qZvIy9Hq;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508D606A33A;
	Tue, 10 Nov 2026 16:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8508D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EENM8nu1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qZvIy9Hq
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMVsIg9meqQ62t0+CY5CMduv42wKWJXNSJQ6i89MUtU=;
	b=EENM8nu1gPjUplzI0LyqYGDYDX8ydEIilY2kjl2L4RJM3e8Zgf0G7mP7B96tI6B+vMgdaT
	2u5+ES4kgbgdRK3MmNArmOuQe1pvBz+jr/6bhDcm0b/zJoB9OAFoE7dWT7dcvYUYBTKRZK
	3Wc67DDXgJ8/LnYUc8jFGzbgUcibwaVigomk992mb2zK6xJsXCkfh1qXr7Y2safpN8ss0I
	L6LuAO6s9CIB9Y3gpn5PLm6IwwMiPrSeAqtmZjVAlOH7Ioi3Y45BwQazlZlrdhBvfp7Bcv
	4uUYy4y3GeeaYj0cl+FLvrKZmRNgZ+HisihcwVby16knSiQaoef2uu1dHOtd/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMVsIg9meqQ62t0+CY5CMduv42wKWJXNSJQ6i89MUtU=;
	b=qZvIy9HqzdP4cmxki1IfCUc3zcjfH8nAuG9BO2d3g8Ig0zYDMXzkTbk/y6I3uP/mop1xVg
	yMwKWeViyNHeTECg==
Subject: [PATCH v7 00/11] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Tue, 10 Nov 2026 17:24:01 +0100
Message-Id: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIACFF82oC/3XQzU7DMAwH8FeZcibIcZsvTrwH4rAmDgtCbZV01
 dDUdycZByqlHP+y/bPsO8uUImX2crqzRGvMcRpL0E8n5i7n8YN49CUzBFTQg+FpjnxaZu5TXCl
 xLYMj4V0I2rMyNCcK8fYA395/c74On+SWqtSOS8zLlL4fG1dR+/7FV8GBE6AXfiAFYF6/4nhd0
 jTG27MnVhes+EdIkA2BlbBCK3IaTaePiG5PqIboCoG2V6WuOmXlEdHvifaQvhAuGK9RemNQHBF
 yRyA0hCzEgIqkBUN0dkeE2hPYEKoSUGat9qLH5p3btv0ATWr5tRECAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=3710;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=nOC1D+FzrtqhciV4vMD0rRrY6gGMlplEHYuBvs/KV+4=;
 b=HjfrNLCGJwvmuPU54O2NOIyR8TehJe80KJDwMAsf2C1JBqXCQ8+9TTtwi3JjD6c02kW6BzKlV
 EtDgHACOrCdB4WVB1kNI5jmu28zsggtdIhsVZJMaF7ckweXexiMi7OU
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
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
Gregor Herburger (11):
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
 include/soc/bcm2835/raspberrypi-firmware.h         |  17 ++-
 11 files changed, 246 insertions(+), 16 deletions(-)
---
base-commit: c9ea4adf1af3e26c64c45ab8005295c420a5703b
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

