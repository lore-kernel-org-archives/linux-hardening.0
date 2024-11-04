Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37A1B2192;
	Mon,  4 Nov 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713745; cv=none; b=WH5BQPT02AqdkenUgVQvM71+wbxB25oFbYtaN2sTL8tpYXTOt2mMCHETIngsAjGYEWgBPH1S6+hpDgbnnVlGwtAp2V7n21Nl4upGuPynzgoXU325j+gZr8dQgSfidskWZkxBF7sYgJGiAKYVYmVGTI0vno35pEiBYZXAyR8pz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713745; c=relaxed/simple;
	bh=SxUxoEGWPdZy6SOalehXXF5ftc8ixgDhH+j2aPtj21c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy0N5XblotFMB6VNlgTxRbci8TdsIpYCBCMg9pHHMs8hqfo7sSvedejcw+M9pqK0kWa8zPEvF+nNflA3n0mRMLsQ8y4IRtlQQzqbOvnb7lR02uUq9IpSXomkhtpfBNialhS90DXN8FZ8haO6qTYT+LisjXlFwGy7EGnlkQDLolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AceZ4ASr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Hd5cqe4J reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AceZ4ASr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Hd5cqe4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730713743; x=1762249743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZBTSAJVXid3MIQtg2BBLWs/I1t+jzrKm6A0/aL6KyAs=;
  b=AceZ4ASr0BmE9215f8RdmVgk4CjMlDjeJmFWmx9Fl7O5HC9Z+wanWfzi
   ZjqLB4qdQQhIIwVDTV2DIlUykJvW6UEj4dsY1Usba/xKiUZPjLZ4GVxoe
   9lPQ8JD9uxKe+xpi63hmiiAwngWocykjXmmcbIHzK7UllhGjc5ktM2Rm+
   lUt0jsxwNiucErJ1SqhAKZo0Gc+KQsIzKM497NJHQWGkvlnnn8MY+9Wc2
   ghptPQnrHi8Ax6ILhBNFJ2DR9A259Z8gZaDgLtdHb6hGyO20wclxk0IOV
   vhe1dDqS1S65ziUrY5ZKqpnkrig2R/Y5hCLI19YPmukpg1bXWL1j/rBLs
   Q==;
X-CSE-ConnectionGUID: a4QuwL1+RUqg7rke2wMldQ==
X-CSE-MsgGUID: 9Oy5HxWCS7CMQvnISBSEPg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39827146"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 10:49:01 +0100
X-CheckPoint: {6728988D-22-F5DC7025-F79421CB}
X-MAIL-CPID: 9EBC8F9B5B9B36D47A3FA86AAF017B77_0
X-Control-Analysis: str=0001.0A682F17.6728988D.0113,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91CD6169DDD;
	Mon,  4 Nov 2024 10:48:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730713737;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZBTSAJVXid3MIQtg2BBLWs/I1t+jzrKm6A0/aL6KyAs=;
	b=Hd5cqe4JUcoeN/yaLmIR2qvjHQaP1Hag/PwvQ4ctbbH5N2YBwhNjw3ifwPatq9lUUxxv/b
	hx9eaRHL6TiKh53SD0/v6+OZSatqVqxRqHnYXlveKmooxFCVhAKQOQEdXV+rjuOIVFnYCc
	13UkZGJWChNaFrINBEerZB4jN2zG8dGNFnPT0c1bxjdUoBeWusSN7w4ks5yUNLXTkPCn4X
	aXBVYZBvzA4HKaaM47G3RMjPjJbOA7GGKIQiB3nRaxiHe6pAE/bN3GCCqj52hvuPolLqt5
	wIDONEW3bauxCgdYgQbINNadm8s1a3p2c69CdaaKVH8SvpcsqvX2Ocgz7WwMBg==
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
Subject: [PATCH 4/5] arm64: dts: ti: k3-am62-wakeup: Add R5F device node
Date: Mon,  4 Nov 2024 10:47:27 +0100
Message-ID: <b0b98b4377559f72bde58ac1ffb7833c17124175.1730299760.git.matthias.schiffer@ew.tq-group.com>
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
index e0afafd532a5c..cd9d2132009bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -101,6 +101,30 @@ wkup_rti0: watchdog@2b000000 {
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

