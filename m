Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA921991B2;
	Thu, 16 Jan 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014444; cv=none; b=l99B2zKnPMemHJ68sAAfbC0/G6738CDfHyRRQgPkR+3+/y5lzj1/ClXdeWXJxtKuxcYmoMKCBzDSP4uqRC6jAuG1P+60REjyfweZa75pbOyazQz4hcyF/UEI73jXNBH5fXKSLlHSoBgKsadcLa7SIcy/SjQIj8EgG8scGwbQH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014444; c=relaxed/simple;
	bh=KR6pDDk62q9UaRrK4RmyRNoSNWfVR6Rmaqs4PT1/DAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaYs5iC2W4W8IyR/J2Lhf+NnoiPXZG8xxhZjFZH6o6oa6KE/ySM/n7A/EpBReUkt09KoKRWF9DgragXPHPiQSmUj+y4vWUW/bABZ1LOqf425IW6gvRAmUMesdeA0uBM6WsylMsTI8LE5hoRC21cwuAUxFwClWIjX+EVKBW4zh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBYqv24m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBYqv24m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29D0C4CED6;
	Thu, 16 Jan 2025 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737014443;
	bh=KR6pDDk62q9UaRrK4RmyRNoSNWfVR6Rmaqs4PT1/DAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBYqv24m0tlLBTlBFW24hd/H61Wr/cGmMHYP+bQ+w2WCuktl5qr/B6BJZveAUzv4v
	 qO1VqvSooL0lt8GXF67x9jllkjaGFVQ26mQlwX1olnl9RKvN9LwgLDiP5YzZE3SEWg
	 HWL2HVOTDdbXeL55L1/rr4tVC9/TC6PKtPJh2iIDwnbe8PEOZcOmo5fec+fo3X1KA2
	 rbW/ctzgeL4aafBBAdfCgJ2JBGG/jeL/GSR1A5Z14TsM/CgX0ySsu0UKxm6p3SYO8n
	 nz2UFzCFo2ckNiHL4HCQZN01+nDZi19gR0SsPToWVU2StsqMhqeyIVJ2iZJZQtPV9E
	 RUr2fUgDNqgBA==
Date: Thu, 16 Jan 2025 09:00:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Wronek <david@mainlining.org>, 
	Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v14 3/4] arm64: dts: Add DTS for Marvell PXA1908 and
 samsung,coreprimevelte
Message-ID: <ct7q2eaps2m2ceghiek2pmb7yhd5it6s53moumfncnyq4d4zmw@fmtoyyn3j5t2>
References: <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
 <20250115-pxa1908-lkml-v14-3-847d24f3665a@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115-pxa1908-lkml-v14-3-847d24f3665a@skole.hr>

On Wed, Jan 15, 2025 at 09:35:56PM +0100, Duje Mihanovi=C4=87 wrote:
> Add DTS for Marvell PXA1908 SoC and Samsung Galaxy Core Prime Value
> Edition LTE, a smartphone based on said SoC.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm64/boot/dts/marvell/Makefile               |   3 +
>  .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 336 +++++++++++++++=
++++++
>  arch/arm64/boot/dts/marvell/pxa1908.dtsi           | 300 +++++++++++++++=
+++
>  3 files changed, 639 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/m=
arvell/Makefile
> index ce751b5028e2628834340b5c50f8992092226eba..39c5749e631db33aa8fb0386a=
951c0a70215bc02 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -32,3 +32,6 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-base.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-pro.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9131-cf-solidwan.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9132-clearfog.dtb
> +
> +# MMP SoC Family
> +dtb-$(CONFIG_ARCH_MMP) +=3D pxa1908-samsung-coreprimevelte.dtb

Hm, why separate ARCH if this is part of Marvell Makefile? One ARCH per
vendor, so if you think this is different than MVEBU, then should be in
a separate subdirectory of marvell.

> diff --git a/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.d=
ts b/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..83b789a837d3876bf15ed0d7e=
10e190eacdfd56f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "pxa1908.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +/ {
> +	model =3D "Samsung Galaxy Core Prime VE LTE";
> +	compatible =3D "samsung,coreprimevelte", "marvell,pxa1908";
> +
> +	aliases {
> +		mmc0 =3D &sdh2; /* eMMC */
> +		mmc1 =3D &sdh0; /* SD card */
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		stdout-path =3D "serial0:115200n8";
> +
> +		/* S-Boot places the initramfs here */
> +		linux,initrd-start =3D <0x4d70000>;
> +		linux,initrd-end =3D <0x5000000>;
> +
> +		fb0: framebuffer@17177000 {
> +			compatible =3D "simple-framebuffer";
> +			reg =3D <0 0x17177000 0 (480 * 800 * 4)>;
> +			width =3D <480>;
> +			height =3D <800>;
> +			stride =3D <(480 * 4)>;
> +			format =3D "a8r8g8b8";
> +		};
> +	};
> +
> +	/* Bootloader fills this in */
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0 0 0 0>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		framebuffer@17000000 {
> +			reg =3D <0 0x17000000 0 0x1800000>;
> +			no-map;
> +		};
> +
> +		gpu@9000000 {
> +			reg =3D <0 0x9000000 0 0x1000000>;
> +		};
> +
> +		/* Communications processor, aka modem */
> +		cp@5000000 {
> +			reg =3D <0 0x5000000 0 0x3000000>;
> +		};
> +
> +		cm3@a000000 {
> +			reg =3D <0 0xa000000 0 0x80000>;
> +		};
> +
> +		seclog@8000000 {
> +			reg =3D <0 0x8000000 0 0x100000>;
> +		};
> +
> +		ramoops@8100000 {
> +			compatible =3D "ramoops";
> +			reg =3D <0 0x8100000 0 0x40000>;
> +			record-size =3D <0x8000>;
> +			console-size =3D <0x20000>;
> +			max-reason =3D <5>;
> +		};
> +	};
> +
> +

If there is going to be resend/new version:
Just one blank line.

Best regards,
Krzysztof

