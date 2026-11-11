Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381824;
	b=LGLk1gXc9DSChMxjpkJm3OaP8TQIaA80ExxgD82HtW+N/fylFNTupdrmIzVz4QgDFz6h
	 JFTsGGoq4bJbIeIkz4taMYrnU4mrKFJs7QU3GXsD7zgNLAn8fvN6B37HXssEPVVY+lXgi
	 QB07rYGGxumeOm9EbxOo5j26v/qtbYPH5mr6jSrDiuy7/GP17kjneKNON4meETZVR9AFt
	 u2a86orQkTiNFmMMAYtGtswOqqUWiL+Vhsm8XSSz9ft/CvUfUhDyAle0aNqf9LDcCWc2B
	 Iqu8h5P1jkNNbfliVI0Pk9cDqQulxluZq9HSHaSdqB7/9G74waViaO5+vAVp/w0O8KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381824;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=mKYGjVN39ZmAS5dDpTZPzv5V0sAjh7XDRPHVaktxju+j4B1pWt1+Dycpe1H9nZN0t+kd
	 1Si8ao5xAuWWSjwA29p4hznxk0zfaVhLm0m42EQlUwsZgwJPq+L0XekpbGKhkompDua4t
	 3bmCMjdVDzCM7e5kwBWVlTyCQ6KEAWcEFmhrDcm0LNMuQn6ofrcPrx4l+tUoxzmDU0Sc+
	 c9hD+U0HlnKwp/WxvwIlnuOpJ4LLdF6TYDvbPaUEmf+0FJIoBWakpBUHcrdyRdS6tWcHf
	 7N59fod9z5YTCM7tqM1ChQEk9iJxjgZhs4GUKG41jHsuIfG1GIR5SoITXpU6G0I5aVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2nxCh3ph;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KsUmiqsp;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D960A263F;
	Wed, 11 Nov 2026 07:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791D960A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2nxCh3ph;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KsUmiqsp
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=2nxCh3phL4Gg4uDcPZIkS1kWtEnMnINCjLa5gU5dXpK/Kb2ZdEeygFHY/ZFhpr8QdtuH5y
	NSEwLtWf3uznIQQFgzTohEZ7qH2tFh8/jWnN9VO22W5cWkK9vnFXEfwkKvlRJGhYXbeEgb
	nz+Ok/GQI3J1U4Ibr9u8EVjiotfzDlloplCDpIYXspLmBjn0/32VNH0n/7X8wL+jkAJpuC
	onKt1NKpz/BNNhxl/2BdPU8JQWV6HG45OqLtjhPhFaDXXhK8sKeV4ZGtTUtSGI3VYrsmbB
	W/pk6zGaN6Y5malVHzdiSHB0Bj4QTxm1FMVrebvcAnDDQArIYDGJ9SARdATJRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5OI5FX7JL+kgNYLtItHyl+SG6enyYh3fOM8vlFTvoY=;
	b=KsUmiqsp3VOneiMdPSGwZ1ubier6tfKk3lPwNNWIj3cqghr7/xeuqbD8pFRw02SEe3paE2
	BwJshBrusEgLF6DQ==
Date: Wed, 11 Nov 2026 08:23:33 +0100
Subject: [PATCH v9 11/12] ARM: multi_v7_defconfig: Enable the raspberrypi
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
Message-Id: <20261111-rpi-otp-driver-v9-11-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=921;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=nV4q/fY0ggdL9jLjY9jN7SpLOC/gVRnDvW9cn+372lk=;
 b=1tCk9pFjsIbMMI28Q7yk7ySbUAskKjCxomAVr8yQZxqzJEEUokn2EUalvHHHtrnPDvavNPGYO
 LplfVhCe9/pBKXPvkwF6x3/YfNcSomA7ApAXBgimXI43ABuVG4O/GkW
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

