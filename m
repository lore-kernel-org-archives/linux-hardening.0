Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6544CACA;
	Tue, 30 Jun 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833836; cv=none; b=d5+AIkjY6xg4KdO+C7b3JoZyuh8EGSY2PLt9leB+ZBNac8JZ/KmZu7TZJMBzcGahVilM/8R48TeNouuXx12SvCdLQ5A7Z27FYDTs3IbMQCDhf0kOFWzXtPKbYGkDeEQ+UVdd87gAwv0gmi/2sWHyAhZtAH2nDTGhSWQUE8y3NVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833836; c=relaxed/simple;
	bh=LXbKc+pk2xXz8b/bkoNzrA2gM/KwAImFNydJoG/KzbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDPMLFbL2I9gwplEh3RsMoSv02jwg49xLSpriFhNtVE2kCQ210r1H0NXUYTYDJ4cK+Eau63+vh6/+xEJes7xaLeIykm7hM4oDr4g80AsLC0RNaSvIKgG/kNHBaL5lqF+sfze5unZktuOZR4959aweUsnAwWPeh7npAjKYuQ8F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shy5SjIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shy5SjIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4877E1F000E9;
	Tue, 30 Jun 2026 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782833835;
	bh=f3gDDpa2F+xxVGf0PANTbnb+AzneKEHuN6HprbF9bqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Shy5SjIkdi8a1edi8K58WDtF7KRartQjSOwBFdhTNeADxFTOegM7p8O5auSkWXL6x
	 fg+etw55D2K402q0wfLNBnR5E7TrnJaHZHpDMIEHEeaSY1KwWg8oF4ZiOyJtMQzGdk
	 gzA/FtOWre0HXtUWZvzU/Zjm9II8YbvMgwfSqym8Cv/XKgLE8JUwwoogXQMps13vsN
	 hMZhxLEMHOdWUd5A+RnVm83Rt4z75sMsncVtyi2XKshB9Lf41M3I5XZqI2+9qTm99G
	 k87Jbc7MIOTDu/aWsyO7J+HUfZsWWKzpuwv+UqPup6Pf+3O9wAYt+Ouqmp+O1BOqTV
	 SWAYCreI5+ZMA==
Date: Tue, 30 Jun 2026 10:37:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	NXP S32 Linux Team <s32@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 05/11] pinctrl: freescale: IMXRT: Remove NOMMU platform
 support
Message-ID: <178283383072.3679006.860128200601452588.robh@kernel.org>
References: <20260619-dts_cleanup_arm_mcore-v1-0-0101795a2662@nxp.com>
 <20260619-dts_cleanup_arm_mcore-v1-5-0101795a2662@nxp.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-dts_cleanup_arm_mcore-v1-5-0101795a2662@nxp.com>


On Fri, 19 Jun 2026 11:41:02 -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Commercial users and hardware vendors migrated to Zephyr or other RTOS
> solutions years ago, leaving the NOMMU platform support effectively
> unused and unmaintained.
> 
> Remove the obsolete support to reduce maintenance burden and simplify the
> i.MX platform code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pinctrl/fsl,imxrt1050.yaml |  79 -----
>  .../devicetree/bindings/pinctrl/fsl,imxrt1170.yaml |  77 -----
>  drivers/pinctrl/freescale/Kconfig                  |  16 -
>  drivers/pinctrl/freescale/Makefile                 |   2 -
>  drivers/pinctrl/freescale/pinctrl-imxrt1050.c      | 309 ------------------
>  drivers/pinctrl/freescale/pinctrl-imxrt1170.c      | 349 ---------------------
>  6 files changed, 832 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

