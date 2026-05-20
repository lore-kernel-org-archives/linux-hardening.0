Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CC3EAC87;
	Wed, 20 May 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287289; cv=none; b=PnOmCJiVW2c5nYD3+NX+frSfAP1hKC4CYt5rG5Es5FhAdIYo1i7Nc4u9zlco/NEK+GcAhKu8pwqMbmRhqFZqdfdk0BrDnpsRh6Sa0cw6isqbLWaRNiYMp8BeYJocFOGy5hCBleT7Rq3n4Vhl6b2sPLtIS5j0Zl+s111DXgRBtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287289; c=relaxed/simple;
	bh=sxQGCV9Bg6Vz0Ph0j26x9ZfnN5Zu1SLYraSm4g3fJ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeqOqkQZ7WiI92j4c1a/MD6o272G794wqI+jgs/6hBNwzP7yb080BE8A7hX+mieDu/D6a5b6C8trjqprY3Kd+NbmmF941heYEoN/stfGHr2o0K3AeRzoIqvZp4M4d2vagdpQwXXVG4nQnW98xnp/M9qTj8msRNZ0lv9o6orn8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIAvbeo2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p1QkB7/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIAvbeo2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1QkB7/X"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIg0eXBcEZ1WbS9twEGYQ0DKLtIZsDqQu16FcfETBjc=;
	b=PIAvbeo2slSRFIm4bEvFlsDU0yhrl2ye94bZe0Wevq1YcnHq0DfNzxtvpGfBmtnXwUL9ro
	W0FYEu6ndLKTOa3PyjjpebtbtMP9eCoFCNOne62NOtDutTXNoGaCydbPeyZPRJfPmCW0uO
	dUtKaOZ1+iGC0Xuhy6z1UvEYNyhMZeNJnCdZKhBdH1CqxkE3VJEXWAwJ/lAQxi7fgbCVHm
	0srzRXqbUclykB47OioTatGvPbXmFMyizqhsT4Jzw4QobxJlGXseRQ7wULg2aN4LX0BC5k
	SnvD9ykRLVP27UrSu2xJKahLMRcnb2dx5JHWPjZ9mWxmqztIXBrXJV5IKKzVxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIg0eXBcEZ1WbS9twEGYQ0DKLtIZsDqQu16FcfETBjc=;
	b=p1QkB7/XhCF6iMMCWfcVcWhXyu3avpuT37ei72veI4LttLUgbS0gcIw1FZr16t4IjoHerk
	rcH5TLUafbkROzAA==
Date: Wed, 20 May 2026 16:28:00 +0200
Subject: [PATCH v5 8/8] arm64: defconfig: Enable the raspberrypi otp driver
 as module
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-8-b26e5908eeac@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=689;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=sxQGCV9Bg6Vz0Ph0j26x9ZfnN5Zu1SLYraSm4g3fJ2A=;
 b=O7JTUaJejsAQjydEYZ5zW7PCjzoARjdxd349iIcPWPsReeRusOdJ75TtqkMzzA55Z3QsDwONc
 xyLgJkuS2LqBD7vL5cJxVnM9eeURsAbhDN3v3dZ6LVhI88zsqMbrVox
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Enable the newly add Raspberry Pi OTP driver as module to allow access
to the otp registers.

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

