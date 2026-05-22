Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7196441030;
	Fri, 22 May 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464414; cv=none; b=jckVVUAiRJKq2U59ZyTEwJBrJA2jAsqGtS0x32jpFlqYgkKqLMcYjC9cfhmNEEzL9I8rUh+DgiWBuWMBS1Dr6+jSMlgIN1Xj4pjxscI9cvY/hgqHMfG1x7BmVXV/Qfdq2GspxbHblcHCEci29uSR4HU+w4mRJkB+/LC2lxiyQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464414; c=relaxed/simple;
	bh=WczONd7mpNhYLChVMriFZs2nu8WLmfya+omRfON8/Hs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=slKM08LApQysJglglWpyIejKooRJd5WvH+Iu6VcZDJtenLyVmXbrCnuxAkS2KHJnXbWGqFI8pvowU7PGpiENw71/RXUUrXA55yVFIZEQuAKhDwPzKvQHQTD2srOKlpt2QeKLTg4kWzqsiQQPn3P10HqXaSRCcmKEphCFKiX2BhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlOiQD70; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EivLgcIZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlOiQD70";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EivLgcIZ"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ1imeqZ1Bc/uc24aV3TZVpElQegMgVauvFloOACEZY=;
	b=qlOiQD70p6dU0RLcBrElMcfW2H5mzLQ3W92/VVpUjQPb/L3owihhNdqksRYBRui6m/fqXR
	JhUckeI/iYFLnoOPoQxdu51BRNUr3iSC2cooTolNQETob/nof7aNXg5beT6wV9rpVDp2fQ
	6eSOcU9MDC1MnW4Tqgo53ZhcHRx9hvJqVmUiaess5WxeybEUv51JxF0PDVHWatU5trRjtZ
	W+RLi2MR7RQM4oJfyVb/9Y9cO7w510UljI/N6iYqMh3uKizzQzBdWdo3rTzLUdEKnPE6zg
	QmTzeh6tsK/q7gRxAmyan6kNl3WIJBlEzGKG+lzzEyg2CYLLAZYyDnvncUoiUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ1imeqZ1Bc/uc24aV3TZVpElQegMgVauvFloOACEZY=;
	b=EivLgcIZaB61jGRfbmekMSnr/ofrR5PHxGemnfBaH1yWf1sGhkzdByH1egtAwPOUMYEtLe
	IdM4JmgFSa4VbMBQ==
Subject: [PATCH v6 00/10] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Fri, 22 May 2026 17:40:00 +0200
Message-Id: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANB4EGoC/3XPTW7DIBAF4KtErEs1jM2Ps+o9qixiGBqqyrbAQ
 Yki372QLmrV7vJp3nyjebBEMVBix8ODRcohhXEoQb0cmL2chw/iwZXMEFBBC4bHKfBxnriLIVP
 kWnpLwlnvtWNlaYrkw+0Jvp9+crr2n2TnqtTGJaR5jPfnxSxq7188Cw6cAJ1wPSkA8/YVhuscx
 yHcXh2xeiDjLyFBbgisRCe0IqvRNHqPaNaE2hBNIbBrVZmrRnVyj2jXxPaRthDWG6dROmNQ7BF
 yRSBsCFmIHhXJDgzR2f4llmX5BrU1p3bOAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=3446;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=WczONd7mpNhYLChVMriFZs2nu8WLmfya+omRfON8/Hs=;
 b=uP/teUmc9q7IhXxzEBLrPJerSrL1/0mL5ImZRRSTOut1b0MmrXh8G3cCjujugKlCCJ5Lz/Ko6
 bUXGLLi7q3ZC9VadrP7F8aoX2HCXUOL/1d857zNUrsZg/lUAeteGDtp
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
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
Gregor Herburger (10):
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

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++--
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/raspberrypi.c                     |  59 +++++++++-
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/core.c                               |  12 ++
 drivers/nvmem/raspberrypi-otp.c                    | 131 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  17 ++-
 11 files changed, 244 insertions(+), 15 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

