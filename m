Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE091AF0B9;
	Mon,  4 Nov 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713742; cv=none; b=aoQtM62ffIAmcq4v3tkmhCPlhVeffk69HbBPxZGX0jkdZ88a2C9zHT6A0QyrWivX+1fmnRP+1jetTMR74rRlPFivmBMN+B/VAxacIKA3o8nXP9tIHU33TdEXRcQVOtp8/lsyHGL8J48rnvBOcZGMGtFfu+CL9/y4QbSfkNG/jqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713742; c=relaxed/simple;
	bh=xZ6wH9NwIJdn68zqaN4oUXhbnE7mcOvRn9YvuwvEp/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRToTcWg2srunKm/NKWcbKekBBtDh1LNqIbOi4gqo3nzfl9OuqnQMmaiIlPyjWgOXDU/zsdaP2taVHto1kHD7OeonKYB3SdVXxWZJehF0R18QqCNvAMyMAAyWh0mSrqUHbio61mC0knuN293ywIJVCKmzKjDczGfYk1/T/XJfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YHYq4vks; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=elA341p4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YHYq4vks";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="elA341p4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730713740; x=1762249740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrBMF+uepwwER16iMh3Tc9DMPJGlXiQwEYl2Z21Ai0s=;
  b=YHYq4vksf+zSl+99E8W/ZrnySUxxjbJN6wdaM6/f5JEAobZiYhv+g7yK
   25lqU2l+VmZzv9/Nz+jim52DJD/nZLc2vXkFdNRPIjHHf6UgKGHSvwY3E
   LIPRRskD17yCP0KNm7UXhlYwQ2Lx/SAlEK+QNCUwgIpvpg0Skn0ZlVA0R
   a/2vWTjZFZRufxyruX9JwOn/tks4QKCYatrE3IiQ1UvsaI0FIVXnNLi2l
   xjPdC/ldxX47j3Tmw8NvVnPdEIjJ3gxzNbwfR2SnGBZvxlqbDMIiO40S+
   UYrzZQX2Fc9sdvBrH9XbO3jlkSZeuB+GH7iHIq6rJJIEnfILYxQUkPbfK
   Q==;
X-CSE-ConnectionGUID: LIOKSFLDRy+Ivy51jVf4dA==
X-CSE-MsgGUID: VrCq4X79RkySfycBxZbAYg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39827144"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 10:48:56 +0100
X-CheckPoint: {67289888-36-1E10F2A5-CC0651E5}
X-MAIL-CPID: 767AA39CC074AF12199F979CAE3A44A8_4
X-Control-Analysis: str=0001.0A682F17.67289888.00F9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A58CD169DA4;
	Mon,  4 Nov 2024 10:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730713732;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZrBMF+uepwwER16iMh3Tc9DMPJGlXiQwEYl2Z21Ai0s=;
	b=elA341p4HCyIFuBhl+0BplAXOHPm8VFR87oZJNAGTqWPuS7EwnpFrbHasGHqx0vz+xUz51
	vUJ2zlZo40nDATGAFhhzEIvVsJzv9VuGo4lBAJKdDv9PSUWUX7k9mvgKkgI5puSKB47Mvt
	11oMrL4GO3l9J+I2VJTmsF/s2LBuDkx+iEUxoD13jRntqwQE0pZQc93OnNQxV4Zlm/Y6UA
	X8pEJJy9Zo7Fq1y/9b6/e8v69YWRLSpZXVvm0oIYtdiwAVh5KEB7Qfs6/tOsu0rhVVOmUO
	USa7zDwD3B4oJcN0F2mh1hInylX6DtNaku6cMLDP98xPYHE9cgX+gtgC4PT6OA==
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
Subject: [PATCH 3/5] arm64: dts: ti: k3-am62: Add DM R5 ranges in cbass
Date: Mon,  4 Nov 2024 10:47:26 +0100
Message-ID: <08da3463b14d51c620292d574c01d29901987019.1730299760.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
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

