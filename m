Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0264A32
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216929; cv=pass; b=U3Y49oiD46Rar/WYNwcQfBeI87pFHq/LFSaaHVKEqU8Rp5Jswgla5DKTDCpopDBHo1wLi2VPrAbIp+TOyuXsGlPpQnb2fG7JDRdkcL1spm+QK5RvjSpXisv38YavRyk/Q7wUQD5aeSTv4GqI5/3V2Os8/8KdJsDTq/X1T3BV+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216929; c=relaxed/simple;
	bh=bNiYili71PAbnu7ejGQwhFC/zvGTK+ad8EJT2VjIX4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxTcFiUlEEuWc0QAKEU1oULqX8ClYl0b2VGJ0WLAio6ahsOHHqKUfOJOkzleyzPf2HRFvRJTHVkUgb9tLaYr1aJ9sJ7L8O2aezC2XLUzsXYCSQG4NtkrC0eWcJIf8Cclh/M1IeW4ImxGmsLAOALpJ0hRWpKJ0nrSPw+mZnFTCxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hl+AGCH4; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hl+AGCH4"
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=qqgHi6LM2GBcY7CEojYrH5XX5uV5q8rOKITQKEaMliU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768216895;
 b=TZjeLL1uGnsgMKJCbn6WTUv331QJl8/yt9MlKxx6uBHYAuhwiRkLPXvE0golHaFQBWWaymO0
 1lZUFvKP2BQsrMLWzKqg1TsERdSG98SbYLe2eJ/NuAVjmIN/rLUOlRGy9/m4SLAnFN93gOGBC5b
 +QFR8siXXBynSoDLyq7bc1I8befZApczrqBcPb3LEPxPReAv9epbJU9/pSt1vtvATy2jCYgjPp+
 QLskFG/sytC+sdtYf/rHKldIF/a2qbJV723R1gXN30kchX1vSXgM58ryRo850/MVx8sobn/231k
 Jz4NGWlyrYNdpQ+KWDjW3JykU/jz4d2BZxcrPUaUuK6ug==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768216895;
 b=XcaiPTdIF5KDJbf8WHZOrqyFeb+XKM9aB3jr4fQF1R0TzaZTl/WCs2ApJWLUsr4j2pltkiW1
 HSLy6bD4756EOZoqFGqCtx2P9SX5c6FSPEEqLTtMHleWl9JiVKxwxBocqyQ5LpH2823mv3VHOUj
 pso813TcdtKfBaLqAHeh6a5EiLz5Uu7Wl/KlPhTwmlB+XOMAMIt+ENvYeEXIvDcOkHqXec19+9J
 9hE3ackI6ddZ59FquYK4zmtPK7/A1qjw2PNLBU0lxW+9XQGiORa8d1ccSeM5lOLLMl2GOGV+gdQ
 t3InK3zlf/E9O0LWcRzOYQp7EPspMBLJbHR8dl7lpFXcw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Mon, 12 Jan 2026 12:21:35 +0100
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id AE1545A0EB0;
	Mon, 12 Jan 2026 12:21:16 +0100 (CET)
Message-ID: <b5eec4417133c2802a5fd716aba6a0f7f02bb0ba.camel@ew.tq-group.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Andrew
 Lunn <andrew@lunn.ch>,  linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org,  linux@ew.tq-group.com
Date: Mon, 12 Jan 2026 12:21:16 +0100
In-Reply-To: <20260109195912.c7wiyzj4qtdlxkh2@tumbling>
References: <cover.1767627010.git.matthias.schiffer@ew.tq-group.com>
	 <5df62f37eb84daff28008b8f9d5bd544b2f3a6a4.1767627010.git.matthias.schiffer@ew.tq-group.com>
	 <20260109195912.c7wiyzj4qtdlxkh2@tumbling>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-hardening@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4dqVLj3d9vz1kNh4d
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:909bbf5fc5c76c56937484f23808076f
X-cloud-security:scantime:2.047
DKIM-Signature: a=rsa-sha256;
 bh=qqgHi6LM2GBcY7CEojYrH5XX5uV5q8rOKITQKEaMliU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768216894; v=1;
 b=hl+AGCH4TlvdSqmoHS6vD8AYxkbtgdx7J3GHeAr8BFwd6OlMTavlHVmkEUt5ly+Q5NraTngt
 QfE5rBG9sUbnoVWVWv2uGbxNeF6YG5d7Br2YzpskWtE0AbScigV/Z/SyVekaxWB03PeTx6f01d0
 W2nGNzUmt+YCw+lvc4VQ1MRua+TXLgVcYYxEHtJOTR2c1gKZyGaf1pACdxw88iU2PObrm2LILoV
 aSYAnrmWgqnTWIPRZ5iXZMcgb/G/58AG4LEIqFf/1kw9lZeUqIV+I36IoMvFBUBcaM9G4EcOfWX
 +6J+9s+42ApS8dn47ZcWBBvrSe7WkdpmzK2hU6jJ64T6w==

On Fri, 2026-01-09 at 13:59 -0600, Nishanth Menon wrote:
> On 09:14-20260107, Matthias Schiffer wrote:
> > The TQMa62xx is a SoM family with a pluggable board connector based on =
the
> > TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and its
> > combination with our MBa62xx carrier board.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>=20
> Few clarifications below..
>=20
> [...]
> > diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts b/arc=
h/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
> > new file mode 100644
> > index 0000000000000..cca8d0018504d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
> > @@ -0,0 +1,930 @@
>=20
> [...]
>=20
> > +	backlight: backlight {
> > +		compatible =3D "pwm-backlight";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&backlight_pins>;
> > +		enable-gpios =3D <&main_gpio0 38 GPIO_ACTIVE_HIGH>;
> > +		status =3D "disabled";
>=20
> Document why disabled?

Will be enabled by DTSO for different panels. This will be added in a follo=
w-up
series, so I'll add a comment.

>=20
> [...]
> > +
> > +	panel: panel {
> > +		pinctrl-names =3D "default";
>=20
> Missing compatible? thinking again.. Should'nt these be part of some
> panel dtsi?

We tried to leave as much common configuration for different panels as poss=
ible
in the base DTS, so the DTBOs aren't bigger than necessary. I think it make=
s
sense to have this in the board DTS, as the signals used by the panels are =
part
of the board design.


>=20
> > +		pinctrl-0 =3D <&lvds_panel_pins>;
> > +		enable-gpios =3D <&main_gpio0 36 GPIO_ACTIVE_HIGH>;
> > +		power-supply =3D <&reg_lvds_pwr>;
> > +	};
> > +
> > +	fan0: pwm-fan {
> > +		compatible =3D "pwm-fan";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pwm_fan_pins>;
> > +		fan-supply =3D <&reg_pwm_fan>;
> > +		#cooling-cells =3D <2>;
> > +		/* typical 25 kHz -> 40.000 nsec */
> > +		pwms =3D <&epwm0 1 40000 PWM_POLARITY_INVERTED>;
> > +		cooling-levels =3D <0 32 64 128 196 240>;
> > +		pulses-per-revolution =3D <2>;
> > +		interrupt-parent =3D <&main_gpio1>;
> > +		interrupts =3D <30 IRQ_TYPE_EDGE_FALLING>;
> > +		status =3D "disabled";
>=20
> please document why disabled?

Will add a comment (disabled as our starterkits don't include a fan, and
different fans may need different PWM frequencies).


>=20
> [...]
> > +
> > +	reg_pwm_fan: regulator-pwm-fan {
> > +		compatible =3D "regulator-fixed";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&reg_pwm_fan_pins>;
> > +		regulator-name =3D "FAN_PWR";
> > +		regulator-min-microvolt =3D <12000000>;
> > +		regulator-max-microvolt =3D <12000000>;
>=20
> Just checking.. Did you intent a 12v supply for fan?

This is a standard 4-pin fan connector as is common on x86 mainboards, whic=
h
includes a 12V supply.


>=20
> > +		gpio =3D <&main_gpio0 62 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
>=20
> [...]
>=20
> > +
> > +	lvds_panel_pins: lvds-panel-pins {
> > +		pinctrl-single,pins =3D <
> > +			/* (N20) GPMC0_BE1n.GPIO0_36 - LVDS0_RESET# */
> > +			AM62X_IOPAD(0x0094, PIN_OUTPUT, 7)
>=20
> Could you follow the comment convention you have elsewhere? please follow=
 the
> same in gpio below etc..
> AM62X_IOPAD(....) /* (N20) ... */

I tried to avoid making the lines overly long an adhered to the regular 100
column limit where reasonable. I agree that the current inconsistent style =
is
not so nice... I see two options here:

- Consistently move the comment to a separate line
- Break long comments including pin name, pin function and board signal fun=
ction
  into two lines


>=20
> btw, panel node uses it as:
> enable-gpios =3D <&main_gpio0 36 GPIO_ACTIVE_HIGH>;
>=20
> isn't RESET# meant to be active low?

As an "enable" pin enables when active and a "reset" pin disables when acti=
ve,
an active-low reset is the same as an active-high enable.


>=20
> > +		>;
> > +	};
> > +
>=20
> [...]
>=20
>=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi b/arch/arm64=
/boot/dts/ti/k3-am625-tqma62xx.dtsi
> > new file mode 100644
> > index 0000000000000..1b7d58cb7b936
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
> > @@ -0,0 +1,331 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://ww=
w.ti.com/
> > + * Copyright (c) 2023-2025 TQ-Systems GmbH <linux@ew.tq-group.com>, D-=
82229 Seefeld, Germany.
> > + * Author: Matthias Schiffer
> > + */
>=20
> [...]
>=20
> > +		regulators {
> > +			reg_buck1: buck1 {
> > +				regulator-name =3D "V_VDD_CORE";
> > +				regulator-min-microvolt =3D <750000>;
> > +				regulator-max-microvolt =3D <750000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> [...]
>=20
> > +
> > +&a53_opp_table {
> > +	opp-1400000000 {
> > +		opp-hz =3D /bits/ 64 <1400000000>;
> > +		opp-supported-hw =3D <0x01 0x0004>;
> > +		opp-suspend;
> > +		clock-latency-ns =3D <6000000>;
> > +		/* Enabled by bootloader if supported */
> > +		status =3D "disabled";
>=20
> This (bootloader enabling just this node) wont work unless vdd_core
> voltage is configured to 0.8v as well, no?

Correct, the bootloader patches both PMIC config and OPP table.

Best,
Matthias


>=20
> > +	};
> > +};
> > +
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
