Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CE41C6C;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973582; cv=none; b=kbZDcT/vLJQYJLiipSgaSO2fp01YqRLzmgo+BElpuKkkpQHxzBmisuWnyx5VsHzTd1PeCqlNPIYdkHnRAtjXoL1SkveVkGAH9PhGxxi6zzMjS3sN+3nZ9qzu7k1RNd8wyV+GsNj67drXzjWMPiHCCYusFj3FNhgNru85m/DGvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973582; c=relaxed/simple;
	bh=S24MD3SBevIt2dRAtCZr/oqf5iX/z8SjGn56Z9kvxvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrT9P+K+uVsrOPMhxrDFjft4HkqEPJdF6lCf/ZFBSDeN9oo2XK4UwrtDt86FoNS0Ls/PSuQ/Pi36VqLLOiVZ0iAcf8s9OddQxTTWC5S8DytesjLV3Vf3C03X5nzlTshEm3wEGHTFOiJY+0vaRA7ZVODJ2FOXqCp2Q8nOELMCUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfB1VNqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfB1VNqa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24214C4CEE3;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973582;
	bh=S24MD3SBevIt2dRAtCZr/oqf5iX/z8SjGn56Z9kvxvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kfB1VNqaqW5d6p3GY4uD4h0fV6AOVnzht+YjMcDpw127QxamIw/9M9T/5+rdI43pH
	 gbk8YrHVGCuE9oBrQhH3uWe6xSZ4FXzUKjdKfBtBInJ1pyau1VCPAftNwnM+ZmaHWS
	 d3rullgOwNlYR3pJDNjMQ9BGLCZ5ylEbdo+14aAlwxCJK53tnE8RFiLOOJe1rtMleq
	 qLKMregN6wTwSphhmA77nuiybUHTu0B2F+t1uaGhIj5Zufr3Trkx+2CSBpmI+O+M7j
	 OT6n2+TJES+tytxKlvOetzUnp2wWgR+Viq+S7rzRzvHGt9QrI1gwrysFEefV4hN7Ov
	 VgyRYMNnXqRMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12265C02187;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 15 Jan 2025 21:35:55 +0100
Subject: [PATCH v14 2/4] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-pxa1908-lkml-v14-2-847d24f3665a@skole.hr>
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
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=L4rAAiuF3LliFg2oZyZT72q8jatVvRyWRhUILvNsW0w=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOkdsjyTkp5939WR62SbpmCdF9Wrq5b27kryiieVN3hF/
 mjucK3pKGVhEONikBVTZMn973iN97PI1u3Zywxg5rAygQxh4OIUgIl8OczIsOj4qrOnLybdknZr
 fr9B6u5JloNp7EdOzuPI3z735YRvvlWMDGtEpRiMOn3lOja9C17kY/N2lZOrKZ9MfuOLt8m9Ey4
 y8AEA
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add ARCH_MMP configuration option for Marvell PXA1908 SoC.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 370a9d2b6919d24d6c7111b95bb69a51bdf64e5a..ff9e3c3d5dd4636745b8efd79feb6706c76ec989 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -175,6 +175,14 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+config ARCH_MMP
+	bool "Marvell MMP SoC Family"
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  This enables support for Marvell MMP SoC family, currently
+	  supporting PXA1908 aka IAP140.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON

-- 
2.48.0


