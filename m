Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757711B3925
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112539; cv=none; b=YW/lhUJvivQafb08YBZMs6UQDcgouqJc92hopmO4tSsUi7wk90UNlr4c8twDWD6EBXzoEmoWSLWMFMi68otznKJ1vXtbmFYJDBaMe1E8zIlB01lcNaFIzObY4kx24UyXHs1OvnqPtjvGFNEI5Wic2Ci5Qs2Crz4qnQrRugz0DEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112539; c=relaxed/simple;
	bh=muxODD1niwzljlOtd8iFf5Z19qc+FyKKexUQAn68bzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGIXnWpAFFUYzZ6KatYYyNtZ64dbgcFvgi9PkHrra2eNvWWLvRwPEZkMBQd66j2beeJVYl5HrbYHztNWu3Le/loe5QMretB/gyWzwQ3yQ1FnlpP5HdfGcuQg69YgseNAMI6VdXKCMaGtUV0tZZQENX0q9YfWPx3+oJE9LwA7h04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 68B7Pqp8008672
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 15:25:52 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
	by Atcsqr.andestech.com with ESMTPS id 68B7Pa2M008517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 15:25:36 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Fri, 11 Sep
 2026 15:25:36 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Sep
 2026 15:25:36 +0800
From: CL Wang <cl634@andestech.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A .
 R . Silva" <gustavoars@kernel.org>,
        <tim609@andestech.com>, <cl634@andestech.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
Date: Fri, 11 Sep 2026 15:25:23 +0800
Message-ID: <20260911072524.1297406-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911072524.1297406-1-cl634@andestech.com>
References: <20260911072524.1297406-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 68B7Pqp8008672

Document devicetree bindings for Andes ATCDMAC300 DMA engine

ATCDMAC300 is the IP name, which is embedded in AndesCore-based
platforms or SoCs such as AE350 and Qilai.

Signed-off-by: CL Wang <cl634@andestech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
  Changes for v6:
    - Rebase onto dmaengine/next; no changes from v5

  Changes for v5:
    - No changes from v4

  Changes for v4:
    - Use items list format with descriptions for reg property
      as suggested by Conor Dooley

  Changes for v3:
    - Rename DT binding file from andestech,qilai-dma.yaml to
      andestech,ae350-dma.yaml.
    - Deprecate IP-core-based compatible usage and align with
      SoC/platform-based strings.
    - Dropped Acked-by tag from Conor Dooley due to the above change.
---
 .../bindings/dma/andestech,ae350-dma.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
new file mode 100644
index 000000000000..f040a2bf7d4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/andestech,ae350-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes ATCDMAC300 DMA Controller
+
+maintainers:
+  - CL Wang <cl634@andestech.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-dma
+          - const: andestech,ae350-dma
+      - const: andestech,ae350-dma
+
+  reg:
+    minItems: 1
+    items:
+      - description: DMA controller register range
+      - description: cache control in IOCP controller
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: dma
+      - const: iocp
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@f0c00000 {
+            compatible = "andestech,ae350-dma";
+            reg = <0x0 0xf0c00000 0x0 0x1000>,
+                  <0x0 0xe8000000 0x0 0x10>;
+            reg-names = "dma", "iocp";
+            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+        };
+    };
+...
-- 
2.34.1

