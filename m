Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381822;
	b=HPnwd7rT1CLdUYotFXuWuIbn98K4FhLRi7iRzZcNbPIFE6oXetdG8/vOvGdntHwMeoRc
	 ED4CJT2SypFRfYn08E/tzApyzMiocQ04irAz+OPmSxDbFgAOBVya+7m/cRnX+okn3bpKq
	 RYGEldH+h67NmMp1KFs86VIQC83ZKAd8CwS+2/kPJ2Bagxq/tPVqWqWLiOBxTPZVPpJEJ
	 MWaZ7aDdQX3YOpcimuA2BXHwun5Itqe1Kzz+qJwxFMhoX/+zP5Ti2vuQVgeewtLSHaANw
	 PHUIOC0rwbTfOwwHN5NXmQYShDVeR3uZpc64s8B0ojzDXyA3yMxjjTvXCXqqoO/pWEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381822;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=ErozPzz5VDVHxHLmQgUl1cWqGeMnodvAOtER9jkb+GZg48wgYSxRzoJw21nmnhc7h8rB
	 XUhnMIEedvHFYAiPvYCXT43Ji/6AEATMkR9wSdZ3fxgvivWEkcqbBxCj1nDjyUU1L48hR
	 9tV/fsV9ACM0KurM3GAXk1jKgjP27n+GTXuMVUuNDooyxLwzgLlLTCTVXRHNIO17hmG3f
	 x7QhD7F8yrwhdQyLhPEToLe2NOqxkWXg035wcs0Z8/VbLyptqNahkOusLl/nJGiqICW2Y
	 /MaKzliQrIVgK4Bj7zD/EkvWyoXTnUMDzAfzHO3VzWZXHgy+XGyflmupLCFoWZP93Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rHVl3AE8;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FwfnPu7I;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2295606A32A;
	Wed, 11 Nov 2026 07:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2295606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rHVl3AE8;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FwfnPu7I
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=rHVl3AE8fvYzJtgNH5asppQ9bhqRxaKOoFDt89djKLq7ctmD9iqqdBkKmb5HbkzN5jg+7y
	xKP7riZ3AIWe4qvxsMMap2UyeUeTRUQEnS7TnEGtWl180jCMhct/2GgGIP7HBIXQdbqXXE
	YsQjTftJdSeeJUw06WTTWNuoaOFq+qYzgXo94tmgw8nfrzoQTnjs863sdnVjxj3DolVd4Z
	Fpd8j6yU09AHbiERj4uo1tI/imM4AEyBDjfYXmEvD6eHqvpt8Fqf+Nyd/gXhWuFVWrKK5z
	eUuHbSgK6rTCpFfLVjW2jpA+918nZrVScUP8WHmnSBtZU/dWCX3ddin68dCAHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=FwfnPu7IAJD5Z6i3bOozlDxd4sAGI6+p4KDQII6Q0ICyI3/z7ubIOBgWi//Q4C96V326+u
	hNVPlHt7uoWqRQCg==
Date: Wed, 11 Nov 2026 08:23:24 +0100
Subject: [PATCH v9 02/12] soc: bcm2835: Use IS_REACHABLE for function
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
Message-Id: <20261111-rpi-otp-driver-v9-2-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1460;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=uxXK8avB9nb6Zmd3jDyY1bgqVIcNgF3TcaoqB76MexM=;
 b=SNIHTtUQfvb/LwBqVdeBP+OqzJpEKJeEwlot0SEfaN3KTJB012zKflluhnlsxnRHA3TuYcp4O
 QcMhILPNSE/CUYkuJ0laKWxFCC1urhJ5ok1uJLwv1NhT9aGQ37MSoSm
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

