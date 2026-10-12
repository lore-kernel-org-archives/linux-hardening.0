Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C7440638;
	Mon, 12 Oct 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838734; cv=none; b=HvBHPBqDvaN5AdtvXU9AFgrC+1oAg6aCWgJQV0SBbJL4csIGPN1MCEt2wrx15Zrizl0y+Sm5uSAbMQqSuLLRvM3ZinYLjfPtE6H+90mPZ4+jLrGrfjSAcBvrXAaRhs8m/FCHXpcDWlf5ePQUGOBeYerFeoecqBhb1jasklchiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838734; c=relaxed/simple;
	bh=D7pN0hGL42tFapFXUSfMQNOTFusmYTMs49SZu/rtjMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtH6n/gpjkvJj9q8RwKxc/vFJP+YBlqwiQrzzzsZf033u1VaxlBjy904RQ+pOVgIUE1Nt1doS74WeB41M8eV9k/pxqNu91EdgSlU8rKT7WYufS8RsjACoUJh5+1l05/CyseWwupKt+SfrLZOt2O4zkik5okfh7GTNVoDA3XYKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEFA2/Xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEFA2/Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09AB1F0089B;
	Mon, 12 Oct 2026 20:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791838732;
	bh=FTERMtJjBfGpwEW/7N9atE/SuZtPxRrxPJJ+sCrbI1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UEFA2/XvZh6xGwmFTr1gmFKTGwkquuem+CBCyvU65UziSfWztd6/4S7znRYs4ihh9
	 18Xm5NXQV53k2H1OVpcTZ1zIq2mlimGIW2YuezkpsiJyqGT5fSBhX/chXNgAkYudcC
	 me3OYfW0ezy2I7i0WHIvKUAbMSO/j67x14HHBqs6DH8JhMZBxEh8eBZLj3hThet6pp
	 QglO5S8DVi25KZMi/D9ihaCT5uayeI8uvEMyr69W38GQxVv9X+ZajAtQdi39PprP3B
	 t4XiBQwsnO/9KfqUDxEA7ZhifaDyjqoe3FKUMzSVPI/oCmd2QeaDYXkEquEPvN03yD
	 eczSP5LPU0PQw==
Date: Mon, 12 Oct 2026 21:58:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
	kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
Message-ID: <20261012-citizen-garbage-57e1314b4817@spud>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/AODqDgrLRFJHav6"
Content-Disposition: inline
In-Reply-To: <20261012152408.3729237-2-elder@riscstar.com>

--/AODqDgrLRFJHav6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:24:04AM -0500, Alex Elder wrote:
> Define the binding for the clock controller functionality present in
> the Toshiba TC9564 SoC.
>=20
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - What was formerly described as a "clock" node is now "clock-control=
ler"
>     - The clock-controller DTS node, which dropped its reg property in v2=
, is
>       now a sub-device of the config syscon
>     - The config syscon is now (also) compatible with "simple-mfd"
>     - The clock-controller DTS node no longer defines a toshiba,config-sy=
scon
>       property, and the config syscon no longer requires a label
>     - The clock-controller now requires a (parent) clock property
>     - The header file is no longer included in the binding example
>     - The binding example now includes the definition of fixed 25 MHz clo=
ck
>=20
>  .../bindings/clock/toshiba,tc9564-clock.yaml  | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  include/dt-bindings/clock/toshiba,tc9564.h    | 34 ++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc956=
4-clock.yaml
>  create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock=
=2Eyaml b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> new file mode 100644
> index 0000000000000..24e07d4aead32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/toshiba,tc9564-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9564 Clock Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +  - Daniel Thompson <daniel@riscstar.com>
> +
> +description:
> +  The Toshiba TC9564 is an SoC accessed by a host system through the
> +  upstream PCIe port on the PCIe switch it implements.  The switch
> +  includes an embedded PCIe endpoint that provides access to various
> +  SoC peripherals (including a clock controller) via its BARs.
> +
> +  A total of 21 clocks are implemented, though two of these are not
> +  controllable.  Access to the clock controller relies on PCIe being
> +  functional, so the PCIe clock is assumed to be always on.  Similarly,
> +  the PCIe controller relies on I2C, so the I2C clock is also assumed
> +  to be always on.
> +
> +  Clock ids are defined in <dt-bindings/clock/toshiba,tc9564.h>.
> +
> +  The clock controller uses registers within the same page as a
> +  reset controller, so both devices are defined as children of a
> +  "config" syscon.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tc9564-clock
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - "#clock-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    tc9564_xo_board: clock-25000000 {
> +        compatible =3D "fixed-clock";
> +        clock-frequency =3D <25000000>;
> +        #clock-cells =3D <0>;
> +    };
> +
> +    syscon@0 {
> +        compatible =3D "syscon", "simple-mfd";
> +        reg =3D <0x0 0x2000>;

Same comments apply here as did on the reset, so I won't bother
discussing it in two places at once.

I'm going to mark this CR so that the lads don't need to look at it,
given that you need to resubmit anyway for the driver side.
pw-bot: changes-requested

Thanks,
Conor.

> +
> +        clock-controller {
> +            compatible =3D "toshiba,tc9564-clock";
> +            clocks =3D <&tc9564_xo_board>;
> +            #clock-cells =3D <1>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77bd64bae919f..b19c62eabaa7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28166,6 +28166,13 @@ F:	Documentation/devicetree/bindings/media/i2c/t=
oshiba,tc358743.yaml
>  F:	drivers/media/i2c/tc358743*
>  F:	include/media/i2c/tc358743.h
> =20
> +TOSHIBA TC9564 CLOCK DRIVER
> +M:	Alex Elder <elder@kernel.org>
> +M:	Daniel Thompson <danielt@kernel.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> +F:	include/dt-bindings/clock/toshiba,tc9564.h
> +
>  TOSHIBA TC9564 PCI DRIVER
>  M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
> diff --git a/include/dt-bindings/clock/toshiba,tc9564.h b/include/dt-bind=
ings/clock/toshiba,tc9564.h
> new file mode 100644
> index 0000000000000..2106e4199ed45
> --- /dev/null
> +++ b/include/dt-bindings/clock/toshiba,tc9564.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights res=
erved.
> + */
> +
> +#ifndef __CLOCK_TOSHIBA_TC9564_H__
> +#define __CLOCK_TOSHIBA_TC9564_H__
> +
> +/* Clock IDs */
> +
> +#define CLOCK_MCU		0
> +#define CLOCK_INTC		1
> +#define CLOCK_SRAM		2
> +#define CLOCK_UART		3
> +#define CLOCK_MSIGEN		4
> +#define CLOCK_PLL		5
> +#define CLOCK_SGMII		6
> +#define CLOCK_REFCLKO		7
> +
> +#define CLOCK_MAC0_TX		8
> +#define CLOCK_MAC0_RX		9
> +#define CLOCK_MAC0_125M		10
> +#define CLOCK_MAC0_312_5M	11
> +#define CLOCK_MAC0_ALL		12
> +
> +#define CLOCK_MAC1_TX		13
> +#define CLOCK_MAC1_RX		14
> +#define CLOCK_MAC1_RMII		15
> +#define CLOCK_MAC1_125M		16
> +#define CLOCK_MAC1_312_5M	17
> +#define CLOCK_MAC1_ALL		18
> +
> +#endif /* __CLOCK_TOSHIBA_TC9564_H__*/
> --=20
> 2.53.0
>=20

--/AODqDgrLRFJHav6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas1KBgAKCRB4tDGHoIJi
0iSnAP9MGRKjIPSHz1wrmbjS8fuYvn1HnO5o3n0pilv/nDIPbAEAkzKCtP7/LFTk
K3rVqG6piggU5+riXPAx2XhMT3xZCQI=
=gtoV
-----END PGP SIGNATURE-----

--/AODqDgrLRFJHav6--
