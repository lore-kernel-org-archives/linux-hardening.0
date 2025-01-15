Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5421D8E07;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973582; cv=none; b=u/AocBM46HhA+bv+K4XUTHib9fH/rAFmRLpXnuSEfJG5EO888U+pf7oiWf59Nq2WqlcsvmeVr6w7pzfwivzcVPso6nuIa2UnnqsMCiT4RmxEK2/w47pQQJ7+Yd4pIC0Ss8ogOPB5Ow7fbVeRUzuSxm0520ELt+U/GbSb+JGHddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973582; c=relaxed/simple;
	bh=lKnVyd5XjWp1qMnGaWgRYfUAnc3El6o6eyoFWI1XG2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifJksss1Gx8iuvOt9vG6hb7L+voVQhOzleepE70K8NEhGRp9wwdRlcyJUGubYP4mnFWMjuf3jR8ujMpT+CsNjl17F4K39wS5DOSm4bpRQc4IoOu9d2RwuB3wbrRP3oUI3c+6a9M2zkT+OOA/5SVbrFdgu7Fr30gIoUmI3oLYCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCKqPQfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCKqPQfS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D29EC4CEEC;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973582;
	bh=lKnVyd5XjWp1qMnGaWgRYfUAnc3El6o6eyoFWI1XG2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hCKqPQfSlR/xD1Gy2i1mekScyZIunl3mWlqCqxBF94LA6YOnBcHWGoLcHmbd+FWKI
	 UMIat3MOwXmK+nRhHwSkZ3mg4RCgLe/Nntjn2Ake4KZiu4yTLKQXVqJXN+bl/8QCHF
	 EXEr/lhUZCBkV+mpEnpfnNOAj7sbb2/fgrrT5Axe8jjA7KzizG2sv7uOQKeHmApA8j
	 F7ySpri7EhHqTRWNbvIFVNNSGWLiDYScuv1pEghc74UFggDfuOkmBZl3vPZ4VSDsfp
	 +iOCHqbHH+XenpijdkBzzuJZwgFgmQ6yl7VOHaTuAKxLLkpDnnpcnYZdFk4k+plARW
	 xFUl03160BgsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3501CC02180;
	Wed, 15 Jan 2025 20:39:42 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 15 Jan 2025 21:35:57 +0100
Subject: [PATCH v14 4/4] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-pxa1908-lkml-v14-4-847d24f3665a@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=962;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=6vZolXLVCSzdTOeYInagQh75YU9IpR7xHoGIhphNx0U=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOkdsjwWDY21N7ZWfmLyC3w98w/3FJYtSmI5jw5dUPwvE
 M2ScNmro5SFQYyLQVZMkSX3v+M13s8iW7dnLzOAmcPKBDKEgYtTACYSbs3IcPrsXgPdH1F2K06z
 MM2fH7fGceXpmefncOrbZEZ/YInc9Z2R4e+u/1WeS1Qv/JnAtmKP6aZcbva5h/aYmHSalohbLu6
 5yQ4A
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a87ddad78e26f28ffd0f3433560d6db1518f9f95..caa5f6b96251a3da0f3f9d2f760b38288eb23ab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2624,6 +2624,15 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git https://gitlab.com/LegoLivesMatter/linux
+F:	arch/arm64/boot/dts/marvell/pxa1908*
+F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.48.0


