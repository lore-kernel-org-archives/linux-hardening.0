Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F91519916;
	Fri,  2 Oct 2026 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972813; cv=none; b=AN0CqBrRKPeY4avxSlcjO2/h/GPkul4BFwj8tavkxXfqvUoE8hq79x1ykSMOtxMrH9rQQPNfWEXDXQFdu+NOzggl7mmHEoLDBGBBegkwnmUd+DVeqkCELCNgGmsL9wtcvb8pqzKib4GpNs94o1e0BdX7ktg+6DaYH8AyWbI3o20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972813; c=relaxed/simple;
	bh=imIDw8fCVy38A9h/x7FZkyIQg0B0IMA+BYK0uCUgVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJbcAYWenywE3XiAMA2IMb2XL70vPTz1oX7X3y88l96hNIWsNGdDRKKhOw3z9D6oeMLw3aoDrUYi/4mEYn13Ex0J0jemgtxW5jbTcsCY0xWRSeOHRSC19/CW/fWW++vIAhx4LmDgQQiA0bIU0s+iotJnEF9OKsjvWNrWtJ+ZmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4+AIpqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4+AIpqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7359E1F000FF;
	Fri,  2 Oct 2026 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790972800;
	bh=tWF81GupOPiYz8DCKS1yJfWgC9i7VWNImgSAZo/oATQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h4+AIpqL9MJyUCNxnKtMPZViW7xx4423x75vdqVuQSN81wCGIZ3uIo5Fpk6j8gcC2
	 M8t23fldE1KkYMNnVRM55yty+gvSo4ddCYy4qCsQt9FzOocRXIWdKPdPhbBBJ1HoO3
	 K6JUDcxWYVHQqIKvHBzOh57nXNwidQ14FaJJqxX5CqaAgphKak9J3RyQLhIl95EYSQ
	 3qY9AwEpGF4V/RimJEXVTMkQWe8ltXXsbOZyE+yA0DetM3l6HyXO7i3/zyrrO0avaV
	 UyccYxtbBxwozDI/AjunD9WI5Mt3LLtzRf+YBTk+kwM1PgsByipIuzD/1LzUFyMDWd
	 d5Au//UMoigyg==
Date: Fri, 2 Oct 2026 21:26:34 +0100
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
Message-ID: <20261002-doorbell-recycler-f386e3b8d5a4@spud>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930-grafting-undertake-ff3e01060284@spud>
 <ar_4NBLHrq2W7_vc@redhat.com>
 <20261002-amigo-joyfully-6894bdfa17e3@spud>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="19rhacsLviSpo5YF"
Content-Disposition: inline
In-Reply-To: <20261002-amigo-joyfully-6894bdfa17e3@spud>

--19rhacsLviSpo5YF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 09:11:44PM +0100, Conor Dooley wrote:
> On Fri, Oct 02, 2026 at 02:30:12PM -0400, Brian Masney wrote:
> > Hi Conor,
> >=20
> > On Wed, Sep 30, 2026 at 11:43:22PM +0100, Conor Dooley wrote:
> > > FYI clock folks,
> > >=20
> > > On Wed, Sep 30, 2026 at 05:42:54AM -0700, Changhuang Liang wrote:
> > > > The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
> > > > subsystems:
> > > >=20
> > > > The JHB100 SoC is divided into multiple subsystems, and basically
> > > > each subsystem includes a CRG(Clock and Reset Generator):
> > > >  - sys0crg/sys1crg/sys2crg/
> > > >  - per0crg/per1crg/per2crg/per3crg/
> > > >  - voutcrg
> > > >  - vcecrg
> > > >  - gpu0crg/gpu1crg
> > > >  - cpucrg
> > > >  - usbcrg
> > > >  - host0crg/host1crg
> > > >  - pcierpcrg
> > > >  - husb0crg/husb1crg
> > > >  - husbcmncrg
> > > >  - husbd0crg/husbd1crg
> > > >  - npucrg
> > > >=20
> > > > In the current series, we will only add the following CRG:
> > > >  - sys0crg/sys1crg/sys2crg/
> > > >  - per0crg/per1crg/per2crg/per3crg/
> > > >=20
> > > > The remaining CRG will be implemented in future series.
> > > >=20
> > > > This series depends on the series:
> > > > https://lore.kernel.org/all/20260806122553.182449-1-changhuang.lian=
g@starfivetech.com/
> > > > and it has been tested on the StarFive JHB100 EVB-1.
> > >=20
> > > If this revision of the series is acceptable, I'd (although I'm not a
> > > listed driver maintainer) like to send you a PR as I've done in the p=
ast
> > > for Starfive stuff so that I can get some of these binding patches th=
at
> > > contain headers as part of a shared tag to be able to unblock a bunch=
 of
> > > the soc tree stuff. With conferences next week I understand that, wit=
h it
> > > being -rc5, it's probably this doesn't make v7.4 but I figured it was
> > > worth getting my intentions out there!
> >=20
> > I am going through this series now, and I have a few minor changes to
> > the clk drivers themselves.
> >=20
> > Feel free to send a pull for the bindings and headers though.
>=20
> Okay, PR below.
>=20
> I won't put this tag into my linux-next branch until the drivers are in
> the clock tree, but it'll let me get my ducks in a row, particularly
> beneficial given next week I'll be somewhat AFK! Duck alignment is
> currently ongoing in the "jhb100" branch in my repo..
>=20
> Thanks Brian, Conor.
>=20
> btw, will you be at LPC or OSSEU?

=2E.. As I went about aligning more ducks, I recalled that the syscon/pll
series also depends on some of the binding header files in this series.

I've made another tag with an additional binding that you'll need to
apply the clock patches in this series:
https://lore.kernel.org/all/20260828095608.19955-2-changhuang.liang@starfiv=
etech.com/

This tag will actually appear in linux-next as of the next iteration,
because the socinfo driver I will definitely submit as 7.4 material.

Thanks,
Conor.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ clk-star=
five-jhb100-plus-soc-header

for you to fetch changes up to c4a545d3e428e9600d670fa8a08098b7bc82d5ec:

  dt-bindings: soc: starfive: Add StarFive JHB100 syscon modules (2026-10-0=
2 21:17:31 +0100)

----------------------------------------------------------------
jhb100 clock binding + syscon binding shared tag

This is a second shared tag for the Starfive jhb100 clock bindings, between
the riscv soc tree and clock tree.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

----------------------------------------------------------------
Changhuang Liang (8):
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
      dt-bindings: soc: starfive: Add StarFive JHB100 syscon modules

 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml      =
 |  70 ++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml      =
 |  70 ++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml      =
 |  76 ++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml      =
 |  76 ++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml      =
 |  63 +++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml      =
 |  71 ++++++++++++++++++++++++++
 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml      =
 |  64 +++++++++++++++++++++++
 Documentation/devicetree/bindings/soc/starfive/starfive,jhb100-syscon.yaml=
 | 115 ++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/starfive,jhb100-crg.h                           =
 | 554 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/reset/starfive,jhb100-crg.h                           =
 | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1348 insertions(+)
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
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive=
,jhb100-syscon.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

--19rhacsLviSpo5YF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasATegAKCRB4tDGHoIJi
0gNVAQDDCEw/giCQo5Gwo5U4UO0qJ8YzsmgsgM5J++eAapwcUAEAna5ZUJoPL6B9
VEOP9JmwIIKAejBVDHKexT2t1AgjaAQ=
=ZFHw
-----END PGP SIGNATURE-----

--19rhacsLviSpo5YF--
