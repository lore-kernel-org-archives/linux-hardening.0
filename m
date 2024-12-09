Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F421A92E;
	Mon,  9 Dec 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737964; cv=none; b=EjXjBxK5bsiPc4YnVnazPbkcr0v+2lj1HvCmyvYGSL8GzwxjPsaLNGCOmH4or3DZnwKuzUL8FWUfLRVmgN7KzU7ZiMj6ETN5chpkzwOzZxh32tKOBCcBLtQEUaPCtb00mMnwpq9R+/ZImlvhUh+uobkhQv1h6rUq22fZOaxcTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737964; c=relaxed/simple;
	bh=D48N2ZY2HtyHU24j7AiOkZh4IqADUPYfJQOOl86LQ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDIGYST1xJLXNimowMNuMmCe17LtM455du8+z08UZIxPbH1qtqwkvUAxoE+lfqX2+c21aQl9jAlfd1ozbXN4EgFrNftuoy201/o21c5SmS3nGuPtU1RE96SDmQlfVBCJ3Hd5ysNWMcnedG8+i/L43sxdLc+vIbdbwQjAfVhYio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=paIJ75vF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XiwUo0Hm reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="paIJ75vF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XiwUo0Hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733737962; x=1765273962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLrjxzIVn96+FbEmeJSRrF1ncZ62LbWRlJhGTdPCluc=;
  b=paIJ75vFLDnYZbTdY8BO2liAEXWJe+ZkSDL1yAYwsYU9V+uClHTHXnrK
   nGE34zmYofOJjuKNuMISCdgPkwJzHJn/Gwdt1iP9/OzPEorsEZeI50mDo
   6DwEaf1czyXn7nnF2ZaKFG8zLus6WbD1z+GoH7iveLBRRU2FLDqlmSlYU
   1MWdLQtQkE5b8XaIAhG5OZ/tHRs+PPG/uiwtCaXAdYmqPncAu6AtoB6x7
   2rmG67yInGG3jImRSmavNWR6nYOvipg4wcFGso/QkX8iMS9aQmTEYzNSD
   5cMoFIs+Q+5HwnJDcA1HtuiTjwo9dJT9xYrPPev+LFAlXuJQ70DXD5Zw7
   g==;
X-CSE-ConnectionGUID: z5XlGf4cTO6Lf3vaQXJMSg==
X-CSE-MsgGUID: qhAjyFzoQxqaRRGZWIIYyg==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481356"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 10:52:39 +0100
X-CheckPoint: {6756BDE7-2-90CD5875-E0265C0B}
X-MAIL-CPID: 71BC7653E07C44C1F1C13074E1221AAF_3
X-Control-Analysis: str=0001.0A682F1D.6756BDE7.0041,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA6B51664AD;
	Mon,  9 Dec 2024 10:52:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733737954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLrjxzIVn96+FbEmeJSRrF1ncZ62LbWRlJhGTdPCluc=;
	b=XiwUo0Hm5zbYAE2EQFKVKqMMsMEmTWgY4SRz71uMMtFRrz451qc5TodJQWnLzUouN9h0VO
	EfRpbv852JBcRQ3uX7qEaxFUjgc4UR7154Ytqo1ZWl08jMV81PH9pInBNqW4B5uOqguwWJ
	+NII1Qh3agM8rgjL7FuQQZD+SjfoJoT66lrdSJp3Gius3VHhZPyUt7XhE0l7qai97cjY6G
	TnFCQ9NgtHHE3JWNLHv/qsz7l175w2llTJ7CdivUfu2p1Qs96iO8UUM8gy57HUAiCg5eKm
	5ucZUvUg6UmJy1BvNI54mCpWMUo01cFnw0Si2chns24JYaYO7nx4IVkU/Nf2Rg==
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
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/5] arm64: dts: ti: k3-am62-wakeup: Add R5F device node
Date: Mon,  9 Dec 2024 10:51:35 +0100
Message-ID: <87517cce567e1dda89c38f82db93ddff292c5c10.1733737487.git.matthias.schiffer@ew.tq-group.com>
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

From: Hari Nagalla <hnagalla@ti.com>

AM62 SoCs have a single core R5F core in wakeup domain. This core is also
used as a device manager for the SoC.

Co-authored-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[Matthias Schiffer: Updated to match latest submitted version v5 of "arm64:
dts: k3-am62a-wakeup: Add R5F device node"]
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 9b8a1f85aa15c..619848e889cf9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -106,6 +106,30 @@ wkup_rti0: watchdog@2b000000 {
 		status = "reserved";
 	};
 
+	wkup_r5fss0: r5fss@78000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78000000 0x00 0x78000000 0x8000>,
+			 <0x78100000 0x00 0x78100000 0x8000>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+
+		wkup_r5fss0_core0: r5f@78000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78000000 0x00008000>,
+			      <0x78100000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			resets = <&k3_reset 121 1>;
+			firmware-name = "am62-wkup-r5f0_0-fw";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <121>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
 	wkup_vtm0: temperature-sensor@b00000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0xb00000 0x00 0x400>,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

