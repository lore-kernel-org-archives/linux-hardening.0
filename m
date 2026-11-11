Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381823;
	b=DYF883Ulhq49ZUStSTkanvoi/c3lOWGdUUZim+NJDrUvBz4ID8CVt9RCMtgwM/tGkSKQ
	 NuuPjlvuUBaeFd8VIrr2UYKiAzTEg7tJeDR2WVyMmMfFwY6CYSjgwyni7aRoa51luhDAx
	 2YSfD6Pmaqb6bN/BkfeNtvKd0B69fTIpV+SerjLauQkMjOofFCZwvY4ft1bD+yjTDSlMg
	 LNNZPl9FpKSNJ0cYcDv4L35mNdm5T1wPyyLfI3R/Cuq2Ru6qcjD+IZP/ncM+sZcLMXYNK
	 93xVtAYD+b1BJPq3eHgedvIniBdlNxTq0Sjt+FQk1soyUVeA9DBmSe/e4Y1245NfPfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381823;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=0EXIMisuCBr2NzdvXg/1lUK2muWDLkfMdcrxuGLJiYrtocAmocHSlmlZOomcQbc0vr7u
	 4I678MWJcva5gh83Z6AzxAXHH30sfET5UXYwqq7iF2gvCBmnAniUOogYR4fda8YcutN3M
	 vzQUeqx1JoKs6cLB9O5bFAtHYZ6Now8lFVq+4gNy8TQxnkStB+tc/0bcJEc57Lwas+y9c
	 7tIc50Tj85Kvab3HFXR8DiRJnNPY9nybjvVEPBFFggXeSdckG1IBRAPN6ZF0oBxOaJRpa
	 lLm3/PcfDt5N/4NDKX/+PKd9DNOhzIOesUVYGcbu3O7EVHRdCkXh4Ei5imcr9vOwzXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Lzjuxlb5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JxEmz1Y8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7B60A2635;
	Wed, 11 Nov 2026 07:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D7B60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Lzjuxlb5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JxEmz1Y8
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=Lzjuxlb579LNYmFyV6OOiDgdDFuLYlcUkZtQzqaiF9YpwRLSf+gqzFUmfD6YxNzdnYAeuv
	/u4mhV3yosc1iYPzegqeF7OGC9uZgoOv+SVE9ClIPNuzY85/6vEpD3XGaKMA1gjDwdc5zT
	Ry1F0Dvx91EiJHZjitBp6gdcuUAsTYV917RarKMNbEdtI+LM2ohnKhXBjLYwB6IAzEYfJX
	Bc1+8n22H0e7W3tYtGSwOBoikKHrYbjNn68tSZIZ2ErHtSZepIRQ4oa6b4k/WoDKfPVuz+
	hZhxEieW87EfU2/4AII5XjyGNqo7wdu2ASdc60SrBHM5oy/RZH3H/18RiK1AgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1+ETXdhcqBpyFYbvVGAz7S2di16t6DiUwgkIA1sLsc=;
	b=JxEmz1Y8bJBPD6QVAeotaWObnSEPLtphbEahonquN4vmPLIxKttGxazHWbC2z1JVbzF+cj
	awhg1zWgXZ36RKCQ==
Date: Wed, 11 Nov 2026 08:23:32 +0100
Subject: [PATCH v9 10/12] ARM: bcm2835_defconfig: Enable the raspberrypi
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
Message-Id: <20261111-rpi-otp-driver-v9-10-0a7292a7a5b4@linutronix.de>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
In-Reply-To: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=912;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=bOKNOICxqCYZrMWjJOkFJLVvOcoLV2kUC4VhPSN+7gY=;
 b=GacTRK73e/c9T9JmHHoL+BalmLS6g0MWGIy0btLoMGCx/v6FBPhjZHiueYRgYAdqxoIQx71PW
 C++96QBFdW2COewDgMJnHumLQtrft7ocSj7mm7T9aq2JfejL5wVAJa/
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

