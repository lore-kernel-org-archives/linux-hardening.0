Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202151;
	b=B85IhmhQlm7xh8mhIXJHcM4ONz0b34si/jl847+yZUW3+oRBIYVoucAoTOVUDEpoXlNg
	 0WZ//6AMOmG19ZuJTpjxmGpJjf0CuOfqGTnu/78CHw8bFRcAuzb8IcnXgvBjb6s4o5E+U
	 bQh4qO2HxYckuMak7GONul8YrZADfcGzWk7G/g0kMa5n+SL5t4iTCjtQtNB6L/aP7Drcz
	 5+mVQi05xEv9+LmHda/BKPCV1wOJflh8S4uZnCvaYWmAtOESi1Wr0jzRtx9NxFkedweE8
	 77dpJF7XKIQEqzlOdEx6xdpr7XryBnXDwxeKdS8xOdGm1zIZvXpQEWPIzMuscr2PjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+2wCtwxXKIDkxHcE0WIbk0DNcnVd4qsfVLWBnePcPdM=;
	b=Z0Fa5eJWLpZomp4qlQCVgDySVeJll5ycahtk/TDX1NZw49jxGn19UXfn6N/yBfgvm+m7
	 +1m/Pxyc6gKbamT/FIW6aFPUzk7jCl9JyVjywuBY+2sXzbr59KtS6v/SSmxuz79S2zJ8O
	 wa0XA/91k2N8+cRwCNUqhMOwKbLg9lah0ek4FufH+ceHjXu+MMpWuqNh1psTEIkaNXZwd
	 o0pC1yski9Mcjo8utLkuQRcbcyRAbJBXgD8x3k3vA7arhnPfAySX6qHpsIQV2f1B81kKM
	 aq03iL/fiZJ9IHZwQMizUrYRuL0ptoMsCwIx2BMwloJzlraKdW2x+3kmg8tDGyOoIYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LX/HvpaV";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1596606D80C
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 05:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1596606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LX/HvpaV
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a9f9473029so362798b3a.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 21:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202150; x=1794806950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2wCtwxXKIDkxHcE0WIbk0DNcnVd4qsfVLWBnePcPdM=;
        b=LX/HvpaVQDBWsfT2+0kqohS3rHoUvbJMJyHIyGTYM75vhqzY44mOOPLBOQOMGmRZMc
         fdSEenpF6UfrQx6rMyoOVZ4GED/c28nfS4NqAjp3hbg2HovMPvtZjFz89gtZh148mf3q
         3LbDIHsqHCVgGuemSPtTR4l/uaQUQKEtq0wP7k9NeoNPGOGNlwoBDFEE7xuLGjbXZihb
         IOewJOuL/zQ4bPoCjl4ncxrMrrKtn+izP4xIzIMs7bhPHeTn3ke2Ilc7N+d8OB6zPb2v
         G/+1KoKBborVG/JHGQzrZDgAmhdxsS5R/i6Bv7+cuGec4aS6QcdutHHFAz/GUUpNrum/
         9mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202150; x=1794806950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2wCtwxXKIDkxHcE0WIbk0DNcnVd4qsfVLWBnePcPdM=;
        b=XBnoHxvCrD2WwZJAhHrWKbcjCBbBf7UYA1m+R8+DbDecjSOGUt0tjKeUU+oxyIOfLK
         hrHwZsPw1hmx2dJ06dLLYpe6FsLq1JlD311RFsBmZL7zSOnufEg5RVQYZV3R0mfovGBY
         zTB18bALEskk9h2rnYxnGN8k5sgvWPHWwdtrL2KC2VFNwQYG4eiFDzr9J0DhN5Q74zb4
         RLOQXBV/zT46thYgwiMfecP32FWRVU9e0TkBrYnypPcvE0cyO+usgOH+5mcoUUfiHxIM
         4xv1SKOv2YQIjdm2ZX4e6OobopoQoImUeNyt3Nk9znMcDkZg6U5hjhjviX8AzPs5WQ2C
         Z7/w==
X-Forwarded-Encrypted: i=1; AL+hErG5StrNyYdi3W/oLpznWHnY8GQLgsqV5Ek4ubemOdYLZ3Huy03l7hJD7ZK+CVC9dwtiHtgVYW/YGuHGxgDtz0o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yPe0V1EkpuNmCiY3UKbwxYHh/odjp/HTenP2/lrsh5HrE4FZ7
	o1bbproVry+RRHvvywA/0S+F2hKiAvX0m+TkHfbI67Pg4nyDvHl1g+w2
X-Gm-Gg: AYBFou0dxBYwXpO7r3WI2zCCaKejXt21qc0B5mnFfMBXKXg0nUezMA+rGHWAsneVrnc
	0+bJ4nKKNmzAzHUF5QwmexfgcuIgo01WjvJEYhKxMTyynRvk0OZ7/JAUycc424vP7js1NVJ2hE1
	Mtbb58UwWZ9DgsuNtb3rCHWbgZ5vkp5Ec9OqrH34R76I6L6QiHcuvSgA1u1BpcmyueNBQnZKgWB
	dlm2nzmtC7zuQeFMVngjOvzAxLqGjt+gsNVsCCrqV0+T6bnk9aayLaCbW0RsUoYmrpZZ+SXhD7s
	Mlk/V512PpLTetgweEUx1Ojskb/vacL2kbqhD5997sI7qOnFzI1KLew6Dwwi7LEVVguIPc1BQP2
	5LR3tt/Bg1h+vwFUf/Vx++6aIvm0WFlyMxeYctyD0dlnYJNzVZ5MAwVtq3QLStr8XwaOYGsL6Lo
	PKZrSAi0Zx0heUsPqmmtMmNVuM1KILqUNum/SJe1CySceXDbBEEU4w8yS00sAR56YIbDwlWGtql
	4o+QzuEy2GfM8dW5TreoNmP8L3+8626n9MV3znyUbGM1JbmOewlahrTSBO5J9WoSOOMpz2eq9Pg
	vu0cn9ZY++0753MCX2w5CZsQZHvtdYi6LX6U2rxUH+lcRMQxhOyY0rWpxxbnryp45mW0vi9s8A0
	0VvBujSRBQSOhekw=
X-Received: by 2002:a05:6a20:ef1a:b0:3e5:904c:78d3 with SMTP id adf61e73a8af0-3eed5ce2668mr2545295637.69.1794202149963;
        Sun, 08 Nov 2026 21:29:09 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9681385fsm1180899a12.6.2026.11.08.21.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:29:09 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document MA35D1 PDMA controller
Date: Mon,  9 Nov 2026 13:28:59 +0800
Message-Id: <20261109052900.2960473-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109052900.2960473-1-shanchun1218@gmail.com>
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
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
 .../bindings/dma/nuvoton,ma35d1-pdma.yaml     | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
new file mode 100644
index 000000000000..d05971662a5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PDMA controller
+
+description:
+  The MA35D1 SoC has four Peripheral DMA (PDMA) controllers. Each controller
+  has 10 channels and performs memory-to-memory, memory-to-peripheral and
+  peripheral-to-memory transfers.
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
+  resets:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 2
+    description:
+      The first cell is the PDMA channel number. The second cell is the
+      peripheral request source number, as listed in the reference manual.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
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
+            resets = <&sys MA35D1_RESET_PDMA0>;
+            #dma-cells = <2>;
+        };
+    };
+
+...
-- 
2.25.1

