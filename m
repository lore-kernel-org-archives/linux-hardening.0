Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E5C433E7
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6D7206ED
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="ISon/zUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437778AbgJQJWJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 05:22:09 -0400
Received: from confino.investici.org ([212.103.72.250]:43793 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437775AbgJQJWJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 05:22:09 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCyG52b3cz12m3;
        Sat, 17 Oct 2020 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602926525;
        bh=lt+nVGh/K09TUN8TQResc5l4/S510ttQChAFFdvQx2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISon/zUytDcagV8gjHPjjisOnMnmMnqJYTNDa+Z1qFr/tP7BetzAYbWZ6Cvie29/h
         e11vNTOmrmIWv+eUfja4jU5+qcXzXTLVcVbdfONNsBPNjQVeWGY8zoXjrl/R7aGRB0
         thkxpn57H5n/8/wtHF25jIS+u8d5F7kXUEinPwxo=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCyG51lPVz12m0;
        Sat, 17 Oct 2020 09:22:05 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC][PATCH v2] Fortify string function strscpy.
Date:   Sat, 17 Oct 2020 11:22:04 +0200
Message-ID: <2224107.5bobqytM52@machine>
In-Reply-To: <202010161555.A73EEE9@keescook>
References: <20201013165955.7350-1-laniel_francis@privacyrequired.com> <20201016123808.10007-1-laniel_francis@privacyrequired.com> <202010161555.A73EEE9@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 17 octobre 2020, 01:16:36 CEST Kees Cook a =E9crit :
> On Fri, Oct 16, 2020 at 02:38:09PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > Thanks to kees advices (see:
> > https://github.com/KSPP/linux/issues/96#issuecomment-709620337) I wrote=
 a
> > LKDTM test for the fortified version of strscpy I added in the v1 of th=
is
> > patch. The test panics due to write overflow.
>=20
> Ah nice, thanks! I am reminded about this series as well:
> https://lore.kernel.org/lkml/20200120045424.16147-1-dja@axtens.net
> I think we can likely do this all at the same time, merge the
> complementary pieces, etc.

You are welcome!
Just to be sure I understand correctly: you want me to add work of Daniel=20
Axtens to my local version, then add my modifications on top of his work an=
d=20
republish the whole patch set?

>=20
> Notes below...
>=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  drivers/misc/lkdtm/Makefile  |  1 +
> >  drivers/misc/lkdtm/core.c    |  1 +
> >  drivers/misc/lkdtm/fortify.c | 37 +++++++++++++++++++++++++++++
> >  drivers/misc/lkdtm/lkdtm.h   | 17 ++++++++------
>=20
> Yay tests! These should, however, be a separate patch.

Ok, I will separate it.
If I understand correctly: one semantic modification =3D one commit.

>=20
> >  include/linux/string.h       | 45 ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 94 insertions(+), 7 deletions(-)
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
> > index a5e344df9166..979f9e3feefd 100644
> > --- a/drivers/misc/lkdtm/core.c
> > +++ b/drivers/misc/lkdtm/core.c
> > @@ -178,6 +178,7 @@ static const struct crashtype crashtypes[] =3D {
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
> > index 000000000000..0397d2def66d
> > --- /dev/null
> > +++ b/drivers/misc/lkdtm/fortify.c
> > @@ -0,0 +1,37 @@
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
> > + * Calls fortified strscpy to generate a panic because there is a write
> > + * overflow (i.e. src length is greater than dst length).
> > + */
> > +void lkdtm_FORTIFIED_STRSCPY(void)
> > +{
> > +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) &&
> > defined(CONFIG_FORTIFY_SOURCE) +	char *src;
> > +	char dst[3];
> > +
> > +	src =3D kmalloc(7, GFP_KERNEL);
> > +	src[0] =3D 'f';
> > +	src[1] =3D 'o';
> > +	src[2] =3D 'o';
> > +	src[3] =3D 'b';
> > +	src[4] =3D 'a';
> > +	src[5] =3D 'r';
> > +	src[6] =3D '\0';
>=20
> Hah, yes, I guess we need to bypass the common utilities. ;) I wonder if
> using __underlying_strcpy() might be easier.

I am sorry but I did not understand.
If we use here __underlying_strcpy() the function this will not profit from=
 the=20
protection added in fortified version of strscpy()?

>=20
> > +
> > +	strscpy(dst, src, 1000);
> > +
> > +	kfree(dst);
> > +
> > +	pr_info("Fail: No overflow in above strscpy call!\n");
> > +#endif
> > +}
>=20
> One thing I'd love to see is a _compile-time_ test too: but it needs to
> be a negative failure case, which Makefiles are not well suited to
> dealing with. e.g. something like:
>=20
> good.o: nop.c bad.c
> 	if $(CC) .... -o bad.o bad.c $< ; then exit 1; else $(CC) ... -o good.c
> nop.c ; fi
>=20
> I'm not sure how to do it.
>=20

This is a good idea, I though to it but I did not see an easy way to deal w=
ith=20
it.
I will investigate one it, but I cannot guarantee the next version will com=
e=20
with this feature.

> > diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> > index 8878538b2c13..8e5e90eb0e00 100644
> > --- a/drivers/misc/lkdtm/lkdtm.h
> > +++ b/drivers/misc/lkdtm/lkdtm.h
> > @@ -6,7 +6,7 @@
> >=20
> >  #include <linux/kernel.h>
> >=20
> > -/* lkdtm_bugs.c */
> > +/* bugs.c */
>=20
> oops, yes. Can you split change from the others, since it's an unrelated
> clean-up.

Understand, it will be done for next version!

>=20
> >  void __init lkdtm_bugs_init(int *recur_param);
> >  void lkdtm_PANIC(void);
> >  void lkdtm_BUG(void);
> >=20
> > @@ -34,7 +34,7 @@ void lkdtm_UNSET_SMEP(void);
> >=20
> >  void lkdtm_DOUBLE_FAULT(void);
> >  void lkdtm_CORRUPT_PAC(void);
> >=20
> > -/* lkdtm_heap.c */
> > +/* heap.c */
> >=20
> >  void __init lkdtm_heap_init(void);
> >  void __exit lkdtm_heap_exit(void);
> >  void lkdtm_OVERWRITE_ALLOCATION(void);
> >=20
> > @@ -46,7 +46,7 @@ void lkdtm_SLAB_FREE_DOUBLE(void);
> >=20
> >  void lkdtm_SLAB_FREE_CROSS(void);
> >  void lkdtm_SLAB_FREE_PAGE(void);
> >=20
> > -/* lkdtm_perms.c */
> > +/* perms.c */
> >=20
> >  void __init lkdtm_perms_init(void);
> >  void lkdtm_WRITE_RO(void);
> >  void lkdtm_WRITE_RO_AFTER_INIT(void);
> >=20
> > @@ -61,7 +61,7 @@ void lkdtm_EXEC_NULL(void);
> >=20
> >  void lkdtm_ACCESS_USERSPACE(void);
> >  void lkdtm_ACCESS_NULL(void);
> >=20
> > -/* lkdtm_refcount.c */
> > +/* refcount.c */
> >=20
> >  void lkdtm_REFCOUNT_INC_OVERFLOW(void);
> >  void lkdtm_REFCOUNT_ADD_OVERFLOW(void);
> >  void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void);
> >=20
> > @@ -82,10 +82,10 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
> >=20
> >  void lkdtm_REFCOUNT_TIMING(void);
> >  void lkdtm_ATOMIC_TIMING(void);
> >=20
> > -/* lkdtm_rodata.c */
> > +/* rodata.c */
> >=20
> >  void lkdtm_rodata_do_nothing(void);
> >=20
> > -/* lkdtm_usercopy.c */
> > +/* usercopy.c */
> >=20
> >  void __init lkdtm_usercopy_init(void);
> >  void __exit lkdtm_usercopy_exit(void);
> >  void lkdtm_USERCOPY_HEAP_SIZE_TO(void);
> >=20
> > @@ -98,10 +98,13 @@ void lkdtm_USERCOPY_STACK_BEYOND(void);
> >=20
> >  void lkdtm_USERCOPY_KERNEL(void);
> >  void lkdtm_USERCOPY_KERNEL_DS(void);
> >=20
> > -/* lkdtm_stackleak.c */
> > +/* stackleak.c */
> >=20
> >  void lkdtm_STACKLEAK_ERASING(void);
> > =20
> >  /* cfi.c */
> >  void lkdtm_CFI_FORWARD_PROTO(void);
> >=20
> > +/* fortify.c */
> > +void lkdtm_FORTIFIED_STRSCPY(void);
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index b1f3894a0a3e..b661863619e0 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -6,6 +6,8 @@
> >=20
> >  #include <linux/compiler.h>	/* for inline */
> >  #include <linux/types.h>	/* for size_t */
> >  #include <linux/stddef.h>	/* for NULL */
> >=20
> > +#include <linux/bug.h>		/* for WARN_ON_ONCE */
> > +#include <linux/errno.h>	/* for E2BIG */
> >=20
> >  #include <stdarg.h>
> >  #include <uapi/linux/string.h>
> >=20
> > @@ -357,6 +359,49 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char
> > *q, size_t size)>=20
> >  	return ret;
> > =20
> >  }
> >=20
> > +/* defined after fortified strlen to reuse it */
> > +extern ssize_t __real_strscpy(char *, const char *, size_t)
> > __RENAME(strscpy); +__FORTIFY_INLINE ssize_t strscpy(char *p, const char
> > *q, size_t count)
> I would name "count" as "size" to match the other helpers.
>=20

I decided to keep count because it is the argument name in unfortified vers=
ion=20
of strscpy
I will change the name for next version to stick with all the fortified=20
functions arguments.

> > +{
> > +	size_t len;
> > +	size_t p_size =3D __builtin_object_size(p, 0);
> > +	size_t q_size =3D __builtin_object_size(q, 0);
>=20
> These can be using ", 1" instead of ", 0". And I'll grab the related
> changes from the mentioned series above.
>=20

I looked Daniel Axtens patch and understood why it is better to use 1 inste=
ad=20
of 0 so I will add it for the next version.

> > +	/*
> > +	 * If p_size and q_size cannot be known at compile time we just had to
> > +	 * trust this function caller.
> > +	 */
> > +	if (p_size =3D=3D (size_t)-1 && q_size =3D=3D (size_t)-1)
> > +		return __real_strscpy(p, q, count);
> > +	len =3D strlen(q);
> > +	if (count) {
>=20
> This test isn't needed; it'll work itself out correctly. :P
>=20

Indeed, if this condition is met, __real_strscpy will be called later.

> > +		/* If count is bigger than INT_MAX, strscpy returns -E2BIG. */
> > +		if (WARN_ON_ONCE(count > INT_MAX))
> > +			return -E2BIG;
>=20
> This is already handled in strscpy, I'd drop this here.

I though of it at first, but since the patch modify count/size before givin=
g it=20
to __real_strscpy(), real one will never return -E2BIG due to that.
So removing this modification will lead to difference between returned valu=
e of=20
fortified strscpy() and __real_strscpy().

>=20
> > +		/*
> > +		 * strscpy handles read overflows by stop reading q when '\0' is
> > +		 * met.
> > +		 * We stick to this behavior here.
> > +		 */
> > +		len =3D (len >=3D count) ? count : len;
> > +		/*
> > +		 * If len can be known at compile time and is greater than
> > +		 * p_size, generate a compile time write overflow error.
> > +		 */
> > +		if (__builtin_constant_p(len) && len > p_size)
>=20
> This won't work (len wasn't an argument and got assigned); you need:
>=20
> 		if (__builtin_constant_p(size) && p_size < size)
>=20

You are right, len is unknown at compile time... So, I will correct it for=
=20
next version!

> > +			__write_overflow();
> > +		/* Otherwise generate a runtime write overflow error. */
> > +		if (len > p_size)
> > +			fortify_panic(__func__);
>=20
> I think this just needs to be:
>=20
> 		if (p_size < size)
> 			fortify_panic(__func__);
>=20

I am not really sure.
If p_size is 4, size is 1000 and q is "foo\0", then what you suggested will=
=20
panic but there is not need to panic since __real_strscpy will truncate siz=
e=20
and copy just 4 bytes into p (because of '\0' in q).
Am I correct?

> > +		/*
> > +		 * Still use count as third argument to correctly compute max
> > +		 * inside strscpy.
> > +		 */
> > +		return __real_strscpy(p, q, count);
> > +	}
> > +	/* If count is 0, strscpy return -E2BIG. */
> > +	return -E2BIG;
>=20
> I'd let __real_strscpy() handle this.
>=20

See my three times above comment.
__real_strscpy is called only if count > 0, so it will never return -E2BIG =
due=20
to this.
So it will lead to difference in returned value between fortified strscpy()=
 and=20
__real_strscpy().

> > +}
> > +
> >=20
> >  /* defined after fortified strlen and strnlen to reuse them */
> >  __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t
> >  count) {




