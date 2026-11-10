Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328456;
	b=2MpxTkvSDI2K1/4Y3KMG86n5CxbxInMqvFbSNlMi34D0toYvbKBCZNhbGawoRZII+ZIg
	 gHu2ZBs60FmtwlJtnaWfwQAU5yUvanuAIc7n5NaWUWlpjBlzjyUCVv1MconJIAkrA1751
	 KMgbq+wPRIYamUMDFM4Y8KswEi5tOZGyIngjMJ3FkiL2QQO/EwMHw2IqLNRqY6YJQK5IN
	 qaTBc+995/iWwA9L8Rcin0ugirEv2Ngs4z7B/Bdft9ZEyBYXIrCoBA0tXwmWCKpdYWX77
	 vMTjCrxezTcr1I3qInQq2cHYwLp5gBZapKieI7bl5I8rZtTJYnLeOjz3av0g4kYj7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328456;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=sIRmTf4Ry7hEfJzTnWsNm+0IATxUhKHa9wwUN5RbIDERh7HEEMzSo5Niq0/EovTIWXkH
	 qRCYNqKSiE+J+Jy/AorO8K9OmPVx9dNjR9NYCClTEyH8NVrVYNhDlOFkA2DjqiBCoWEGI
	 pSCGlsVlHXoc6hWIzgTDCZ4jt/kyyY/JSRveL7dpIUGB7hc+WlYs9H3caKRcIPOkmxh+t
	 SN0hvuiSrL43tu9pXT2G3Q2U7WPKk0LCCmOTgGY17Ma+DIkiugWQhK5sFuMfwuQeEYmcB
	 t0Zhe3M0gHxop3XU/Qf1wBzTpvXyP0GF4Uy+wzZlrMv04GsxLgos1PJKQcboUiGscJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="dPQZ/jOl";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="P/l20lKr";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DB60A3837;
	Tue, 10 Nov 2026 16:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212DB60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dPQZ/jOl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=P/l20lKr
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=dPQZ/jOlDJW3uiWmm/UVeaX0pGXpTCsuP76T/M/TBDJDnNXpMTSonLbluNeHTNVaATUKtM
	r6ShX7IrVZzTB1T971aAmWYVaeMS1LLNMHMZ4ahTV8mFtmol+3NNj1oXuNpJJlSqI1adsH
	wswK4AXz79kv64KBv8Te5DBzTk3CMmkJVyZCx04cuoZ7T1SJjHB5yfv386EQ3tB/shmU3c
	VDaz6BKgi+/WmZASLlP+6q43Y2XtqYZ/7izH89RTmfZeTHWajLhG0UuDNakPcZqiOJHjN/
	B+Sn2rLvZSLJB7bUICSXKlwsqOcTMeWaYy4m5FRAeiqsp2lm0P8KYJACe1Is/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=P/l20lKrtQLnvxFFN1y20agVA9zPwrpdFzVeWmoa3JQMFsITSKmv+tQ0ncxaGv9HcOqRqu
	rb42cc2KenjkvfAg==
Date: Tue, 10 Nov 2026 17:34:08 +0100
Subject: [PATCH v8 09/12] arm64: defconfig: Enable the raspberrypi otp
 driver as module
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
Message-Id: <20261110-rpi-otp-driver-v8-9-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=987;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=6YL5o+FkfRNe3jisn0G42FaZ58Ui5doUPUkjSlQYsNY=;
 b=u9JLUg2o0uL0aebjjbMEF3vtqfLcdiYqHl2mlCpO1lxK3oEbV5tseq8NZ/poVFJVmXgqW76Lu
 dzycJzw29RnAf9NL+iadVJIJt65b3HnQJ49U9UH82p3qYrOyieARHva
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Enable the newly added Raspberry Pi OTP driver as module to allow access
to the otp registers. This driver provides access to the OTP registers
present on all Raspberry Pi boards and the private OTP registers present
on the Raspberry Pi 5.

Enabling this in the generic arm64 defconfig allows standard upstream
kernels to use these registers on Raspberry Pi 3, 4 and 5 out of the
box.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21c..023def2297331 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1740,6 +1740,7 @@ CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
 CONFIG_NVMEM_ZYNQMP=m
+CONFIG_NVMEM_RASPBERRYPI_OTP=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m

-- 
2.47.3

