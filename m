Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5024C433E7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451B020878
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PPYKOE5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409056AbgJPXQk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393118AbgJPXQj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 19:16:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F96C061755
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:16:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so2069125pld.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=69nALPk8v90pAaWTYkbWrsrnz1o7zHa+/D5qqOGzxmA=;
        b=PPYKOE5Ywm+L4fa+vNI9CB6dxQrqGD1+FZ7e94ABo9O2gKcFf0FE+6dPI0+7947eaj
         eqNhYlv72xxabSXxnJIhAZcdLSxi/EpmvWxuDS33GzurHoVRPIMx4oBWoHTkzphf6Btf
         QbnKHXtaa/xZuFA7xS/XI6C3A6NVjxl0U0cwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69nALPk8v90pAaWTYkbWrsrnz1o7zHa+/D5qqOGzxmA=;
        b=ev6Oc2oT+5mLyaga0Y0v1KZLI2em1GaZ8RdSC1XypZu6MvvTUsleNa07ECJ7tSlaZN
         rtnuLzk4gJfVmzfTHe5pbC0kqasZU8oSrjmWEv1oMU2Yjjs31si4s1jJT6gcQlv2uuva
         6bPL9745BF07QDsr6Dcc2TeU82Bv+4tp+JCnkCcPYLZDrQfaVp8mouthw4URNb47bKsh
         9+1B/DmyvwUWD+fcGUeGcMniHHMwQVeH/jMRh3kSa1GepV+kxZTJblvdFY0peHGLafNE
         kiQd2mK/Ux9AhRUAxKMzo11TqSptddnhEaYFGLSeCuVpbKEf4VaCH0sTwAsNdmjU7Pb2
         PxYQ==
X-Gm-Message-State: AOAM531ffGjY2hECbYFLNYX+7jMNxuvfveP924K06Yqlr8/umde52lQk
        vzGL4Jduu1eI6D+fYK+c7Wasavxai8buDw==
X-Google-Smtp-Source: ABdhPJxC5pjmP8GL7yFcT1vBxlUPaz5jf22657GankwuWpGyw1wov/pYJSydvZA8ErYSe+l3OtrZmg==
X-Received: by 2002:a17:902:be0d:b029:d2:8084:cb19 with SMTP id r13-20020a170902be0db02900d28084cb19mr6466351pls.45.1602890198856;
        Fri, 16 Oct 2020 16:16:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4sm3745384pgl.51.2020.10.16.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:16:37 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:16:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC][PATCH v2] Fortify string function strscpy.
Message-ID: <202010161555.A73EEE9@keescook>
References: <20201013165955.7350-1-laniel_francis@privacyrequired.com>
 <20201016123808.10007-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016123808.10007-1-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 16, 2020 at 02:38:09PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> Thanks to kees advices (see:
> https://github.com/KSPP/linux/issues/96#issuecomment-709620337) I wrote a LKDTM
> test for the fortified version of strscpy I added in the v1 of this patch.
> The test panics due to write overflow.

Ah nice, thanks! I am reminded about this series as well:
https://lore.kernel.org/lkml/20200120045424.16147-1-dja@axtens.net
I think we can likely do this all at the same time, merge the
complementary pieces, etc.

Notes below...

> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  drivers/misc/lkdtm/Makefile  |  1 +
>  drivers/misc/lkdtm/core.c    |  1 +
>  drivers/misc/lkdtm/fortify.c | 37 +++++++++++++++++++++++++++++
>  drivers/misc/lkdtm/lkdtm.h   | 17 ++++++++------

Yay tests! These should, however, be a separate patch.

>  include/linux/string.h       | 45 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/misc/lkdtm/fortify.c
> 
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index c70b3822013f..d898f7b22045 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
>  lkdtm-$(CONFIG_LKDTM)		+= cfi.o
> +lkdtm-$(CONFIG_LKDTM)		+= fortify.o
>  
>  KASAN_SANITIZE_stackleak.o	:= n
>  KCOV_INSTRUMENT_rodata.o	:= n
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index a5e344df9166..979f9e3feefd 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -178,6 +178,7 @@ static const struct crashtype crashtypes[] = {
>  #ifdef CONFIG_X86_32
>  	CRASHTYPE(DOUBLE_FAULT),
>  #endif
> +	CRASHTYPE(FORTIFIED_STRSCPY),
>  };
>  
>  
> diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
> new file mode 100644
> index 000000000000..0397d2def66d
> --- /dev/null
> +++ b/drivers/misc/lkdtm/fortify.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Francis Laniel <laniel_francis@privacyrequired.com>
> + *
> + * Add tests related to fortified functions in this file.
> + */
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include "lkdtm.h"
> +
> +
> +/*
> + * Calls fortified strscpy to generate a panic because there is a write
> + * overflow (i.e. src length is greater than dst length).
> + */
> +void lkdtm_FORTIFIED_STRSCPY(void)
> +{
> +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> +	char *src;
> +	char dst[3];
> +
> +	src = kmalloc(7, GFP_KERNEL);
> +	src[0] = 'f';
> +	src[1] = 'o';
> +	src[2] = 'o';
> +	src[3] = 'b';
> +	src[4] = 'a';
> +	src[5] = 'r';
> +	src[6] = '\0';

Hah, yes, I guess we need to bypass the common utilities. ;) I wonder if
using __underlying_strcpy() might be easier.

> +
> +	strscpy(dst, src, 1000);
> +
> +	kfree(dst);
> +
> +	pr_info("Fail: No overflow in above strscpy call!\n");
> +#endif
> +}

One thing I'd love to see is a _compile-time_ test too: but it needs to
be a negative failure case, which Makefiles are not well suited to
dealing with. e.g. something like:

good.o: nop.c bad.c
	if $(CC) .... -o bad.o bad.c $< ; then exit 1; else $(CC) ... -o good.c nop.c ; fi

I'm not sure how to do it.

> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 8878538b2c13..8e5e90eb0e00 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -6,7 +6,7 @@
>  
>  #include <linux/kernel.h>
>  
> -/* lkdtm_bugs.c */
> +/* bugs.c */

oops, yes. Can you split change from the others, since it's an unrelated
clean-up.

>  void __init lkdtm_bugs_init(int *recur_param);
>  void lkdtm_PANIC(void);
>  void lkdtm_BUG(void);
> @@ -34,7 +34,7 @@ void lkdtm_UNSET_SMEP(void);
>  void lkdtm_DOUBLE_FAULT(void);
>  void lkdtm_CORRUPT_PAC(void);
>  
> -/* lkdtm_heap.c */
> +/* heap.c */
>  void __init lkdtm_heap_init(void);
>  void __exit lkdtm_heap_exit(void);
>  void lkdtm_OVERWRITE_ALLOCATION(void);
> @@ -46,7 +46,7 @@ void lkdtm_SLAB_FREE_DOUBLE(void);
>  void lkdtm_SLAB_FREE_CROSS(void);
>  void lkdtm_SLAB_FREE_PAGE(void);
>  
> -/* lkdtm_perms.c */
> +/* perms.c */
>  void __init lkdtm_perms_init(void);
>  void lkdtm_WRITE_RO(void);
>  void lkdtm_WRITE_RO_AFTER_INIT(void);
> @@ -61,7 +61,7 @@ void lkdtm_EXEC_NULL(void);
>  void lkdtm_ACCESS_USERSPACE(void);
>  void lkdtm_ACCESS_NULL(void);
>  
> -/* lkdtm_refcount.c */
> +/* refcount.c */
>  void lkdtm_REFCOUNT_INC_OVERFLOW(void);
>  void lkdtm_REFCOUNT_ADD_OVERFLOW(void);
>  void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void);
> @@ -82,10 +82,10 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
>  void lkdtm_REFCOUNT_TIMING(void);
>  void lkdtm_ATOMIC_TIMING(void);
>  
> -/* lkdtm_rodata.c */
> +/* rodata.c */
>  void lkdtm_rodata_do_nothing(void);
>  
> -/* lkdtm_usercopy.c */
> +/* usercopy.c */
>  void __init lkdtm_usercopy_init(void);
>  void __exit lkdtm_usercopy_exit(void);
>  void lkdtm_USERCOPY_HEAP_SIZE_TO(void);
> @@ -98,10 +98,13 @@ void lkdtm_USERCOPY_STACK_BEYOND(void);
>  void lkdtm_USERCOPY_KERNEL(void);
>  void lkdtm_USERCOPY_KERNEL_DS(void);
>  
> -/* lkdtm_stackleak.c */
> +/* stackleak.c */
>  void lkdtm_STACKLEAK_ERASING(void);
>  
>  /* cfi.c */
>  void lkdtm_CFI_FORWARD_PROTO(void);
>  
> +/* fortify.c */
> +void lkdtm_FORTIFIED_STRSCPY(void);
> +
>  #endif
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b1f3894a0a3e..b661863619e0 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -6,6 +6,8 @@
>  #include <linux/compiler.h>	/* for inline */
>  #include <linux/types.h>	/* for size_t */
>  #include <linux/stddef.h>	/* for NULL */
> +#include <linux/bug.h>		/* for WARN_ON_ONCE */
> +#include <linux/errno.h>	/* for E2BIG */
>  #include <stdarg.h>
>  #include <uapi/linux/string.h>
>  
> @@ -357,6 +359,49 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
>  	return ret;
>  }
>  
> +/* defined after fortified strlen to reuse it */
> +extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> +__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t count)

I would name "count" as "size" to match the other helpers.

> +{
> +	size_t len;
> +	size_t p_size = __builtin_object_size(p, 0);
> +	size_t q_size = __builtin_object_size(q, 0);

These can be using ", 1" instead of ", 0". And I'll grab the related
changes from the mentioned series above.

> +	/*
> +	 * If p_size and q_size cannot be known at compile time we just had to
> +	 * trust this function caller.
> +	 */
> +	if (p_size == (size_t)-1 && q_size == (size_t)-1)
> +		return __real_strscpy(p, q, count);
> +	len = strlen(q);
> +	if (count) {

This test isn't needed; it'll work itself out correctly. :P

> +		/* If count is bigger than INT_MAX, strscpy returns -E2BIG. */
> +		if (WARN_ON_ONCE(count > INT_MAX))
> +			return -E2BIG;

This is already handled in strscpy, I'd drop this here.

> +		/*
> +		 * strscpy handles read overflows by stop reading q when '\0' is
> +		 * met.
> +		 * We stick to this behavior here.
> +		 */
> +		len = (len >= count) ? count : len;
> +		/*
> +		 * If len can be known at compile time and is greater than
> +		 * p_size, generate a compile time write overflow error.
> +		 */
> +		if (__builtin_constant_p(len) && len > p_size)

This won't work (len wasn't an argument and got assigned); you need:

		if (__builtin_constant_p(size) && p_size < size)


> +			__write_overflow();
> +		/* Otherwise generate a runtime write overflow error. */
> +		if (len > p_size)
> +			fortify_panic(__func__);

I think this just needs to be:

		if (p_size < size)
			fortify_panic(__func__);


> +		/*
> +		 * Still use count as third argument to correctly compute max
> +		 * inside strscpy.
> +		 */
> +		return __real_strscpy(p, q, count);
> +	}
> +	/* If count is 0, strscpy return -E2BIG. */
> +	return -E2BIG;

I'd let __real_strscpy() handle this.

> +}
> +
>  /* defined after fortified strlen and strnlen to reuse them */
>  __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
>  {
> -- 
> 2.20.1
> 

-- 
Kees Cook
