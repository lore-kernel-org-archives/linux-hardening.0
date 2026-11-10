Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327864;
	b=49digex0HBByDxh94YY+iDSOT6OzjPi4+Jb/IqoEMwIzp4Mrfp126WEx67LHdpfvqE7n
	 EWLBrDbk2WQtuZZVLJmh3EBlZIG7i67Th3NJd8hAUhPfmTOE85Vbe05V7ApGXDvf+sVBq
	 X5VTxSg6AL67yp0kdt+uhDqu8aJhor9+OhdrBEoSXpD9g8Gwda5WAVtpWc/VGkE8e2f+q
	 U547Gs4HWAhKJqH+FF3nSh4+q/b6M9yDGCRXj8BNHRhOQ9owyaWkIFUz8ipDl3kc6R16U
	 ldsICshoCQwzsLD9FqhrIIjGXy7iB1wAGfRXzUPAbhRVeo21ni3uV2M1xDSAcSFTzbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327864;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=043MRMNNdZd+/rDXS4KMBzqjVXT6Drc3D6s0aVnvyKp6x2ax6xIhw6JkfqFpLQL/ow15
	 k1mufaSmNhInA6Pe5DYsUWBuhErvtch9sK9WMNxZdWNvJ0d8OhcpcyvVXEP8Gtjhzmtoq
	 /QTBB6IS+hafKnGNP0/YAXezZ7vcAAPl8gxxGZ7KBvHujGvYA+J4auXlf0k4ib8FRc4aN
	 Nt730zcoBut1KiILrE49syNtNlCa+wNwhtbWE8ADplvcKvLcFajxorr+N0s8U9bxdrf6t
	 QfKiH38qs7JrKgIQHrNZ8aQD3YidiT/kvd8K7dLCMgWn9wgKHevURvUFpFmTX/+W2Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=n8tkX2iy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e3E+zm1g;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A960A3827;
	Tue, 10 Nov 2026 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 962A960A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=n8tkX2iy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e3E+zm1g
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=n8tkX2iyYSyeM3L/MEv8MXyX1nQ9SZj5X2NObcRCdkyJmd5z3BDXMcgifaCITmZiOmQHbp
	wVoArt7GQo/fXIBlO9jbFb9xwLQmOqODCNEWa/g0QNCT8ZtjdHjNAldaJEZv6IgqnbitH6
	lqHhwMRmGA0kR+Yzq6FO8X8wFc0u4wkf+CnORq3f05I+uwOrllHqjN/SHJK9r1nXNLtB55
	YgEg8FpZzEibAfg88TrwJlNyTlc4Vde52Ljkb9AImLPGM21tRNvb6lqZv/pJlqVvuQBNzH
	h/0KjoNaol5vZ8UC5bxm3ECs0HVEI1K5w9OCoBsIPnOYVgzDLBcMhfDtNy2oxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=e3E+zm1g9UwbIscvvFag7v0UvpTQWoVlyWV018dFcNycG/rXu8soJhiChKk96srMVxgoCt
	VIaj80xiL+nvQbBw==
Date: Tue, 10 Nov 2026 17:24:10 +0100
Subject: [PATCH v7 09/11] ARM: bcm2835_defconfig: Enable the raspberrypi
 otp driver as module
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
Message-Id: <20261110-rpi-otp-driver-v7-9-2345d0ee65f0@linutronix.de>
References: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=912;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=bOKNOICxqCYZrMWjJOkFJLVvOcoLV2kUC4VhPSN+7gY=;
 b=lbJJNSAE86j5ftCfcY3QmYysFU+YUjigm/P3RIDOgQg8rHqoZt0j4eX881fuU7KZK0qLGGLTm
 otH8Iu3IptxCiOetRwZNJWQJvs6EQjopLuzHpV/NzFxw0fxXIX+qAB/
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
index b469ecc36cf58..8a1c492db870c 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -150,6 +150,8 @@ CONFIG_BCM2835_MBOX=y
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

