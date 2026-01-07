Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9EF28C00D
	for <linux-hardening@vger.kernel.org>; Wed,  7 Jan 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773709; cv=pass; b=Jp+XminuEAaUibt3JZ5d6gMvCaKJbKZU6q35Tm2OZMxsz+8eO52Kg/ywI4jzu21Kf2hhvsFO3Ebqmw7hPE8W0CqCki1Usq177cECwXb7JKtGsi+qqHUuUpsSZIbb0JS5jawCA6T8t+8U7ZCeq8P8KFZEH7e6PtBvWJXf2bXD7Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773709; c=relaxed/simple;
	bh=ZpgnAP5wX6GgNZjloXb7hfCChu/j4seBkUO44tt6zPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk7scpC0bdyzMj7nARvKgmAZk0Rti2V6mYACVv0PM/8KVXm2eIKmKAgIMR+zGZM+xwFdzrXY9xuDq2Sl9BQh/uYQwTwMqUarIl/nA6tWlhki+uivgHfAIBEOF/yuc8faeNNhpEAs9AFmndUHwGy/YUjMM4DcEAVL4nSY+dmI2pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AoFrLUsk; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AoFrLUsk"
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=+vMvOlrPgjkIwmEXFdQz2Q2ubA3EDVESm5G8NqGI75c=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1767773678;
 b=Z4v1Raj8Vr0mGrGuG/u9iFFImRzz5SG0+IyKH64rOKtc/N/dmJr0cpKvSOzP61z8rpug5Nqf
 NBZxcF7F5sl7IxPq3rT9Wqz7oIJQ2ccdU5aOu3G77guamhh0zvGPaCcWq8wCEzYXwsYdUx9LWKo
 4Y24mWXzKsmiIHaO8YQxKi+dlhhhZndS+nvbcx1X4v7W9DRcTkZ8MOJDeOdoNz4E/5vhZit06xr
 qr6Cxz/trlu5TwqCjbTHMbXDc958YtvvJiiWLmOiBHauiRzGmRdLEyfR6a3eVV2kwzOw4oMEmYw
 UNz7wvkxJ3tI37aTusoBSs+6Cw+E8J31dxJQaHP6kmX6Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1767773678;
 b=PpHBh2GD+NUDbf9MHMf51Q+AEVb+Z/iWtwEeRzikAA1dtEuWXcdIzU5lErLF5rjs18xrtBiF
 ZMFY1NjcV21yYhUNVp+LkkJpke2KjOVsC12AEI6nBBNro0d8vxohgp0NtfWpGdSKAr0jie45PqC
 ISTPCAdcNa28My9Gw0NlGZU3ZbnWhwAn2moEMOLPro44eDvmqgGQ8cp9E09u+LMpjyalYTVGwUe
 eCkMZg0f65TtYBGNtSgpHnzze01WCQZz84DSSuLMH7kT5Npn50iY+p1fCg82iebcM9KeGjsezoK
 GILE4B3eYz0lDMLJwbRBwhP/hNH2MY6cI2yPlcAWXitRw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Wed, 07 Jan 2026 09:14:38 +0100
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 673DD220CF3;
	Wed,  7 Jan 2026 09:14:22 +0100 (CET)
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
Subject: [PATCH v5 1/2] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Wed,  7 Jan 2026 09:14:01 +0100
Message-ID: <510c681c6428a9470c2b3710e4e3b399c2886d76.1767627010.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767627010.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1767627010.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4dmLRM1WGdz3ybNh
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:bd7b7d3b06095a7435fa3d9b1d159766
X-cloud-security:scantime:1.841
DKIM-Signature: a=rsa-sha256;
 bh=+vMvOlrPgjkIwmEXFdQz2Q2ubA3EDVESm5G8NqGI75c=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1767773677; v=1;
 b=AoFrLUsktwcjIo+wjawwKQ2CCeK8QXFuNyj5gWn3ykQ0jqCeOb4eHrhv3R5/332JKJrLIr3y
 d6jl/UHySIT1hKsYhN3WS8z5o3vPAFvAQ/BAAodjA1Xaju7tIKYdHsTYE8rKS4spOiyCDGaFlxF
 9BK8NXbbUhvCHAp1NzQ2+YTnH8P4nESRJOk49gfgal/+XyRmVeHV4uDr41PKt+zdIxx6tIJNf7n
 rG2roQuF2TameBB7PS+A48H73MUa1BlXKZZ2XL4Q7PQrRlpgxntb4vcSmPxM05dIBUIHWgWTPsD
 ixurHEJMf1K3CeQIEQn99m9xqt17bDoVnyEIlEfs74uUA==

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 85deda6d42920..f1b6ef98714f3 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -95,6 +95,13 @@ properties:
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

