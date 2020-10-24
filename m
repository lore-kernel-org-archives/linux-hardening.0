Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE304C4363A
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A634E2226B
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 10:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="KGF3lxui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760991AbgJXKgt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 06:36:49 -0400
Received: from confino.investici.org ([212.103.72.250]:25441 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760913AbgJXKgt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 06:36:49 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CJHb25zWSz12bk;
        Sat, 24 Oct 2020 10:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603535806;
        bh=xWkDeALRgm8S298EDz6zxzlwhDmf59s75GtPFeBgo3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGF3lxuikKA+63mPuI1Jm1LqlR5Vnc2ueouk0phEBJxHCAEttX+xppuoM/onL1aXC
         b4k+Df2eG2osTlwnzA83Q0CDJHFIEBBtoQ4L2ZZItbUxzNQzWZyUcM5yIGrGMWrUHA
         VCVsZCFX57q7np3OjREKSisLI75pvkE6dhfa9X/g=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CJHb252rqz12bV;
        Sat, 24 Oct 2020 10:36:46 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC][PATCH v3 3/5] Fortify string function strscpy.
Date:   Sat, 24 Oct 2020 12:36:46 +0200
Message-ID: <1757511.6Qb6Y897ce@machine>
In-Reply-To: <202010232017.14FB7034@keescook>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com> <20201021150608.16469-4-laniel_francis@privacyrequired.com> <202010232017.14FB7034@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 24 octobre 2020, 07:04:04 CEST Kees Cook a =E9crit :
> On Wed, Oct 21, 2020 at 05:06:06PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > Fortified strscpy detects write overflows to dest.
>=20
> This commit log needs to be expanded to explain the "why" of the change
> with some detail.
>=20
> Also, please look at the git commit history of include/linux/string.h
> for a sense of the kinds of Subject prefixes being used. I think this
> Subject should be something like:
>=20
> 	Subject: string.h: Add FORTIFY coverage for strscpy()
>=20

I will expand the commit message for the next version and adapt the title t=
o=20
follow the history.

> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  include/linux/string.h | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 46e91d684c47..add7426ff718 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -6,6 +6,8 @@
> >=20
> >  #include <linux/compiler.h>	/* for inline */
> >  #include <linux/types.h>	/* for size_t */
> >  #include <linux/stddef.h>	/* for NULL */
> >=20
> > +#include <linux/bug.h>		/* for WARN_ON_ONCE */
>=20
> ^^^ no longer needed

I will remove it!

>=20
> > +#include <linux/errno.h>	/* for E2BIG */
> >=20
> >  #include <stdarg.h>
> >  #include <uapi/linux/string.h>
> >=20
> > @@ -357,6 +359,42 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char
> > *q, size_t size)>=20
> >  	return ret;
> > =20
> >  }
> >=20
> > +/* defined after fortified strnlen to reuse it */
> > +extern ssize_t __real_strscpy(char *, const char *, size_t)
> > __RENAME(strscpy); +__FORTIFY_INLINE ssize_t strscpy(char *p, const char
> > *q, size_t size) +{
> > +	size_t len;
> > +	/*
> > +	 * Use 1 as second argument to guess only p size even and not the
>=20
> This isn't a "guess". Perhaps just say:
>=20
> /* Use string size rather than possible enclosing struct size. */
>=20

Your comment is clearer than mine, I will add it for the next release.

> > +	 * surrounding struct size (in case it is embedded inside a struct).
> > +	 */
> > +	size_t p_size =3D __builtin_object_size(p, 1);
>=20
> A short-circuit path should be added here:
>=20
> 	size_t q_size =3D __builtin_object_size(q, 1);
>         if (p_size =3D=3D (size_t)-1 && q_size =3D=3D (size_t)-1)
>                 return __real_strscpy(p, q, size);
>=20

I thought I misunderstood one of your passed message because I understood t=
hat=20
I should remove this snippet.
I will readd it and sorry for the misunderstanding.

> > +	/*
> > +	 * If size can be known at compile time and is greater than
> > +	 * p_size, generate a compile time write overflow error.
> > +	 */
> > +	if (__builtin_constant_p(size) && size > p_size)
> > +		__write_overflow();
>=20
> Compile-time size > p_size is caught here.
>=20
> Compile-time over-read on strings isn't catchable.
>=20
> > +
> > +	len =3D strnlen(q, size);
>=20
> Runtime over-read is caught here.
>=20
> > +	/*
> > +	 * strscpy handles read overflows by stop reading q when '\0' is
> > +	 * met.
> > +	 * We stick to this behavior here.
> > +	 */
> > +	len =3D (len >=3D size) ? size : len;
>=20
> This test isn't needed: strnlen(q, size) will never return larger than
> size. (i.e. len has already been reduced to size.)

Nice catch! I will remove this branch then.

>=20
> > +
> > +	/* Otherwise generate a runtime write overflow error. */
> > +	if (len > p_size)
> > +		fortify_panic(__func__);
>=20
> Runtime over-write is caught here, though I think this needs to be:
>=20
> 	if (len + 1 > p_size)
> 		fortify_panic(__func__);
>=20
> since we need to fit "len" plus NUL in p_size. len + 1 =3D=3D p_size is o=
k.
>=20

I am not really sure about this but I need to think more about it after cod=
ing=20
a new version and tested it.

> > +	/*
> > +	 * Still use size as third argument to correctly compute max
> > +	 * inside strscpy.
> > +	 */
>=20
> If we do this, then we run the risk of doing the over-read anyway. For
> this call, we need to use len in most cases.

I had trouble when I used len as argument in previous version of this patch=
=20
set.
But you are right we totally need to use len, moreover it avoids having=20
write_overflow.
I will then switch to len and test the code with LKDTM and gdb.

>=20
> > +	return __real_strscpy(p, q, size);
>=20
> In the unfortified case, -E2BIG will happen when strlen(q) >=3D size. When
> fortified, strnlen is capped at min(size, q_size), so -E2BIG could only
> happen when len =3D=3D size. If len < size, there will never be -E2BIG.
>=20
> So I think this means we need the __real_strscpy() call to look like this:
>=20
> 	// All safe from over-read  (len + 1 <=3D min(size, q_size): strnlen()
> above). // All safe from over-write (len + 1 <=3D p_size: explicit test
> above). if (len < size)
> 		return __real_strscpy(p, q, len + 1); // not E2BIG
> 	else if (len + 1 =3D=3D size)
> 		return __real_strscpy(p, q, len + 1); // not E2BIG
> 	else if (len =3D=3D size) // therefore size < min(size, q_size, p_size)
> 		return __real_strscpy(p, q, size);    // E2BIG
> 	else //  len + 1 > size
> 		return __real_strscpy(p, q, len + 1); // E2BIG
>=20
> or simply:
>=20
> 	return __real_strscpy(p, q, len =3D=3D size ? size : len + 1);
>=20
> But the complexity here clearly calls for test cases.
>=20

Modifying the last argument of __real_strscpy() can modify what it returns =
so=20
fortified strscpy will not return the same as __real_strscpy().
I will stick for the behavior of __real__strscpy() for next release.
Maybe I will first write the test then the fortified function so I am sure =
there=20
is no problem with the new version.

Thank you for the complete review though!

> > +}
> > +
> >=20
> >  /* defined after fortified strlen and strnlen to reuse them */
> >  __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t
> >  count) {




