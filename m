Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097753E122C
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132575; cv=none; b=G24JCHqikoi9/AhYUBpwfNErS0aJ9HlYtAjqB66Xftm7tdic0ct0CPntx76NqOxy6XPSlMlnl6xyV7ccsfgxyn/hIRzIU0JvgS3fASO43BKDznybt+4QRMKhx3uOW5lZzLdAovmJLt57D38VP4umWRcPF9vRIjgMmWvUgnK7Lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132575; c=relaxed/simple;
	bh=5Pc0OenZ3fZcs93Pg80x5PzRg92S/L7v3o65TCyhgfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0XymUUAk5Nr48WRlAyxjaEYPjEsmF30gNvrplE1fcXVQ/DpgWslJHJNPO6acARBVbduZk3qvu10/j2RNl2fk19NRojIN4q8cMkl+7pDIXon4H9XL0/KFO3YrJJdL6xc2275ZMB8emTo/I1xHGhB8F7i7EnElRI5eB0JkYbnH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H4B-0002P0-Bs; Thu, 02 Apr 2026 14:22:31 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H49-003N51-1P;
	Thu, 02 Apr 2026 14:22:29 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H49-000000009AC-1Nzj;
	Thu, 02 Apr 2026 14:22:29 +0200
Message-ID: <2d3ef7359f63fb364cb7bc13b721132894428874.camel@pengutronix.de>
Subject: Re: [PATCH v1 05/22] dt-bindings: clock: Add StarFive JHB100
 System-0 clock and reset generator
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Michael Turquette	
 <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stephen Boyd	 <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti	 <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook	
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org, Sia Jee Heng
	 <jeeheng.sia@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>
Date: Thu, 02 Apr 2026 14:22:29 +0200
In-Reply-To: <20260402105523.447523-6-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
	 <20260402105523.447523-6-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org

On Do, 2026-04-02 at 03:55 -0700, Changhuang Liang wrote:
> Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
> JHB100 SoC.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 30 +++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-sys0crg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
>
[...]
> diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt=
-bindings/reset/starfive,jhb100-crg.h
> new file mode 100644
> index 000000000000..71affdcdf733
> --- /dev/null
> +++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
> +#define __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
> +
> +/* SYS0CRG resets */
> +#define JHB100_SYS0RST_RESOURCE_ARB					0

Where are resets 1 and 2, ...

> +#define JHB100_SYS0RST_SYS0_IOMUX_PRESETN				3
> +#define JHB100_SYS0RST_SYS0H_IOMUX_PRESETN				4
> +#define JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN				5

... where are 6-13?

> +
> +#define JHB100_SYS0RST_BMCPCIERP_RSTN_BUS				14
[...]

If there are non-reset bits in these registers, please enumerate reset
controls in a contiguous range for this binding and add a mapping table
in the driver.

regards
Philipp
