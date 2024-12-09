Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE6217679;
	Mon,  9 Dec 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737957; cv=none; b=EtgHFgCTWBXCnaB6qAONhc2qlaGsw/8uggJ54mPxZIupM6lCh6GlhMAelUoLATjJcmR7LHx7Wf8p/Hl+pqVbDlcdJqURqQVN/ats2c6lDZYDPU632BwY92PqfjfeEYPrKtTBMbJM6qArvOAevnXJo/GttpdeUh06PX7R9A9OCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737957; c=relaxed/simple;
	bh=21+SG0suICdfD6OKnQqkgAGQEXHKSgaTP/C0tXY1/u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx+41WR+OS0IQufCcOUQgRH2MlbVz6FA0zsesvgIaq0I/BaUwWPSj44gaZZkos8Yvvn6VG1dA6PYm6I3RMUCYyUPpnFBVnDVF1hxSRgw+VC2a7Dz7LX7EF474s5GVeUhpe3WTW7B0ueT49k8ioouGfyF18C2jVxx/FQUsLyEZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZVRbNe75; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iwkoMmUF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZVRbNe75";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iwkoMmUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733737955; x=1765273955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/aYN7rPyWzwA0+POa1Li+U2OVvspaRln1K5mS8yp+8=;
  b=ZVRbNe754k+81iDuIBgVwmPboN/brclZggbTF1ncLKvVNTQxX9vCUnpB
   7qAOUpr9zoOF5Oa2cGv4nx31S/n6jQNup82VNlYLEc2nFjPpwxKzntBue
   XvTssRB56LWHse3PJkE6P9Vk1r01Xgw0YFR6IezKpte9iqOXgBaU9mSbl
   4yP/69IwkN3IwFiWKFY8AxFxzbA2DYnLTFvTP8DjCE0RZkjpZQ4l1pvkt
   0DB/7sLjXD3YBiECF7LJiwtd1RI2IED1ZgS1bgNASFAtzXrMsv21SYQi1
   Y0x5rn2BKc4qFNxuHn9PBMdcL2dEEXIXICHDXg16+99J8uRHFhNb9b/AD
   A==;
X-CSE-ConnectionGUID: YMOy1Z7QT8S99Otl0T/FcQ==
X-CSE-MsgGUID: s+1EYtGfSy2rp0zfhDpAhw==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481350"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 10:52:28 +0100
X-CheckPoint: {6756BDDC-23-D31EDE1A-D52D6119}
X-MAIL-CPID: 10A3F78DCD06F9DC5117D727EB54E499_5
X-Control-Analysis: str=0001.0A682F28.6756BDDD.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9354F1665D0;
	Mon,  9 Dec 2024 10:52:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733737944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/aYN7rPyWzwA0+POa1Li+U2OVvspaRln1K5mS8yp+8=;
	b=iwkoMmUFFa/7e4DGM6ciLJ/UC4LbWlxbDIkkVqfNGcy8w+STTge0R7crmwqB8m/Jczm8MR
	MZsyp8JofofDfizM6+vWG2lpEscISZ0FfJUyo4Kh4204r7r5V/S+NUlQqA1afZbss5cn6z
	7hY0UvDkD3HizpIoM6pJwV+ohktoQ1EP0mYbpJeEVbEjrUC4NUfUlIZiv86VpHuAGiU0T9
	RKDiREaGTrEMH3lBTS/mmh0ymQRyrkQA+WKkDtGyYs7+mUwn2TwH3tG6HeM2GM1+i+WzN9
	PEZbxDfD3r3LzAtUKV2KopcKYz3BGSEPp6/EomphzLTmist3XRi6rqM7OzG66Q==
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
Subject: [PATCH v2 2/5] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon,  9 Dec 2024 10:51:33 +0100
Message-ID: <6052e70b8e744bd3a608728f876c97d3172bf975.1733737487.git.matthias.schiffer@ew.tq-group.com>
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

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 18f155cd06c84..07d98a67d967f 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -75,6 +75,13 @@ properties:
           - const: toradex,verdin-am62          # Verdin AM62 Module
           - const: ti,am625
 
+      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
+        items:
+          - enum:
+              - tq,am625-tqma6254-mba62xx # MBa62xx base board
+          - const: tq,am625-tqma6254
+          - const: ti,am625
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

