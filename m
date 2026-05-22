Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE656477E4D;
	Fri, 22 May 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464421; cv=none; b=QlAFNJTeBeU4Q5ryJlcNEGZg1hMqEPTnuAlMX+DJr808huK2tMG7ptnDJtGHffUnys3M+GxbG2DSxxSavZwh28Pn2PuCsazsWEAvONcYTVc6B0iRvtV7MV/+pDX3FAY05vU/kXPs6Qyq28/sSnS1FAMOTLvaODxs7AjH8ZCshz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464421; c=relaxed/simple;
	bh=4RYdMjibQW2/XaXdOtKYjooXgvg+7dGzfuDMj2Lhh80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2HvY33/cae11Tv78EftTD5EGqOllc2QtCNbS4XQr0nufBbv9uRoQ3+4apmRglY5WTO0AOP/bYJs6jrCMO++b8qZ3xHpS0AjcRfrIpmNhK/5b6eV4CdKNUDrmrOnmQEHAUElLAq+WT4SJNfqJZrC3kjUeScOZeUaFdtxXSO5GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRLoE10a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nT1NQABk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRLoE10a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nT1NQABk"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH1oKT414TlTCl2C+lV3L01K8kAHjponcj2ya0Cw6KI=;
	b=gRLoE10a/qZ+GP9kFYrL34oKHTONLFQwj39tJCo1QAfSuRNeBez3mK71mZ5ZC167gI0m2u
	VroDI4oOj5T+fw+ibHPZvx3AlVAFIaVr4pLj4Kh3hifampWUNxVnanfs8TShjlR9P4ulYj
	KnPrkBuczJ3nJFabqfqG8XpFy/jECe048x4HsyiiTttUQvRaw0zmrMH2+8t0U4bWwbbRWr
	cY8CJukg4Uck4EQrLO+V686PDVFPCq3m8i17IqkMSUGwZljgmc/Yrp3pqiYwMpWys1zlZk
	4uOnmsLbD0+RriwOBjBe9JdeY3HplSWr9y0uwWfsowrs9miam9TiKvjCo1jSTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH1oKT414TlTCl2C+lV3L01K8kAHjponcj2ya0Cw6KI=;
	b=nT1NQABk5MQRRkgcK10OumdbeOof4+Mha7NSWjVsLxpaSIpuXBOLOB0qxUQ2+GJbPFKV9Z
	K8uz6x9mDxXYhEAA==
Date: Fri, 22 May 2026 17:40:09 +0200
Subject: [PATCH v6 09/10] ARM: bcm2835_defconfig: Enable the raspberrypi
 otp driver as module
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-9-b0eac97d1428@linutronix.de>
References: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
In-Reply-To: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
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
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=912;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=4RYdMjibQW2/XaXdOtKYjooXgvg+7dGzfuDMj2Lhh80=;
 b=jxaFs44VX0BQ/NAzWDc37HASvUIs4J6XgZUmMwhXXrHLj40KDW2yxlbl4C966rFBXFC8PiXQU
 6DAgR2Y3nadBNnDlBhHJ78385iBetnicGlGrQyIectCaZ4xoZJIzSLe
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Enable the newly added Raspberry Pi OTP driver as module to allow access
to the otp registers. This driver provides access to the OTP registers
present on all Raspberry Pi boards.

Enabling this in the bcm2835 defconfig allows standard upstream kernels
to use these registers out of the box.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm/configs/bcm2835_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 4a8ac09843d73..fd83bda9cfaaf 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -151,6 +151,8 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_RASPBERRYPI_OTP=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y

-- 
2.47.3

