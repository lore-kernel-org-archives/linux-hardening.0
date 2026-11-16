Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823853;
	b=YigO71ttdlh/FdqZbffXt9RojryR7408macLr6QJroKAIirpfe1FSfgnpKVmrbOcVSx5
	 /Bhfq+SJ537fRNQWJjD+DvUS2rU8HVxxAkjRo/y+THRqHdCubOYqVHIckuj/AK8GEMwDC
	 raDh5L+rUH/jzS/is6w0faV0fdG94DVEEL9Gexbl3jeEafzjhYHRc+kyH41BPqDDo7lPL
	 yzvquJDsOCkBfUk0hbw33kSqHFeISkQzwCA3xfsxi2K7YOLJ8t1Vul70YCoP7sYx0Fq8d
	 yvqB3ZjDN66QQHJ59rogJZjFJu0LcUpLc/dm6njST68rotoIszyWOJgT9eXOPo6Bi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823853;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=zeULddAPCvnf1ewVclz0Ne7ow1ULacMpbK28q/uVGlRBsKn0+xX1iutl9cvNRSfSn9DI
	 gVYoXhfihwn7b9PNxi0VVzyiu3qu7DnLZZdpxB+LkbXy94B1KfCVZ0G9EKJM4c6KuDi42
	 RGGe7PfTyjRDmRbSFay10mtFNSe4peihLdey3D+sAY3b1MQR7ALZX8Znr4MKa4Xy3Xn0s
	 13HPbQ68uH1dMOKiKO48Y7l5lZ33JgGrLASVkyM7Tz9MRMx8nZAxO79ceiYPUrmPxs606
	 NaCto/GGhAbpEYjKqGy8Blp2gT9gp6LPX4eVQyo9WmZ7l05AifF6TdOQI6QTzNGaCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tW0mwRBZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U1jl2t6R;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32C606A334;
	Mon, 16 Nov 2026 10:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C32C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tW0mwRBZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U1jl2t6R
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=tW0mwRBZEdVsZnn/t2HzpLJ7R47yBnMfbvCpv9e61TmkHCw4jvnaE83UPCqVHnplWLr9if
	f8yZNBq+W5FBJBkV1Eq9hMT5Fka18X0X2fryDqX8zK03sZvH36B2cZujySByj1Jj2lzJZ5
	ZTLtwCUQFYMTFhSpgcBaZlr0RFOVIi1dkIARFdEgNnKzHJ6oytHh7NO/0BV9sPR8gLn/7z
	4o4k59FGspA9HZx79aq/BAIB8Vgl56Hn9ZI6fyFkYsUoW3Y86z5oE6VgPtflXvOXgqmRDt
	mXgT0fJrobb+vEYZNqHnbPDJpKpbdi93/BDUqoXYvysPq0lrmDWJFEgFIh2miw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=U1jl2t6RyRlxBnoqeoLgapMZBAvIoOakjZVnRUvqAwL3y1dVWG8kw57KR1em9M1mjCJvDO
	yheA01RR3dtK3tCQ==
Date: Mon, 16 Nov 2026 11:10:26 +0100
Subject: [PATCH v10 02/12] soc: bcm2835: Use IS_REACHABLE for function
 declaration
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-rpi-otp-driver-v10-2-15302dcfd5e1@linutronix.de>
References: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
In-Reply-To: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
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
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1460;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=uxXK8avB9nb6Zmd3jDyY1bgqVIcNgF3TcaoqB76MexM=;
 b=YeFtWIfvUimynPm3WpeQxKJC6iXX2TWfS1Oo+5M3p+R0Y/VYNuiFtvTtvUUHK9gmV7ue5mTuC
 UqL5SX72ikmBEpR7tLxBx6xoCNXuyP2BvYnlLUGnFMrg/DHkUz1xYXS
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The drivers that depend on the RASPBERRYPI_FIRMWARE use

	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)

This should ensure that the driver is not compiled in when
RASPBERRYPI_FIRMWARE is 'm' on COMPILE_TEST which leads to linker
errors.

The same can be achieved by using IS_REACHABLE in the
raspberrypi-firmware header. This evaluates to false when invoked from
built-in code. This way the Kconfig can be written as

	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST

Which is a more readable variant.

Suggested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 5a0cbb18d0b6c..33ac26f2f135a 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -201,7 +201,7 @@ struct rpi_firmware_clk_rate_request {
 		.id = cpu_to_le32(_id),		\
 	}
 
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+#if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,

-- 
2.47.3

