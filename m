Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429D3358D6;
	Fri,  8 May 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251373; cv=none; b=C+GSFP9Q5fhdYGZtNc8/Yw+8INN2MUF1LwfN0LCvbq9nUy3anfRqxoGAWpSnl5CK/oA8WxQL7WWtirnERkDjTRmFXqNs/e4bteh/pUFrACZ0Mky0/7e5/lCUH6OLJcmpMTWXRQ5v/2+gbx4yUh39i5X35S+NNmwdU0bX0d6otTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251373; c=relaxed/simple;
	bh=V9GmBUFQTVOB5tCmIq5vsLmb0d8tlLj/Y32VdUZQHww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UhHw2gcHtc+ONS94AfYSjgPGRNMKuGENiaO4LU65uNtPsMV/1cy2Uadg3PxYXYR/JYenxWC94lthyxVn5it1xs8IMWEYXfgmSZWFGoO+lsggLiQlkCN3J4l6RyvypMdasNQ39nNXCmJPSVzPckvL/8tqu3DRNMx+1k0oq/8dIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0L42296R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q2uF9fUW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0L42296R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q2uF9fUW"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778251370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yr5IQx3x6yRZTZSyiChHgjVJVsdEd7WvN2BZWd6TkrU=;
	b=0L42296RbVkTvQKecSFLZpQs186mKIK1vXv6VXuR2Fnu8m6og/XP1LGM4yiMB2Exn6GZ8J
	VIfXnU7btls5Z1j7k3Tesx9InGAr/Q5IvyeD1wzAAsJgi2FGj3n7FxnlQM3mWhOZg1Tjjq
	prGwG+aUpKQc98wLW9NzYQheX8OUQ3nBVgN5Ma5h1UX1MPw1OtU8i8MvZpcg8uYurAoH7P
	/Ra2u2mjmK9KkODi3/b80zf4bn2VRarT4gybR6m0hVUO4DCC2RM50+vfUGerRfR5f7yXj/
	qgP+hbdwVcAkMWp407uOFUPuLLntOmdPRqPezlgSFccG9/FAp4F/AbJ0yBrsGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778251370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yr5IQx3x6yRZTZSyiChHgjVJVsdEd7WvN2BZWd6TkrU=;
	b=q2uF9fUWzDoPpa0e7xFC9PS6+uPn0YG/R4BervVeUp9l3/OrsVozQSFtC8AWSyz5vhcIyM
	mK3/RcyT41RgymAg==
Subject: [PATCH v4 0/5] nvmem: Add Raspberry Pi OTP nvmem driver
Date: Fri, 08 May 2026 16:42:43 +0200
Message-Id: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGP2/WkC/3XNQQ6CMBAF0KuQrq1pC7TgynsYF9IOMsYAaaHBE
 O5uiwuN6PJn/rw/EwcWwZFDMhMLHh12bQjZLiG6ubRXoGhCJoIJyTJWUNsj7YaeGoseLFV5rYE
 bXdfKkPDUW6hxWsHT+ZXdWN1AD1GJjQbd0NnHuuh57P3FPaeMAhOGmwokY8Xxju042K7FaW+Ax
 AEv3kTO8g0hIlFyJUErUaTqF5F+EnJDpIEQZSbDXaayzL+JZVmeN4pg5kgBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778251369; l=2204;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=V9GmBUFQTVOB5tCmIq5vsLmb0d8tlLj/Y32VdUZQHww=;
 b=7BLy7+i2zbR3woZBSr6rGnjflELuHjREYz6StrpbUTdMiFERWJrXxHZl0p3mVjg6SQ+RjCe/c
 De1gEoQO8pgDUbjfPQcfpWCxMln5Ap5+vGnF8NcW8ylZuuoY1KEiR9i
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Hi,

This series adds support for the Raspberry Pis OTP registers. The
Raspberry Pi has one or more OTP regions. These registers are accessible
through the firmware. Add a driver for it and add updates the devicetree
for the Raspberry Pi 5.

---
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
Gregor Herburger (5):
      dt-bindings: raspberrypi,bcm2835-firmware: Add bcm2712-firmware compatible
      nvmem: Add the Raspberry Pi OTP driver
      firmware: raspberrypi: register nvmem driver
      arm64: dts: broadcom: bcm2712: add raspberrypi,bcm2712-firmware compatible
      dt-bindings: raspberrypi,bcm2835-firmware: Drop unnecessary select

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++--
 .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
 drivers/firmware/raspberrypi.c                     |  59 +++++++++-
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/raspberrypi-otp.c                    | 130 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  14 +++
 7 files changed, 224 insertions(+), 14 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-rpi-otp-driver-75fce1dcff7d

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

