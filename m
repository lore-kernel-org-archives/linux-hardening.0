Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D9C7EE22
	for <linux-hardening@archiver.kernel.org>; Tue,  9 May 2023 08:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEII0H (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 May 2023 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjEIIZl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 May 2023 04:25:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB46E74
        for <linux-hardening@vger.kernel.org>; Tue,  9 May 2023 01:25:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIf9-0006Ho-6B; Tue, 09 May 2023 10:25:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIf7-002BxA-H4; Tue, 09 May 2023 10:25:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIf6-002iSX-P2; Tue, 09 May 2023 10:25:32 +0200
Date:   Tue, 9 May 2023 10:25:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ram: Convert to platform remove callback
 returning void
Message-ID: <20230509082532.ppnc6pyve5oqgh4u@pengutronix.de>
References: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
 <ee6bcb45-765b-30b8-fa38-a634b58391db@igalia.com>
 <642f4cca.170a0220.db953.9229@mx.google.com>
 <20230408081007.haisxrinicaxkkqp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqnw7qwrw7jnpit6"
Content-Disposition: inline
In-Reply-To: <20230408081007.haisxrinicaxkkqp@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--uqnw7qwrw7jnpit6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kees,

On Sat, Apr 08, 2023 at 10:10:07AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Apr 06, 2023 at 03:50:49PM -0700, Kees Cook wrote:
> > On Thu, Apr 06, 2023 at 12:57:30PM -0300, Guilherme G. Piccoli wrote:
> > > On 01/04/2023 09:00, Uwe Kleine-K=F6nig wrote:
> > > > The .remove() callback for a platform driver returns an int which m=
akes
> > > > many driver authors wrongly assume it's possible to do error handli=
ng by
> > > > returning an error code. However the value returned is (mostly) ign=
ored
> > > > and this typically results in resource leaks. To improve here there=
 is a
> > > > quest to make the remove callback return void. In the first step of=
 this
> > > > quest all drivers are converted to .remove_new() which already retu=
rns
> > > > void.
> > > >=20
> > > > Trivially convert this driver from always returning zero in the rem=
ove
> > > > callback to the void returning variant.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > Thanks, it makes sense for me! Code-wise, it looks fine.
> > >=20
> > > What would be interesting it to mention a mail thread discussing this=
 or
> > > maybe the patch itself that added the .remove_new() idea
> > > [https://git.kernel.org/linus/5c5a7680e67b right?].
> > >=20
> > > BTW, nice idea - converting all at once would be a terrible sync effo=
rt,
> > > I guess this way things will go smoothly.
> > > Feel free to add my:
> > >=20
> > > Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> >=20
> > Thanks! Looks good to me.
> >=20
> > Acked-by: Kees Cook <keescook@chromium.org>
> >=20
> > Do you want to take these view some other tree, or should I take this
> > via my pstore tree?
>=20
> Take it via your tree please. There are still >1000 drivers to convert,
> so I guess this patch will be in Linus' tree long before I can convert
> struct platform_driver.

This patch didn't make it into v6.4-rc1, is it still on your radar to
queue it for the next merge window?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uqnw7qwrw7jnpit6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRaA3sACgkQj4D7WH0S
/k4P7wf+LcIPRU3QGbueS4w+jlwG9nfY8YVD6Woh0o26RczLC4RM9C641rTmqhML
ZQJK4TK649jl0Cg210c/R/q4hy2UYTULPBmDUhKBJ6ynKLVehvwHjdfSZbNKiSkR
uOnmp4I/e6kC29scFZpo5IzEi1j/xi7274LnPkoywBaDKgOG/fD4XbJIEPjhtpw8
LxOgwb5ow6Tk/F8tFZ+Dl24Xi8Izyqf1xz52EP+hvBdYMRwuRQNjQ+i4AqIYsrtk
wa4PHszBgLIM3sCSDZxj9mi30I094JnBVbO/bkyvVj5sW14g/7mPASePVurABEzb
efHGGFqYhx7P9hJBrUzZrIv/QW2fDw==
=urVO
-----END PGP SIGNATURE-----

--uqnw7qwrw7jnpit6--
