Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327863;
	b=BlLNY33bkWR2i4q3k4EdUAt/k70MIl8xzn0KHntHhULVOLo4qkk0BgHNSvfR2dHlXaP6
	 8X8LQq2HN2CdM13ZwdREIQ+hkheukLD9ZceAT8a9yR6Ik61AgxIPxba9Ik7Y1RymXGhnX
	 nZviLq3nQtT5HuTrSFALvYAAt8zWkYtOJMvHHDByBKlKqNptYLycwJW1RSTnejrnpF5hS
	 7ZkwGrg0DqL5f38ibIBrGmLHct8QbEG2c6eUkQiul6OuFTo3pOL87zo0eBN7bOaJeX6E+
	 Pxc/R5J2y01X+t1ne/zntuHsINiaY41Fh8n34yHCtTuiuHn9hDQ+7333UUvsqtbFZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327863;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=aSGcCssOvdQ+sHpd+6fvR9/6ByVha2bN2wwqVqLlonwo7K1cyHiW+ZrNTwg7BN3BpfZS
	 iIVFM+pFbKTGZniqWgCbcKMMf6uaBvyl7OR/b7QmSJUzGNn7bESHq8voykX0G/nfLP9he
	 SSKx/8T2I7oMqtuVZ/gvTnJ/8/Dx0Cqc2QC/A/qavFvcVQ/0nTBWDpYTuQQxqdQY9q2VK
	 ensgQKGMnbmxP0LY3u81L8rHKeFaazIJk6zInyT0io9ZeXgnqnS08P54X8SVAZUBLk6jz
	 /S1tt/elpbWKEYuP/Pnfn2w18OtnWcoGRzhHYfQH8qUCgBOF6K+JveDfNcoFcNEW/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2ADUSuV9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pdx5nWQi;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D060A3818;
	Tue, 10 Nov 2026 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243D060A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2ADUSuV9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pdx5nWQi
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=2ADUSuV9X4bNSOWDhK1G/Qbq/PDBcw0ZG1PX55+wRcJyjvy3nxNyIKTmIeRTwg481ImUji
	Rj7KrciWJrzAd1sH3UC2+QENVPcnEVmbAXsbdcau283cfo4b+ytEUvrn9ROpygZzvrwGus
	yvnkGx2eLlCudZA1hH288pFO65s4vZ9SwRl+x3gb+rrR/IUsuqr9+f/0mnZdsaVsT8Qnfd
	OTRz6GwkEQyDOfcC0MYCB6Tc0HNEyhCCvalF4cZ+7XdodifHDRKkFbo9yFU3WjOfrhJcOh
	S9cCIVP2LUjj88llKKAxKbhSy3Gzfcdwpcv3bGIjFFtb2epwp6vA/0yjPuQAnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e2DLc/EFtAmhQSbf1IYEBcV1UrLcWSeCvbdOXz2tM=;
	b=pdx5nWQiUCT6eIDuzVu6eKoXwDsOy9XFnuvisgC9zyrKUzmF1o62E8uJ6JPhS/nXYPXsbf
	IgQtv1RmuDvPtjBA==
Date: Tue, 10 Nov 2026 17:24:09 +0100
Subject: [PATCH v7 08/11] arm64: defconfig: Enable the raspberrypi otp
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
Message-Id: <20261110-rpi-otp-driver-v7-8-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=987;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=6YL5o+FkfRNe3jisn0G42FaZ58Ui5doUPUkjSlQYsNY=;
 b=7HLXLgHtQEriR+V9jkLKzAMI/ntWvjTTVujde45O8cCbz7rS50LsgVaW5GkshJMbPCdQT/MGi
 tJJglZTfbrrCqVqP6BHXg8Fk1qusKNZLVAGQnOQMffOhQBElJE0yJAK
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

