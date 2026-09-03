Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F6446BEF;
	Thu,  3 Sep 2026 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421114; cv=none; b=gjAjMgYMYs0/MK7bscHkAGqH8RPmgVQF3ksRoadWnosoD1dkWsix4Qn2bSVv+Kqh/k0O6G4no2bjBozsmvk43I9/Qt5Q6o4RHjpn/9k7YlnPDl1WeEL3HmBrEqt0x1VSlmaRgQKTcZbR2lxyIQyfxcIPPzTHv6pwaN2YI+wssuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421114; c=relaxed/simple;
	bh=HjPvIcv6mjvoHee2qbgEDrRu5g63yWG6e0WdNC6RalI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpUIwkNqTOTqslUH5iCvCyD0xFpNLA3peQBS52jlv+MfBbORjZrhE5Nz074FvY6VBq8S7rHOSJzHD4Y13/mwenPpGen0iyS0Fw2U2I23WL5+yBtLf0V8iAWagbhfY9Qwjkm+fBZQrLzKd+C5K7mpGk6j9Z/2Pan1mArmgaFJJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nceSxOq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nceSxOq/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0EC1C2BCB8;
	Thu,  3 Sep 2026 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788421113;
	bh=HjPvIcv6mjvoHee2qbgEDrRu5g63yWG6e0WdNC6RalI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nceSxOq/QoQdUr7Z2Z6FR3kOTS6K4qSvvdDp97zOokApqpALC1YtJbiMfFeWQmgPl
	 fEb4m1H5kLyd3R1s28ksYPxUN0lgmSHHvhKNTlGNGOb2R+SSKhnZFqmyaHM0Ai/N8g
	 qqFOrF9QalwYE+3RRjWcrSfo5QN2S1R28uxo6T/AKeNl30YUC2s6fuKa/rdOQr+G4z
	 25co915K5kf6vvvMtsU6QqXsDJz73PZyynwDxSOAS4Jx20rvjUrBobGDotfcyDrJpS
	 TEdNwHZRQ48EG4niAWM0Ncm1M4RGVI2vrCgqr+t+J8RpgaNfzCDlsZBl56uPOTGi6x
	 V+XMK0xTnbBPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F154C624A4;
	Thu,  3 Sep 2026 07:38:33 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 03 Sep 2026 07:38:28 +0000
Subject: [PATCH v12 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-amlogic-dma-v12-1-f769bc344056@amlogic.com>
References: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
In-Reply-To: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421111; l=2958;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=cKXRfn5UIkIE+VJAQBEmrP1PxVr2HXEVLluheUBFB6M=;
 b=qt5qMdoUGiRul8XXXy22i1WJFHMJoNkUhAkAuUHAx63iLtZ+ll5g/flx2wApiurns8C6dOIzP
 b3GJGM7RmYHCFUIYmDBk3BH7VWLxShxH8UIHVOS/xpI82FzfImCE/Hf
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add documentation describing the Amlogic A9 SoC DMA. And add
the properties specific values defines into a new include file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 68 ++++++++++++++++++++++
 include/dt-bindings/dma/amlogic,a9-dma.h           |  8 +++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
new file mode 100644
index 000000000000..3e1a4fba3047
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
@@ -0,0 +1,68 @@
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
+    description:
+      The first cell is the DMA channel type(AMLOGIC_A9_DMA_TX or AMLOGIC_A9_DMA_RX).
+      The second cell is the DMA channel index.
+
+  dma-channels:
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
+    dma-controller@fe400000 {
+        compatible = "amlogic,a9-dma";
+        reg = <0xfe400000 0x4000>;
+        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc 45>;
+        #dma-cells = <2>;
+        dma-channels = <28>;
+    };
diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
new file mode 100644
index 000000000000..ea7c90063572
--- /dev/null
+++ b/include/dt-bindings/dma/amlogic,a9-dma.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+
+#define AMLOGIC_A9_DMA_TX		0
+#define AMLOGIC_A9_DMA_RX		1
+#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

-- 
2.52.0


