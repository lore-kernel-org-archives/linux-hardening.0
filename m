Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B86286880
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798501; cv=none; b=nHXMMjAc2mOFxQLRP64N4W7iS9QFZfOPg5rlyotlMn0h19yxJcdvv+WikSuuzGVH4iLlZbirvGf5TPbooRyjKTvchoi8MkNgxAJOve45x4bR4UNZelpAdDrBsEMnWC671CHRGW0RAev3vvmBcfrOemIgs1qFedy9wl7HvMWFNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798501; c=relaxed/simple;
	bh=0y2/d70U9xnaWfeS0Wb0q41Df1I5MN62Olvm/podXrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4nLeF+Rc2jc9s8i/HcXzFWI8XlEVPP48KONXUYPjcfr2JdOTXtYopaGJvpl5DB5MIh7jmluzQOsSbyA1n33vzfAny3zLTF901M8dufXO8xVxlroiaSsRgc8pGnYPb9O524a8EvdCtFFYi9inTpavkFXLDif0ers1J7YDL1kd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HljCuZPh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HljCuZPh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2134708f8f.3
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798496; x=1758403296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=252dG71R8/wsuDQzak40yRZblq74Z4LJhIzW4rwDhZ8=;
        b=HljCuZPhPNDKExnMUAPo+JyT1CT6bsF6PejrPUvrdk+eNaXnwl8Ct5O46on6NFY4l/
         Wtr9fqHx2pQ3nKmineyE4qY/WFYiFZibp0VIocQu7Z670q/DKdJk21tJRyaIT8dJPY0y
         VMQYb7AcITOy8xb6dfrXLPJRDZDkE/UcJVQZrqmGKBppoXYNcUqbV49kwbGg0UslSqGT
         13syjxSEcrxqI8M7boRRU7Typh8eiTE8DrxQpU1mKoYJchMclRaDMrz6NkE997tF/7J8
         HQp9m062BEiIq7T6Yk3xit/1O9e/UQJs4sCvDrlGh5YlZ0qWfAbbaX4WqvxCxYbn1Tn6
         bLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798496; x=1758403296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=252dG71R8/wsuDQzak40yRZblq74Z4LJhIzW4rwDhZ8=;
        b=Z9RSenXpL/l5ha0PBDdc3FBi/0ONnQDP+mAo88wCjt+UBimStIQRN+xInUwFEnQDax
         6VsZ0y859xlPyALUYxY3qRhkvwXEkw4NAqW/bpGR0AbzgkY/J2v2ccl38KlpPxCuJkVh
         JXMsvFe4NCCG/wv4kRcQgl6oCpuOxtTP6qSpKCZs3/ABhHQbXDzTMOtDfSbC15c9H6z8
         s8qzOUIHCYm6Rlg/6HcuAsFWbiOhxDVBg9P7pvUZPi2o5CnNeYxwSs7ts7GSEMRUYFO9
         zQLlgCKq8j+2HlmG9L8OhEFrVMxy+4Lx4Hu341wf4TBpoCR9othScb9CZfiQrPO8CO9Q
         RBvg==
X-Forwarded-Encrypted: i=1; AJvYcCXOIFxEPUR3IX4wJBHAhjGaBLWssiuukQm8WEZWWCalkRsjeMyuI7WMJEJW5ivgQF/B87iA2oS0oknne8gqJRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvmDMWzhT22HHODFF6WM+hoiRZD/+s8lifqPhZFirlOlKEAXc
	pg0KH5aR1zadnGN29Kh7ePNPXSYoOiPQ4SZ6VF68v2CAc8h4nTHAVJup
X-Gm-Gg: ASbGncvlwhrCbBHevdoOzwiVTYj/b7HdIS5mnUUJByfEMuGJ4CnURF0Cq5kgVkjeSaY
	W3ZCgy0bQjeGm5Yk5G84wzCsrrpki83ob5qp04tYNRmmr7VKGTA9/DP+RyIFc3G1C/DmmAFtgV3
	cN8cSibileBvtiYzmM5EnCtZteFjHDT89Z2NpEt7LyG0uR+4fxr23qVqsCC7lnQsOxlQ7hObNui
	FshP/tCxDtiyGFLMLrQ6UBRCyPjTtyCvXgjMhILRb0EdXL0/lmuY3KZErdGYe2n82jxNnFMKmOg
	JtGfgOEqsIn3qm6ExRr/jd0lwN5DvSOfNY0pGrmV36KQNZ8MA+vsBGFhV1eoPfKN9xetQB3582m
	1oyCb1DJsNVnpB5ZaZO86YhX1WPC43obw89+159/YIw==
X-Google-Smtp-Source: AGHT+IHOzhOcRmPGX9ESktIGDwB7TcfB0Cd8b/2rDPSkgB1eTEkWJ4gz/AUMS7YuUta78c/x3bq5/g==
X-Received: by 2002:a05:6000:2885:b0:3d7:b12b:1312 with SMTP id ffacd0b85a97d-3e7657b0092mr4921139f8f.9.1757798495900;
        Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:08 +0200
Subject: [PATCH RESEND 6/9] arm64: dts: marvell: pxa1908: Move ramoops to
 SoC dtsi
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-6-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=x0fqWkqgQtK1SSNlROzTYDeTJ7VSRsicm6OwB8pn5ns=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/hP31qVdWIe4+l05XL9nPhHs4y+LTr8vmJd3znD5
 TvMT4gkd5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBE7LIZ/tkf897MIve97fb6
 6WWy7sv3iqW7X3gkNqnscovakQnfJqUyMhyfM997m9rR5dKyzHLXg+R0Pie83LL0h/SBernAWWm
 vGtkB
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The ramoops memory region is the same for all boards based on the SoC.
Move its node to the appropriate dtsi.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts     | 12 ------------
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi               | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index c28c2eadc42cc538fc5491ecdfcfbe0191004794..dc58b19ef5d11c69f52ea7804323fe2fb2257ca7 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -37,10 +37,6 @@ memory@0 {
 	};
 
 	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
 		framebuffer@17000000 {
 			reg = <0 0x17000000 0 0x1800000>;
 			no-map;
@@ -62,14 +58,6 @@ cm3@a000000 {
 		seclog@8000000 {
 			reg = <0 0x8000000 0 0x100000>;
 		};
-
-		ramoops@8100000 {
-			compatible = "ramoops";
-			reg = <0 0x8100000 0 0x40000>;
-			record-size = <0x8000>;
-			console-size = <0x20000>;
-			max-reason = <5>;
-		};
 	};
 
 	i2c-muic {
diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
index 61498fd75d1dcaf0d068943c1ac14d3e5a7ca9ae..deb1a9df27c2f7c946096c05a684c3f1f0f16d6c 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
@@ -58,6 +58,20 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@8100000 {
+			compatible = "ramoops";
+			reg = <0 0x8100000 0 0x40000>;
+			record-size = <0x8000>;
+			console-size = <0x20000>;
+			max-reason = <5>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.51.0

