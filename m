Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949196;
	b=ZzpHCyHi5MsT6mAe7Qg7bYLjM9/3po5ocJVO2/VekJiHEaHZDcFymWSzzJd0UC/wPeB0
	 DmNSbv4pRnkfHlBqyyUF+RhBXfapXFlNBPi/NSEU4JLgSQMRm5tX4p/Pk8k9du1nFsvOB
	 vDiuBeqnnSNJW+C6nTroamo+FwZHOK6mVWf67g/aqB27F4r5aLSP3dYQoqBbMmpZNacNo
	 1lBRe2mzY90PN1+5LWleOe8J/DKam8OzEOCk8WHUX91zoRGy0LEI0EqFsnTc4a38chLAG
	 6uNF1WXerGWo5EUZyC4YJewOORjc9/c3/q/ynNhm3a61NFb4D7nByN6w3+pLBLi7nbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949196;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z/ZZ/v2ozrIFzFDjrSLFseMeWg/94kHqZgMwNJDg2q4=;
	b=Tu7I/NviFQq6Bh7+KObi/nnhS+hbVMzenHmJXYkUeFSgN8MM+EONPW+ZJ3KWU/lGiOpN
	 /dHqhkcqlxpyib0p6+o40mUNrBqQnh+2zopVcbtVil1lW8lDOaSwuCFULreWqIs2dC7VA
	 vYCJZ+ZLainB0zUFqIhTzHKgxvU8TgcOxszx3Z8/vHzp2nvDNXaPegX8ASiImDaippbsz
	 Bc2rcOvh/WhEM52+UhkZ4Sm8sa1aag9m2v88r1SmArmGe2zTHKXxF1p7v+/MlNNYt5LE0
	 MoYQ7/2dGZBX44keakAmJUIPfUfuTBt9Yp3YvkicDwGXxVbBYcx2boHWFuVD/v71jaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tj4eP/rS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C83606A33B;
	Fri,  6 Nov 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj4eP/rS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793949195;
	b=MkQZ68AHze0Xfm1F/RbPek8pf33GX7SQVdWuViwlISyA4gxUsM4wM1xpiLwntkE5hhvw
	 4NxubdzmfDu+KbL/JvdBDfuEBVy26tXKYG1G6v1aXMiDVoYraiyCkBD6MhEgcRVArUHCp
	 +c4ruE0jFoKVRImEfzKyHT40UTzCQED6JASS6EXrjRXEU2cOOgOZ/xvDvRPwAWd+42gkw
	 TQP7luBqmiEWRu5o9G+9pbJxKcPCeRJ2SY/dRXZXqgBENnUzF17PbGRGdcx8mH8Z7WF2q
	 EA0gf2+cgw4O1/jUWtGHLVRhocQjm6r6RIdeb/pQXG+FfiptTOCLUQGpoCZGg2rBfCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949195;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z/ZZ/v2ozrIFzFDjrSLFseMeWg/94kHqZgMwNJDg2q4=;
	b=Xopdpj4VYGxioNFZqfIcj4ok1F7jTuq/ckUeJWJTHKoW4Tn3oDrpgKGu/1DhJGsqcjER
	 U+POpKH2zLG9aGY4z9uQxnjDAmezV3VYdAmlQIXyb5+3iCHn5XoDZMVEgkedlaYvkn9Tj
	 kqc0on2FytD8EAbY4+kokhFtoNaZaoKFI6qY1gtcKPDo2UiWoSmrC4RkYN2nBETDLWBhf
	 Gn63rXYtTpLVoGLVnJbvxRZO1hN98NnVy/4iuYnIxOy4/STZvMhJZMVOTzj10hEUZuvSh
	 7D0WWANQOSNyoN/jhtcJd2K4BWvihli1BidI/vMTIE/JfYGPEdIXpOgqjpS/kCLq9JQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 841861F008A3;
	Fri,  6 Nov 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949195;
	bh=z/ZZ/v2ozrIFzFDjrSLFseMeWg/94kHqZgMwNJDg2q4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Tj4eP/rSdBUkUPuoM1W9YYwEfrRZJBBBzlJodJHuEK+LZQjWEVWjIRqvKTYIYRgET
	 AKBM9GHVyKGn9q8ryheAE+VpvMrzNfOCIqpWfdhOnCkPGSZkHQl+rh4rKw4JJAIZWP
	 ++rs853Vs2jpGu5x46/Ad5SLORAaA8XR+GnDaTCKoHfEaxtCadmHYdCu6siryECF0w
	 oAo/F5LMYnpfJm+gaDSSfIxruCETRuIzs/QgIRux9k/eb+QtpF9gD696as/SuZravG
	 VKRHRrq9+BHgejKyO/uaXock2tYqpG32hWATGvRNZQH+wh26q5QudokPGYhBZJaO7Z
	 /b/LjQ9KOgv1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 12C9545C3F;
	Fri,  6 Nov 2026 07:13:14 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Fri, 06 Nov 2026 15:13:09 +0800
Subject: [PATCH v3 2/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
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
Message-Id: <20261106-a9_i3c-v3-2-804b69b9095b@amlogic.com>
References: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
In-Reply-To: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
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
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793949192; l=3008;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=EbBk034GgwE/lc2KD1CPaTtRovIqCoOmYzsKMI0uw94=;
 b=PL+f2g6aiQBoYwgwUjM03HWozXwwqI0y/oLp6OneE8FG5gPq4DZyr64D1ghA4gICEt8xHaQ1y
 9pNv4KLHqkuDz3THgyulcyimgZl9v3xIkMzMNoMEjC8oF7YiQIRy8Ft
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


