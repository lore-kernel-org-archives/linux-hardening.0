Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB841AF0D9;
	Mon,  4 Nov 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713735; cv=none; b=rYr7e54YVfxJ0IsffrfVLc43OSzg+ezvsndLpcsekkfEPdSIGOkb9YVrebAbiOul9+n0k8RN6cwNLulTUxEnbtABUmtlOeEg8N9ngHDaaYBUwC29uWi/y1lp07KE03tfbdNPmxi72eQU/ObJVhxHSXylxvOiq3xxZGEHfyqOd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713735; c=relaxed/simple;
	bh=k3qK1y2cd6v0wqEYOwu6qgOIx8HByD7CMySLR7vkI+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ86galGG0IFxlmPiC84y5EtBduqH8oHprCGFBCrT9TmO9gle7lEv2mKUgMlXqMYWErRDvYapGkZ5AMHKOWpIRv7Buw3Fy3tq0sCQ/wKl0DKri9VYpCGpaeTSqEMhOrOdK65XWQXrK9OWN8QFOeuaDCMP0ZKyn63/YrSh6JcyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Nd9NG0z4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DX39Bo1H reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Nd9NG0z4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DX39Bo1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730713733; x=1762249733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JH5f7VASZS6KUhpV8GNdtHAYtBKP0OBrhdci13q1zI=;
  b=Nd9NG0z4szWgOmNFvjf1R++YtjvJEao28AIfwe+PbyN3Kr/DTxj1vHvo
   3sLtnIyYZpy04tlwsm2atoTMnkDPRb2cqCqM/IYjAYYEmPOwxsP0rVybw
   WLDiVj1uUiciiDOXp+7+Jk4RygeA2Nt4ybE7QiKv8+JKpL4kqyvQ+JkfN
   k6ho9qRAXoqMASKmalsok3so8fizgymxZDG9++U/BDxISRkYs3h+Bj8Lt
   PTtptJUNlI2MdJ4MN6ATgaa0Uo1Udyw9EIAZaNcVXY+rLP0hOURnzrozu
   99kA7fGJZo9pzw8Kk++76rpj2KwVv2Q0VfrMXwet/UJIPWgCDNh5ANRfd
   Q==;
X-CSE-ConnectionGUID: /lxKrMAkQYuqCOTFr5JbIw==
X-CSE-MsgGUID: xmNmdh8DT5O3cKJCqw6d3A==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39827143"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 10:48:51 +0100
X-CheckPoint: {67289883-41-86C05612-CA75E1CA}
X-MAIL-CPID: 6CA3FE28D4F36F3CDB780E76E530CC4A_1
X-Control-Analysis: str=0001.0A682F28.67289884.000B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF5EB169DA6;
	Mon,  4 Nov 2024 10:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730713727;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5JH5f7VASZS6KUhpV8GNdtHAYtBKP0OBrhdci13q1zI=;
	b=DX39Bo1HqN2ICbpZoX39qlp948wy1HNquH2lPpf+D0eXQI0qXHsdOgD42FOGWKpIQ0Xxaj
	7u9+3e48h9frhqbBOE4Q+IvRWFk2ai3FY+wi9xNjxagLtEJoYvl9EDXwlY3ZNy37N6au6d
	1iCshzhku/gfNYrToQC99vC0Kx7UBDoQCO+tyNOyf15gUndugn3GxnU7S3A2kJnQW3zdBg
	BveeQXwpZrgU/FD+oB6FdrXpId2GY5O6B/LV59rBxM6E6chy0/yqb9qIsb0Q8zB4yfc4V+
	BoMgwb3EL6VZcctojgDhT1THk6XThWyqsOKVISvf+QK/oI5dJsFOTZ75ZHXUVw==
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
Subject: [PATCH 2/5] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon,  4 Nov 2024 10:47:25 +0100
Message-ID: <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
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

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index b0be02f9d1253..d8b52b95fba7b 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -73,6 +73,13 @@ properties:
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

