Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5627361DA6;
	Fri,  2 Oct 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971926; cv=none; b=lJWaprs4044zaAjX8LaOhQqhp0UlRtXxMlvrB8kUrmKhF9+u0s83156DJSakGlXJW7HSkfhp7tYZgQNYye96tcvuUTHTIfNZCsdKbKlKGoyvCvxlWWIwnU0NyhGIkU38gSnhK3soANVUNTffAGnuK1G8SAX5EwKhtArc3xysAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971926; c=relaxed/simple;
	bh=u1VUi7i2eo1s5ZkFz17C9mIWmLAfAeA9kAw6eY65CJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImDYqs6kGyp6eywtffGaRAaibinDbYwPdwe0s+Ypk105AQ7c+X9keZuxtsdw8xz9rWNbsKQUEFcHqm0q6t5iLgDYba+NVzFAhGiwxQF/NDWx+Q/zc2ZZzxXMOuOes7VSLvMxLFlBI3t72XwjspUsb+IxduLc8anpc/27tAXZJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb3i9PEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb3i9PEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7D51F000FF;
	Fri,  2 Oct 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971910;
	bh=8mB+2FAvudWlhy7JU6hqu2muO7sjzdIMHRZOCMN4uzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hb3i9PExZcl0SqoaXhsoR4RTEv8vEPBtocVnHEBD1WEqU/XSl8fegU3INkq/61sRS
	 6yvoZhls/RBwtpcIdEHb2Rg1nQHF87CcjLjFgfsr0vqlPBK5aSkToUeIvCX2F8QXyD
	 Wk0qIOIR2kM9eOAF8LJfPSRlQzWOQr6ZEdI3BMNe3Rwi/3VhkfMH2A9DvSXAcmMWAL
	 ZJvg0/KZ7oaIGOGoJPLGw7ZBxUj5DBmPtMtFMFHmCycrkG825/FFlqzQkxtK5mAplv
	 nnBqa1Pj99oYZpmpUQqeSob1nGpXmKU2W3l8mB1IaGSLT++uHuBCHk7m8ufvKLXJks
	 l2xD+uv+P9Yyg==
Date: Fri, 2 Oct 2026 21:11:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <20261002-amigo-joyfully-6894bdfa17e3@spud>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930-grafting-undertake-ff3e01060284@spud>
 <ar_4NBLHrq2W7_vc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlg7mmY8Da63fSnW"
Content-Disposition: inline
In-Reply-To: <ar_4NBLHrq2W7_vc@redhat.com>

--zlg7mmY8Da63fSnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 02:30:12PM -0400, Brian Masney wrote:
> Hi Conor,
>=20
> On Wed, Sep 30, 2026 at 11:43:22PM +0100, Conor Dooley wrote:
> > FYI clock folks,
> >=20
> > On Wed, Sep 30, 2026 at 05:42:54AM -0700, Changhuang Liang wrote:
> > > The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
> > > subsystems:
> > >=20
> > > The JHB100 SoC is divided into multiple subsystems, and basically
> > > each subsystem includes a CRG(Clock and Reset Generator):
> > >  - sys0crg/sys1crg/sys2crg/
> > >  - per0crg/per1crg/per2crg/per3crg/
> > >  - voutcrg
> > >  - vcecrg
> > >  - gpu0crg/gpu1crg
> > >  - cpucrg
> > >  - usbcrg
> > >  - host0crg/host1crg
> > >  - pcierpcrg
> > >  - husb0crg/husb1crg
> > >  - husbcmncrg
> > >  - husbd0crg/husbd1crg
> > >  - npucrg
> > >=20
> > > In the current series, we will only add the following CRG:
> > >  - sys0crg/sys1crg/sys2crg/
> > >  - per0crg/per1crg/per2crg/per3crg/
> > >=20
> > > The remaining CRG will be implemented in future series.
> > >=20
> > > This series depends on the series:
> > > https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@=
starfivetech.com/
> > > and it has been tested on the StarFive JHB100 EVB-1.
> >=20
> > If this revision of the series is acceptable, I'd (although I'm not a
> > listed driver maintainer) like to send you a PR as I've done in the past
> > for Starfive stuff so that I can get some of these binding patches that
> > contain headers as part of a shared tag to be able to unblock a bunch of
> > the soc tree stuff. With conferences next week I understand that, with =
it
> > being -rc5, it's probably this doesn't make v7.4 but I figured it was
> > worth getting my intentions out there!
>=20
> I am going through this series now, and I have a few minor changes to
> the clk drivers themselves.
>=20
> Feel free to send a pull for the bindings and headers though.

Okay, PR below.

I won't put this tag into my linux-next branch until the drivers are in
the clock tree, but it'll let me get my ducks in a row, particularly
beneficial given next week I'll be somewhat AFK! Duck alignment is
currently ongoing in the "jhb100" branch in my repo..

Thanks Brian, Conor.

btw, will you be at LPC or OSSEU?

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ tags/clk=
-starfive-jhb100

for you to fetch changes up to 17986e31f3b6142c302c8f9af16540422787daf9:

  dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset gene=
rator (2026-10-02 20:58:09 +0100)

----------------------------------------------------------------
jhb100 clock binding shared tag

This is a shared tag for the Starfive jhb100 clock bindings, between the
riscv soc tree and clock tree.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

----------------------------------------------------------------
Changhuang Liang (7):
      dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset gene=
rator
      dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset gene=
rator
      dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset gene=
rator
      dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset =
generator
      dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset =
generator
      dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset =
generator
      dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset =
generator

 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml |  70=
 +++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml |  70=
 +++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml |  76=
 +++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml |  76=
 +++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml |  63=
 ++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml |  71=
 +++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml |  64=
 +++++++++++++++++++++++++
 include/dt-bindings/clock/starfive,jhb100-crg.h                      | 542=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/reset/starfive,jhb100-crg.h                      | 186=
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-per0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-per1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-per2crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-per3crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-sys0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-sys1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100=
-sys2crg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

--zlg7mmY8Da63fSnW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasAQAAAKCRB4tDGHoIJi
0qA6AP9gOlhBMLDM29gtUuUG2e3rfHqov1UQArl3qZThyTLh/wD+Lh811Lj+bq83
7y5mCm3kd+fKHBmjMt4/TQBCvC9ZaQA=
=zqex
-----END PGP SIGNATURE-----

--zlg7mmY8Da63fSnW--
