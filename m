Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177DC64E7B
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 16:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB2220829
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="DCQ/jYaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgKSQ3v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgKSQ3r (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 11:29:47 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F444C0613CF;
        Thu, 19 Nov 2020 08:29:46 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CcQBJ153Pz8shH;
        Thu, 19 Nov 2020 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605803384;
        bh=as/FP3+UtccsQc0KiRNQ/5PQHycuMz7qOGok4Ha1beI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCQ/jYaVXjRnpWR6Dv9XBaXUg4NRYXFa+IE9G8bTXwa/HBfDEaSY+EfLrt1YgTFnD
         N3NycX5FuQ1lmkW33nEwy88pE3mrBnFWx2Pu7MEyPVzVjQW/2f+9qGAAub7cM/fIh3
         KOL9+YjSWZG2auZLX+ZhCLKRjizLQPE39ksFDRpw=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CcQBH3sCxz8shD;
        Thu, 19 Nov 2020 16:29:43 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH v5 4/5] Add new file in LKDTM to test fortified strscpy.
Date:   Thu, 19 Nov 2020 17:29:42 +0100
Message-ID: <17083947.HZsgYSklLr@machine>
In-Reply-To: <202011181201.59B1B947A@keescook>
References: <20201118110731.15833-1-laniel_francis@privacyrequired.com> <20201118110731.15833-5-laniel_francis@privacyrequired.com> <202011181201.59B1B947A@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mercredi 18 novembre 2020, 21:02:32 CET Kees Cook a =E9crit :
> On Wed, Nov 18, 2020 at 12:07:30PM +0100, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > This new test ensures that fortified strscpy has the same behavior than
> > vanilla strscpy (e.g. returning -E2BIG when src content is truncated).
> > Finally, it generates a crash at runtime because there is a write overf=
low
> > in destination string.
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >=20
> >  drivers/misc/lkdtm/Makefile             |  1 +
> >  drivers/misc/lkdtm/core.c               |  1 +
> >  drivers/misc/lkdtm/fortify.c            | 82 +++++++++++++++++++++++++
> >  drivers/misc/lkdtm/lkdtm.h              |  3 +
> >  tools/testing/selftests/lkdtm/tests.txt |  1 +
> >  5 files changed, 88 insertions(+)
> >  create mode 100644 drivers/misc/lkdtm/fortify.c
> >=20
> > diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> > index c70b3822013f..d898f7b22045 100644
> > --- a/drivers/misc/lkdtm/Makefile
> > +++ b/drivers/misc/lkdtm/Makefile
> > @@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+=3D rodata_objcopy.o
> >=20
> >  lkdtm-$(CONFIG_LKDTM)		+=3D usercopy.o
> >  lkdtm-$(CONFIG_LKDTM)		+=3D stackleak.o
> >  lkdtm-$(CONFIG_LKDTM)		+=3D cfi.o
> >=20
> > +lkdtm-$(CONFIG_LKDTM)		+=3D fortify.o
> >=20
> >  KASAN_SANITIZE_stackleak.o	:=3D n
> >  KCOV_INSTRUMENT_rodata.o	:=3D n
> >=20
> > diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> > index b8c51a633fcc..3c0a67f072c0 100644
> > --- a/drivers/misc/lkdtm/core.c
> > +++ b/drivers/misc/lkdtm/core.c
> > @@ -175,6 +175,7 @@ static const struct crashtype crashtypes[] =3D {
> >=20
> >  	CRASHTYPE(USERCOPY_KERNEL),
> >  	CRASHTYPE(STACKLEAK_ERASING),
> >  	CRASHTYPE(CFI_FORWARD_PROTO),
> >=20
> > +	CRASHTYPE(FORTIFIED_STRSCPY),
> >=20
> >  #ifdef CONFIG_X86_32
> > =20
> >  	CRASHTYPE(DOUBLE_FAULT),
> > =20
> >  #endif
> >=20
> > diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
> > new file mode 100644
> > index 000000000000..790d46591bf5
> > --- /dev/null
> > +++ b/drivers/misc/lkdtm/fortify.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Francis Laniel <laniel_francis@privacyrequired.c=
om>
> > + *
> > + * Add tests related to fortified functions in this file.
> > + */
> > +#include <linux/string.h>
> > +#include <linux/slab.h>
> > +#include "lkdtm.h"
>=20
> Ah, I just noticed one small nit here during build testing: lkdtm.h
> needs to be included first to get the correct pr_fmt to avoid a warning:
>=20
> In file included from drivers/misc/lkdtm/fortify.c:9:
> drivers/misc/lkdtm/lkdtm.h:5: warning: "pr_fmt" redefined
>     5 | #define pr_fmt(fmt) "lkdtm: " fmt
>=20
> -Kees

This my bad, I noticed this warning but though it was "normal" with LKDTM.
I should have asked about it!

I will send the v6 soon!


