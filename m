Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383EF21B9D4;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056197; cv=none; b=RPMyng1CY2M3bR1CQWLLhjhMwyVzjPAFtcTRZIYwPZQquGtx8QVsWNXLIEOiLphHiNxq9pRCWsQWpF8NbL18xzAXkQHT1Ja6lXiSCUqHN+REHn7+aN1gjQYcixN3fpKfBIxgKWTj2Pz1Bh/HayQDSmay/qp0rObLv7hehMpaZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056197; c=relaxed/simple;
	bh=6oRWJG2jN4vB5YCUB7eKoDygtklrG22njZT+Ja4t2j8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gIkJjJw93hdlYJu/mPHQRyv9OPO2eYppSUuSXNRY+OCcENzsbMvtiuRyS7e3IBaW3saYS4g279F7ofmG99xduXZKA1rXMXikNKHuVRp2DTuByEf2PnxrYxpXezmRFwNKtk8JfaUnogFbTqdyjEq91BT7pCa0DxiomRaFfFBjb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr1hpYlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr1hpYlB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3000C4CEDD;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056196;
	bh=6oRWJG2jN4vB5YCUB7eKoDygtklrG22njZT+Ja4t2j8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Jr1hpYlBgFZwNGOPRmfPFHxrLS4aq8BRwCwldZWIkYz2WUt/Ceew6jmhCDvAzBt0w
	 pYh7uKjNbhUOfnGfdVxOqkaBn+vUl1xLcEtCIQurqcMqKos2uwp7wk9gTGkqGre7n6
	 IWXYJbYoLJPGWa4yPtPBaNvYh3Vh7HL7iB6C1huPbnrb/wdpuaI793zGi1zuuByIKM
	 1pB1AvOxpo1S9YiyWwkvViiKHlSIG68UxP4d0Vb1twh6R3I+0ZRv6nQNsg8vrymjLt
	 SEYOOhQpvnPWwjo4GPd+j+k4Ojlar1SpWKmlojFKY4J1ubaH0C2YqdSjxUcW6mExkb
	 UwRHxWKyaj9aQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ECAC36018;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Subject: [PATCH v15 0/4] Initial Marvell PXA1908 support
Date: Mon, 07 Apr 2025 22:02:11 +0200
Message-Id: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEQv9GcC/4XSyU7kQAwG4FdBOU+1vNQ6p3kPxKFWOkNDowQiE
 Op3pwKiO5gDx7L02ZbrfxvmOo11Hv5evQ1TXcZ5PD70B5o/V0Pex4fbqsbSCwMBMXhg9fgSMYB
 Xh7v7g7KeofoStclu6ORxqm18+eh3fdPf+3F+Ok6vH+0XXKufjRwhIYCmHaFho1CV5/91dz/2k
 cdlzP/mu+Oh7vbTsHZZaCsdWgoQdhYYf4N8gR70990XVqB81b7lyA5CEFZvrRNWd5sTe1ccJ21
 IWLOxSMKabqMpBgO7WlkLa88WAUFY222iViGQhty8sP7LasAf1nfbanTWRxO0k3PDxWqQO4duy
 UQArp6zbcIibDDJQ/dNQLHNpSXjNTZ5acSLdizXRlxnY0mJK3kXWGq6aE8sNa0/lTmWaDDVBFK
 fI6J7IFHqNSM2heia1S3EKvU5JKYf3Ei9psRrV0g3ttbEjT6dTu8I1BBvfQMAAA==
X-Change-ID: 20230803-pxa1908-lkml-6830e8da45c7
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7359;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=6oRWJG2jN4vB5YCUB7eKoDygtklrG22njZT+Ja4t2j8=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOlf9BsbDtXsX5nzSiMmP/bQnZ4HH0ruiWTu4fvlsdGCV
 /gzV9+hjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIEyaGf6oKvyOdUgWDUkXv
 CO3sca1e1PlU/sGjhS/WNv+sOa0hacPIsNyrTmlniK/aJOF1BdpJtTwMt1rF3xkxLL/cONWZL7m
 bCwA=
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

Hello,

This series adds initial support for the Marvell PXA1908 SoC and
"samsung,coreprimevelte", a smartphone using the SoC.

USB works and the phone can boot a rootfs from an SD card, but there are
some warnings in the dmesg:

During SMP initialization:
[    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
[    0.006542] CPU features: Unsupported CPU feature variation detected.
[    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
[    0.010710] Detected VIPT I-cache on CPU2
[    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
[    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
[    0.014849] Detected VIPT I-cache on CPU3
[    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
[    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]

SMMU probing fails:
[    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
[    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
[    0.101816] arm-smmu c0010000.iommu:         no translation support!

A 3.14 based Marvell tree is available on GitHub
acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
CoderCharmander/g361f-kernel.

Andreas Färber attempted to upstream support for this SoC in 2017:
https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v15:
- Update trailers
- Move device trees to mmp/ subdirectory
- Remove excess newline in board dts
- Add soc@ to Cc list
- Drop tree from MAINTAINERS
- Rebase to v6.15-rc1
- Link to v14: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr

Changes in v14:
- Rebase on v6.13-rc7, dropping everything except DT
- Link to v13: https://lore.kernel.org/r/20241001-pxa1908-lkml-v13-0-6b9a7f64f9ae@skole.hr

Changes in v13:
- Better describe the hardware in bindings/arm commit message
- Rebase on v6.12-rc1
- Link to v12: https://lore.kernel.org/r/20240823-pxa1908-lkml-v12-0-cc3ada51beb0@skole.hr

Changes in v12:
- Rebase on v6.11-rc4
- Fix schmitt properties in accordance with 78d8815031fb ("dt-bindings: pinctrl: pinctrl-single: fix schmitt related properties")
- Drop a few redundant includes in clock drivers
- Link to v11: https://lore.kernel.org/r/20240730-pxa1908-lkml-v11-0-21dbb3e28793@skole.hr

Changes in v11:
- Rebase on v6.11-rc1 (conflict with DTS Makefile), no changes
- Link to v10: https://lore.kernel.org/r/20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr

Changes in v10:
- Update trailers
- Rebase on v6.9-rc5
- Clock driver changes:
  - Add a couple of forgotten clocks in APBC
    - The clocks are thermal_clk, ipc_clk, ssp0_clk, ssp2_clk and swjtag
    - The IDs and register offsets were already present, but I forgot to
      actually register them
  - Split each controller block into own file
  - Drop unneeded -of in clock driver filenames
  - Simplify struct pxa1908_clk_unit
  - Convert to platform driver
  - Add module metadata
- DTS changes:
  - Properly name pinctrl nodes
  - Drop pinctrl #size-cells, #address-cells, ranges and #gpio-size-cells
  - Fix pinctrl input-schmitt configuration
- Link to v9: https://lore.kernel.org/20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr

Changes in v9:
- Update trailers and rebase on v6.9-rc2, no changes
- Link to v8: https://lore.kernel.org/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr

Changes in v8:
- Drop SSPA patch
- Drop broken-cd from eMMC node
- Specify S-Boot hardcoded initramfs location in device tree
- Add ARM PMU node
- Correct inverted modem memory base and size
- Update trailers
- Rebase on next-20240110
- Link to v7: https://lore.kernel.org/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr
  and https://lore.kernel.org/20231102152033.5511-1-duje.mihanovic@skole.hr

Changes in v7:
- Suppress SND_MMP_SOC_SSPA on ARM64
- Update trailers
- Rebase on v6.6-rc7
- Link to v6: https://lore.kernel.org/r/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr

Changes in v6:
- Address maintainer comments:
  - Add "marvell,pxa1908-padconf" binding to pinctrl-single driver
- Drop GPIO patch as it's been pulled
- Update trailers
- Rebase on v6.6-rc5
- Link to v5: https://lore.kernel.org/r/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr

Changes in v5:
- Address maintainer comments:
  - Move *_NR_CLKS to clock driver from dt binding file
- Allocate correct number of clocks for each block instead of blindly
  allocating 50 for each
- Link to v4: https://lore.kernel.org/r/20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr

Changes in v4:
- Address maintainer comments:
  - Relicense clock binding file to BSD-2
- Add pinctrl-names to SD card node
- Add vgic registers to GIC node
- Rebase on v6.5-rc5
- Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr

Changes in v3:
- Address maintainer comments:
  - Drop GPIO dynamic allocation patch
  - Move clock register offsets into driver (instead of bindings file)
  - Add missing Tested-by trailer to u32_fract patch
  - Move SoC binding to arm/mrvl/mrvl.yaml
- Add serial0 alias and stdout-path to board dts to enable UART
  debugging
- Rebase on v6.5-rc4
- Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr

Changes in v2:
- Remove earlycon patch as it's been merged into tty-next
- Address maintainer comments:
  - Clarify GPIO regressions on older PXA platforms
  - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
  - Add missing includes to clock driver
  - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
  - Dual license clock bindings
  - Change clock IDs to decimal
  - Fix underscores in dt node names
  - Move chosen node to top of board dts
  - Clean up documentation
  - Reorder commits
  - Drop pxa,rev-id
- Rename muic-i2c to i2c-muic
- Reword some commits
- Move framebuffer node to chosen
- Add aliases for mmc nodes
- Rebase on v6.5-rc3
- Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr

---
Duje Mihanović (4):
      dt-bindings: marvell: Document PXA1908 SoC and samsung,coreprimevelte
      arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
      arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
      MAINTAINERS: add myself as Marvell PXA1908 maintainer

 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
 MAINTAINERS                                        |   8 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 arch/arm64/boot/dts/marvell/mmp/Makefile           |   2 +
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 335 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       | 300 ++++++++++++++++++
 7 files changed, 660 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20230803-pxa1908-lkml-6830e8da45c7

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


