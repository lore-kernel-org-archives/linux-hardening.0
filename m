Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE51AF0B5;
	Mon,  4 Nov 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713734; cv=none; b=khklWliINz9JLa7sbu/BqPrvsUiPRSlRnQEpU9KNTQAzRk3faZgTWoABTle+zn9cbo9zslt5TsM3hvKPjZS4e5Bzr5FuODVJiWebQ3OIrw0lO7aixwi7vT1vlEnZ2Vx1oyVeDZwUgL46qSvy2ChJ/i+cB3OBmxOZy9vRQl/o+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713734; c=relaxed/simple;
	bh=JaKKjcuoZrlAHWCj9ry4pIYxlYOv/4w3Qb/RX0S4tzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWj9f3xD46a5fRfOQqODo1bmby87bQNpMk7JPlYSuMaVGX5p1C+EB9oTYFZRwASMqCb1GyBd0xAFNmFVpxTGd3Ab0piY5hiyOnqbyM3KQgGtd6M7SV7ia1e/ufPXBxN16j9wez3BGdjoWj0pmSDtK5sXv0LMUf1JcanXwjf1fUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Qt+FFcOI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iM07p21m reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Qt+FFcOI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iM07p21m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730713731; x=1762249731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bF9Uq3Q8dX1adVB/pmYg1Vw77dvx2Gt3C/hOrtDal4=;
  b=Qt+FFcOIC7KxgazBJFT/DnRy1XmlIWMDzS0k/AwsxPiGHxcn10aZmPRz
   tcauD3bOSS6O4Z6rWe1XAkScoZUbIz6NqSmr0kppD8gQNRe4t74IlJWd+
   1N7W1KCqrusbneyK4vWRXMqFI3QbXjs4VTFKI8q8rd9bXxVIBmPll0l7R
   W9ixXRxu+pbunXpu9b0xup8VqgFBUvOmVWzoZvHa30ZjEo+G1lIZbndFZ
   S5dO4W3tk5vhsA6a3+CxgVffhnLtPHAvcWb3SwdcS67AVVoe5fbQhloiC
   FIySR+HsA3yUwFn3aX5ZYLEv0caIeyzEOKwVZ42UtwbpdOXR0jLJmBHZs
   g==;
X-CSE-ConnectionGUID: FJihrQ4eSoSnsWD8yr+YcA==
X-CSE-MsgGUID: A/ojzjwQTSy9JlGXM/frGA==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39827140"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 10:48:47 +0100
X-CheckPoint: {6728987E-32-F5DC7025-F79421CB}
X-MAIL-CPID: 7CAA90896B5648B07D4AD14BAFC460AE_0
X-Control-Analysis: str=0001.0A682F28.67289880.00F8,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA5DD1692CF;
	Mon,  4 Nov 2024 10:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730713722;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4bF9Uq3Q8dX1adVB/pmYg1Vw77dvx2Gt3C/hOrtDal4=;
	b=iM07p21m9vLjmMaFAnfwkNerfr5GgwT8dNf6UEIt+ahRyx3/Gzjlsl7ICCfXzQVTfGT75L
	vcfP6fcLeNEiW+H1umVkWzMA6+EGkebQx5c1K/19bTFr8cbS6tdO2PLe/LIEjAd49gypGt
	d5IK3op7TrJjeRUq5KU38CKHMwGRJ0h8MtYkRf5ZtAyO6NskTji3aP9HLakF86eRrLuiCc
	wD4A5BjZISbASLw/cmRgE1S6wuKMVUGwEu75BzwXWt8qKNLcWaw6z6CfrZS4r1631nG4mv
	rIACJ8o92zmi0AaeGULxR247RzQANOF9r1m/GxgFhUuqHl8bzo+P3K6gCkOW2A==
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
Subject: [PATCH 1/5] dt-bindings: usb: dwc3: Allow connector in USB controller node
Date: Mon,  4 Nov 2024 10:47:24 +0100
Message-ID: <c8c9f19c300378916e920f5d3c26c67bac95d143.1730299760.git.matthias.schiffer@ew.tq-group.com>
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

Allow specifying the connector directly in the USB controller node, as
supported by other USB controller bindings.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d9..2976fb1a58061 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -68,6 +68,12 @@ properties:
         - enum: [bus_early, ref, suspend]
         - true
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+    description: Connector for dual role switch
+    type: object
+    unevaluatedProperties: false
+
   dma-coherent: true
 
   extcon:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

