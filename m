Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053301;
	b=mIJH3UqbfH8jZBvaxZKq5Z2tURwefF2VN5wP1aXAJ90qLOZqKaNbyAKHdtKujTdjxsmb
	 pqnRORiXP2IM37zWWq78qAZqTS5BXLz9ZxRj5Sh3I9agZc6PZRXlKEJ2edNuyQMRsDEik
	 +4mgFq1IutiJEqvpv6JNfCs9tP/90k5/QyknyQ9dSXq7tM67mx1xIbvuqFCc28CuM4PfE
	 0Wl33eBetDZsKCfs34jK/e50Dzl+KB83786g9+CFg0j3UNBHYsCSFgIfY/S902KkRBOW/
	 hNsOInFFb9/DL88TtxH9BLnxQmP7+lN+aexXgWDUniokyu4ttA8bL0fWaLCgWylRaBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tjBxBXExyy9WLefYOQ4nHcOgOQ5o+ZNc0xlxhA3bZ8E=;
	b=jyIr3zahW+wkT0saSwQt1uqemNQD5omvkjQ2mf2SS/Mf3VloFloZCB5cMkJbVm1F/LfL
	 So8TCM3UIYJwGBx1KXNV1LUG6glvJgaD2YW12KCYF3Z31uHObGylL65yQQCRr8+gjlhPM
	 FYypC0zg17/QppRaPOi4p9mlv0isC73Ltl0/kNQTd12sJRexpzCGzeBs/Tj2PKqhPuKkl
	 kx0kzN/9OIipQejXp/LVJT/svAcDEr/D4sSFNsKwPPIA52BGuSx8sNbRnDuFOvDlxbvha
	 78Qwyz+7W4m4im1j09hwCcqzBj0i3bN459aMopFFYslcVPAuc4KNJ/yk00fS8S7n+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiDpmAby;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831860A2616
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 01:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6831860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiDpmAby
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1091283a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2026 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795053300; x=1795658100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjBxBXExyy9WLefYOQ4nHcOgOQ5o+ZNc0xlxhA3bZ8E=;
        b=yiDpmAbyEafa+Bp5TnuXax0bY7p1lXAGnYEyqXmuMV5ajdev7k2TECoemjX6fe/7v5
         zsDZNStqvnScyh0UBRWmwPPMYLYTkH9ZmmYesSJ60RChor5miC0PQMXYt8iEBxgYWCQ+
         RH1ZSrSSH2T8DEWV/aKxc3aR/yxQBE3obLRAcmMc0R33nW8Xdw2MFLtXj8KAct24cV5k
         caDScZtQPTVTY4Pg0cQnfOZyjLVOBGwZTWMcCExLfi+dTfyCnH/UxqB8M1h0kFItcgpA
         r/30T6Bu9zQcxrqzQ8K93WwLadVtLD3LQk/w0r+hOi78DK19M/4Acx/Fei8pmpkpDYfY
         Ry5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795053300; x=1795658100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjBxBXExyy9WLefYOQ4nHcOgOQ5o+ZNc0xlxhA3bZ8E=;
        b=kJLe6ZyyYPUWCLcn4LEHKkRGnwwpQpNM5qSzYVpApSqcOBlb+ano0NrKNyfW6nvQqa
         tif7DGrQMUbRePT9a8/xNlsic9eUmNI2H9Z0ku9Le/xCW1DNE9z9SuNcCRjDlsqWwHaJ
         xPhtWSh1xXmpr4oJfiPxgTnZe9U2p+1ayIEps+7uxiXq6OKg7rigwuOYlD5WslrplvNs
         ApwbWgYwaqHphZmKPA0f6e3M3MHTwj8C0IFZOQMKT9tT52PIXZLCb4sBiXH+sFpUUrhE
         aum3B8M1vliKfdg7BrjBuIuxm5hj3P73o49Re7NkOKNYXEapdJu31mbxC4HVla5+wfrV
         bVgQ==
X-Forwarded-Encrypted: i=1; AL+hErHJKdd0QPF7XZyAYIjPvbbnVwQk1DPv7+aiOYm/xT2bVfxH+zA7O9X8K4nTLaJhLnCPRw2bRI6WSW2F/LivIPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yieRPS9qRP3NhGcRN02Nc/eiouPE/H5ATxwYwv0UuvugCU86O
	p24rWBggiT0iaoWOc4oF0JHsWChfoiNUjnLbZmFGGw+nRtVUBzR9a6Pt
X-Gm-Gg: AZFdTZcDnXRe0blEnmlc65vctpTGaSPNkyn2pZf6cGazAsbsuEjAT06UgWTvSrWU6Cd
	aU5i50hWAEuPNWFMV54s+WsfnP8kg3a5BLJ+vMc77S3J08oBnO+TiF0fnrT5HWigZvpZ9rY153v
	Lve1SQGwpdneC7rhyLWFsbpKoVF7edUNOldcCY4R+oBEox2OnAb/CLce/RSwoL66eBVV6eK+pxf
	c4MA/lcMix/UPOA9fpRkWoOioqF8R8nFYON1J1mACeUaYmIWK9HHw7rxTtJxFDlg2lrq+kvPdwE
	Rly4Pq297fh3/UO5+SE3dZQRFo7cu47HP3kvLdgCRQv/NCRI7ZBrGW0rpTo+7yyt4xIB/qIX9CL
	/GtWg6ytRJgCsdueAzLwEx2Kyc/Aj0WR+xwVqMhik+CMS4VGulZaJaEQsNCXnzFtPsthT0PEZO0
	YrlHJpQNx9aEFl3zgvFmGljXlW3dLlrfOb6o4bVKXdIth0UkqhGvNUMRhRJlWnXSmsRAHFToQVg
	tdj/Nu46dmmrtk27u5b+vNdjgNDmn5+Gd0K+91T/XC7gZiwi7VBSDhD2fywIsuknZizJCTKfW5Y
	bzXksacP0Ey2Pwt4ILZkiqFkRaKJ4QYLqVYwUtnB2IiHiyelgra/TWq0hC+GjQUZl60Zz8tQIzz
	qLpeZUdmFXtxg1tA=
X-Received: by 2002:a17:90b:3d8f:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3b3d07cd7c6mr4085733a91.61.1795053299722;
        Wed, 18 Nov 2026 17:54:59 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe03c3d4sm773081a91.14.2026.11.18.17.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:54:59 -0800 (PST)
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
Cc: Shan-Chun Hung <shanchun1218@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document MA35D1 PDMA controller
Date: Thu, 19 Nov 2026 09:54:46 +0800
Message-Id: <20261119015447.160470-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119015447.160470-1-shanchun1218@gmail.com>
References: <20261119015447.160470-1-shanchun1218@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

