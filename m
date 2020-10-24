Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB509C4363A
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 10:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E852226B
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 10:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="iCihgVlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760917AbgJXKTs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760916AbgJXKTs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 06:19:48 -0400
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCDC0613CE
        for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2020 03:19:47 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CJHCP3zYFz8wgW;
        Sat, 24 Oct 2020 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603534785;
        bh=Wa0yfVjmKCkFr1gbrPAvLAk1MAsdKasb0+S443HaO2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCihgVlIi/UUcF6trVQSHZlecSS6p9xLOyZlu2oRw4iSchhon8zHeRBm5y1eet12Q
         rENmkGp0D3SMH90OZxrDarDOA8e7fCzvCrEfzm5yr61oTn7A0p938d7RYOmjrG9ndy
         Svt2nEBg/cQIiJBALpgN9moqPFK31Iq4rsMgNNcw=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CJHCP1rQKz8wgV;
        Sat, 24 Oct 2020 10:19:45 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC][PATCH v3 4/5] Add new file in LKDTM to test fortified strscpy.
Date:   Sat, 24 Oct 2020 12:19:44 +0200
Message-ID: <3172137.tozOrHZ9KS@machine>
In-Reply-To: <202010232204.9DCF5501DA@keescook>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com> <20201021150608.16469-5-laniel_francis@privacyrequired.com> <202010232204.9DCF5501DA@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 24 octobre 2020, 07:23:01 CEST Kees Cook a =E9crit :
> On Wed, Oct 21, 2020 at 05:06:07PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > This new test generates a crash at runtime because there is a write
> > overflow in destination string.
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  drivers/misc/lkdtm/Makefile             |  1 +
> >  drivers/misc/lkdtm/core.c               |  1 +
> >  drivers/misc/lkdtm/fortify.c            | 47 +++++++++++++++++++++++++
> >  drivers/misc/lkdtm/lkdtm.h              |  3 ++
> >  tools/testing/selftests/lkdtm/tests.txt |  1 +
> >  5 files changed, 53 insertions(+)
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
> > index a002f39a5964..4326e2d09870 100644
> > --- a/drivers/misc/lkdtm/core.c
> > +++ b/drivers/misc/lkdtm/core.c
> > @@ -180,6 +180,7 @@ static const struct crashtype crashtypes[] =3D {
> >=20
> >  #ifdef CONFIG_X86_32
> > =20
> >  	CRASHTYPE(DOUBLE_FAULT),
> > =20
> >  #endif
> >=20
> > +	CRASHTYPE(FORTIFIED_STRSCPY),
> >=20
> >  };
> >=20
> > diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
> > new file mode 100644
> > index 000000000000..cecdfbb8ba55
> > --- /dev/null
> > +++ b/drivers/misc/lkdtm/fortify.c
> > @@ -0,0 +1,47 @@
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
> > +
> > +
> > +/*
> > + * Calls fortified strscpy to test that it returns the same result as
> > vanilla + * strscpy and generate a panic because there is a write
> > overflow (i.e. src + * length is greater than dst length).
> > + */
> > +void lkdtm_FORTIFIED_STRSCPY(void)
> > +{
> > +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) &&
> > defined(CONFIG_FORTIFY_SOURCE)
> I would drop the #if: just let it run and freak out on non-fortified
> kernels.

I will drop it for v4.

> > +	char *src;
> > +	char dst[3];
> > +
> > +	src =3D kstrdup("foobar", GFP_KERNEL);
> > +
> > +	if (src =3D=3D NULL)
> > +		return;
> > +
> > +	/* Vanilla strscpy returns -E2BIG if size is 0. */
> > +	WARN_ON(strscpy(dst, src, 0) !=3D -E2BIG);
>=20
> For LKDTM, we have different reporting that "normal", in the sense that
> usually the WARN/BUG outcomes are _desirable_ (i.e. "freak out on stack
> overflow"). So, I would write this as:
>=20
> 	if (strscpy(dst, src, 0) !=3D -E2BIG)
> 		pr_warn("FAIL: strscpy() of 0 length did not return -E2BIG\n");

I was not sure if using WARN_* lile macro was a good idea in LKDTM since if=
 I=20
understood correctly the goal of a LKDTM test is to fail.
I will rewrite it the way you suggested it for the v4.

> > +
> > +	/* Vanilla strscpy returns -E2BIG if src is truncated. */
> > +	WARN_ON(strscpy(dst, src, sizeof(dst)) !=3D -E2BIG);
>=20
> Same.
>=20
> > +
> > +	/* After above call, dst must contain "fo" because src was truncated.=
 */
> > +	WARN_ON(strncmp(dst, "fo", sizeof(dst)) !=3D 0);
>=20
> Same.
>=20
> > +
> > +	/*
> > +	 * Use strlen here so size cannot be known at compile time and there =
is
> > +	 * a runtime overflow.
> > +	 */
> > +	strscpy(dst, src, strlen(src));
>=20
> I think we'll need a couple more corner cases, and any that need to Oops
> separately can be separate functions. Here's a corner case to test to
> strnlen():
>=20
> struct {
> 	union {
> 	        char big[10];
> 	        char src[5];
> 	};
> } weird =3D { .big =3D "hello!" };
> char dst[sizeof(weird.src) + 1];
>=20
> strscpy(dst, weird.src, sizeof(dst));
>=20
> if (strcmp(dst, "hello") !=3D 0)
> 	pr_warn("FAIL ...
>=20
> But each of the cases being tested in the fortified strscpy() should be
> exercised.

I will try to add these cases and other tests, if I think to more, for the=
=20
next version so the tests cover as most case as possible.

> > +
> > +	pr_info("Fail: No overflow in above strscpy call!\n");
>=20
> pr_warn("FAIL: ...
>=20

Will be modified for next release!

> > +
> > +	kfree(src);
> > +#endif
> > +}
> > diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> > index 70c8b7c9460f..29c12dcdeab1 100644
> > --- a/drivers/misc/lkdtm/lkdtm.h
> > +++ b/drivers/misc/lkdtm/lkdtm.h
> > @@ -106,4 +106,7 @@ void lkdtm_STACKLEAK_ERASING(void);
> >=20
> >  /* cfi.c */
> >  void lkdtm_CFI_FORWARD_PROTO(void);
> >=20
> > +/* fortify.c */
> > +void lkdtm_FORTIFIED_STRSCPY(void);
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/tools/testing/selftests/lkdtm/tests.txt
> > b/tools/testing/selftests/lkdtm/tests.txt index
> > 9d266e79c6a2..4234109579eb 100644
> > --- a/tools/testing/selftests/lkdtm/tests.txt
> > +++ b/tools/testing/selftests/lkdtm/tests.txt
> > @@ -70,3 +70,4 @@ USERCOPY_KERNEL
> >=20
> >  USERCOPY_KERNEL_DS
> >  STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
> >  CFI_FORWARD_PROTO
> >=20
> > +FORTIFIED_STRSCPY
> > \ No newline at end of file




