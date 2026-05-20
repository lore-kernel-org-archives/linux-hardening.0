Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED12F363F;
	Wed, 20 May 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287284; cv=none; b=jYGwhXoqsepjFE63Zko1QDrN9wQty0D2GXWIlgXvEN1uwx4XJon2S/CCX9NPfo7u5xgmbjyzj38rfz0MXL1i3jBamOuEudc9g8qeZNFaB4fWuRiet7+lvt2EF2PABr3tcdSUH7/uPH0XfldI7ZE63iWwY5nqB3/FL6vvzCRf9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287284; c=relaxed/simple;
	bh=au4xWUMxkrQnvU1u6IDdk6ABFJbLPtkw+ui4+y5bLec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaEY2yq652LRu/SJ1veMfBXLNQqlwIuvJvoC2+gRyduFAxnoTebx+SJ1WmMYxJE4xDbUOwuBhHImJHMPyUfgfevyojRSxict90U01hQYn4tFyvGghwujURUcMa1stHFiWKCfNVW/14ETnYwqxKLkCIGjgmFEsyNKAw8jb0wEdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcuEc5os; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wb3nK3Y+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcuEc5os";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wb3nK3Y+"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cM6T3JboLweSs+J5rPXUUdgy1Wperx1vRoU9nQtE5kk=;
	b=NcuEc5osdAfjz8c5aFfFsY8umChOIjYnsUKSsAGUBvK67JTppF4Sb44DUBJBbX/x8QOdC4
	GP1vWVMIEAiaAMV7uzyTxCkb4Ww6ylkZO2o5ByPMGqP2up7wAmpmzoZoMrniJN1D7QUGEx
	ymA7tWjujqVldSFOy6FoEJxetATzJLiyOvmkJ2dmV6Kk5PoawMLQAek+aDRwjpS+y8cve2
	E2EV9y/+BdeY801AcLzsaoCj5QwPSr/x3AUjoEBCEx2rr8BqlFVFw2uZP8qI9n41Ta1+eV
	pB0iLJNrgIUMzeueyPBOzH1PcVKItb3A646IlBNW/8RUe4WbwXot/VQmNA6eFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cM6T3JboLweSs+J5rPXUUdgy1Wperx1vRoU9nQtE5kk=;
	b=Wb3nK3Y+Kv27l/Xl2g/kmfvzfCEv7Ct5zl4MQ9nVHYftOQ2eBWxx8iWkdeRVR/QPSsj4LM
	ZqXoKEXec7MViCBg==
Date: Wed, 20 May 2026 16:27:53 +0200
Subject: [PATCH v5 1/8] soc: bcm2835: Use IS_REACHABLE for function
 declaration
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-1-b26e5908eeac@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
In-Reply-To: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=1327;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=au4xWUMxkrQnvU1u6IDdk6ABFJbLPtkw+ui4+y5bLec=;
 b=fcW6MCbGz5a3dOo1SLrPb00wjdsHCrmhO22EfAVfrMuIRE2/jZfyBmFX9zpHH7HH1iDSVSLM0
 ynv2Mv3YtUNAraVhvyXd8GNweutT/mpp6VVswobWeJT2/w2eu495IqI
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

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index e1f87fbfe5542..eb33838e0cd10 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -174,7 +174,7 @@ struct rpi_firmware_clk_rate_request {
 		.id = cpu_to_le32(_id),		\
 	}
 
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+#if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,

-- 
2.47.3

