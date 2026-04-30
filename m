Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653932874E3
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516141; cv=none; b=WPk84NKJ+et/kH2jne8Gq2y4y/EtYdSO6MJoDTAI7Hy6TPtoGmJDWYXTiERalgMXA5pK7oggyQ689NXqi6tReiGLmwwBE+EMQxBLzD580QZFRHVwU/tW1/u6oRZpcwju7o200dNzFIqmcTsieNwY1yQsQWHyJY/kFr4DTgPoPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516141; c=relaxed/simple;
	bh=m/Xfc0yttr790dvluLCktuZe/Qbje/l2mIZp0WYNOos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BScrzLZQdJz9N+n79crdgMdbZfhcAaNOW9P2tuNmb/FrDTzGcGq/ssA4+YjueRF2qf0u76gCydavlCXmRQbrlUFTDYktd3FWAzd1B7RKbGrYGf/mPH93hFk4nV8q07Kh4gWh2dJBVMFsr2dUr9/eS+8H7TAqWPZhKCFeDaW+r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDXB3OmS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDXB3OmS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7980c060cfso116601a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 19:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777516139; x=1778120939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yamg2LURb/TSAJp5ESv6zShjxXxQYQ9667SLJMB3Nuc=;
        b=gDXB3OmSP2mosEWDrlEEKjQVGNChNiaR294EdbujUUzLBaLWenewCVpjEc+Iv5I9c0
         TYK9qfhPX3dZVxl5SvWgHjFdjOYyQZxK/IFUgow2x+747ZY7QjKEmpBelz3BgMhXdoz6
         GKbqBKqCCJOV4Whiimwq3ydpu08dihlEeUuWKFFvBMxp2uMlTKuu23wWpooXxVVUDxom
         GNC/tMVfVEUBgKFEm9DDsqaPBv1lj+WO+52oQATpSUAVJM1W6WCUJOqCM0t3ve6E5m5O
         41jtDZczZI/2vviKSxEBbXcNHG7Doo/7Jpd4NPI+yZp08qveCjn/gWtDClCsn/lXSE3O
         tUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516139; x=1778120939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yamg2LURb/TSAJp5ESv6zShjxXxQYQ9667SLJMB3Nuc=;
        b=sthaElav26y2tTHI9zKQ7gFu15IrFz/k8d3Ln3ZWzyxtOuy9GRkU6PPI7gyX/5rP7s
         eQy1cKOS4DD+75m37sECEKJdTfTUTkD5BqN/8kacaDnteXa0mA/rhsAXZQqiVAD95Er5
         64DN9bJ0+CE9OyqFEZ4VWb5Azy5N9Pc05VMhxoN4bT36xlYYKWhm0HbYlTAlUyXR/NW0
         kz2fe54GZ3tn8ws/lpbcyiHdJNZrUWWfFqIBhS4vhiwR97FqISbboJ3VcNGr8BRakuai
         z4Lfb7KLHZH9WynJAxYQMA1gyLF62+yU7GOLrcb3PMp9gHp0wm/a6lrPo34Qq/wC6Y2r
         H06Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yoqjoUQhCsCTEf8W4KP81uSFab7LJWSVlQXLtCQqWQb8GhRF5KwG/jD/QtKC0DUpL9V5Xs/UFlXVc7ma0JH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/b5qwqbEuI28/E5022UQiiKqvYxOKZH6X9cwCzjnKDfr/ySof
	A2W6RLZI+SN/7I3e4ODNEm97sSIT3ouwYK1Sq6nujmarKYxNW3PcJuLlaPLXRVuo
X-Gm-Gg: AeBDievvrMJTbg5cSuBAvnrhjX8SxhQdR07VYs4bXCuZR5UOVQz2one4shMJsjc4r0V
	mPHWh7byPOg/Q5y2BZQN/HFqSO1GZ9xFkibT8fUkvfdLzVFpLBMRzRYUf2qYBHeSP9epupmwG+e
	KJlYEqbkbvNPL7/smBBAYbkrLzaue8AwofH8xZs/IA2xeF4LHOxwKXryXae7LAx0GIqhKSRFvpo
	Sr0mqJs99p8Nw59N24rfVZQ1qQA0rsvo9PyDzz9Po6sERXY3XRRBMw2DZkWGtYuZbzlRhWmPXX1
	sCtdz2U2VKhfZOsSlNcpgVxk3SmPeyoErzLcSnb9C7BR1f2r6fwu0Z/0zv2xr5SFj9XvS5jOZPH
	JXoETYADdfaGHLsr8murT1fY0FevUQmOIcUSifonFANhsrhrYcQL+jQ+M963TUoqFk1BrZZ16KP
	VVZ7RjtI3d1cCQ8Q032g3blUjs8H9hJ1U5qw==
X-Received: by 2002:a05:6a20:1aa3:b0:3a1:90fd:dcd6 with SMTP id adf61e73a8af0-3a3cf6b2d12mr738604637.31.1777516138751;
        Wed, 29 Apr 2026 19:28:58 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f0a08sm3373649a12.15.2026.04.29.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:28:58 -0700 (PDT)
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
	Ze Huang <huang.ze@linux.dev>,
	Alex Elder <elder@riscstar.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy support
Date: Thu, 30 Apr 2026 10:28:40 +0800
Message-ID: <20260430022843.1090138-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430022843.1090138-1-inochiama@gmail.com>
References: <20260430022843.1090138-1-inochiama@gmail.com>
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
 .../bindings/phy/spacemit,k3-comb-phy.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k3-comb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k3-comb-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k3-comb-phy.yaml
new file mode 100644
index 000000000000..7aa2cf9301b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k3-comb-phy.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k3-comb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K3 PCIE/USB3 Comb PHY
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+properties:
+  compatible:
+    const: spacemit,k3-comb-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 2
+    description:
+      The first one is phy id, the second one is phy type.
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
+required:
+  - compatible
+  - "#phy-cells"
+  - spacemit,apb-spare
+  - spacemit,apmu
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@81d00000 {
+      compatible = "spacemit,k3-comb-phy";
+      reg = <0x81d00000 0x600000>;
+      #phy-cells = <2>;
+      spacemit,apb-spare = <&apb_spare>;
+      spacemit,apmu = <&apmu 0x00>;
+    };
-- 
2.54.0

