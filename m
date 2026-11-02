Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617549;
	b=ihVDc0/jW3kswbVTxbXj6bu54XGhilCHVvGe7R7wjn+31DYQg5GG8pYNP2SfGuOxH6cL
	 J0By0rYsz7iyUgw/THy8niPM5JSAk+YyO1JUYPk6cGyw8YhTVLliVktm4JfYy6er0AaPG
	 RTfrLBWJqzar0Ga2WOUg56QO8fjx8d7KzpRk46TZbZ3u+Gp96Ck3itmFsqmxd/J+zG4UM
	 fkKm2mli/uogzf2UZYSOjbmmHdM663m3/DVKYT91oWPysEtpdXb4j+HTm3QzhY+lU0wQE
	 MEV8dxCFNIPeIZw8J9lA+MaLh1J27M1R4v0P/DOTXlE691cKN6gvd/voxApEOOm2qLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7aAbwd3bYb82jK+lqdIlaSeyPNIbeoyxMw+OMzIVIVo=;
	b=3G9kw9O+TMVqQaOhPBF/enn9G5+pZQMmKVF1rjjU3FNr580Jdx2s1fnU9rS/eR3wSdsf
	 ctkkAUuXNeWu2FcH+OrP9SIFWexykpXJt3cgUqlD3O4MaYC4EBhzLGkfAvnfI1ecDcIET
	 yuFdujD+rWbTmKcVYENVOS4Xbs17oRKyz1sJfseTg3rv37rZzbXGS3MT3ALhnW22XxhHh
	 xswgatPrm+A1b/qRzgzrrCNKLu0pkrQMei8IxTO4FYDPedirgJCCdgQLS3feKUleScc9b
	 ooQusukcGnhcqaTPPtNALa1HwUlXmsWI/hy7DsGeBUBZ3lbFBbEBkH7dsr9HHQtOysw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bgz+yMfM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7531606A324;
	Mon,  2 Nov 2026 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bgz+yMfM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793617548;
	b=rWr11ZJBqEL0aGNXbaCGqseIREFRP3NOglvUsQABzxc/6iB8XCUOALuuPE0Tu3OvK4fe
	 9i2A0puCzuZFQAfyqnVXYyQ37FZ8ImZigtDEqoO+SOHfpbKU3yuRm5rHTqnfzjjUbZDsq
	 Lkm/D2oWXe0AzwcJ1wUPD63mxRLcb7wHWSGMPH9S4IogHZFoOKYql36qD+mVyEkZhCumD
	 HVinqFlQ1o5cKMS5ng2SZgVdWbOGjZ19NoDmHET9juEWo9wArlr5Rs3bKDf/1wRJaHX9A
	 Mv7PxUFCUeWiw58BQpI42Yo+OILw3bwqDDM7iYps9fewEHxGk3eH4lppZLiGGyVBl9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793617548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7aAbwd3bYb82jK+lqdIlaSeyPNIbeoyxMw+OMzIVIVo=;
	b=ud887XKI/MIJbzrwKFedmdpfNph6Q4rmYIQv7mXB3Rp4Exz5865eH/q6hog2X+X6N5BT
	 /vkLAvEyhykOF+Wc0nuFCJ87yFW6RHzhb4ldh0ddoeo61nkfWiIyAkpfU+/MkhZVm4f0x
	 H0Zn5uIqd/y8V7TmEFzl3WvwQ1FdVyxk9dDT0WyoHzUVqP6HM1bdIJAVRs9Z34AYoQi+P
	 GM8CwdIoojBQsEsESvvAKd5s0nMsySQCHp4EiPBrpdSU1+FiaVwc3B22uyk5p6tGwMJkO
	 aTADDdiv1oaFPDu/ygMCQtAuN1D/WtxLR39ZzZrGqvqi01Xm4hpqNabYvy0x5sZN5rw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BFC2A1F00A17;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617548;
	bh=7aAbwd3bYb82jK+lqdIlaSeyPNIbeoyxMw+OMzIVIVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Bgz+yMfMV2FNBhZHScXdCUyeG127xsbdfJPJqpfqFYX1TR8qe5dipzpa72q1UuDJB
	 RZZNNlyRVcZ1QDyycJNh+cnQqX0oboT7jcqAMLsFBr14NF4OtnIvX9Pc4LW03tPAGi
	 LiOn/etAjkInA7jZxWvQ0MYl5aS0HTOYr4yf9zsDDGFFnvNuFeou9dc2tJ6I5/oQkL
	 JikHuwR5ydMsw3Dh/D34dEHsiQ+MinRE9vjhVbkkYGeP5OyyU7Ru9IgAYHKGlx0ZwW
	 PC8acOGAXTbF4FPRGLUsw+MrXQLNM0U/RNwSIAqVcfivq4+ypwGnvkO393p2APyWPV
	 zKyP8blQ7gKCg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 41F48464B1;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Mon, 02 Nov 2026 19:05:40 +0800
Subject: [PATCH v2 2/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
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
Message-Id: <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
In-Reply-To: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793617545; l=2417;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=VT+yxtCcLwOnlSZwmUk7jkYSPZwtcYrMQt3WmbKM8GU=;
 b=Zyyzgp93TKMyE6jcJva/Zq1NmI1BVjP38JPANbk3tdzRgiWllHITIyK7Vpovl9498mKkoLFEo
 6eEov0fXsgEDx8+q1wg0bmzZ1fVltozCJ9/WjtaU8Fp5N6bxJhAEyFW
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Junyi Zhao <junyi.zhao@amlogic.com>

Amlogic A9 SoCs integrate the Silvaco I3C IP with two controller
instances:

  - amlogic,a9-i3c for the EE domain, which takes two clocks,
    "pclk" and "fast_clk" like the NXP variants;

  - amlogic,a9-ao-i3c for the Always-On (AO) domain, which exposes
    only "pclk": its bus clock is generated by an internal divider
    located in the controller's own register space.

Allow both compatibles with the "silvaco,i3c-master-v1" fallback and
enforce the per-variant clock counts.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
 .../bindings/i3c/silvaco,i3c-master.yaml           | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 853092f75..de1fdec65 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -19,6 +19,8 @@ properties:
           - enum:
               - nxp,imx94-i3c
               - nxp,imx95-i3c
+              - amlogic,a9-i3c
+              - amlogic,a9-ao-i3c
           - const: silvaco,i3c-master-v1
 
   reg:
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
@@ -72,12 +74,30 @@ allOf:
             enum:
               - nxp,imx94-i3c
               - nxp,imx95-i3c
+              - amlogic,a9-i3c
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
+            const: amlogic,a9-ao-i3c
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
 
 unevaluatedProperties: false
 

-- 
2.42.0


