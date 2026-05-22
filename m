Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B146AEC2;
	Fri, 22 May 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464420; cv=none; b=ekqsnVyU2LTUFju0IdtslhcDnQxoBvkLfTdCyk7fhJZ1w0KKT8bQx9Zk4Gfw3PmEZqe9f3CE0aP3Eex3GEvSM9X1vSuo0gne/wOJkANQJTM8bMGOTa5CroKSxbLlnNgdNJYN2njpbcWuDw/9XWkPtUIIOb1qM/XYZ9CYL1AIYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464420; c=relaxed/simple;
	bh=W3od+N7ms8LBhCXN/JpOtSic+LkKIcRVMQF9+TfNOg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZHVbvE6l7GaEZFd5oHWDm21HYc2pthhz6WFK5m0mxCZBjwHyf8vXRj0axr4Mg/pgBidOfpVdP0ziICDukYkyYxOoK5n7IjBSxZEjwBl315zZHJ15wlp5sp9KrqevMXrYH31LTY0Q+1fsyWWKSHMpNiwuDDaYGr37NdvSHTZFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PeW7RWXt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FP20AERF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PeW7RWXt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FP20AERF"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqxlm0R5Wd0RrDJc5qf7hWcJWc/FoDh8Mkn++k5Hxho=;
	b=PeW7RWXtB8dNpBjtqAuzknD6YIeNWIlj560/kokuYKeP2iZfGvG0ZyjC+K6m9aHmLAWtjY
	HGrSqN5ATspKKfezk3Z798vb/AnFsFS/cNAQKLEha4UMnu+vSHLo6HWdMWisu5K75sL3IZ
	vcHiTHA9A51VaN4c8WOzn+li1R+wLLp0MVA679JAiCuvBrOIXGdrBISOdx8lle7Fy0WGP9
	KkP4bz6hB3+NxHhvTOnGxdj/7ui/VuFRocx5JvfNSkydi8Kba8VTm3E/pEU9wLEzJkdxt0
	+N6TN0JK3oszZlI/6GcQUSULe6gTxkmUV5ofqmnKZ77CPYYtWVgbkIDnT98Y1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqxlm0R5Wd0RrDJc5qf7hWcJWc/FoDh8Mkn++k5Hxho=;
	b=FP20AERFPEgsCyqxYTObObpLvBVoVITO2G4VKGk81EX0Ss4ym6WmwVvnBAQx9rMWhxEJx9
	Xznhv0ohlYX3ROAA==
Date: Fri, 22 May 2026 17:40:08 +0200
Subject: [PATCH v6 08/10] arm64: defconfig: Enable the raspberrypi otp
 driver as module
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-8-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=987;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=W3od+N7ms8LBhCXN/JpOtSic+LkKIcRVMQF9+TfNOg4=;
 b=El25Y3nV3USsdO3HnhHOD39+moGC7yQlHwDZobn7c5IdnDfIhTZ7J2pDbwLYYkAZGn36W34UG
 JRg3YhKIVJ7BjoGaB8DBBtdyq7P60+jVQ+6AWkc9K0gqRvbgf5iQDn6
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
index e44e83bc57812..3abb3ca34c708 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1849,6 +1849,7 @@ CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
 CONFIG_NVMEM_ZYNQMP=m
+CONFIG_NVMEM_RASPBERRYPI_OTP=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m

-- 
2.47.3

