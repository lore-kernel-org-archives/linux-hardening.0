Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FE1C288;
	Thu,  2 Nov 2023 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbwrF7am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B019C433C9;
	Thu,  2 Nov 2023 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698938801;
	bh=CLu2jh9OlzM/sGA794f8ZsBB8L94ScdqfEUVqcrrVuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbwrF7amZPORQN6XEePLyXfiiZ8ycC5AP0VuVxJw9NDsMuXC8LQTkbBxCQY6r90nO
	 Y+anNtIn/BjOUCJOXluLD5XHtZcNHtqL0nMw874GYI/GKuDFAI7dyJCxiTbWIZT09s
	 zVD2KEkoT3mriuzjQCICRHzeKizPqwVcItVs71NcBLXPc6arxXaqfhWRpZyCVQpu6p
	 bKa6n9rCnSVfhhbsmmrah+lRCyKqtmOOHtl1FDHQYv/Z0HBnN6eh+RXyd6Zae1CGfL
	 HUtqS0EpBndyQy1GtXAvccj0WXis8wCarS/oJt9tUVRjxGDRisnaVa9qBoYPTw7Tp1
	 fiNJ8wWO6pmlw==
Date: Thu, 2 Nov 2023 15:26:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Leo Yan <leoy@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Karel Balej <balejk@matfyz.cz>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Message-ID: <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qOq/Mx9vNp7JTaIV"
Content-Disposition: inline
In-Reply-To: <20231102152033.5511-1-duje.mihanovic@skole.hr>
X-Cookie: A is for Apple.


--qOq/Mx9vNp7JTaIV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 04:20:29PM +0100, Duje Mihanovi=C4=87 wrote:
> The SSPA driver currently seems to generate ARM32 assembly, which causes
> build errors when building a kernel for an ARM64 ARCH_MMP platform.
>=20
> Fixes: fa375d42f0e5 ("ASoC: mmp: add sspa support")
> Reported-by: kernel test robot <lkp@intel.com>

>  	tristate "SoC Audio via MMP SSPA ports"
> -	depends on ARCH_MMP
> +	depends on ARCH_MMP && ARM

This isn't a fix for the existing code, AFAICT the issue here is that
ARCH_MMP is currently only available for arm and presumably something in
the rest of your series makes it available for arm64.  This would be a
prerequisite for that patch.

Please don't just insert random fixes tags just because you can.

--qOq/Mx9vNp7JTaIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVDv6YACgkQJNaLcl1U
h9AOwQf/T1o3MmUT/AHCyzC1ybmn9jdutGNuOKe8pi9O3wXGrNVyx5Fkp1SK4nbc
62A11OUzAZ0h9HETpVH8AdVGBkxF2J+yKKBX+JuqvzuzEKm03uXRhUElJmqfU+nK
jDKPeW4JH7ebL94RYoy4P0IFywZIaS+PjdREKi5j5zTTvDKLxEVqppJPz30+UXz7
QRoVMkJmqK4HrvzznNuiuhBuz96tooQLS1dIVzrBmNJ5YEbbjeVpXHcUEv+YanOL
Qd6s2Onh6sZigqrrZlb5F2CIKw+AuHnLNL9XEyT2ZXyDY8ZdCF7ZgZ64acZz+39b
21kilHuZZYaEZTKdul8WvivXsPffgA==
=zsGC
-----END PGP SIGNATURE-----

--qOq/Mx9vNp7JTaIV--
