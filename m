Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026232571A0;
	Wed, 30 Sep 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808210; cv=none; b=e5zpTSpgKKAMR4n9J58rLY30tFg5TxrL5y83vxNhMEh1Ipnc0KzfyKZ8tvdvkQn1cl+hd4/OZkYtkJ7fuldrs6yETTHXKUiZgLT2BKQDKWwLYE5SWwCf1A40PeDk6ssQHv6uQFqLVfdVlH31OdrFH9swHaOMFYCQHjSYKuUL8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808210; c=relaxed/simple;
	bh=2ov0GbnogjR3/jyPQ1bhg6y5dh4CEj/b8mcGNwnij6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzemERM/88AoIFsFnaes/3NsX2uTF0bmsuhWjFpeSKnhURu8hgMwf+fkuvbTztx9vRWS/dH+ZNVgCvs0RvNtumxw0SdctMct1KUN7MDWO3q/Nmh18yIyC6I5J3QsK42A2C/V9pxfzjnSh4qdLyjNs3BxwZF7cKzQAKWcuX6iRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9xQnJwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9xQnJwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFF31F000FF;
	Wed, 30 Sep 2026 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790808208;
	bh=Cvx9L07M33gn8Y74tUeJcRYqmrgbju7YiUCcwjoMfhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O9xQnJwM1f9MCNSrfh67FeQv98nRF0mAx1b78otrvCccpVrNRsXXEPE3pIMiqphLk
	 SGmgQeR+UbbNggwNo5vtGk08HoX3g993v67QGqXV68gydbN/RmmYXl1zaBidRP4iWO
	 R1jz+CbAoBdtMDeeFD0HfWn9p+B7qkhk4oiwNUyiiCYPkTWEXASIvbwwBFEs9bnsYE
	 lAj0HJQeVAu5/cMdul+vtUq9t02twcRk9gS/X9N4Gj6gs8kqMaA1HwdSHCgOZLQVZo
	 lAcSds3Df3Lf4JKDX/l73/jm+OeuLfgmaEuOUZjd2hoPM/sM4efhzFE9EWvh2N7mq5
	 oztzKeIMG3Zqg==
Date: Wed, 30 Sep 2026 23:43:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 00/23] Add basic clocks and resets for JHB100 SoC
Message-ID: <20260930-grafting-undertake-ff3e01060284@spud>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GmYp61kn4TS9EarS"
Content-Disposition: inline
In-Reply-To: <20260930124317.5648-1-changhuang.liang@starfivetech.com>

--GmYp61kn4TS9EarS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI clock folks,

On Wed, Sep 30, 2026 at 05:42:54AM -0700, Changhuang Liang wrote:
> The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
> subsystems:
>=20
> The JHB100 SoC is divided into multiple subsystems, and basically
> each subsystem includes a CRG(Clock and Reset Generator):
>  - sys0crg/sys1crg/sys2crg/
>  - per0crg/per1crg/per2crg/per3crg/
>  - voutcrg
>  - vcecrg
>  - gpu0crg/gpu1crg
>  - cpucrg
>  - usbcrg
>  - host0crg/host1crg
>  - pcierpcrg
>  - husb0crg/husb1crg
>  - husbcmncrg
>  - husbd0crg/husbd1crg
>  - npucrg
>=20
> In the current series, we will only add the following CRG:
>  - sys0crg/sys1crg/sys2crg/
>  - per0crg/per1crg/per2crg/per3crg/
>=20
> The remaining CRG will be implemented in future series.
>=20
> This series depends on the series:
> https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@star=
fivetech.com/
> and it has been tested on the StarFive JHB100 EVB-1.

If this revision of the series is acceptable, I'd (although I'm not a
listed driver maintainer) like to send you a PR as I've done in the past
for Starfive stuff so that I can get some of these binding patches that
contain headers as part of a shared tag to be able to unblock a bunch of
the soc tree stuff. With conferences next week I understand that, with it
being -rc5, it's probably this doesn't make v7.4 but I figured it was
worth getting my intentions out there!

Cheers,
Conor.

>=20
> changes since v4:
> - Remove patches 1/2/3/4 in v4, and patches 1/2/3 are newly introduced in=
 v5.
> - Refactor the shared clock and reset implementation into JH71x0-specific=
 helpers, updating
>   the affected drivers (These include patches 4/6/8/10/12/14/16/18/20/21/=
22 in v5.) to use
>   the new interfaces.
> - Split patch 6 in v4 into patch 4 and patch 6 in the current v5.
> - Split patch 21 in v4 into patch 21 and patch 22 in the current v5.
>=20
> PATCH 17: (in v5)
> - Add Krzysztof's Reviewed-by tag
>=20
> v4: https://lore.kernel.org/all/20260920120044.194901-1-changhuang.liang@=
starfivetech.com/
> v3: https://lore.kernel.org/all/20260807112923.191627-1-changhuang.liang@=
starfivetech.com/
> v2: https://lore.kernel.org/all/20260508053632.818548-1-changhuang.liang@=
starfivetech.com/
> v1: https://lore.kernel.org/all/20260402105523.447523-1-changhuang.liang@=
starfivetech.com/
>=20
> Changhuang Liang (23):
>   clk: starfive: jh7110-sys: Fix memory leak in reset controller
>     register
>   clk: starfive: JH71x0: Move reset controller registration to jh71x0
>     common code
>   reset: starfive: jh7110: Match auxiliary device names to jh71x0 clk
>     driver
>   clk: starfive: jh71x0: Add generic CRG probe helper
>   dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset
>     generator
>   clk: starfive: Add JHB100 System-0 clock generator driver
>   dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset
>     generator
>   clk: starfive: Add JHB100 System-1 clock generator driver
>   dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset
>     generator
>   clk: starfive: Add JHB100 System-2 clock generator driver
>   dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset
>     generator
>   clk: starfive: Introduce idiv ops for inverted divider clocks
>   clk: starfive: Expand the storage of clock parent index
>   clk: starfive: Add StarFive JHB100 Peripheral-0 clock driver
>   dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset
>     generator
>   clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
>   dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset
>     generator
>   clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
>   dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset
>     generator
>   clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
>   reset: starfive: jh71x0: Support discontiguous reset IDs
>   reset: starfive: Add StarFive JHB100 reset driver
>   riscv: dts: starfive: jhb100: Add clocks and resets nodes
>=20
>  .../clock/starfive,jhb100-per0crg.yaml        |  70 ++
>  .../clock/starfive,jhb100-per1crg.yaml        |  70 ++
>  .../clock/starfive,jhb100-per2crg.yaml        |  76 +++
>  .../clock/starfive,jhb100-per3crg.yaml        |  76 +++
>  .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
>  .../clock/starfive,jhb100-sys1crg.yaml        |  71 +++
>  .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
>  MAINTAINERS                                   |  13 +
>  arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
>  drivers/clk/starfive/Kconfig                  |  72 ++-
>  drivers/clk/starfive/Makefile                 |   8 +
>  .../clk/starfive/clk-starfive-jh7110-aon.c    |   2 +-
>  .../clk/starfive/clk-starfive-jh7110-isp.c    |   2 +-
>  .../clk/starfive/clk-starfive-jh7110-stg.c    |   2 +-
>  .../clk/starfive/clk-starfive-jh7110-sys.c    |  57 +-
>  .../clk/starfive/clk-starfive-jh7110-vout.c   |   2 +-
>  drivers/clk/starfive/clk-starfive-jh7110.h    |   4 -
>  drivers/clk/starfive/clk-starfive-jh71x0.c    | 161 ++++-
>  drivers/clk/starfive/clk-starfive-jh71x0.h    |  24 +-
>  .../clk/starfive/clk-starfive-jhb100-per0.c   | 599 ++++++++++++++++++
>  .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 +++++
>  .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 +++++
>  .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++
>  .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 +++++
>  .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 +++
>  .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++
>  drivers/reset/starfive/Kconfig                |   9 +
>  drivers/reset/starfive/Makefile               |   1 +
>  .../reset/starfive/reset-starfive-jh7110.c    |  10 +-
>  .../reset/starfive/reset-starfive-jh71x0.c    |  99 ++-
>  .../reset/starfive/reset-starfive-jh71x0.h    |  19 +
>  .../reset/starfive/reset-starfive-jhb100.c    | 302 +++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 ++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 186 ++++++
>  34 files changed, 3553 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-per0crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-per1crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-per2crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-per3crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-sys0crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-sys1crg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-sys2crg.yaml
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per0.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
>  create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
>=20
> --
> 2.25.1

--GmYp61kn4TS9EarS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar2QigAKCRB4tDGHoIJi
0oVVAP0c47tKWIuayAkDGb+sm29ALOHttM++ue/mqJZmjW48awEAxWm2rARVM9lR
6Ilj3pz4tC9NQZDgEAnwBnkNggJTCgg=
=hlmd
-----END PGP SIGNATURE-----

--GmYp61kn4TS9EarS--
