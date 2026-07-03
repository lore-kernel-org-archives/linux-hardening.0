Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAE25228D
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044669; cv=none; b=RTmUGtDyY/Ys7rI0VBDI1nnDcjNiSlrWTsnHY5bsqZAxPbhZXD3HTWIXuqq3578c+ua0qyvqYRj9i96cgAsoOh/uCV3jJvosAExsl0OKsoohNyQB2Z5IgEG7OOzK/g06RU0t8/63GBN9JGR4jiASkW5HzJIwcZpR+fJeYYMq7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044669; c=relaxed/simple;
	bh=aS6ha+d4/ARpImKQaz8GQTHAOozMF5z/u2rWDl6rRGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHJHulf5cBOhJ9akNThJgsNuLoIxTNv455jSEwFrNTVXJZA4PNdxKklmAMVtW29B19DAbpuw56adT847ate8uu2/xeec5LApYjBf4ye4zNeae995KPJTww/3q7Ryog3RbEhKKmRpIyD8Oc9z34brxXgPzO5EwhqDz8BsI2H+t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUyWnSmw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUyWnSmw"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37fcae0ecb3so59702a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044660; x=1783649460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLtOt0nYZtjUYJXDOkZT3LzWT/GyJY005mggTmWgITg=;
        b=aUyWnSmw0qDxV6iSXKHztRrmoowG+XP861c0WYExFnYdveaIUZt4HM35cjlWujPCaZ
         V2MAm6wdCifwQ/M8M7decRTPBsZ5K+9d2cKdsl71j9N129vapA+PxvYc+leznFoB2PFY
         kZuYvlrT6F3Ne9TePFiYw4dGdALY2qdKOOD370403r/cKxkXmVYQzHEMneANyd7xYBX7
         8x6RMUcWBkMKaK5GjMrKYlUJiOJ5QLhRFHk/DeKIL6LkID3eQEPBg0cgv/tmx0ZbqOmy
         dmUH6twycPifbQQLBlGAu4RdmaXfn/jyEOiA6xMKvJJBZ7NaPM6H6bUEiMNqNHVgj8ZA
         YxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044660; x=1783649460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLtOt0nYZtjUYJXDOkZT3LzWT/GyJY005mggTmWgITg=;
        b=FfMwL2jZ1apDr9NkEtEWHKRstspEGc+VBIcLLqotmVCtShhyIy1DKaGlc3dkj9M1Is
         TsC7T+vOrtQrxho2ZnNXFWF1qO2BO8ga4GJ2+I1jlExVd586lt3KdHto4PYPjITeyRiS
         zNZZovGcOMsfl6LV2Oasajm42oCOxWivvajPkQVqnx8jO+PqJ3U1rmrRg8G4RrNrRoQ0
         lMpcm1ap29jBlxJrXYD0cYarngHqbDu0aFo9gMQvP4lPBB00DiW4X2gSZVVhzHN03n+s
         1CFoWeCwqgk6W1bN77PJvYuEYoA6ySUETtrzMVcpuXp6qg9EXfermjxP07xMdoeFJD6P
         TQZA==
X-Forwarded-Encrypted: i=1; AHgh+RoLiKw+MvC/FO7y0XVAn5Tgf94q+Sc/HL+RVTeav45zrzPNcw9iN3h76wtnVBYMJ/hTiHcSJnvw5mjAUC1L3ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8eVzrXLRB+k8jZr+m/OeJ0N55RXHH4l2ssLTdvoTBuUQSMvY
	tDrYpC6sTjo68uVkXOn+DH9pzIavPmoTE90DgBisubfWKpEJpticeBcc
X-Gm-Gg: AfdE7clqiWthoaj9e4ExlOzLRWTbLnWfZF1dj1SVfPgw4T9OeNG8LQAQ86XvAcebMqd
	fZITfr9OPhZrkPNA0QlQnnjp+D2IIg6j2hFeGEf7JdIfljSLmV8G7l8tCjC3Hd2zoT2s+07PQF8
	+ejyuYe9aVotBPbAcgcqKO66k4dRFTAHROyMBATlwGX/mUg/KsAEISGmI68BlZQjbBrGOxCoxVU
	EGs4fS+oJ1dIW1rKwG6EWlO9gOS+yDiZDbmDZcBB6Cg2Shk+pSUEiv+o4e3MIg71YYI1cLgjadG
	KZEbU7jJzh8Kq2cS4uLAL1rCJyzKDkD8VV9zktgh7uswGngGSWVjIbxGiThFFCAHQNByoC2GYO8
	9FyY2UPyNFSr309XTE/zjNKChLR5mtmuoh4qHPd2PkLVmIex5CRQuF/Gdz2Q22pxZUZaa3JxikT
	gCuXXcaf2HaCI=
X-Received: by 2002:a17:90b:4d88:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-380aa0952c0mr8804402a91.5.1783044659714;
        Thu, 02 Jul 2026 19:10:59 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38128174885sm194920a91.16.2026.07.02.19.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:10:59 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Ze Huang <huang.ze@linux.dev>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy support
Date: Fri,  3 Jul 2026 10:10:22 +0800
Message-ID: <20260703021024.495433-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703021024.495433-1-inochiama@gmail.com>
References: <20260703021024.495433-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB3/PCIe comb PHY on the K3 is a complex PHY group that
can provide multiple phy for both PCIe and USB controller.
Its mux configuration is controlled by the APMU syscon device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/phy/spacemit,k3-combo-phy.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml
new file mode 100644
index 000000000000..ed820cf697b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k3-combo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K3 PCIE/USB3 Comb PHY
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+properties:
+  compatible:
+    const: spacemit,k3-combo-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 2
+    description:
+      The first one is phy id, the second one is phy type. This
+      only supports types are PCIe and USB .
+
+  spacemit,apb-spare:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to APB SPARE system controller interface, used for
+      PHY calibration.
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle of APMU syscon
+          - description: configuration of the PHY lanes
+    description: |
+      Phandle to control PHY mux configuration. The configuration
+      is described as follows:
+      bit 4: 0 - PCIe A x8 mode, 1 - PCIe lane share mode
+      bit 3: 0 - PCIe A x4 mode, 1 - PCIe A x2 and PCIe B x2 mode
+      bit 2: 0 - PCIe C lane 0 is PCIe mode , 1 - USB mode
+      bit 1: 0 - PCIe C lane 1 is PCIe mode , 1 - USB mode
+      bit 0: 0 - PCIe D lane is PCIe mode , 1 - USB mode
+
+      The bit[3:0] is only valid when bit 4 is 1.
+
+      This mux control does not affect the PHY for PCIe E, it is always
+      in PCIe mode.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - spacemit,apb-spare
+  - spacemit,apmu
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@81d00000 {
+      compatible = "spacemit,k3-combo-phy";
+      reg = <0x81d00000 0x600000>;
+      #phy-cells = <2>;
+      spacemit,apb-spare = <&apb_spare>;
+      spacemit,apmu = <&apmu 0x00>;
+    };
-- 
2.55.0

