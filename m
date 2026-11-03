Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672539;
	b=DEwwF9hWn1s9/NpeQ6jw113cN2NAuewcbFQ8YRCE++jguvq5WC4DVavMaxk8pMRgkiNS
	 18o8iMchoBxnPzHUt7CzjsgfW80ug6wIvSzG2iJLcPIlYLDPXre3rmGL784R2OuBCBBik
	 BQStZ39cpnCToIEsobnXN+WpoCJy7tDNw+RYdKdvt78PGwcrqCTRbwu/n9rsF5LHQjDHs
	 L8PJzGO+Xnev42EAGtmRNUf2bs47aGryVrGK0Znv+yifZCVlozBY/dMUVyPKirrjVrTYg
	 IotMx+FACAI1WdwWfxFBo/KsyFZT9gzr/OHIXAn8JjtLtY1sy29GOAfdmQQLByg/twA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c6o6PLfOQ/7KuRbl8bHOcYkGmLHd5N5tTbX+9m2iR9o=;
	b=a0T2jOywWHnDMJT+jemhNWFprAI5QDcUflrgafrW/XdtYE7U1dUr+IKLC+8CtQ4vzWx6
	 sV6H7pwOEe6KTum3GJ4LePz1nDmbEz7894twN2DALVUbGuZEdRhAa47xbu++ObJUHN0M9
	 poTLgwGsN8ONGwFxk651JDGhyXqOSRQK0F7BM8T82uJvB1CxsIFE8Dsx/mgsa1UZfaVQM
	 sdgKMefmJyfd27j1MuOYNMY2IBusSCrgko8pi/XnruH7rEeDeaWQHUoampdpvqEWiPNBd
	 RS1C++H055gaKbStA9FBUqTiN5Kt/ms4yeY4cg9VQbQu98L9ykywTnHjuzHm7k2VE+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2TT2Anp;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DA606A324
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 02:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1DA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2TT2Anp
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1301442a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 18:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672538; x=1794277338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6o6PLfOQ/7KuRbl8bHOcYkGmLHd5N5tTbX+9m2iR9o=;
        b=m2TT2Anp45931/GbpPEfD/jEZWQDpLLp5MNAFB0D+d4TLBq6QJ6swR9O39ofTgNgBj
         eqY0UTxeAd1ot3BtcdwpqCxipc+7EUclOjtxBtOHUDoqrrWVlaRzadNb+rx0SN/omHg7
         u/54ORaaNI78u0d1f3z1uc66QgyLMQcDIbFC7nBAnL9Dj7VwIuNHgb4agSFVXhvbMWcB
         tcCm0eS7lLEiivtuY27U9NhreZhMULytjVms5Rf/+zGjsS1pRDFLTXC2YmIiAO0tBHmy
         mleiO6f54qJ/uDQMTL37SvmwHAYcbmKnwHO5DX29ejGu1zl38s8FcOjPsPOSc47+USNk
         97cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672538; x=1794277338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6o6PLfOQ/7KuRbl8bHOcYkGmLHd5N5tTbX+9m2iR9o=;
        b=Vp3/l7q63zA1DRkyC0+MhxvL8zrlh0iitdCg4tCakWnjnZQhvNGE6djNuDMeTJ4rT8
         lTzUWacteLkTLRceb+shjD3OGS+D4BfVd7pQKmpTBrr1NJtG7Y3L6UksQmpiJ0GbcI5V
         vjQmHNYdSkrbMvt8Z+9NvJbUWoVNfQdsy5jXPqfCe+g7eIAZYjiwzXN5r8xbHG49mKZ1
         ioRF7018Kcp3lWGqUk7WzwPjujBhLlavuF9gHdYhrAQURwVLAlbfeAS/mp4ZfVgNLNLC
         0Sux6v6eUdin4y7bWYGEdai205A5cSuqSaqXbGBMAcZX16wN3VzCmHuILPFcyYQJN5dQ
         V87Q==
X-Forwarded-Encrypted: i=1; AKwUvBzLdAb/cA7soNUDrEUqjNOyW5aCiQj4V1ST6mbBeypLyQD2h3lh2iDpcbjnoGmy9JXB2bhGAh9HQXvUBclHZuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2TTwEOn0xWCxbMQ3aoO5F/I23V/g3x6yoMaP3nWICrsRF60dh
	23qiTm4NTOWNbJWoR4w92/cE2NmxyN5FPxYd1WAus1GzUyyvoxvRQ5Nf
X-Gm-Gg: AYBFou0IWmHQioWBoNGnMQyI+xDZEvBuVssbKvJFFwfjSaBntGd90eVUXUgCUGcRWDY
	TdzNXkPMt2dClyWzMyBEB/ODEAHX0zS9eou03XtSwcXU0ouRkC/HnOYHSh8kRD7ZeSJMbPGiKFh
	8MafrjfFBS4up9NW2dUx2ugFaTdkM6pBGA7tnc1KnrXTeVwuIesNwn0ZPFGkF//rOCBHxTVHjoM
	rLbxZEJ9dO0FJJGZ4W7qVuXo8PtYb8lmtg0RSbvhvGp1boIQBaNkMDnTqGITMZvJ95M+Sh49NcA
	pxVfEivGWmOLrmYQTfpTP/UrkeAkBX6kN9hS5UIZMtgRm9OaG0qrJvKP+afMvmUbg5MXiuYhzFZ
	GCQa1bvz5k7fpn+wF19DNh8kDGsBUsHbCA8jeZjx9MdHYq2iSOqj0gSWVQDgUZnr7M7WBjRvo5c
	xSof90ZRhVuypOBi5O8IRsjYCTznOcWiLbIwPeFmVpmUqNSY7MzSsls8wLNYNaZjm190KI5/1++
	ZFDBYRR/dJ9o5Jp9MCl9dxwzzgg+fWK4u/T7ZA9viCFa/1eGT+VZTe++pSZSYUiHMjJXZ0aBQml
	l6l74cY7gF/gap2X8rpJWvxahoPwnEA45TXpCA2zx7YSIvXdJXePBtEFK/Mm3LEE7Vf18YhIPMW
	r5cOUOwcA67wM1G4=
X-Received: by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3ae8953617fmr10497917a91.3.1793672537642;
        Mon, 02 Nov 2026 18:22:17 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm1570124a91.5.2026.11.02.18.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:22:17 -0800 (PST)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document MA35D1 PDMA controller
Date: Tue,  3 Nov 2026 10:22:01 +0800
Message-Id: <20261103022202.2139674-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103022202.2139674-1-shanchun1218@gmail.com>
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Nuvoton MA35D1 PDMA controller.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 .../bindings/dma/nuvoton,ma35d1-pdma.yaml     |  72 +++++++++++
 include/dt-bindings/dma/ma35d1-pdma.h         | 113 ++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
 create mode 100644 include/dt-bindings/dma/ma35d1-pdma.h

diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
new file mode 100644
index 000000000000..cd752571242c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PDMA controller
+
+description:
+  This describes the devicetree bindings for four Peripheral DMA engines to perform
+  memory-to-memory, memory-to-peripheral, or peripheral-to-memory data transfer
+  capable of supporting 10 channels, implemented in Nuvoton MA35D1 SoCs.
+
+maintainers:
+  - Shan-Chun Hung <shanchun1218@gmail.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-pdma
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 2
+    description:
+      The first cell is the channel number. The second cell is the
+      peripheral request source (REQSRC) selection, which defines which
+      peripheral is connected to that PDMA channel.
+
+  dma-channels:
+    const: 10
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - "#dma-cells"
+  - dma-channels
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@40080000 {
+            compatible = "nuvoton,ma35d1-pdma";
+            reg = <0x0 0x40080000 0x0 0x2000>;
+            interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk PDMA0_GATE>;
+            #dma-cells = <2>;
+            dma-channels = <10>;
+        };
+    };
+
+...
diff --git a/include/dt-bindings/dma/ma35d1-pdma.h b/include/dt-bindings/dma/ma35d1-pdma.h
new file mode 100644
index 000000000000..0ddc99d29661
--- /dev/null
+++ b/include/dt-bindings/dma/ma35d1-pdma.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ */
+
+#ifndef __DT_BINDINGS_DMA_MA35D1_PDMA_H__
+#define __DT_BINDINGS_DMA_MA35D1_PDMA_H__
+
+#define MA35D1_PDMA_MEM			0
+#define MA35D1_PDMA_UART0_TX		4
+#define MA35D1_PDMA_UART0_RX		5
+#define MA35D1_PDMA_UART1_TX		6
+#define MA35D1_PDMA_UART1_RX		7
+#define MA35D1_PDMA_UART2_TX		8
+#define MA35D1_PDMA_UART2_RX		9
+#define MA35D1_PDMA_UART3_TX		10
+#define MA35D1_PDMA_UART3_RX		11
+#define MA35D1_PDMA_UART4_TX		12
+#define MA35D1_PDMA_UART4_RX		13
+#define MA35D1_PDMA_UART5_TX		14
+#define MA35D1_PDMA_UART5_RX		15
+#define MA35D1_PDMA_UART6_TX		16
+#define MA35D1_PDMA_UART6_RX		17
+#define MA35D1_PDMA_UART7_TX		18
+#define MA35D1_PDMA_UART7_RX		19
+#define MA35D1_PDMA_UART8_TX		20
+#define MA35D1_PDMA_UART8_RX		21
+#define MA35D1_PDMA_UART9_TX		22
+#define MA35D1_PDMA_UART9_RX		23
+#define MA35D1_PDMA_UART10_TX		24
+#define MA35D1_PDMA_UART10_RX		25
+#define MA35D1_PDMA_UART11_TX		26
+#define MA35D1_PDMA_UART11_RX		27
+#define MA35D1_PDMA_UART12_TX		28
+#define MA35D1_PDMA_UART12_RX		29
+#define MA35D1_PDMA_UART13_TX		30
+#define MA35D1_PDMA_UART13_RX		31
+#define MA35D1_PDMA_UART14_TX		32
+#define MA35D1_PDMA_UART14_RX		33
+#define MA35D1_PDMA_UART15_TX		34
+#define MA35D1_PDMA_UART15_RX		35
+#define MA35D1_PDMA_UART16_TX		36
+#define MA35D1_PDMA_UART16_RX		37
+#define MA35D1_PDMA_QSPI0_TX		54
+#define MA35D1_PDMA_QSPI0_RX		55
+#define MA35D1_PDMA_QSPI1_TX		56
+#define MA35D1_PDMA_QSPI1_RX		57
+#define MA35D1_PDMA_SPI0_TX		60
+#define MA35D1_PDMA_SPI0_RX		61
+#define MA35D1_PDMA_SPI1_TX		62
+#define MA35D1_PDMA_SPI1_RX		63
+#define MA35D1_PDMA_SPI2_TX		64
+#define MA35D1_PDMA_SPI2_RX		65
+#define MA35D1_PDMA_SPI3_TX		66
+#define MA35D1_PDMA_SPI3_RX		67
+#define MA35D1_PDMA_I2C0_TX		70
+#define MA35D1_PDMA_I2C0_RX		71
+#define MA35D1_PDMA_I2C1_TX		72
+#define MA35D1_PDMA_I2C1_RX		73
+#define MA35D1_PDMA_I2C2_TX		74
+#define MA35D1_PDMA_I2C2_RX		75
+#define MA35D1_PDMA_I2C3_TX		76
+#define MA35D1_PDMA_I2C3_RX		77
+#define MA35D1_PDMA_I2C4_TX		78
+#define MA35D1_PDMA_I2C4_RX		79
+#define MA35D1_PDMA_I2C5_TX		80
+#define MA35D1_PDMA_I2C5_RX		81
+#define MA35D1_PDMA_I2S0_TX		86
+#define MA35D1_PDMA_I2S0_RX		87
+#define MA35D1_PDMA_I2S1_TX		88
+#define MA35D1_PDMA_I2S1_RX		89
+#define MA35D1_PDMA_TMR0		94
+#define MA35D1_PDMA_TMR1		95
+#define MA35D1_PDMA_TMR2		96
+#define MA35D1_PDMA_TMR3		97
+#define MA35D1_PDMA_TMR4		98
+#define MA35D1_PDMA_TMR5		99
+#define MA35D1_PDMA_TMR6		100
+#define MA35D1_PDMA_TMR7		101
+#define MA35D1_PDMA_TMR8		102
+#define MA35D1_PDMA_TMR9		103
+#define MA35D1_PDMA_TMR10		104
+#define MA35D1_PDMA_TMR11		105
+#define MA35D1_PDMA_EPWM0_P1_RX		110
+#define MA35D1_PDMA_EPWM0_P2_RX		111
+#define MA35D1_PDMA_EPWM0_P3_RX		112
+#define MA35D1_PDMA_EPWM1_P1_RX		113
+#define MA35D1_PDMA_EPWM1_P2_RX		114
+#define MA35D1_PDMA_EPWM1_P3_RX		115
+#define MA35D1_PDMA_EPWM2_P1_RX		116
+#define MA35D1_PDMA_EPWM2_P2_RX		117
+#define MA35D1_PDMA_EPWM2_P3_RX		118
+#define MA35D1_PDMA_EPWM0_CH0_TX	122
+#define MA35D1_PDMA_EPWM0_CH1_TX	123
+#define MA35D1_PDMA_EPWM0_CH2_TX	124
+#define MA35D1_PDMA_EPWM0_CH3_TX	125
+#define MA35D1_PDMA_EPWM0_CH4_TX	126
+#define MA35D1_PDMA_EPWM0_CH5_TX	127
+#define MA35D1_PDMA_EPWM1_CH0_TX	128
+#define MA35D1_PDMA_EPWM1_CH1_TX	129
+#define MA35D1_PDMA_EPWM1_CH2_TX	130
+#define MA35D1_PDMA_EPWM1_CH3_TX	131
+#define MA35D1_PDMA_EPWM1_CH4_TX	132
+#define MA35D1_PDMA_EPWM1_CH5_TX	133
+#define MA35D1_PDMA_EPWM2_CH0_TX	134
+#define MA35D1_PDMA_EPWM2_CH1_TX	135
+#define MA35D1_PDMA_EPWM2_CH2_TX	136
+#define MA35D1_PDMA_EPWM2_CH3_TX	137
+#define MA35D1_PDMA_EPWM2_CH4_TX	138
+#define MA35D1_PDMA_EPWM2_CH5_TX	139
+#define MA35D1_PDMA_EADC0_RX		146
+
+#endif /* __DT_BINDINGS_DMA_MA35D1_PDMA_H__ */
--
2.25.1

