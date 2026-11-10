Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328456;
	b=X482k036Pa1JeLq4RmpbWgv8Xg60sPSKyupNQGVEykkoTMCjxEnSCL0x/Y2T43nESgXz
	 xLc7jzqJ4/QcyKGSVkbCM/V1OObLN2v0NFNJtxr5RagICjzfKGkqNJn1bgi8hPWrW6BSI
	 +8YvvlVAxDNegcE+u9gTt4gXAQUKMoO3SkUMXnZ0Ka6965C7vl/dwB4jgpYPIKJYD7zE0
	 WuQGOer6I5KV4NaDyo4kErd+mGK/X76ldHAaB+pzzqPzk4CYsKuMQYwfvoBchknl9MTKR
	 uDntYbrkYu3+q1ghYeTchRAIN+Rg1wOyOXc47Kr5EoUl9L6l1Wf3ZkCfegUJJyy7V5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328456;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=eYe+ke8mr3Bve0JKI6NYuQiz0y/lVe8celdfk6YVKkepM7kdaQH5jyg1mxtGUJTDC0SQ
	 T7D9hHUF/3qh0b0EbY1g07qHIxPSfiKz+nXkMktntJGzQdhqHrX4XE0sqSzLC4X3jXQ8u
	 DJrVW6xr3KW9oqo5CfXlzbJQND/ZRSiHa/udiBHGvM73gMPtXfdE3UYlmiV7nsCCcS5wh
	 Jv+4vnEcXuAsGNug6SiPFXdlXRUnK4rDOtlzqVRPWjFY6JsTyjj72oJBJkhPooNF1pfMC
	 16Twwf/5v0B1jxLpZbw6eRD0sMOZ2biGNTq2ioW5vrgUHgS8UUC9juRBS3UgBWn8Giw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CNIUKLxz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Viq0FdxQ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533460A5BC2;
	Tue, 10 Nov 2026 16:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5533460A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CNIUKLxz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Viq0FdxQ
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=CNIUKLxzwOJzVXxqcjjkExLO/DbDTxbOcL+36y48TxavD7YXoo5m7VXPEjia8aro/EhuzF
	xrP+9MoCvUV5i9ylm6Q5tSNk67AEpXQjOdUX/zh0OJKJR4INABtg88dYwPurJ5zbkrv4JF
	QEY3ASJ3mVvcQSOwIvKqJhyEj9MzVCVOgMfcJpGyDzmnVJHjd3mCB3i+3TIYwWFeGsu6wG
	hbvCpu4pY/s58/2AcA5T76YsE4pb+NDiwvNKi4RS78yPo42n6nx7lKYd1fieBvK/1Ji6jt
	21pTtDUgxCjT4Inm/4+l+p/X4LP31Tn6UiONlrN5HRjMDsonyuOXtJxNjY/FjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=Viq0FdxQ+2iyJ+AKnezN3ltbEJ3awgDIJT2UCh7Hffjbfud+SKLRsGp8C/6YoHalX/JYs+
	O/j82rf089IqZLDA==
Date: Tue, 10 Nov 2026 17:34:09 +0100
Subject: [PATCH v8 10/12] ARM: bcm2835_defconfig: Enable the raspberrypi
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
Message-Id: <20261110-rpi-otp-driver-v8-10-797e0577d414@linutronix.de>
References: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=912;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=bOKNOICxqCYZrMWjJOkFJLVvOcoLV2kUC4VhPSN+7gY=;
 b=OfzIddYMXrDesd6O+P90W20wdclo/TP3jNtMsETK7Wlfpnbn0v3zo2DV13N2ijqvcU+v/DR36
 vCFlZ8ASw29DO2TkHyS3SlmG3/lSViddxeQb2zIaTvZbDaC3SmU4IjL
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

