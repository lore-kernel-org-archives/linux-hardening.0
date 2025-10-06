Received: from mx-relay04-hz1.antispameurope.com (mx-relay04-hz1.antispameurope.com [94.100.132.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9126A0F8
	for <linux-hardening@vger.kernel.org>; Mon,  6 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751406; cv=pass; b=Ah6B7Bs1+0apbLouhcR5gmHl+GpG97M8kYAsYscuGNQZh2a5PQ3/+dhfeogSSjl5asnsoJmll3qeCQu77wXqfmhyonukrbec4RYZxjl3BhLzk/2+/r5Vc+Ieht0X/TMgp2P2Gh1RfQ+m8cFeFHPxGnofgZGy5HD7L4HK3PmvDLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751406; c=relaxed/simple;
	bh=qarvGPIXqA4kc0VRJVXX2DsO6Wnlroa5YHsjyH+FLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTBMkLj9RXFMwjFqwR62DVekDW83KCYWAt3Op708AdwNHjHP0noS+VqOW0jvhqULGSRAvBrYNvHYv/1+I4x3+gCRrIDheUrk8G5DelzugpKqlIVyaWf5Yc3yq8Fv50MX5CQpG0DKi2JXZ/goO3IEE0GUg/cm0XlAUIikc8aJuAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KPf+Dnax; arc=pass smtp.client-ip=94.100.132.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KPf+Dnax"
ARC-Authentication-Results: i=1; mx-gate04-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=KYptHwQxYppzTfCWVdL/R5bMHuCmx/luf6VVt6namUI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759751362;
 b=BcfORPh31icY70H1K7KigT7SAtqsVDTsQjTqi5t445qQhJik/176SrNV5c1Em2eqEhH/GF5m
 zP1sWdtn/3mrx0TkuS8VMii2KZ7d2HciFRtJpRIEaKBFVYOPtrnrfHxihGTi0qjMDgMNsrSM1MW
 8Y07bs08CgrEHnKUwUr2e4cQrR5q/XrRasS3Do9dL2oQ0Bnm/5dL6Mbs7PNy0yVnlFH7vja+/HU
 UI6ET+oQZKNonxdF0CVf0krMGt/qfEfI12g2RQ2D8EVkfWRKv/pKfH8h9H+28XuEpm13CNSqFvr
 xCZbExBl0PZxryPDbyLEuZiEY2DEf73f72xUCqnV82esA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759751362;
 b=fU+bnyk4ruRuyUKmEybm9IXoUI9mHEHbK1Or+qHNXT1xdOGsZIWeDFpnw+dX/Dgz0s3EJ+PV
 uXw7sWY+GHa9JBtDGW+YwsuieuHsuSwcOJ6vv0mAiEYK9jA8GdWHKQU4ObfJwdTwCcSDfpu47lX
 YU0WLwZMGmCNglM1JE4K/rY99o6j81jhmtT+9RBJ38DUNrpRTxkDzHVHqeTIwkxwbFQ9tCZSG7D
 iKqYcfXosfuHD2jISdEubmLpESTpRzuyK9T5iqtqd/JFUR6rpcjAAY0C+vfSOHanlIIq86W2wkt
 U/Rm8BHiS8iPofnKgRqsqW9HDz6Nvs6mQ50QSSCQXybtA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay04-hz1.antispameurope.com;
 Mon, 06 Oct 2025 13:49:22 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 4F5EC220CF2;
	Mon,  6 Oct 2025 13:49:03 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon,  6 Oct 2025 13:47:47 +0200
Message-ID: <7691a2ca5ed49da6276d406e5dd986c91f221c9b.1759749553.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-hardening@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay04-hz1.antispameurope.com with 4cgHc010rQzS0jY
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:b8a1cefe5a1b3338a1f745c2baa9dc55
X-cloud-security:scantime:2.278
DKIM-Signature: a=rsa-sha256;
 bh=KYptHwQxYppzTfCWVdL/R5bMHuCmx/luf6VVt6namUI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759751361; v=1;
 b=KPf+DnaxEUQFvW/TnLEXXcZbAcM9pgb7AjS2KswEib6PH40PiRQ2JfScuyQ+SmiaosZBsbW1
 87E0UsB17vwuV8csObrfFTo4cp7a3zqSWFoYXd0LJ+W8ifHqVOarV70fLgA+Lv8XXOPEb5F6XMz
 OIv1ICG0eDt9SwkBeAehyVRYGX+MVwbLbIS7KEVZMHnXc8LXdhoU73GvBYGV/BU/0rbs2l2lG4o
 XJcQ94PWArazjcQ9jmP8p8DgSvC+Ot4j2SJuWhE2QwbEYz3GCPMlhZlkVSHZAXQ8JH2McSYtjE7
 /KjT0H73UG5mwOmd+BZoWqEsoB69yef/0coOXiLboqepw==

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 0105dcda6e04d..ed89a7a36e1f8 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -89,6 +89,13 @@ properties:
           - const: toradex,verdin-am62          # Verdin AM62 Module
           - const: ti,am625
 
+      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
+        items:
+          - enum:
+              - tq,am625-tqma6254-mba62xx # MBa62xx base board
+          - const: tq,am625-tqma6254
+          - const: ti,am625
+
       - description: K3 AM62P5 SoC Toradex Verdin Modules and Carrier Boards
         items:
           - enum:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

