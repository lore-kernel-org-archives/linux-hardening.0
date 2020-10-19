Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5FFC433E7
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5912240C
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/23EFoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbgJSXTq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbgJSXTp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 19:19:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F97C0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:19:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h4so69688pjk.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wa3DYrL7q9kV/Tm9AGXm24UAsNlzJ2A1b0WRPtMvNF4=;
        b=G/23EFoAZOqgesTyeZwkG6XPzZV9F3tYCS+724ey2UsfY/1aagkfHf0YGBqSamDmdB
         1zAXBv3lP+Q5MsgmGEFERcev3AfB1OROIsS0bj12ggEsnu7vMxOuzGna6pLcfjnO/1lF
         cTolGZszBO5FE/XMPofX7RgZgwNVBP2GxTuw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wa3DYrL7q9kV/Tm9AGXm24UAsNlzJ2A1b0WRPtMvNF4=;
        b=gNhPqjsd2HQG4hmgUxlFqy1yWW6/zrkFboGcy9AZdnz++Lg01ODEXpicSY/bVc+PNF
         qDnxplCyuI90CetlOm1ilKR6NuykxwIUZUiObIN2FKShBfzSk5H7ZOyblaUHzGdxfRa3
         sfRlMtcHLYkm2aMLPPElcu5xpLlO/TESFrfGWkIj5luBHYE3EkIML4wcjK60DLqntYOL
         DKFJsTp5g8AoHVGaUWUbSIUgPi+6MxJyaWtdLV2VrNKTx3Luk1/MTee+zLAO4221kUS2
         v926h2WFU/58lov9WmJeywR8iqITPVlm3/R99PWYwUHkhwgC13TnVRgWwXB9vCfnj318
         lHWw==
X-Gm-Message-State: AOAM533QohiRnR2La7jjKY4ghrOwa2egVqVwM3T2sJVEF3gxov4vbOq6
        fhfFfKcVed9v3bABi/7kPXbzEmVZizGcSA==
X-Google-Smtp-Source: ABdhPJyO7EbE1zIjHHqNDuzqEaJTmZ9dQ/j8/H8nbLnoKGVlflnv9DSlXRu4/UWES9+evPfbLhBB9g==
X-Received: by 2002:a17:90a:d18c:: with SMTP id fu12mr145440pjb.102.1603149585058;
        Mon, 19 Oct 2020 16:19:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o23sm49114pjw.32.2020.10.19.16.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:19:44 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:19:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Francis Laniel <laniel_francis@privacyrequired.com>
Cc:     linux-hardening@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC][PATCH v2] Fortify string function strscpy.
Message-ID: <202010191606.72397DFC6E@keescook>
References: <20201013165955.7350-1-laniel_francis@privacyrequired.com>
 <20201016123808.10007-1-laniel_francis@privacyrequired.com>
 <202010161555.A73EEE9@keescook>
 <2224107.5bobqytM52@machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2224107.5bobqytM52@machine>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 17, 2020 at 11:22:04AM +0200, Francis Laniel wrote:
> Le samedi 17 octobre 2020, 01:16:36 CEST Kees Cook a écrit :
> > On Fri, Oct 16, 2020 at 02:38:09PM +0200, laniel_francis@privacyrequired.com 
> wrote:
> > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > 
> > > Thanks to kees advices (see:
> > > https://github.com/KSPP/linux/issues/96#issuecomment-709620337) I wrote a
> > > LKDTM test for the fortified version of strscpy I added in the v1 of this
> > > patch. The test panics due to write overflow.
> > 
> > Ah nice, thanks! I am reminded about this series as well:
> > https://lore.kernel.org/lkml/20200120045424.16147-1-dja@axtens.net
> > I think we can likely do this all at the same time, merge the
> > complementary pieces, etc.
> 
> You are welcome!
> Just to be sure I understand correctly: you want me to add work of Daniel 
> Axtens to my local version, then add my modifications on top of his work and 
> republish the whole patch set?

Yup; I would rebase his, and then have your patches follow.

> 
> > 
> > Notes below...
> > 
> > > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > > ---
> > > 
> > >  drivers/misc/lkdtm/Makefile  |  1 +
> > >  drivers/misc/lkdtm/core.c    |  1 +
> > >  drivers/misc/lkdtm/fortify.c | 37 +++++++++++++++++++++++++++++
> > >  drivers/misc/lkdtm/lkdtm.h   | 17 ++++++++------
> > 
> > Yay tests! These should, however, be a separate patch.
> 
> Ok, I will separate it.
> If I understand correctly: one semantic modification = one commit.

Right -- I'd like to see the tests be separate. Also, probably the new
test should get added to tools/testing/selftests/lkdtm/tests.txt. I
forgot to suggest that last time!

> > > +/*
> > > + * Calls fortified strscpy to generate a panic because there is a write
> > > + * overflow (i.e. src length is greater than dst length).
> > > + */
> > > +void lkdtm_FORTIFIED_STRSCPY(void)
> > > +{
> > > +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) &&
> > > defined(CONFIG_FORTIFY_SOURCE) +	char *src;
> > > +	char dst[3];
> > > +
> > > +	src = kmalloc(7, GFP_KERNEL);
> > > +	src[0] = 'f';
> > > +	src[1] = 'o';
> > > +	src[2] = 'o';
> > > +	src[3] = 'b';
> > > +	src[4] = 'a';
> > > +	src[5] = 'r';
> > > +	src[6] = '\0';
> > 
> > Hah, yes, I guess we need to bypass the common utilities. ;) I wonder if
> > using __underlying_strcpy() might be easier.
> 
> I am sorry but I did not understand.
> If we use here __underlying_strcpy() the function this will not profit from the 
> protection added in fortified version of strscpy()?

Sorry, I meant that instead open-coding the assignment, you could use
__underlying_strcpy(). Better yet, now that I look at it, would be:

	src = strdup("foobar", GFP_KERNEL);

Instead of the kmalloc and src[0], src[1] = ...

> > > +
> > > +	strscpy(dst, src, 1000);
> > > +
> > > +	kfree(dst);
> > > +
> > > +	pr_info("Fail: No overflow in above strscpy call!\n");
> > > +#endif
> > > +}
> > 
> > One thing I'd love to see is a _compile-time_ test too: but it needs to
> > be a negative failure case, which Makefiles are not well suited to
> > dealing with. e.g. something like:
> > 
> > good.o: nop.c bad.c
> > 	if $(CC) .... -o bad.o bad.c $< ; then exit 1; else $(CC) ... -o good.c
> > nop.c ; fi
> > 
> > I'm not sure how to do it.
> > 
> 
> This is a good idea, I though to it but I did not see an easy way to deal with 
> it.
> I will investigate one it, but I cannot guarantee the next version will come 
> with this feature.

Yeah, this isn't required for the series; it's just me thinking out
loud. It'd be really nice to validate the fortification on the compile
side. Though, in following Linus's guidelines, it may need to be a
warning, not a hard failure of the build. Hmm.

> > > +extern ssize_t __real_strscpy(char *, const char *, size_t)
> > > __RENAME(strscpy); +__FORTIFY_INLINE ssize_t strscpy(char *p, const char
> > > *q, size_t count)
> > > +{
> > > +	size_t len;
> > > +	size_t p_size = __builtin_object_size(p, 0);
> > > +	size_t q_size = __builtin_object_size(q, 0);
> > > +	/*
> > > +	 * If p_size and q_size cannot be known at compile time we just had to
> > > +	 * trust this function caller.
> > > +	 */
> > > +	if (p_size == (size_t)-1 && q_size == (size_t)-1)
> > > +		return __real_strscpy(p, q, count);
> > > +	len = strlen(q);

I realize again that this needs to be strnlen(q, size), I think?
Otherwise we're just repeating the flaws of strlcpy().

> > > +	if (count) {
> > 
> > This test isn't needed; it'll work itself out correctly. :P
> 
> Indeed, if this condition is met, __real_strscpy will be called later.
> 
> > > +		/* If count is bigger than INT_MAX, strscpy returns -E2BIG. */
> > > +		if (WARN_ON_ONCE(count > INT_MAX))
> > > +			return -E2BIG;
> > 
> > This is already handled in strscpy, I'd drop this here.
> 
> I though of it at first, but since the patch modify count/size before giving it 
> to __real_strscpy(), real one will never return -E2BIG due to that.
> So removing this modification will lead to difference between returned value of 
> fortified strscpy() and __real_strscpy().

I think if you avoid modifying size, it'll work out correctly.

> > 
> > > +		/*
> > > +		 * strscpy handles read overflows by stop reading q when '\0' is
> > > +		 * met.
> > > +		 * We stick to this behavior here.
> > > +		 */
> > > +		len = (len >= count) ? count : len;
> > > +		/*
> > > +		 * If len can be known at compile time and is greater than
> > > +		 * p_size, generate a compile time write overflow error.
> > > +		 */
> > > +		if (__builtin_constant_p(len) && len > p_size)
> > 
> > This won't work (len wasn't an argument and got assigned); you need:
> > 
> > 		if (__builtin_constant_p(size) && p_size < size)
> > 
> 
> You are right, len is unknown at compile time... So, I will correct it for 
> next version!
> 
> > > +			__write_overflow();
> > > +		/* Otherwise generate a runtime write overflow error. */
> > > +		if (len > p_size)
> > > +			fortify_panic(__func__);
> > 
> > I think this just needs to be:
> > 
> > 		if (p_size < size)
> > 			fortify_panic(__func__);
> > 
> 
> I am not really sure.
> If p_size is 4, size is 1000 and q is "foo\0", then what you suggested will 
> panic but there is not need to panic since __real_strscpy will truncate size 
> and copy just 4 bytes into p (because of '\0' in q).
> Am I correct?

Hm, so, if p_size is 4 and size is __builtin_constant_p(), and p_size
< size, it should fail to compile. (The wrong max size is proposed.)
But yes, you're right, for the runtime case, if len < p_size, we shouldn't
panic. But that means the test needs to be "len >= p_size"

> 
> > > +		/*
> > > +		 * Still use count as third argument to correctly compute max
> > > +		 * inside strscpy.
> > > +		 */
> > > +		return __real_strscpy(p, q, count);
> > > +	}
> > > +	/* If count is 0, strscpy return -E2BIG. */
> > > +	return -E2BIG;
> > 
> > I'd let __real_strscpy() handle this.
> > 
> 
> See my three times above comment.
> __real_strscpy is called only if count > 0, so it will never return -E2BIG due 
> to this.
> So it will lead to difference in returned value between fortified strscpy() and 
> __real_strscpy().

There are enough changes pending here that I'll wait for the next
version to look at this part again. Regardless, we should at least have
the tests described even if the compile-time ones can't be tested yet.

-- 
Kees Cook
