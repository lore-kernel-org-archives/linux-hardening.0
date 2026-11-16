Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826177;
	b=x6IXudB8diWSIkbsjRjU0eWZ6zxCzhBkFLTHGIW41dtgs3Psu4sCyenGwWaWW8fjoEzh
	 Ma4xuKOpaMMOX0SUqoBXoJnQSeUg4tVWEVLyuV85mN1xQbwa69DSTbKUU6+D+2ldy9UI9
	 ayviUETuBD89G5QKhrUh3qnGtXH0uP0FfP1/9a2z8Nn43efn3Ze/OWmvvO22olvcybdLI
	 DWu/vCrTfuoaUxS/OBHLUmZmJH3UVPNIdBAclgqI684J2LUt0eJxudygpxF8ECjAKK2FN
	 cPiq6aJgb03AScBJXcuQWwX+E+E3Dp3/B1V06NYWfubavqxBdYheWZaZJ0T/OfQH7xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826177;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A81oYfFCXcO6HZpWwd5qxf6wQpKOmYnm0LcgiCbY46Y=;
	b=WZLC+Vbm8zlO0Q5UpE8OWqKOK+3TYn9BqJIC6DTC3N/p7GiiuV91Y0cBmdaba/rWvmra
	 8SMYTqjCTG3v+OBP4tidsHHyplm5sOw8oaCtlj0gPZWoQAu0cNL5CWPxCQ3ZkQSdsnL8x
	 kHgrt9IOKzqSRWw2LV4MdW+2yt1FDjXdqellITUl2uCC/48XRRJRFAH0qrsmDpC98QkcL
	 njb4W0+ZpNw+BdSsd9b7X7VhQ5KebRiwQvCrfuMfnHpaE5UEyh4Odz9qG/3m2mFIZyDnp
	 sxjDMhzgBQOEFgoiI8kBGnqC4TLJF9T4kOT3+agsMeKbxWBhm7Tu7n0D04d0OcJ64gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jn5iy83Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223C606A31C;
	Mon, 16 Nov 2026 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jn5iy83Q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794826176;
	b=DQH+bblN5mZyP9LRLnYw66t4iGBYTgfhfkBmFQDZpjLzr7cOWHwX2bQadLrRLmYTFJk5
	 KiMRvaS0TRwZeuFhgnSGgw+KmYMt3aU6Nccsv2ms45Y6YooU7DB5f6nNRkhI+McyKBALh
	 arTQl4c9OisiRAiQsC6xORixQWRc0q2ic5xT5JnNkq7qzNf8uiAiqYQmscLaHgLf4YYhM
	 O9Sm+sv/fVBZWwcm0znKAY5AQD+i/wOhJMyW0RFECI4HCd5HRFE9c9+eyhz8aKHG2cxtp
	 g7fOD728U6uwqORLWlo7yncZWtiOex/RG8OOnHhXzsxvxxa9ARIInjlieT3ReBaXCWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826176;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A81oYfFCXcO6HZpWwd5qxf6wQpKOmYnm0LcgiCbY46Y=;
	b=LlVI6cvAjdokomq2ZrUyleJUQABIkCy4RAzYsuXMX7d2r9ne/OwUdIBu62rnWwevLFsO
	 lTCY/5YODETPZnGV6mP1FODklLWAD4hRGqPoJcnJDjIIIy+FnPufR7SWIuqN6NnFiPXIp
	 NX8Ap+bNUrQiB7Su0W/IeNwZixGWuxKOF72VVbONoMVHCq9Wbr65wIpmh4P9UZ/NF/2dT
	 /r3n/Y3tKSKObymzuHxweBYqnf2AeboFYneDVpsx4ZZRkOQQwdgshnEe5InRJrzEU5LUl
	 U9w83+2pja/74moyOEXF9+29tp1+ldOyE8KdGlD4GAktUezcjavyBNSHGsB1i2PR2Xg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 153BC1F000C4;
	Mon, 16 Nov 2026 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826176;
	bh=A81oYfFCXcO6HZpWwd5qxf6wQpKOmYnm0LcgiCbY46Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jn5iy83QsJtIwOQWqXT1GyZCEE0DRfqluUuctwQMsxJBB2mmcf6kYFL/Clh6omTp9
	 cwcsiPfCFvYYIU7+svWoG54aRMuvFTUazC6cqOkMAWv/5j4hCCm6CYGeBGkHrissgC
	 0bdPpofJWq7dxAciZv3NSFvXp+GNwokacpHOuilU/MtLXacEw1PMwJo0iRsbu2As3C
	 nCBbXc/eH9QwCw0XbtcPsGgJSIB6keEZh1YK7EFDVfeOdJwmwmpTGzyStBMU+7RLqh
	 mfpMRqlMayyaFrrjmeZ4QAB3vpVeC8j4arP4frkMwJlYWaUt3y11siMLLwbRFehx69
	 LzYBV66sEGFbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87B5F4A41A;
	Mon, 16 Nov 2026 10:49:35 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Mon, 16 Nov 2026 18:49:29 +0800
Subject: [PATCH v4 1/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
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
Message-Id: <20261116-a9_i3c-v4-1-3d3222b7128d@amlogic.com>
References: <20261116-a9_i3c-v4-0-3d3222b7128d@amlogic.com>
In-Reply-To: <20261116-a9_i3c-v4-0-3d3222b7128d@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794826174; l=3081;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=dIkv8OCvN45i4CbYK1jcC+1GlXumNc4PG6TMfSPbzdY=;
 b=zdXFGGS6SyLc2mvbTC4jp4sYjVVAJvJ0Hg2d7mMwFoz4nN/qoIaXc7Ly8IRrM0WUxZSYpt27j
 aUD2MFwhIlkAf/91eTICrTHk340V2SSuJDIsLmSHj4HLtzRQ7hcmeqO
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


