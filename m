Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F93450918;
	Fri, 22 May 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464415; cv=none; b=rhvdHwbEsNfC7EwSloxDLGCTTHoeFt43Ha/o2CAh2X8TmClvwXjKpk/6j8zV6OT7PGN6Hxo1FIEtKfPYFqk8e+U8NW6eEKnh6Yjs9vkxSnEsoafhMjZRyn2Je+OXjMNCMXVTd2+nIPR0NDx/VwzT/Pa5DIIZ0bX1ddGhrRyyVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464415; c=relaxed/simple;
	bh=+yF/ZOGATgT1knyeuTiskzGTPk9VvxbdwCVyBSDY6N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEeRBywk/7DxViPnqa9xlXW2dMaFu2KdByctfAv7m8PeNejJxAnfRp2No5dY18MLKR5hZ++LfqkNAjxiekVPYmwlkpn6dIidoOfwurE29yrfgrljnu0TxeiXkNUhQ+a/2whSQrcGQebb/VHWw2ZlW4Akk/KeFU5tgpqNRa/Js04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kj3GdzKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNPPgvlH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kj3GdzKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNPPgvlH"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2lsUYzchtqx04itc4WRveJiV+KtXF/+FGSTUlJCjc=;
	b=kj3GdzKv+tvO8VLWkvZbkt+rXeiTvoIyU0DG1IrGIjtH2aX79Bpqby7Oo+i4Hd/jb49Ukn
	PECz+aTg2dj3L4q1m34IVriaZK72PkQHkZ0aDnCpmEudOneUiG1bG1AlMRj+Vdg3ZhzNfa
	/fEaCkub91WTEAlG0u1WR2un5XBWw2VXXVmQDL8n6epEjiMBsjhklD5YMPM5+Myz8PKOIj
	HfGQRXbOu77l81Ndo+zpFaITqaexMkty04Wys0ENG3iTrczR+3kTbg/fklapb6u9TwSUgF
	bc73nzVrsYSpEiigcIa3Qhfnqwyq189kW4TBg/71HnUYR92ppZPrAKv8WrEfpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2lsUYzchtqx04itc4WRveJiV+KtXF/+FGSTUlJCjc=;
	b=gNPPgvlHlTrdMFlqBfmn1BphNAqyf/TkB9WuDdtsQ/EKSxgRkBTs3w5HasA0nxs5Rv1n3h
	oW6klMniK+9vAyDA==
Date: Fri, 22 May 2026 17:40:01 +0200
Subject: [PATCH v6 01/10] soc: bcm2835: Use IS_REACHABLE for function
 declaration
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-rpi-otp-driver-v6-1-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=1460;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=+yF/ZOGATgT1knyeuTiskzGTPk9VvxbdwCVyBSDY6N4=;
 b=iBRNzAlQd69QIz5xYGgMSpngrsfvUlezpxd+TjcIp9dNS/0nZ72sQWYLTAj2wt9qFhqMZPIK1
 LQZHpvWw0XaAcJukNOejh/LfP6Iez/UUYSNnll/EQgc35e18HFRGZM0
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

Suggested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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

