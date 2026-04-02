Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F83DA7C2
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132658; cv=none; b=rd/g4wNu+tvOz4PcfTdtgWUGH+TUMb7JESck58LI7hLpmbZzi1uACMg6i9BKEHmZlI1iS2n7bu+64tyxD3gX6UoQQwQB7MHCCS0x1YOocHtMFZ9O5gXtpdN+hsKNgtUK7oKGpbvYBhKFcOnV+fFHfKqHGAJMHUAYPTDID18hL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132658; c=relaxed/simple;
	bh=B6Wn3du+xd9k/zV7sV20cGrrWXf20VzC5GJ2Un2tpV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfomb+N3vZPZeuDDaEGve26U2VdnXm0v4gdyFd+lcEuMRuPBTd3txll2Z6Db/2/1yNAxwFq/O7z5cstgzWKzjr8xva+U6ZPYItWCeIsNuB628sXmWMMOY0+FMMiTgra45pMRo1eq9MQZaDkwrAMrjpLv2uSWaSh4MAcrfdTO8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H5Z-0002fM-Ed; Thu, 02 Apr 2026 14:23:57 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H5Y-003N5G-2S;
	Thu, 02 Apr 2026 14:23:56 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H5Y-000000009Ot-2kEj;
	Thu, 02 Apr 2026 14:23:56 +0200
Message-ID: <9336e65273fb9a4c805c9703ad20ea803b74a860.camel@pengutronix.de>
Subject: Re: [PATCH v1 21/22] reset: starfive: Add StarFive JHB100 reset
 driver
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
Date: Thu, 02 Apr 2026 14:23:56 +0200
In-Reply-To: <20260402105523.447523-22-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
	 <20260402105523.447523-22-changhuang.liang@starfivetech.com>
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
> Add auxiliary reset driver to support StarFive JHB100 SoC.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/reset/starfive/Kconfig                |   9 ++
>  drivers/reset/starfive/Makefile               |   1 +
>  .../reset/starfive/reset-starfive-jhb100.c    | 121 ++++++++++++++++++
>  4 files changed, 137 insertions(+)
>  create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3af9d79b7daf..4ddf8ba2e60d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25319,6 +25319,12 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/starfive/jhb100*
> =20
> +STARFIVE JHB100 RESET CONTROLLER DRIVERS
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +S:	Maintained
> +F:	drivers/reset/starfive/reset-starfive-jhb1*
> +F:	include/dt-bindings/reset/starfive,jhb1*.h
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kcon=
fig
> index 29fbcf1a7d83..6f9a0f24f9b9 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -19,3 +19,12 @@ config RESET_STARFIVE_JH7110
>  	default ARCH_STARFIVE
>  	help
>  	  This enables the reset controller driver for the StarFive JH7110 SoC.
> +
> +config RESET_STARFIVE_JHB100
> +	bool "StarFive JHB100 Reset Driver"
> +	depends on CLK_STARFIVE_JHB100_SYS0

Please make this buildable under COMPILE_TEST as well.

regards
Philipp
