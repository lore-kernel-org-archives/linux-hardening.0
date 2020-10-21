Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B02C388F9
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6FC2224E
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 14:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="YGpZNi1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443197AbgJUOt1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442644AbgJUOt1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 10:49:27 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8BC0613CE
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2020 07:49:26 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGYKt5mqmz12jq;
        Wed, 21 Oct 2020 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603291762;
        bh=HNPD9ZgOxmFSibYl+85ZM61D1LVHTbCuhwp0hjBQhjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGpZNi1Yp8xiWvO1hqeJ6S63T3IfIxVVJTT3i75IXG6wxnpogn0azLo49wjcFzUa3
         HQDR4Y0/PecBSnQ950FUYpNV+fEqseZNhci3J1Udu0+UhavcpolH1p3/v0UwNWp6wV
         RuDBqFtmNhPdi8/GfwjHgIQNdVd0E2xexqIJw1iI=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CGYKt4kr7z12jb;
        Wed, 21 Oct 2020 14:49:22 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC][PATCH v2] Fortify string function strscpy.
Date:   Wed, 21 Oct 2020 16:49:21 +0200
Message-ID: <11802252.guoqaGusNR@machine>
In-Reply-To: <202010191606.72397DFC6E@keescook>
References: <20201013165955.7350-1-laniel_francis@privacyrequired.com> <2224107.5bobqytM52@machine> <202010191606.72397DFC6E@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 20 octobre 2020, 01:19:43 CEST Kees Cook a =E9crit :
> On Sat, Oct 17, 2020 at 11:22:04AM +0200, Francis Laniel wrote:
> > Le samedi 17 octobre 2020, 01:16:36 CEST Kees Cook a =E9crit :
> > > On Fri, Oct 16, 2020 at 02:38:09PM +0200,
> > > laniel_francis@privacyrequired.com>=20
> > wrote:
> > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > >=20
> > > > Thanks to kees advices (see:
> > > > https://github.com/KSPP/linux/issues/96#issuecomment-709620337) I
> > > > wrote a
> > > > LKDTM test for the fortified version of strscpy I added in the v1 of
> > > > this
> > > > patch. The test panics due to write overflow.
> > >=20
> > > Ah nice, thanks! I am reminded about this series as well:
> > > https://lore.kernel.org/lkml/20200120045424.16147-1-dja@axtens.net
> > > I think we can likely do this all at the same time, merge the
> > > complementary pieces, etc.
> >=20
> > You are welcome!
> > Just to be sure I understand correctly: you want me to add work of Dani=
el
> > Axtens to my local version, then add my modifications on top of his work
> > and republish the whole patch set?
>=20
> Yup; I would rebase his, and then have your patches follow.
>=20
> > > Notes below...
> > >=20
> > > > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > > > ---
> > > >=20
> > > >  drivers/misc/lkdtm/Makefile  |  1 +
> > > >  drivers/misc/lkdtm/core.c    |  1 +
> > > >  drivers/misc/lkdtm/fortify.c | 37 +++++++++++++++++++++++++++++
> > > >  drivers/misc/lkdtm/lkdtm.h   | 17 ++++++++------
> > >=20
> > > Yay tests! These should, however, be a separate patch.
> >=20
> > Ok, I will separate it.
> > If I understand correctly: one semantic modification =3D one commit.
>=20
> Right -- I'd like to see the tests be separate. Also, probably the new
> test should get added to tools/testing/selftests/lkdtm/tests.txt. I
> forgot to suggest that last time!

I separated my commit in three different for the v3.

>=20
> > > > +/*
> > > > + * Calls fortified strscpy to generate a panic because there is a
> > > > write
> > > > + * overflow (i.e. src length is greater than dst length).
> > > > + */
> > > > +void lkdtm_FORTIFIED_STRSCPY(void)
> > > > +{
> > > > +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) &&
> > > > defined(CONFIG_FORTIFY_SOURCE) +	char *src;
> > > > +	char dst[3];
> > > > +
> > > > +	src =3D kmalloc(7, GFP_KERNEL);
> > > > +	src[0] =3D 'f';
> > > > +	src[1] =3D 'o';
> > > > +	src[2] =3D 'o';
> > > > +	src[3] =3D 'b';
> > > > +	src[4] =3D 'a';
> > > > +	src[5] =3D 'r';
> > > > +	src[6] =3D '\0';
> > >=20
> > > Hah, yes, I guess we need to bypass the common utilities. ;) I wonder=
 if
> > > using __underlying_strcpy() might be easier.
> >=20
> > I am sorry but I did not understand.
> > If we use here __underlying_strcpy() the function this will not profit
> > from the protection added in fortified version of strscpy()?
>=20
> Sorry, I meant that instead open-coding the assignment, you could use
> __underlying_strcpy(). Better yet, now that I look at it, would be:
>=20
> 	src =3D strdup("foobar", GFP_KERNEL);
>=20
> Instead of the kmalloc and src[0], src[1] =3D ...

I did not think about strdup... It is now used in v3.

> > > > +
> > > > +	strscpy(dst, src, 1000);
> > > > +
> > > > +	kfree(dst);
> > > > +
> > > > +	pr_info("Fail: No overflow in above strscpy call!\n");
> > > > +#endif
> > > > +}
> > >=20
> > > One thing I'd love to see is a _compile-time_ test too: but it needs =
to
> > > be a negative failure case, which Makefiles are not well suited to
> > > dealing with. e.g. something like:
> > >=20
> > > good.o: nop.c bad.c
> > >=20
> > > 	if $(CC) .... -o bad.o bad.c $< ; then exit 1; else $(CC) ... -o goo=
d.c
> > >=20
> > > nop.c ; fi
> > >=20
> > > I'm not sure how to do it.
> >=20
> > This is a good idea, I though to it but I did not see an easy way to de=
al
> > with it.
> > I will investigate one it, but I cannot guarantee the next version will
> > come with this feature.
>=20
> Yeah, this isn't required for the series; it's just me thinking out
> loud. It'd be really nice to validate the fortification on the compile
> side. Though, in following Linus's guidelines, it may need to be a
> warning, not a hard failure of the build. Hmm.

Should we redeclare __write_overflow() as a warning instead of an error?

> > > > +extern ssize_t __real_strscpy(char *, const char *, size_t)
> > > > __RENAME(strscpy); +__FORTIFY_INLINE ssize_t strscpy(char *p, const
> > > > char
> > > > *q, size_t count)
> > > > +{
> > > > +	size_t len;
> > > > +	size_t p_size =3D __builtin_object_size(p, 0);
> > > > +	size_t q_size =3D __builtin_object_size(q, 0);
> > > > +	/*
> > > > +	 * If p_size and q_size cannot be known at compile time we just h=
ad
> > > > to
> > > > +	 * trust this function caller.
> > > > +	 */
> > > > +	if (p_size =3D=3D (size_t)-1 && q_size =3D=3D (size_t)-1)
> > > > +		return __real_strscpy(p, q, count);
> > > > +	len =3D strlen(q);
>=20
> I realize again that this needs to be strnlen(q, size), I think?
> Otherwise we're just repeating the flaws of strlcpy().

Using strnlen would save us when src does not contain '\0' so I replaced=20
strlen by strnlen for v3.

> > > > +	if (count) {
> > >=20
> > > This test isn't needed; it'll work itself out correctly. :P
> >=20
> > Indeed, if this condition is met, __real_strscpy will be called later.
> >=20
> > > > +		/* If count is bigger than INT_MAX, strscpy returns -E2BIG. */
> > > > +		if (WARN_ON_ONCE(count > INT_MAX))
> > > > +			return -E2BIG;
> > >=20
> > > This is already handled in strscpy, I'd drop this here.
> >=20
> > I though of it at first, but since the patch modify count/size before
> > giving it to __real_strscpy(), real one will never return -E2BIG due to
> > that. So removing this modification will lead to difference between
> > returned value of fortified strscpy() and __real_strscpy().
>=20
> I think if you avoid modifying size, it'll work out correctly.

I removed all about modifying size for v3.
When I implemented that I though "you should recompute size here because=20
strscpy can save you because it exits when '\0' is met".
Then I though about it and changed my mind because we need safety inside=20
fortified version of strscpy and the maximum safety.

> > > > +		/*
> > > > +		 * strscpy handles read overflows by stop reading q when '\0' is
> > > > +		 * met.
> > > > +		 * We stick to this behavior here.
> > > > +		 */
> > > > +		len =3D (len >=3D count) ? count : len;
> > > > +		/*
> > > > +		 * If len can be known at compile time and is greater than
> > > > +		 * p_size, generate a compile time write overflow error.
> > > > +		 */
> > > > +		if (__builtin_constant_p(len) && len > p_size)
> > >=20
> > > This won't work (len wasn't an argument and got assigned); you need:
> > > 		if (__builtin_constant_p(size) && p_size < size)
> >=20
> > You are right, len is unknown at compile time... So, I will correct it =
for
> > next version!
> >=20
> > > > +			__write_overflow();
> > > > +		/* Otherwise generate a runtime write overflow error. */
> > > > +		if (len > p_size)
> > > > +			fortify_panic(__func__);
> > >=20
> > > I think this just needs to be:
> > > 		if (p_size < size)
> > > 	=09
> > > 			fortify_panic(__func__);
> >=20
> > I am not really sure.
> > If p_size is 4, size is 1000 and q is "foo\0", then what you suggested
> > will
> > panic but there is not need to panic since __real_strscpy will truncate
> > size and copy just 4 bytes into p (because of '\0' in q).
> > Am I correct?
>=20
> Hm, so, if p_size is 4 and size is __builtin_constant_p(), and p_size
> < size, it should fail to compile. (The wrong max size is proposed.)
> But yes, you're right, for the runtime case, if len < p_size, we shouldn't
> panic. But that means the test needs to be "len >=3D p_size"

I do not agree on the fact that the condition should be "len >=3D p_size".
Indeed, there is not write overflow when len equals p_size, src can just be=
=20
truncated when written to dst.
When len is strictly greater than p_size, there is, for sure, a write overf=
low.

> > > > +		/*
> > > > +		 * Still use count as third argument to correctly compute max
> > > > +		 * inside strscpy.
> > > > +		 */
> > > > +		return __real_strscpy(p, q, count);
> > > > +	}
> > > > +	/* If count is 0, strscpy return -E2BIG. */
> > > > +	return -E2BIG;
> > >=20
> > > I'd let __real_strscpy() handle this.
> >=20
> > See my three times above comment.
> > __real_strscpy is called only if count > 0, so it will never return -E2=
BIG
> > due to this.
> > So it will lead to difference in returned value between fortified
> > strscpy() and __real_strscpy().
>=20
> There are enough changes pending here that I'll wait for the next
> version to look at this part again. Regardless, we should at least have
> the tests described even if the compile-time ones can't be tested yet.

Normally the review for the next version should be easier.


