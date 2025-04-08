Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F423C8B0;
	Tue,  8 Apr 2025 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076827; cv=none; b=M3sWMAp5QpngrLnNRmKc7WjkVd+1NsLSpVWHXeNg+HsCFgusrEq21pYB4h16RJU4v8TH5AuFQXHF7gHhLjAHTZ4oYVv0GlqXskAWuiISUNkHuGl8AdjkXi+VLilxzruRwhkATeWOXGVGcrz52bKfrxxDKbrbBDiGOAyGuQomfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076827; c=relaxed/simple;
	bh=KE+Z3d6E92vWk+TGoKSL03e7Q9j7w8jegPEWdu9JpzA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=j2fh94TFBy2+9sNB+E3Yr8ZeR1LxXrFt7nm2p3v0SIYQVZcez+6gIClOvaSntTA3JjPqgpKCgZ2OjxGO+BY3Dh0VTllAOuTngOqAFixQOtdT3S7J2e2b6jixxOWd7yqeHAhSBMqIWGCL78lQRK1kUjeFB/3IdZlrgNDMWfceb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O93E/N+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O93E/N+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F87C4CEDD;
	Tue,  8 Apr 2025 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744076826;
	bh=KE+Z3d6E92vWk+TGoKSL03e7Q9j7w8jegPEWdu9JpzA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=O93E/N+Y1Iljjtf88VhPCAaQwAn08ZSWJm2MAwM49fVIW8aJgKd76TKcJs96MK8C9
	 UrUU3Rwmu723SdPp+9r+EsHll1LzN+A+cQu+UtqvP7vjOSpPo6Ds6xtkxWnuaCidMo
	 bBTVzHfBL03c5XPylumSswLi8jStbwmrrKbsujjwasBwHE3kmdBz3UkEqVG9keXEh6
	 qEakClUM9/pJPLveGa70iYIJI8Mjs0uuJJO3MJ7qUI7JrRfoTu71i2mBJAVlmDi4e6
	 bwJ3A4i9Prj8En3cerE2Uy3trkXPOBGkdgyLeR1tEZs+yzIGhZIVpVZVck8WXT2uW5
	 RoUsNWwATUPNw==
Date: Mon, 07 Apr 2025 20:47:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Lubomir Rintel <lkundrak@v3.sk>, Karel Balej <balejk@matfyz.cz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Will Deacon <will@kernel.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, soc@lists.linux.dev, 
 Andrew Lunn <andrew@lunn.ch>, David Wronek <david@mainlining.org>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 devicetree@vger.kernel.org
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
References: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
Message-Id: <174407675100.451724.4417307292758250572.robh@kernel.org>
Subject: Re: [PATCH v15 0/4] Initial Marvell PXA1908 support


On Mon, 07 Apr 2025 22:02:11 +0200, Duje Mihanović wrote:
> Hello,
> 
> This series adds initial support for the Marvell PXA1908 SoC and
> "samsung,coreprimevelte", a smartphone using the SoC.
> 
> USB works and the phone can boot a rootfs from an SD card, but there are
> some warnings in the dmesg:
> 
> During SMP initialization:
> [    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
> [    0.006542] CPU features: Unsupported CPU feature variation detected.
> [    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
> [    0.010710] Detected VIPT I-cache on CPU2
> [    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
> [    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
> [    0.014849] Detected VIPT I-cache on CPU3
> [    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
> [    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]
> 
> SMMU probing fails:
> [    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
> [    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
> [    0.101816] arm-smmu c0010000.iommu:         no translation support!
> 
> A 3.14 based Marvell tree is available on GitHub
> acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
> CoderCharmander/g361f-kernel.
> 
> Andreas Färber attempted to upstream support for this SoC in 2017:
> https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
> Changes in v15:
> - Update trailers
> - Move device trees to mmp/ subdirectory
> - Remove excess newline in board dts
> - Add soc@ to Cc list
> - Drop tree from MAINTAINERS
> - Rebase to v6.15-rc1
> - Link to v14: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr
> 
> Changes in v14:
> - Rebase on v6.13-rc7, dropping everything except DT
> - Link to v13: https://lore.kernel.org/r/20241001-pxa1908-lkml-v13-0-6b9a7f64f9ae@skole.hr
> 
> Changes in v13:
> - Better describe the hardware in bindings/arm commit message
> - Rebase on v6.12-rc1
> - Link to v12: https://lore.kernel.org/r/20240823-pxa1908-lkml-v12-0-cc3ada51beb0@skole.hr
> 
> Changes in v12:
> - Rebase on v6.11-rc4
> - Fix schmitt properties in accordance with 78d8815031fb ("dt-bindings: pinctrl: pinctrl-single: fix schmitt related properties")
> - Drop a few redundant includes in clock drivers
> - Link to v11: https://lore.kernel.org/r/20240730-pxa1908-lkml-v11-0-21dbb3e28793@skole.hr
> 
> Changes in v11:
> - Rebase on v6.11-rc1 (conflict with DTS Makefile), no changes
> - Link to v10: https://lore.kernel.org/r/20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr
> 
> Changes in v10:
> - Update trailers
> - Rebase on v6.9-rc5
> - Clock driver changes:
>   - Add a couple of forgotten clocks in APBC
>     - The clocks are thermal_clk, ipc_clk, ssp0_clk, ssp2_clk and swjtag
>     - The IDs and register offsets were already present, but I forgot to
>       actually register them
>   - Split each controller block into own file
>   - Drop unneeded -of in clock driver filenames
>   - Simplify struct pxa1908_clk_unit
>   - Convert to platform driver
>   - Add module metadata
> - DTS changes:
>   - Properly name pinctrl nodes
>   - Drop pinctrl #size-cells, #address-cells, ranges and #gpio-size-cells
>   - Fix pinctrl input-schmitt configuration
> - Link to v9: https://lore.kernel.org/20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr
> 
> Changes in v9:
> - Update trailers and rebase on v6.9-rc2, no changes
> - Link to v8: https://lore.kernel.org/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr
> 
> Changes in v8:
> - Drop SSPA patch
> - Drop broken-cd from eMMC node
> - Specify S-Boot hardcoded initramfs location in device tree
> - Add ARM PMU node
> - Correct inverted modem memory base and size
> - Update trailers
> - Rebase on next-20240110
> - Link to v7: https://lore.kernel.org/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr
>   and https://lore.kernel.org/20231102152033.5511-1-duje.mihanovic@skole.hr
> 
> Changes in v7:
> - Suppress SND_MMP_SOC_SSPA on ARM64
> - Update trailers
> - Rebase on v6.6-rc7
> - Link to v6: https://lore.kernel.org/r/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr
> 
> Changes in v6:
> - Address maintainer comments:
>   - Add "marvell,pxa1908-padconf" binding to pinctrl-single driver
> - Drop GPIO patch as it's been pulled
> - Update trailers
> - Rebase on v6.6-rc5
> - Link to v5: https://lore.kernel.org/r/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr
> 
> Changes in v5:
> - Address maintainer comments:
>   - Move *_NR_CLKS to clock driver from dt binding file
> - Allocate correct number of clocks for each block instead of blindly
>   allocating 50 for each
> - Link to v4: https://lore.kernel.org/r/20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr
> 
> Changes in v4:
> - Address maintainer comments:
>   - Relicense clock binding file to BSD-2
> - Add pinctrl-names to SD card node
> - Add vgic registers to GIC node
> - Rebase on v6.5-rc5
> - Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr
> 
> Changes in v3:
> - Address maintainer comments:
>   - Drop GPIO dynamic allocation patch
>   - Move clock register offsets into driver (instead of bindings file)
>   - Add missing Tested-by trailer to u32_fract patch
>   - Move SoC binding to arm/mrvl/mrvl.yaml
> - Add serial0 alias and stdout-path to board dts to enable UART
>   debugging
> - Rebase on v6.5-rc4
> - Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr
> 
> Changes in v2:
> - Remove earlycon patch as it's been merged into tty-next
> - Address maintainer comments:
>   - Clarify GPIO regressions on older PXA platforms
>   - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
>   - Add missing includes to clock driver
>   - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
>   - Dual license clock bindings
>   - Change clock IDs to decimal
>   - Fix underscores in dt node names
>   - Move chosen node to top of board dts
>   - Clean up documentation
>   - Reorder commits
>   - Drop pxa,rev-id
> - Rename muic-i2c to i2c-muic
> - Reword some commits
> - Move framebuffer node to chosen
> - Add aliases for mmc nodes
> - Rebase on v6.5-rc3
> - Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr
> 
> ---
> Duje Mihanović (4):
>       dt-bindings: marvell: Document PXA1908 SoC and samsung,coreprimevelte
>       arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
>       arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
>       MAINTAINERS: add myself as Marvell PXA1908 maintainer
> 
>  .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
>  MAINTAINERS                                        |   8 +
>  arch/arm64/Kconfig.platforms                       |   8 +
>  arch/arm64/boot/dts/marvell/Makefile               |   2 +
>  arch/arm64/boot/dts/marvell/mmp/Makefile           |   2 +
>  .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 335 +++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       | 300 ++++++++++++++++++
>  7 files changed, 660 insertions(+)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20230803-pxa1908-lkml-6830e8da45c7
> 
> Best regards,
> --
> Duje Mihanović <duje.mihanovic@skole.hr>
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit 0af2f6be1b4281385b618cb86ad946eded089ac8

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/marvell/' for 20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr:

arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dtb: / (samsung,coreprimevelte): memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0, 0, 0]]}
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dtb: mmc@80000 (mrvl,pxav3-mmc): pinctrl-names: ['default'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dtb: mmc@80000 (mrvl,pxav3-mmc): Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#





