Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21915477E43;
	Fri, 22 May 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464421; cv=none; b=gW3S4vsLtQrXnGLnNr9UTZxd7DU3e4a8sor89v56NHiFlFt7WSdWncNtQiVUxs7dq5Zbt0zkkw5LOX+u9qPgiHjptdjBFLg56WOgZqu33FErlX1xXoVvv1mxPu4u1SQabnLTy8zVsQ1KLjwa888yw3m6RXBzwhbNjNdhM3ZRp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464421; c=relaxed/simple;
	bh=x+13aj+fO6ZA/JGj9Jo9udh3mNf/KuNcsTa207AzqWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmrgRVLppj3KgQRYSGQgM2Vof5Dm1vBQFia/8+dftUfO1xYucTCXIsz/ByP2KYA2ToTzLJrJiFELI97xZHx49TJROxyXzWf0N6JWvWMZU6HHD/djR/uCWsVmrJhYkoPm6XFx/qrhqo1NUky2S8m9K2UEm8VSkLikU/T/gzJ3PWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OC50Ii7O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fg4uuAAI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OC50Ii7O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fg4uuAAI"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoHgvDPKeXcPQBnOBITGVF8vm2/6C950dldMkcPVKXo=;
	b=OC50Ii7O1Pd9hTS26sCA+EdBU81Zieg+T6Qdpgum9TiU9I+QAhQt5orXKs4ddZVeU/AFi3
	SP0BZ7xqy6c2LOUWff1wle8Ys1DV19zUO12GxCucG1DL96egy6k7Yy24/6rd2kg1c1AWFU
	FVWVefwNa77Ux6YUGqQLTEddJf5GfgSnee+h3ojbO5QVO0ypwHp+KgN149f8Cnlcuwipep
	SF4jR9KuK7VfC0k8ZIr/avEIJZmg2xPIXRz7YhhM42G+XQ+5AQU8enVqX3aqJQQI3p4ZDO
	T2MeIpMIBSvR/4V2C01Ym7KfAQgtRjDLXeZS0o+LTeOlir2pkNhKQEFwifPp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoHgvDPKeXcPQBnOBITGVF8vm2/6C950dldMkcPVKXo=;
	b=Fg4uuAAI0VgfdGlG6i/BnYsRt89DEAZhW7pj0T8KBccDdCx4dtEF0MkhKXNGgU4MlMpQw7
	dLLWqha5lZR7ZgDw==
Date: Fri, 22 May 2026 17:40:10 +0200
Subject: [PATCH v6 10/10] ARM: multi_v7_defconfig: Enable the raspberrypi
 otp driver as module
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-10-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=921;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=x+13aj+fO6ZA/JGj9Jo9udh3mNf/KuNcsTa207AzqWI=;
 b=Ayat5s6ZaWUWlZX1i8MmjySEWOhxUprzvJ6DPCKatqQloXUG6sn6w8hZssiFmgO//xQx3+eJL
 nZ52/89KO9BDElMebvQM8yhwnpzSZCNuBcCoZE44VMStt2smc4vTDRf
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
index bcc9aabc12028..4b61ad5f46ce7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1281,6 +1281,7 @@ CONFIG_NVMEM_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_STM32_ROMEM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
+CONFIG_NVMEM_RASPBERRYPI_OTP=m
 CONFIG_FSI=m
 CONFIG_FSI_MASTER_GPIO=m
 CONFIG_FSI_MASTER_HUB=m

-- 
2.47.3

