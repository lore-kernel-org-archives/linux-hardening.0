Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C7221573;
	Mon,  7 Apr 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056197; cv=none; b=a5qWMUieWgFFT7mo7I8SJNr5+edJD2afxyoSyfe+aR9wL25GXQwA4H/jqxazTRLgORpPVsUVrC9dedsGCVRrH/l2+S5Pc/EwU9CQr1EIp1vYyeBL7GSwQK2vYqIDSBuhvi+rScchi71v6ONVEHERHXldY9oHZDgXwcl8zan/WIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056197; c=relaxed/simple;
	bh=6OMwIuv8o96JS+2SCmLB/cdc8b9zWCLSybt1kkH13F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaP6o2k9fjyB5gFp6XBop68nq7ETKRtcDJX/dx4RxkvIGYMesSJxR9ml2FaE9ONplnjEjtheRrazohNHTVukFNy6sqV4An51nIfDsI5/4xa0zaCA3kCCNF1jl/D+1cS+YFcCFnpvRal09jUqWZQZ+ZoO7L01h0OKY51AtTuf5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYE8RqzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYE8RqzE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058ADC4CEF6;
	Mon,  7 Apr 2025 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056197;
	bh=6OMwIuv8o96JS+2SCmLB/cdc8b9zWCLSybt1kkH13F4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qYE8RqzE3UyjG8/S1/qUyOTfGfxN51ecjsYjDNByXq8xmZqJUIJXXrnOUyWi3GVvE
	 Dykhv/oc9rUDSRRJzA9wr/v5AA+Fmc49W3HjjiS9z6pCkhEtFBPv3Q4P2A1Q6RNpi9
	 vQi9Ic73I0hffA7is2MyiN/uvVFJ8VROfabGdyF6ppZNA3HnpXpb3Kn2/SyH8c10Lm
	 h9bEvTpNEEb2DyPZOyIuILpJVMMcrPmeb2PzD2aJK2s5Rzd/7lHX2PZ8YmG5pQQZ9a
	 fojIxneAPbaUje0cTIalb7Jx+i3GmE+j5BNSgBWBnknpWs0TnpmoboeAPdn3VJu2lS
	 rCr8i4NQYPzZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E853BC36010;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Mon, 07 Apr 2025 22:02:15 +0200
Subject: [PATCH v15 4/4] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-pxa1908-lkml-v15-4-e83ef101f944@skole.hr>
References: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
In-Reply-To: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=XeLw/nRd7g6pEyFxTHXgaJRQM07Qgsbah3nkCqFOIBU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOlf9JvUgtYu4L703uyGhLWE20T/3zuP/XexfTYz7+nP6
 rK7cw/FdZSyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEnr9m+J975FPh49Bq3oPb
 /ykEZX34Ixayf+5lqfa18qbl3xf9Xf2KkeG+gefBtx/vbZR4c1WDj7dE9+AUPzWp57VKSnE2JRG
 RddwA
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b82704950184bd71623ff41fc4df31e4c7fe87..649b70ac8b96ea0bb91e3c641517c334c85270f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2717,6 +2717,14 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/marvell/pxa1908*
+F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.49.0


