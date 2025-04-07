Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D723221569;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056197; cv=none; b=O4yazWZMvZgyQ3ctYnLSznYYOvaWye/9bRLzrCx9/kkdYNZmVxHf+IlyLsIOmRec+65f41cQKod0G6dgwkOnz/vN9yJQr/70FhCfbdou6eX0i4FYukoPsJ8458RGhcEive3ZrGHF8gjHwh28+wgF/pU40zZJ5Hk0GYEqmU31bDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056197; c=relaxed/simple;
	bh=0dXeYBgh2L/3HBCx8wBbRUEktHByls+slsnYn1cPoLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJnIK+yocbDR1mUlsIDz/MJwRYT2jB9FbtWs4cF6Urb16b+WoAuVwPqEWgeMzF9IO8UmHqYvq4SL7eZfI/ZMOiogbA3DWUJiXvQ8M1eVDODd5xAj8y2lrFHamZltalbFKmPptUyFKE52HgUECOKGCm3vGaX2dpmp0P1zzYHC+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP864Is+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP864Is+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5567C4CEE7;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056196;
	bh=0dXeYBgh2L/3HBCx8wBbRUEktHByls+slsnYn1cPoLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tP864Is+ECnZgZN5lojekala04Fer7qjBOnPDavxQp+7o9ne+yo+EvrdQyMXBbZC+
	 4Ku7iEUsKABWuKDoEbLCZoAR7jPtwup/G53VcAy8baYqKhX/8PQFRdJ4MDt8w0KVRD
	 Uaz6eVUHhwIwMy+8YeGjfeK0zt1/NuBaMgNIi5oy63dvGTuLnacZ44Gf0+/hdivceo
	 JkXr41VjV82sPDAnFC/XCjyysAcGUzsmp1WDnlOWONzQDXcwkU/UIO4lEqsXs/o14D
	 AGabdcnnE3ZcOWSfgxuVRMskkYJ+mcldiX38DybpAfbnaLqFmJzIvKUOMvg6d/lSSg
	 qrxW5LwlyPthw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3842C36010;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Mon, 07 Apr 2025 22:02:13 +0200
Subject: [PATCH v15 2/4] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-pxa1908-lkml-v15-2-e83ef101f944@skole.hr>
References: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
In-Reply-To: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
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
 soc@lists.linux.dev, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=5u1dvhpQmAFJynb0nujG0E7sr3ZjMEE0fab61FCV79A=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOlf9BufeNXlyz9fOGuOref/9/2XRcx8Z6deTe+0WFb6L
 FGvRb2/o5SFQYyLQVZMkSX3v+M13s8iW7dnLzOAmcPKBDKEgYtTACYS8YeRoX+xnbvEcpaTK6dd
 6bjNdubcbD42l6M7ijLSDa790mRMbmVkmG+5odDxb9Trhas8bvyXUm03UlrzmP1MS/jL6flrVcM
 vMwIA
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add ARCH_MMP configuration option for Marvell PXA1908 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8b76821f190fcf5cbb5db3a5de211279c23c2c59..858ccd72eb353ac31164a845cce1e1349e9c996e 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -178,6 +178,14 @@ config ARCH_MESON
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
2.49.0


