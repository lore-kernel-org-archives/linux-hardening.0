Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823857;
	b=HFIgNT8tS0G0TP19CED7DQjryuOboRWbnTwHg90a//DviWo/K7ZlBA7z+7Lp8dd2BEXd
	 gIYngabvN+2uXiQBpY01fHUHmKKivVwUK9zIMTBorufjkMckCs1lskNyC+KaJfp7qK4pS
	 s+igMRTugHGY9hGImkSZpO1c11TVMOKKHbb3vDUYS14XGjRpJV6GZ99Jwp2uyWXD8QiPP
	 yN2aWl3qCUMrL7P66KkxEnR+VKy8CtRvdySvffVa0A+2pJPabLBl8X8D2jrllv2HsvcvD
	 jGhWEB7mvLkodIAk5tjwcysLB5veLhdETLt/Qd3tJFx0ve+BCbyqFQEqhsN/n5k4yTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823857;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=LQaSa4KBtU/kCo/UKBYhOSG7nbNXdvgb8ZS2pmJp8iTyhtsdRsR3N383mjmGwSjAk/HO
	 EiOPGg/aUtP6iXzcYib6cXTHzh9RAnC+W1GpD4OpoFom166g38+/jk4K9l0EdiI0tO7DR
	 +yaJ6Nfze5kMe/gsKY0wfgz2Zw+PO2tj8d2IBVgMgfIJIwfkNagiuZwg2V94m1HJ+s27U
	 Crknpe0Xo2ME8WoEWUj0+LTygiWtvQqRDUkVe/F/dgxfiktxyYRtkELfwYQVXFu7fNmnd
	 u2UXL4sOKs7qOVpes3DkeO2nK03BccHmK4bw/Dd/s+XU83MVpYKB5r4loxqEYU+5rlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VfZcH3uy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JF6n3X1L;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E060A2630;
	Mon, 16 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0E060A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VfZcH3uy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JF6n3X1L
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=VfZcH3uyBNfBI5NTJofEZM1w5isgFG6U+LUP+XqFuGN1ID6hS7egFsEdwip8+lGseVxk/A
	Jn2B6sUjqzd+qpq1S10WkkchBtAy5AanqobGmUJBVEUsxgStQwbcsFss5sQ9LxYBGF98PW
	jBwysAVLEk6XCxiDhqRxZDfYTzoiYiXFfkROgfS0aTtHQvcHmcwCrNt0CXzgy8/5j0s4cV
	uu3pYX8xl15bv6cnzu6k1zESq7d1oKNWf8LOWMojEm3JyQNac0wAgZ9iX5WjNynAi60oFm
	vdmXEWA6XP8JDEWCf7AJXATUUTj6Ax/o8PiZxVw4Ic7QhmSN3FsPU0hakqgxNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=JF6n3X1LIHpnX/y+VWPjz5XMlnYgJ0CmB+VrM/IoODYoRWnK8gDWXJEHKcmC5NU5oCzpv3
	bQIsxlEX3PYHszAQ==
Date: Mon, 16 Nov 2026 11:10:35 +0100
Subject: [PATCH v10 11/12] ARM: multi_v7_defconfig: Enable the raspberrypi
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
Message-Id: <20261116-rpi-otp-driver-v10-11-15302dcfd5e1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=921;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=nV4q/fY0ggdL9jLjY9jN7SpLOC/gVRnDvW9cn+372lk=;
 b=tg4uH1U4uSF+j/awFBQXctjuCyxAGa7PE1uL9bx7ZyCzKpOgzLv2mp8RDKa+HF5lu8SrM9/HU
 lMplUV7S2ILCw4X6umDx5wLQkBxVrqgWz1/KJMmRYjx3o896YOh5ZsE
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Enable the newly added Raspberry Pi OTP driver as module to allow access
to the otp registers. This driver provides access to the OTP registers
present on all Raspberry Pi boards.

Enabling this in the multi_v7_defconfg allows standard upstream kernels
to use these registers out of the box.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 069d5a49f01cb..e9720a22a7c44 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1262,6 +1262,7 @@ CONFIG_NVMEM_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_STM32_ROMEM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
+CONFIG_NVMEM_RASPBERRYPI_OTP=m
 CONFIG_FSI=m
 CONFIG_FSI_MASTER_GPIO=m
 CONFIG_FSI_MASTER_HUB=m

-- 
2.47.3

