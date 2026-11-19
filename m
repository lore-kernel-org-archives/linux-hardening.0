Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795062171;
	b=IRms5XZJPMY9PNz9Uc2eveaIuuK+j5SgI1DRCJj1tmjhL6/fikXLSW88erPUXDIySQsB
	 AvRupaaIci6Z4FXZhMq8TKLMr28evVaI4LHQ34JIkAAZMttVxgws8MSCFCfums1jQy3zC
	 Z0QVHnjFLDvPHPRbxOroLENgUe9iAkZXYnZQoH2JPmA6BzhNqPmq5YB8OfjxLcj0NV029
	 aEN+OUgBXaID6TXcSUlrS5Qe31+AX5ZBsiRP9GSNr/KTv+Lnly49BwH+8zdlxpfAhsy4R
	 4jcVL1PnuFpbNu56R5augFq4ypNbMwRkLtzPZ608oC8VGpqJ1CtncddvD2uBoJMtMlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062171;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hOfT/6IE+yXiSnyrTuJj5KzeTLeDeuD5KGuDO9NiLTo=;
	b=Li8lJWx6pDcEbaCS8GioabeiIhcltwTAqsVsla24DTs6U+mxtd2XsT6dVKZqrAPdp8GJ
	 5Gm9ZblkGGYFe+6jgruB+Lao+MUaBzp7ojOH8LRC119lGs8DRX7fsEvy3Iz2Yvsglh6Hx
	 krnFNbwjYK1BYTJR401p6VCFnieVP9zZ+aKKC4nYEVPwNeCqEM5J2mIgX/kAJ5ZdopmKW
	 6HyOqFAZajbTudBAcTLj8iHfV6eHbAIb0hVShXp3ty5L8+6sbEgd+Z8ciu1dWHXi8b6VW
	 m2ZxCZwzITdv/lVKnmmuVJDAZUTQTKLUD6oCAK9Zo0tsdzFWmfqZ+TV7CLUElIQ8MRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8Md+S4d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA59606A320;
	Thu, 19 Nov 2026 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8Md+S4d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795062170;
	b=hSqV8Td7cBnX5aggYL8jidXDmoQkifnuXf+RCZYrUClLFQk9Dk7njZqi29ELMJoZ7QYg
	 FfRaXFqOenJDsqGdH3b1vdpPct8z9sSv7EbB0m6AHPPnH6lL2LlK3SsQAkuCMPk9+zUgU
	 g8tpB/bOGHZdvXUcsT0zu+lFl4asHqUtkL2X5WcHvMCXHDPYcKN1lpuhDzMe37n1yNl9p
	 KD0FY/e/yyf8M8LzZ6heEXltQEnod5pWDZF/fv8gkmQHVR+j+SBa2K41eUY390Do4yzR1
	 0aGsqzyUqZpEBhtBH1yKSEh2SpGdd69b9zt1vpp+x89wq0+mJvGrkzp6GVYYxZVfyYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795062170;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hOfT/6IE+yXiSnyrTuJj5KzeTLeDeuD5KGuDO9NiLTo=;
	b=vERX+JxA91i/mo/21MYwuPyuAM+bYv3ndFBM3aTUUvaFxjSudq0d1fV+zfbRDlpwykmJ
	 MyutyJTX4iPFe1Rew/6ihXlp9xL3b3KdcG0tsfLZIhyovSbizosbS2hZFtUKcNv0Hhz+Q
	 lXeDtEtHqIN0L3UUt0enjmjGUoIlm1BJktdDCgwwO+5sXmZQup+N29KpLPE/fhtzrXsHi
	 7DyYdE78873CslSrtBBQ4SaBD36trndct2RXeJ0k7H1zG6dDOGaNUlWe/8CCeRR62ZX1B
	 7meVcQGKmhcZA/MZrrmgFp1ZO3HpAdiQE9fAwtz3/IkFWk/yMY4D9+esGx5UpzTWO6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A718A1F000C6;
	Thu, 19 Nov 2026 04:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795062170;
	bh=hOfT/6IE+yXiSnyrTuJj5KzeTLeDeuD5KGuDO9NiLTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H8Md+S4demg9p41U88+RTr5Tw3YBxYQ1bFAO4OCfnqhWuttdYybzTZ5IMnh4ZKFp5
	 PcVjaVLJ4zh/kKvTQuVC0aiD8X/RLdL/FXdPAPDJqi8crI70vY1kmdrR3sQPWJpVPr
	 A0Et0oahvnb+abMYWWFsl+ujJtop6DE8YxTYEPM1dTBd9j6ITezIvoKhhNvKPKgx49
	 hYY4+mKcw9qSoDT/ay9nqb11hHg1eabjYocRAcbrvPM15m/FaggI0tRWsd9gaJCyvN
	 stEb84zSrpiYdaJhhBhs+tVj7+SE2pAScVucHO5U00LVQ9IITajEMAQQD5q8x6uJ/R
	 2hFH/vrR5VE9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 24F5B4B0CE;
	Thu, 19 Nov 2026 04:22:49 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Thu, 19 Nov 2026 12:22:46 +0800
Subject: [PATCH v5 1/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
 A9 support
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-a9_i3c-v5-1-6ec51f8fb59d@amlogic.com>
References: <20261119-a9_i3c-v5-0-6ec51f8fb59d@amlogic.com>
In-Reply-To: <20261119-a9_i3c-v5-0-6ec51f8fb59d@amlogic.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev, 
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com, 
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795062168; l=3123;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=Ic31Gjxqnh4s2EDXW6pNiciBkQWy1/9jndpHbnOW4yg=;
 b=U24vad6OC2nqL7S8VmpM1fVCastdgiDzxgkGZb+7cAToCkFrSvfKC+guCx2FTg/+uSFVddGCk
 iXD1AiCvR/iDqxk7KS2P5QdgH2NuPbY03rZRKI3VawX7mrNjHfDDl+H
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Junyi Zhao <junyi.zhao@amlogic.com>

Amlogic A9 SoCs integrate the Silvaco I3C master IP in two domains:
the EE-domain instance (amlogic,a9-i3c) takes "pclk" and "fast_clk"
like the NXP integration, while the AO-domain instance
(amlogic,a9-ao-i3c) lives in the Always-On domain and generates its
bus clock from a divider inside the controller's own register space,
so there is no external fast clock and only "pclk" is exposed.

The two instances differ from the vanilla Silvaco/NXP integrations in
clock topology and required init, so the driver matches them by
dedicated compatibles instead of the "silvaco,i3c-master-v1"
fallback: a fallback would bind the generic driver data, which
neither programs the fast clock rate nor handles the AO internal
divider, and the variant would then fail to work.

Add both compatibles to the schema without the fallback, following
nuvoton,npcm845-i3c, and use per-compatible if/then conditionals to
enforce the clock counts: two clocks for the EE-domain instance and
one clock for the AO-domain instance.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
 .../bindings/i3c/silvaco,i3c-master.yaml           | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 853092f75..d892d42be 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -13,6 +13,8 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - amlogic,a9-i3c
+          - amlogic,a9-ao-i3c
           - nuvoton,npcm845-i3c
           - silvaco,i3c-master-v1
       - items:
@@ -28,14 +30,14 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    minItems: 1
     items:
       - description: system clock
       - description: bus clock
       - description: other (slower) events clock
 
   clock-names:
-    minItems: 2
+    minItems: 1
     items:
       - const: pclk
       - const: fast_clk
@@ -70,15 +72,35 @@ allOf:
         compatible:
           contains:
             enum:
+              - amlogic,a9-i3c
               - nxp,imx94-i3c
               - nxp,imx95-i3c
     then:
       properties:
         clocks:
+          minItems: 2
           maxItems: 2
         clock-names:
+          minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a9-ao-i3c
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+          description:
+            The "ao" variant is the controller instance in the Always-On (AO)
+            domain, which has no separate bus clock and derives the
+            bus clock from an internal divider.
+        clock-names:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.42.0


