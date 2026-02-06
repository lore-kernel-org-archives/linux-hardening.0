Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B36346AD3;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368565; cv=none; b=qQ3DMgLjAzwgSbLQ1OPFbbJa8vm7PRf97HQHNcWnjKgdudGAVKQmItrknsS1hK7phlxCrfMjTW0ASfVw9u5FxYceBNDJXzEyUHjgVcr2AqJhyPSnzYOGLXd4+t6Ug7k1fkiKh4gaeDRMYWkb/6y8TeO+JZ/LvDhsBBIxaGq0cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368565; c=relaxed/simple;
	bh=OO2LYP/Tb0I+6e91AEQlOJswJ6g89wXPZXWxOGQ9iPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stCA9308Q2pmwdM0G+a5c2j8XT/vOjcTT/VTLqU2JFD0duDfKiNOaas1MV/xbAjUuJ1gewM7LqpQPBX8ghEZkAPzbajBvAj7q8QexakDsNgBc+lXFqZhHO2oK078ZMWVmBCfGZ4KEbgn1gqYXUVKthZL03F0bF/Vqk+u7sVLsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM11LzYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM11LzYK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64912C19422;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368565;
	bh=OO2LYP/Tb0I+6e91AEQlOJswJ6g89wXPZXWxOGQ9iPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iM11LzYKO90GFll4q8N7flSMDKe8xnB3rKfpCdaI4D/O3Z9PVDhFNdga5QIkOBA9G
	 NAViS/Axsnp1vp0rQF2YoWv++pNwKS67SESau9Xl4WEkQH8vw5KJbuyHdkO2pLZbq1
	 ktviTxwayO435YPIJsUzCBvyR9tlANukpJ0uQLKdQUvPYHqPOzSmgJHTmyjg6TGLqe
	 aTclwTx58MJYpXGSBd1wREOuaNzRQLau7v08n2a/Eo64LTJdxx9tsioKdMEsH8BWAf
	 RqL+WXfHZn4LfutHWNBlYenjidrpWsGOM71bIZfG8HLE4rSZwPOd6WWBhY9hMbOHd6
	 wOjeri+vcPzyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA7EB28F7;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 06 Feb 2026 09:02:32 +0000
Subject: [PATCH v3 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260206-amlogic-dma-v3-1-56fb9f59ed22@amlogic.com>
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
In-Reply-To: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770368563; l=2154;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=KKG30sNDMKwUEsaooUR8f4bvhWXtqrK9G8Cq30l/PK8=;
 b=VFLaFNwFVnC8YY6CLU/Fo7QfyXgFEiGUj6Y87skZ4P+CkOzgR+V6fm3X7G5ehMWzPeYMdk4AC
 UchpQ8Au+WUADJgcivRZyux8uzbvqYGEd97cjBHBZD1ZAg3ZkdDF8Wf
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add documentation describing the Amlogic A9 SoC DMA.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
new file mode 100644
index 000000000000..3158d99a3195
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic general DMA controller
+
+description:
+  This is a general-purpose peripheral DMA controller. It currently supports
+  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
+  for the same peripheral use two separate channels, controlled by different
+  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
+  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
+  there is no significant difference.
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a9-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sys
+
+  '#dma-cells':
+    const: 2
+
+  dma-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dma-controller@fe400000{
+        compatible = "amlogic,a9-dma";
+        reg = <0xfe400000 0x4000>;
+        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc 45>;
+        #dma-cells = <2>;
+        dma-channels = <28>;
+    };

-- 
2.52.0


