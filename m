Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69644C2D0A3
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3F822254
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eIqWoa7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755688AbgJXFXD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbgJXFXD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 01:23:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698ADC0613CE
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:23:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so2883627pgg.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yzniVRq2+m54YXBbpzCayJPlaV1rTQ8aa2/1Yr41xh0=;
        b=eIqWoa7oakhLRlQT+0XoeE2TKf/nDrq3PAy5EfqWZl7pIUNnWpEtuXHOamU7zG80CJ
         fsUZTJx3rIQYIbR/zqEz8v3DkvIy/E39mk+WBl+fHYt2ypuU72vN5h7O2cpp0xjfcVFD
         +yL7RyLMJT7PEYeCHB/xYKgjRY6kICKF2ne34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yzniVRq2+m54YXBbpzCayJPlaV1rTQ8aa2/1Yr41xh0=;
        b=DvPsEEGCCB+Akj7OK8U3fNUAe6L7fq2adjS2pf7T5daL/y2zG2uQR1mBqCaOqVzGl3
         GP3tqTjrQ36XKqSQiNyJU2vBf1oA86wMxZSlG9+hEheFLCqjCD539BSrxAlv6XE13PD4
         ywEUdYIA1t8ibdMzRqJ/CObJ0wz2jXyoGEFnZRADy/aoYMr2J0Y/bWbRxkyDY1zY7MFy
         m8wGgjKGN8YRdQa1OqzjQ1wGKK7lCxM0H3Mpa4bAL1mqPY1CIo8D5hy/vJeARgSsTi1i
         zPL6bS9frskmbFmCh09tWBoW0mWjB8Hp0IYnB0MFaT9bAH5ScIAh7HBuIrU2KWCtG05i
         4ddA==
X-Gm-Message-State: AOAM532+zfPb5yS7HzDN2l353VHkC+oYteqtgBsC4jAqTEZsCtghiDNd
        L6K3MTKUzEMntHjI9NYyG1cWlBWVFi7hTg==
X-Google-Smtp-Source: ABdhPJwXobKRaEfdjxygOFMGRaOeo7xAHAL4EuWbBh/mRTWA0yTuXhX5CwaYW8hLoMza7lPBkyQVLw==
X-Received: by 2002:aa7:8421:0:b029:155:3229:69cc with SMTP id q1-20020aa784210000b0290155322969ccmr2517978pfn.36.1603516982840;
        Fri, 23 Oct 2020 22:23:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24sm4640301pfn.72.2020.10.23.22.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 22:23:02 -0700 (PDT)
Date:   Fri, 23 Oct 2020 22:23:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC][PATCH v3 4/5] Add new file in LKDTM to test fortified
 strscpy.
Message-ID: <202010232204.9DCF5501DA@keescook>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
 <20201021150608.16469-5-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021150608.16469-5-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 21, 2020 at 05:06:07PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This new test generates a crash at runtime because there is a write overflow in
> destination string.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  drivers/misc/lkdtm/Makefile             |  1 +
>  drivers/misc/lkdtm/core.c               |  1 +
>  drivers/misc/lkdtm/fortify.c            | 47 +++++++++++++++++++++++++
>  drivers/misc/lkdtm/lkdtm.h              |  3 ++
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  5 files changed, 53 insertions(+)
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
> index a002f39a5964..4326e2d09870 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -180,6 +180,7 @@ static const struct crashtype crashtypes[] = {
>  #ifdef CONFIG_X86_32
>  	CRASHTYPE(DOUBLE_FAULT),
>  #endif
> +	CRASHTYPE(FORTIFIED_STRSCPY),
>  };
>  
>  
> diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
> new file mode 100644
> index 000000000000..cecdfbb8ba55
> --- /dev/null
> +++ b/drivers/misc/lkdtm/fortify.c
> @@ -0,0 +1,47 @@
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
> + * Calls fortified strscpy to test that it returns the same result as vanilla
> + * strscpy and generate a panic because there is a write overflow (i.e. src
> + * length is greater than dst length).
> + */
> +void lkdtm_FORTIFIED_STRSCPY(void)
> +{
> +#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)

I would drop the #if: just let it run and freak out on non-fortified
kernels.

> +	char *src;
> +	char dst[3];
> +
> +	src = kstrdup("foobar", GFP_KERNEL);
> +
> +	if (src == NULL)
> +		return;
> +
> +	/* Vanilla strscpy returns -E2BIG if size is 0. */
> +	WARN_ON(strscpy(dst, src, 0) != -E2BIG);

For LKDTM, we have different reporting that "normal", in the sense that
usually the WARN/BUG outcomes are _desirable_ (i.e. "freak out on stack
overflow"). So, I would write this as:

	if (strscpy(dst, src, 0) != -E2BIG)
		pr_warn("FAIL: strscpy() of 0 length did not return -E2BIG\n");

> +
> +	/* Vanilla strscpy returns -E2BIG if src is truncated. */
> +	WARN_ON(strscpy(dst, src, sizeof(dst)) != -E2BIG);

Same.

> +
> +	/* After above call, dst must contain "fo" because src was truncated. */
> +	WARN_ON(strncmp(dst, "fo", sizeof(dst)) != 0);

Same.

> +
> +	/*
> +	 * Use strlen here so size cannot be known at compile time and there is
> +	 * a runtime overflow.
> +	 */
> +	strscpy(dst, src, strlen(src));

I think we'll need a couple more corner cases, and any that need to Oops
separately can be separate functions. Here's a corner case to test to
strnlen():

struct {
	union {
	        char big[10];
	        char src[5];
	};
} weird = { .big = "hello!" };
char dst[sizeof(weird.src) + 1];

strscpy(dst, weird.src, sizeof(dst));

if (strcmp(dst, "hello") != 0)
	pr_warn("FAIL ...

But each of the cases being tested in the fortified strscpy() should be
exercised.

> +
> +	pr_info("Fail: No overflow in above strscpy call!\n");

pr_warn("FAIL: ...

> +
> +	kfree(src);
> +#endif
> +}
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 70c8b7c9460f..29c12dcdeab1 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -106,4 +106,7 @@ void lkdtm_STACKLEAK_ERASING(void);
>  /* cfi.c */
>  void lkdtm_CFI_FORWARD_PROTO(void);
>  
> +/* fortify.c */
> +void lkdtm_FORTIFIED_STRSCPY(void);
> +
>  #endif
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> index 9d266e79c6a2..4234109579eb 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -70,3 +70,4 @@ USERCOPY_KERNEL
>  USERCOPY_KERNEL_DS
>  STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
>  CFI_FORWARD_PROTO
> +FORTIFIED_STRSCPY
> \ No newline at end of file
> -- 
> 2.20.1
> 

-- 
Kees Cook
