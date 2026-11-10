Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328457;
	b=0x07lFjXvtZHd8JKMzDjHaWgpzb5be/X946yq2Ruqv7i66KrAsxE2H5HhxG0GsgaFLrV
	 VDKxZSn6jX7yJVLdjzu4807qKSVAPI/SHzVPV2aiicw+HDBHIiH5yPcVI80p4xa7BuqJV
	 kvdPiIfJ2bRLldOYv+6vtTbQKI76Is2q9ven7oV/R/gnIpVrFHJCkN3yNdPEEJ52j1j1m
	 cUxsb2SyUCaodwF/kpCLXPqnPHbkMFIHW4n8Vl2zYo/5nFjkSdzuHLJXHP4AdJ1DqUzmj
	 8C8Kv58nzKlJWkHSAfZ4eRHefbwuY5Xjzh7fmPAQcddR6NqQ9vI1zsmevA1B+P+kPXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328457;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=rhDyAYqsh3ZKftI3BOGeBjJuOBeZQZkg7zmSCDs4MjOwxGoiJIcvwHs9sHzCFES7VDDK
	 1iTSOhHvofQ/gsiaJSmVsR7tMS+vRuRMis9ojLkyeb/aifndprSQKEZHt9W8xFLpafy0z
	 B4XNVtW4IZv0mQfrsTgxZUEu52KLKXF9+xTQrqrMql39EdiwmgbZLCCnM+MyL8JauLwls
	 9uOLPdfC/PZdT4v45CLHjlM+yeLie0c02uv6pKk1kwKjpCNn4oJL+mzNy8ZN8o6uOUm8f
	 pXWGwSOBiVsFFLWFPB1wjEB/G9bA9gKf+qz8iVfH2S6mY3/L7OFDjE7iW4Q3VTm5sKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=D0jxqckK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nctSQOq7;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC228606A338;
	Tue, 10 Nov 2026 16:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC228606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=D0jxqckK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nctSQOq7
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=D0jxqckKK6Xk8R6hFho6o3ukNf2TUCRtXNtZPkLnKnnkta8oMv/gYZVbgZMjvpMjcgBGQg
	aw6EINY/4YIcXrCuNpjH1lY8poCK7On8A5KsW8rVmvNRPvmQQFXiM383UxIq97FyUTGRda
	5iAH3Vi0ohgAsIrZl/UtPsdvXroXd1NMqv4U0f8Z1B/QtfNtpDwYhMDW9jbbv4PW2RHB6Q
	9d5menNIwgnS15dSywGEuj4OMX5ha90p7730PIrrpCNL0xZFhdPJVi0cGAk27UfEdRznv6
	ia4/v1kAkecBp4IKPaJVCjrq9kLs5rdb6hK/lHoE2rZKy9NRHeOHhCR/m14jNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=nctSQOq7y6pW8i+2azc6S2Ra3wI+JYWrSup+tTJOAnWhXA2AbZTQYSiWgiIyET6kYkMlbD
	Ehhu7MqQn4k+vvCQ==
Date: Tue, 10 Nov 2026 17:34:10 +0100
Subject: [PATCH v8 11/12] ARM: multi_v7_defconfig: Enable the raspberrypi
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
Message-Id: <20261110-rpi-otp-driver-v8-11-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=921;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=nV4q/fY0ggdL9jLjY9jN7SpLOC/gVRnDvW9cn+372lk=;
 b=sNChvnfgs3UBEWxu3bTAj95LK9Eaj+c0VksXtEtrWUZ3aXq6QKuXvpywXAnR2hAiAFN6IqMvQ
 k4YEigxkBXcCIMsv9dfkur4p1Ig98fTS1Rrdxrylw+orREd8GaM9gmu
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

