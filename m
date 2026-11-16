Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823857;
	b=FBpvMQxsw4kSQod9dzB0DxpL8iYzfmo+ctmdeqWz04GkKYKws3vOAmo0oR1Ic8vsEF2K
	 VvExxyIKV0kmYn6kqe/dtErEiiWyEJkdNyL1BxlJzqCQWecm5e0uDyJF0/cHdyFkrKACT
	 KbD+h4szi3QwBXo/e1aX1l3iXd8SQLW/30rKQDGW0dr8JaOiR6gM/mJfeH4o7pCOz/+ak
	 RWh97g7DQUWDKILQmaemVA03PhStMUeontkpUCPVl2+mAYwdBcLw0K10GqRnNQ2TaqjsY
	 es6F6O6pXsDOVlNo0ZCHpwtsUQgJrPpUef4TL3kZVbsNI4vGoCRG3C7EY2C7+CvuOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823857;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=Aaxgap1tfFNS4+4dsFj5VkSMD/VgyvU+khDRLMC7Z0aCh93XQJt3BQmkTyWHqKhdy+Hc
	 l4FTaKAmAcHmpYZrd40A7Ml9E6vWznENOQ8Xah5APYSm7NPD9UWm1XW4WsrkVt1Z+5Kes
	 RVWyIMWzhWZupBzSoWRyYKjG0br4EytwlUp8OUbUSKcfFHJx53emIgULCPIONJ3bkvqAG
	 7NgSg5Jwr7AsPaKlA+r/3xC992asgbi89sv1tOYbe59kG23i1FW+gNAumtcRjJ67lQeWy
	 Nq+hqzSPuo5QEJ7Q7QxwXaK9F1wI+t5NqnCsd05o1fKnh0VxCcVaGoGBjxWXRgMkQYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TM26JCQF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mCsdp8PU;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708C60A2621;
	Mon, 16 Nov 2026 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8708C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TM26JCQF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mCsdp8PU
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=TM26JCQFoAnht5BFwb3zhIhj4jsbnO2OSo0YeZDJ+x3j/dKe2U3PhkJ0GXoVU89Yd0XPC5
	EWbBzF1DMrz5HrXNHLlMqSEnLfq4K/QE90G/9q5fLiSu+4RAZ5PUU2HTfKcozO1hSjsKGH
	xcMEYrgdgAX/v9cFaoxwP30LTO2Q76fZzJm2wX954M9LN++SA85iIsBLrMjO8GvtCJDGh1
	sizCRDQWEit1isrX9zTg0SHoGYxwTir9aUtNrAQtYzGc7UVojoA/iuqYnnVmcyOFQqc1ix
	2c5seHoYVfB0YVd5W2sz3BNbRD6L817mXpY8G4T026aHE8lz+tD/COLrrIKvww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=mCsdp8PUvqF/Yim9bXJ+gwkyRtboEus4fDXD4PR0UIjaTywVS7KlsdZr5oip12U/e2HGi/
	sZyDB95oiyTWPzCw==
Date: Mon, 16 Nov 2026 11:10:33 +0100
Subject: [PATCH v10 09/12] arm64: defconfig: Enable the raspberrypi otp
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
Message-Id: <20261116-rpi-otp-driver-v10-9-15302dcfd5e1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=987;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=6YL5o+FkfRNe3jisn0G42FaZ58Ui5doUPUkjSlQYsNY=;
 b=lRvb8b55MOrlxfIN4UPMYCa64R/X3dF0pzqQOWqPd4W3rwzhXw0ec/EPPPRJ4vxKikvjlIbM5
 W0ZXWhIawwmBxdPH3KFDXv9pSPf2fGP+lQqlXFGspb1FXa1/95jPpzY
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

