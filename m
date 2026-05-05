Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1B20C00A;
	Tue,  5 May 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965917; cv=none; b=UKFfQR9wDujPHa1pLummnOu93/hRHiy7aJHUYdCLlpmaVzm5aoAoPgZcqBYgcNNN+5npwqYRaOLHvzRMPmP2/YgBYGwLhYB6cinwAPjWn1OHo05ZvvK+rxahjsF1I4xhd62hX3D0SNlYLD/Sx2p3C4lYpKT17Yy3AkjlaSf7yF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965917; c=relaxed/simple;
	bh=mfdpoyvJ/vQBbQI/bmDoedqkrugfTtNLIWwARcA+Uq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YaYkOQzBkF0Dayc6HCrV3utFdj6voj/UcVQdJigEMKutYq5XhUlZL+wkIeAtUf6QI8rQPW0BBiwH9AB3LwpNnxVo0j5hsj2oG4bAmG9bxNGzA6vwXEe7yr0pKgrrrcj2xSu3ZTT7i0cwBZFutCYZmzgEca2QdwwRQRqG2+ZhnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLoPDLEa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/56EhU+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLoPDLEa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/56EhU+"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777965914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s960FrAUsSOThuJjUj2aGZ3htIKJj0KKXIvAdIn5Z+M=;
	b=FLoPDLEalzO5+GNZIPbncOQyLpFqbsggpl+TL6ZGqimonY28p7i1fKC7pQlxYWX+AEs3h8
	sotGS/6jGzE8SqOHxiufuAn6DuzfA2V0CcNpmXXXwHf9LNu1xSPPnam63pDILn4kgHzpqY
	Uj0zEYrBmkVUyb/rbyL2/Bz3A/ALaZauTwRmrU5YcIataj+OV24OsrtrFJT7NaczApwS4b
	SM8BE1XqZEQ186VHpoj6DPwGrxxIEoNFmZnYWYNoUeW4GkWSl632GRP525FnS4mbF3KTh+
	PmxMnDHevE1JAWc96cj/+GP9BF6RrDbnrdQBlKGefGQhtxj0JDiiAI1UVayK/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777965914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s960FrAUsSOThuJjUj2aGZ3htIKJj0KKXIvAdIn5Z+M=;
	b=b/56EhU+/g7uh/HhNjsrgmWNKE4rpODP1VPU1rqJR357F1CWJtQFumAuyo5FhevMdGQMfi
	/PLuNSPyASlgQkDw==
Subject: [PATCH v2 0/4] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Tue, 05 May 2026 09:25:08 +0200
Message-Id: <20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFSb+WkC/3WNQQ6CMBBFr2Jm7Zi2USCuvIdhIe1UxpiWTEuDI
 dxdwLXLl7z//gyJhCnB9TCDUOHEMaxgjgew/SM8CdmtDEaZSp1VgzIwxjygEy4kWF+8Je2s97W
 DdTQIeZ724L39cRq7F9m8VTaj55SjfPbHojfvb7xoVEjKOO06qpRqbm8OY5YYeDo5gnZZli8q1
 C1YwgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777965913; l=1577;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=mfdpoyvJ/vQBbQI/bmDoedqkrugfTtNLIWwARcA+Uq8=;
 b=BbUqU7IQezBfwDtWvsQn4NvuhloqYHLcxiWuzDBfL1h2uCjqNsBMKjaFq4tlSu6pUo66pzwkf
 Gxayp+UdrY+A/LaMeAOz0DtL7TIBXTseXnbot/ClDhe7glqB2yez8co
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
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
      arm64: dts: broadcom: bcm2712: add bcm2712-firmware compatible

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   4 +-
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   2 +-
 drivers/firmware/raspberrypi.c                     |  59 +++++++++-
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/raspberrypi-otp.c                    | 119 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  14 +++
 7 files changed, 206 insertions(+), 3 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

