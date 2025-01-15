Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4331D88BE;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973582; cv=none; b=LJ37+I2qBo82TaFGviOR1oGqInKSxj2CwiC2qyte74fTfdXyZdlk/1Kr27hcoZtvhZE8F8Hzgl9pf7mGFa/1gBZG56J54+s1eBLwbMGqdWR1kVclofsSbO6rKkHou0G2DCKqOgCDikIbWIWdd+XZ8gabVsfdAt6A/ytqp4t0Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973582; c=relaxed/simple;
	bh=4rHuuIIznllRMWXRTJSSwhOHFyt7BOtP3GxwNOgi94Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jVVSo9zmiA4TiVTLntr2PnaIYRfck3mfC+j7mU+yG/Pa3U/3EwVg90kYRpupgg63bJdv48iR56V00WMzfC6kKic+an9jwuFW5MmiJ71KRvH3V9EKzumKc5RaK8F2ELj8hMnKoKXW+3Xy/6kqZzYWPqpTc16f+zBfxnR6C9L6qqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBOsWTKL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBOsWTKL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12121C4CEE2;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973582;
	bh=4rHuuIIznllRMWXRTJSSwhOHFyt7BOtP3GxwNOgi94Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uBOsWTKLzEkJ606NcHvNEY42qnvkeOpOEoDCm5lE7Hb4te2Ggl4Za1Acxu1HwHwUy
	 TnY07kq7g7OkOcrOpPbS+pIAKUU4hFL2XWzLCvYwgbws7egck1BS9JrQUF6JOhBaVO
	 rbugmjwwTB6DrWOrNFes4tPApiXhhaEfijLXCdxXy5y1Pbyd6TnEwm4cy1D9ao5r2j
	 /OuguU4WRUAzvWC4eOmjsbmSvqYP7X4OJ1Toj9yRnYlsuNxE2GIgc9I6iChHvDSBbO
	 gIAVQkrD989xsrNJ0GXXFpF+8+/r4PAkNuHLXqT3TcGjWQ/bCAwt6g1x3ne4UlwvPr
	 igistPaQtOXZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B6C02183;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 15 Jan 2025 21:35:54 +0100
Subject: [PATCH v14 1/4] dt-bindings: marvell: Document PXA1908 SoC and
 samsung,coreprimevelte
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-pxa1908-lkml-v14-1-847d24f3665a@skole.hr>
References: <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
In-Reply-To: <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=qR7h7Srn86tbFZcfkQnFSzKzStRtjopHrNplHXNcxgQ=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOkdsjxexqYRTOfOzniQ1nj5B//zgLQVcrlbJ5w/xSCRl
 rX3VtzFjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjII1OGv8KsgSZbJ4p6/eQz
 0Tf9JPe++eHuiO1fekwioj5+5kt7v4vhv++pW7t3Nd20vLo1rCirIKOQNU/+k27wirlvH+06Fn/
 0By8A
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add dt bindings for the Marvell PXA1908 SoC and the Samsung Galaxy Core
Prime VE LTE phone (model number SM-G361F) using the SoC.

The SoC comes with 4 Cortex-A53 cores clocked up to ~1.2GHz and a
Vivante GC7000UL GPU. The phone also has a 4.5" 480x800 touchscreen, 8GB
eMMC and 1GB of LPDDR3 RAM.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 4c43eaf3632e4ec8e7d9aeac62f7204e2af4405a..f73bb8ec3a1a1b9594eb059b72d95dcbf8c87c6b 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -35,6 +35,11 @@ properties:
           - enum:
               - dell,wyse-ariel
           - const: marvell,mmp3
+      - description: PXA1908 based boards
+        items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
 
 additionalProperties: true
 

-- 
2.48.0


