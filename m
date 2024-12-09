Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0189217739;
	Mon,  9 Dec 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737958; cv=none; b=moGOOSOTNnZZqIe/lMJsrl0Ioepfzh/FZRTlOFzNmKFJ3ujnO3zMw0Dialcfua8kv3/Xf1JtffOeBrNM7yH1xT5NLmsk97G88hYTvZ54bdJ5oNYyugXMOGTWFA4c5rm5XEmK5+wlqUtJihySrbC2rz6Z1HnF5UKezMjb5frPlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737958; c=relaxed/simple;
	bh=xZ6wH9NwIJdn68zqaN4oUXhbnE7mcOvRn9YvuwvEp/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsMnzxRBpV4gvUBQxUWsLebWIp4kxbptMKb11ag/L0OLq7dONib/qUYTS49mUsIZHaPSUAY4fiITWr95Ix5j6yrvKXvZ4YzgqQu03rOOXAt3Rqe7GuIFrhZ5qfF1nX8xBKmUFtS3dJ4YDMQ0M5OBVEqlLbCj9WXgGL+Tz4C2Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BquZJxT0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YPb8j5r8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BquZJxT0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YPb8j5r8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733737956; x=1765273956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrBMF+uepwwER16iMh3Tc9DMPJGlXiQwEYl2Z21Ai0s=;
  b=BquZJxT0iHQt1pEVmMZIkOFaE9m28jdO8jn4ojDdU12vGi1Qy6GkvDRi
   4CTf27X4Fv1f1AsXDpRC5wXPFQFEqXNteL0RzIRdvcYWOiiNis7u7adah
   g+qtQ0lXEPaIBWfLqSfUl8wgDu/pZBwCCNq6ZXlXC0TsePbcG3Vk4UFqY
   0wYwoNrPXzwylM/bebURKsUv7zZBdlEU8SRj7kqCsoiOV4gyIGLnbQF5v
   NDQoszrwWT3WFtuhvyMxsC/Q/P6gcXAmaZ2377/XO6nkDWf3s3Ggy32S/
   dAyxpA8w6IIZOlO6xrHJVo1jD5RQXTBLpkIuio3zTeL/oMxw/T/LNuudH
   Q==;
X-CSE-ConnectionGUID: oSYvtfyuSkupLwQwn2bcpA==
X-CSE-MsgGUID: P736M27rRyyQwtveoRH5tg==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481353"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 10:52:34 +0100
X-CheckPoint: {6756BDE2-3-90CD5875-E0265C0B}
X-MAIL-CPID: 2739E13F82B87DEBC461CF3D2DF1E092_3
X-Control-Analysis: str=0001.0A682F15.6756BDE2.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBB231665D3;
	Mon,  9 Dec 2024 10:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733737949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrBMF+uepwwER16iMh3Tc9DMPJGlXiQwEYl2Z21Ai0s=;
	b=YPb8j5r8q9X7Ign/5O2ob7Dy1VXmGWAUQQq+svfw21q4+m5uV8xy3JCtN2xPuQqk6VsICE
	mOrPfhxtI7pTm04JaXAh4oPOYYc8qOfvWRunVDyI49ajx3ZOZyfYII/6FMN8z9uZfuCBOR
	kN+8PmWgq4w2jH3Xbw+Hkn/Gc5pmM+L+U99ibqvPo7bljuTR7b5Bai18KT3lj6d6d7bu0f
	q6Ta9ndbaChjPQWD5gQ4Hr09XDRCTIUy1qHdbfcbFE66c6GKFU1LSd9U72SAmiMab50fAZ
	g+O2TIzvenVSPVbPUutkUyyPH4HDL4JueFqinM3iO5LtfS4U+pyby4NgL9vSbQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Devarsh Thakkar <devarsht@ti.com>,
	Hari Nagalla <hnagalla@ti.com>,
	linux@ew.tq-group.com,
	Dhruva Gole <d-gole@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-am62: Add DM R5 ranges in cbass
Date: Mon,  9 Dec 2024 10:51:34 +0100
Message-ID: <641475ca5720fcd24bcb41af36b69781a0a86df4.1733737487.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Devarsh Thakkar <devarsht@ti.com>

Add DM R5F ATCM and BTCM ranges in cbass_wakeup and cbass_main.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am62.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index bfb55ca113239..f01a594ba7f89 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -86,7 +86,9 @@ cbass_main: bus@f0000 {
 			 /* Wakeup Domain Range */
 			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
-			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
+			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
+			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM */
+			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM */
 
 		cbass_mcu: bus@4000000 {
 			bootph-all;
@@ -103,7 +105,9 @@ cbass_wakeup: bus@b00000 {
 			#size-cells = <2>;
 			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
-				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
+				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
+				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM */
+				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM */
 		};
 	};
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

