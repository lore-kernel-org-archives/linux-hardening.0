Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9080C7EE22
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 06:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEKGNN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKGNN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 02:13:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329E19AB
        for <linux-hardening@vger.kernel.org>; Wed, 10 May 2023 23:13:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzY0-0005vi-3h; Thu, 11 May 2023 08:13:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzXz-002f9s-3H; Thu, 11 May 2023 08:13:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzXy-003KMn-4L; Thu, 11 May 2023 08:13:02 +0200
Date:   Thu, 11 May 2023 08:13:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     gpiccoli@igalia.com, Tony Luck <tony.luck@intel.com>,
        kernel@pengutronix.de, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Convert to platform remove callback
 returning void
Message-ID: <20230511061302.bobt65hflutwvuoo@pengutronix.de>
References: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
 <168375283737.2438356.7396268515330470842.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m74l52gyqowm3ap5"
Content-Disposition: inline
In-Reply-To: <168375283737.2438356.7396268515330470842.b4-ty@chromium.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--m74l52gyqowm3ap5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:07:20PM -0700, Kees Cook wrote:
> On Sat, 1 Apr 2023 14:00:00 +0200, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > [...]
>=20
> Applied to for-next/pstore, thanks!
>=20
> [1/1] pstore/ram: Convert to platform remove callback returning void
>       https://git.kernel.org/kees/c/48f2c681df43
>=20
> I will send this Linus's way for -rc2. Apologies for the delay!

Thanks. If you ask me, you don't need to annoy Linus with such a patch
after the merge window. If it goes in for 6.5-rc1 that's fine for me.
There is no urge, still >1000 drivers to convert before I start thinking
about a patch that changes struct platform_driver and so depends on this
conversion.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m74l52gyqowm3ap5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRch20ACgkQj4D7WH0S
/k4VUAf/R3BcoAML5vmQDcEEPO1z+lerVcoXgOxEK02vD3Obl9+HoIUa4dGJLz8s
nHDW99YV0ogb3PLGDj5xM+rqaeLGVebk0ZQwg244QGigAimSXyMK1R3EHaV9pFC0
OwyNtTeRPLnVt6UoBaU07JTT3R4HP+rrVxK3nK5xjN6QF8L4ruGYK4iw3pDMtKXe
0s8XIUxBZ9XKGoHy/+qTNM+QVhPw1Bx/r3o6Szx0mwPa9ordZ+UZP+ZqfBJ9Jn3t
PNciieBQEl4fWzQB1P8TOtbSD2EMdU9OlODIxUVpEzFdTnvsH9Jr9TslSjo+en2Y
HSmDYUnnKnJX9Ee4CjnYAgPFnp3Adg==
=DnPE
-----END PGP SIGNATURE-----

--m74l52gyqowm3ap5--
