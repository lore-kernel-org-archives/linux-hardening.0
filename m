Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CC4418CB;
	Wed,  6 May 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070513; cv=none; b=k2fxS3XV6nNYBMmVhyIvUzehusKuLRPtybjV9MDfgo5NFp6X/9rFtcEl57qIrqQNEv1xdRYF319sj8/7qCluzn7UK4T8bB5Xc2vFOX4Slz+hpBncb0xI+YJv/bvBMabB+oJRXS2yK2P0C2aLdUNcDqW0AVu92zDdNcpU12ZfSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070513; c=relaxed/simple;
	bh=h2DdwHnpSm9GT23TX10C4j5YVLHusim3g88AnD+8Q4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uax3rE69l8jbzbaYfW35eqiC1qipeZWfThjiBEUJ/o2Dm6TlmylDNSpN1546po4UWUFwjM89UOKhL1P4H70ImnMjG5r2Ga2HztP5lQMjvHi8veOMzaNNc8/k71KR9Noeg54AOXF8Fnw/7eAHl1cljCOQtZ8WOeGOrUUb3r7Jq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNgkf5Co; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vU5OMg5U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNgkf5Co";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vU5OMg5U"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778070510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDGBJbL2NvS6X0WDh9bIw2fs6RpUDabbpuEEljscOpo=;
	b=ZNgkf5CogPCNx8svAZzreW9bk3lgPrlUAWBzYpDfZmBFVxhzUHfdW9tX/Hy3gbeVNtlq2S
	t6Bi4HvY7v66txyGAlacry5iPq3Yv2Nv/okRCRiqY6jykZgRZ1oA3yQc0b+yL4GElGrrkc
	T+sCPFpqboTMSXhMRlpbzdmDt3CN8v8Dkm+ZDPKML9pYd9rxGdXXCPWq1lpSlDqFK8MWTK
	q2PmBZoFULkcjm/T0SdSvMsbXpo/VneMq9itZ1VIiUYcajSE/o2m+l6RF8KgevvqXOSD/r
	ucuk+0eXvFmsuHLyQBfXCXQHwf1S94AAWluJOWQ+YR+GatwilExhFSXlw864RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778070510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDGBJbL2NvS6X0WDh9bIw2fs6RpUDabbpuEEljscOpo=;
	b=vU5OMg5UjghUYmPTJ4HdtVqlPCgZHd+oFcmoBgobGRGqL4JV9MU/nh3hVrneXPp/PSqXgv
	nIjQ7PSeRTuk95BQ==
Subject: [PATCH v3 0/4] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Wed, 06 May 2026 14:28:14 +0200
Message-Id: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4z+2kC/3XNQQ6CMBQE0KuYrq1pi1B05T2MC2l/5RtDyW9pM
 IS7S3FhonE5ycybiQUghMCOm4kRJAzouyUU2w0z7bW7AUe7ZKaEqsRe1Jx65D723BImIK5LZ0B
 a45y2bBn1BA7HFTxf3jkMzR1MzEputBiip+f6mGTu/cWT5IKDUFbaBioh6tMDuyGS73DcWWD5I
 KkPUYryh1CZOEhdgdGqLvQ3Mc/zCx9Rr8kFAQAA
X-Change-ID: 20260408-rpi-otp-driver-75fce1dcff7d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778070510; l=1864;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=h2DdwHnpSm9GT23TX10C4j5YVLHusim3g88AnD+8Q4U=;
 b=0iTh8vD+bgUXNiojQXakvPeAxiKwpUiQffjzRL/horECxeARB97nOoGjwOOPlOMEpfILf77gi
 +UM0N5E+yLJCl9YCH1zYWXfNzKZQ9QeY0gopBspOc5u3HtpkfeuyC7T
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
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
Gregor Herburger (4):
      dt-bindings: raspberrypi,bcm2835-firmware: Add bcm2712-firmware compatible
      nvmem: Add the Raspberry Pi OTP driver
      firmware: raspberrypi: register nvmem driver
      arm64: dts: broadcom: bcm2712: add raspberrypi,bcm2712-firmware compatible

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  13 ++-
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
 drivers/firmware/raspberrypi.c                     |  59 +++++++++-
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/raspberrypi-otp.c                    | 120 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  14 +++
 7 files changed, 216 insertions(+), 5 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

