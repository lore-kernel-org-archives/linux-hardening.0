Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC618035;
	Mon,  6 Nov 2023 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th/nT6Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD3EC433C7;
	Mon,  6 Nov 2023 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699268329;
	bh=Sg8f81K8kk3/SHGG8dWL3FhrCJtkIiWJ0jEsgKtTGhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th/nT6VeS2zk1OlULtw+APVIYXcTssnx5cdpxe9RWD0rBicD+1gbBEBPHnoIJ2JxS
	 y0BaJK13gBKtKqEq76LNJbcJooPSje3Rwa686by63MpTCvKZ9nW0vsP+ImT+OBHxlT
	 /nq79xJlOCrCMBfTp/K2hw05nNLWY9683dIA1GR968Irjlhm1oNjc/Q7Rh5/ujtfpE
	 EJyXp/JtyEqTP9GYp16IRj+3RmdFZfOV5og+MqYW5QDIk7bLhEYHgjdSpFJKPghEE1
	 8DyuRWRhuQF5tpNI71knoBGV9foel4lRcP/XoizdI/dUMengOwxo81jAxXZMKfiSbY
	 cDmyD6XWbes/Q==
Date: Mon, 6 Nov 2023 10:58:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <ZUjG5tUrBvm6PDvB@finisterre.sirena.org.uk>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
 <3b4ac48b-e29d-415f-89f1-6d354f18c4a4@arm.com>
 <4855402.GXAFRqVoOG@radijator>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cDAfE28G8f8xdnBg"
Content-Disposition: inline
In-Reply-To: <4855402.GXAFRqVoOG@radijator>
X-Cookie: Save energy:  Drive a smaller shell.


--cDAfE28G8f8xdnBg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 05:58:05PM +0100, Duje Mihanovi=C4=87 wrote:

> I just looked at it again and it looks like no code in sound/soc/pxa/* or=
=20
> sound/arm/pxa* depends on AACI in any way. Therefore, I believe that to f=
ix=20
> this correctly, I would have to remove "select SND_ARM" from sound/soc/px=
a/
> Kconfig and optionally move the PXA2xx code out of sound/arm/ and into so=
und/
> soc/pxa/. Is this correct? If so, I'd also split that fix into a separate=
=20
> series.

There's the pxa-ac97 driver to consider...

--cDAfE28G8f8xdnBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVIxuUACgkQJNaLcl1U
h9AeGAf/c2+d+tcgxFoSAkZXFPkCaz/eMgb8h+BgUpxjiuIheHzsxvbKE0zqEpob
LLb77Y8RJuFjRED+1HDwewAzExBafqDv6jOitYbrJDCL+ERlb72HhaWK7jrSvo9y
OjupBMTVvmLY0W64K7Vb2NM0T2/OIxrKApBbEMUxxpEagmmM1I09erf7m1Gi0Sfl
31oZwOnmH810ZaG0mtQuZijawmCMSuEnpl0vjhrQe0D8mSieZRdlT8IdpMVN7sm+
IZ6qvIh644bG7uf1E9a0QV6eM9ziLMDdId1h4W3hCTssoFesy9wWw6dV2mZiKrat
/yjpAz05qMaAFLHi45RxQYjqwdAKQw==
=jjeN
-----END PGP SIGNATURE-----

--cDAfE28G8f8xdnBg--
