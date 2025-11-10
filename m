Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BB30AAC8
	for <linux-hardening@vger.kernel.org>; Mon, 10 Nov 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775466; cv=pass; b=P2eqAjUXA7hjjfUzig+xZ09/i+RA2C0TZLMoeEUjPXHFNMTkRamgYBZ7IuSoFq6FGoe8bEsKJhmSEh2PL+APPNulh4kwp/Wd6wiqxMFKDkhP9ugBTE2SPa58JxQrNbuLiigGjfzfKwJcp8W8DKxKiyc7ZbTWz85KPRrCJ7eDn08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775466; c=relaxed/simple;
	bh=HXlBxqOb74Fg5Giay0IgvqZHwM52eaS13jG1nIa4SVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbKEV/mQvIu0XzRNPvTkDDaKyITwa9BRxjGi7+W8Phhh2uitn8YsxUXObr+438jP/r9GfZH4ALs9Qud14zNlsnavrywRRFu3x0d7E+LR6G5P3YRuIhaoIU4WaYo5BM0I/Bmj1RPCR+s5llHJZuE4BknqB1lnI15dC/iM19iT3+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sSMvFP9c; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sSMvFP9c"
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=EI3VncdrDlFCBHgHP23iIzteEuQaU2FWB5CYdMi6Jhs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762775422;
 b=cIg/tpq7q/AUaI3e1aMRFNWklJLKpB9T9SKthGYeSAXXNyoazPlDzPTdeX5FUvnMpUavO/FS
 hjhUMWDBGRmNI/+POe3ttnctL0oDUYTQ49McoWJnyQvHFR+scA8iyRQDm2OZNpfLWGFC4lC6k/v
 LNk/7WWOfjUdpvCYHAkrZQT+DreilG7xm+rztMSUYOq+T3xb3eb6ZH5mNDXvqsrDhdPKyn6FmBK
 9xHgKpY1mSpqh8VUycmg6xAE13iwdqMELXV6FAW76iCl84HBss97SNXvZw0q1kHpThnRvyPORA1
 jp7kUhuL+oY0DyemKVBh1FcYDZ3UQEbhUFwtVxPWbjlsg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762775422;
 b=FBHzdQc85HxoXDaknX4otuPgpiVR2PNgNjwOjHXoU3QGJUJyiUo6t6fl8AqpP7oUUFf3zrgZ
 679qPu1G3VSeX1iSex7SjE8Z62i4yI1RK+X9w4y+qRx4VMel0AHVf5sIhexFVVti5AlyOOhqyY+
 UVDkNw+tFw3JPd1DGEv4kPuSodzcZkAAO4brgjQIRKHgKq1z1Ww/zj0yXq9zR8plY3eNLwW6zqp
 BrZfP+mN6dgl0tVYJZRD0+gZgYxWGNgDBrs+L1lgQVqpMxAYFJTneqfRTkK3OGaa3adrke8FHA+
 SPNKvhofZszWpe2+318xGu2RGK0vzcACib6SMK6P9GMrw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Mon, 10 Nov 2025 12:50:22 +0100
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 57E2FA40F9D;
	Mon, 10 Nov 2025 12:50:06 +0100 (CET)
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
Subject: [PATCH v4 1/2] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon, 10 Nov 2025 12:49:45 +0100
Message-ID: <18471e4c907e8681248776e3674e22075e25a50a.1762775119.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4d4nz31Pkkz3yYR4
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4ec77760357b01082a9b811132bbae09
X-cloud-security:scantime:1.896
DKIM-Signature: a=rsa-sha256;
 bh=EI3VncdrDlFCBHgHP23iIzteEuQaU2FWB5CYdMi6Jhs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762775421; v=1;
 b=sSMvFP9cCutjLx+UcLtkSX3jhTjZZ/x5nhqxjJpt9H5OUUvHakB4fkNAJBAYn8nU69cSXilf
 e0niCWkPuhaBua3Fl1Ac1CaGxMVmzTVoVH+cdwJruphiCtF8bfMSp3NPrf90Y+lvE3bm5887Qhf
 sPzwTXsp4xYeMsJ83n5wIL5VkfRpugPaF+xEE0FaKRnmDKgGIitYASBH6Feia7i9gxhz+hJt+ek
 1LaPJxUr3DIePYS6+Y+Kv/72HdElr/D4Oxhoh9P7J25XYGjhSUKzmAKVy054cq/c46uVqirnEOw
 jjFCniZDgiGn2k2rFJXejPtv7OnwTuBOO3WTFYylLZ7ng==

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 2e15029dbc677..cfa158dfdc9cb 100644
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

