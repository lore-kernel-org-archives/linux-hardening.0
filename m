Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD974C55178
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0A22254
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VAsHc4HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759534AbgJXFEH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 01:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759532AbgJXFEG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 01:04:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A9C0613CE
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:04:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk5so315610pjb.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HfrNgNyw9kbNLIqwBXcRSjAZHZrpM/JEy6HdTow6Ds=;
        b=VAsHc4HKeweOmiIbcvaDvAtfckNlGgu1H9quimn/Ntl8Z3MRFpTxoWZ5Ze7lPZuiAS
         j4XhhDYAWIYvcOmP6Fcs+nBlVW/3Qcahf09/pHkUgwenEde3fkHi/wwt3BClQr97Nilx
         Pq9p6I/eEV3gFeIx+AJbeEJ43wLR4pT8J1GjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3HfrNgNyw9kbNLIqwBXcRSjAZHZrpM/JEy6HdTow6Ds=;
        b=SDy8Y+PQer3ogAjAagsmlXJGp3JGcQ3KkzDyBvpdENhXRin6qyjjCmtjraDPy9b0bq
         TUFm4DlJ3MXE/AhC0aqDZyvdtk0AOzYk0KkgxuYnFyc6GUTEWVGRcwdSprJKa7pekRsD
         WM+unX7lOJX2Q5jcfNpYQ1EtDfjhfLLDyNe4qTj3RjGEk6BkSoH5/+8KEBeIy6PUYeuu
         n92YSLw882A8OsZUi/vQSYpLpyUuT13mnjiDA0mIO3n2Y3UjpQoE1/QXlqJ7Anw2ycIt
         jAdFyE5wI/Z5ej82MleLrA9QFqvJDPCINwjy4w5n3pKwmjX/gXgNiXwseM7bzKYFP9VZ
         ptqQ==
X-Gm-Message-State: AOAM531SrfKN8D185Hc43REutzBVLntaGBG4nGFmRdnr5yz5iM3EYodW
        v60aiinomYlRTuyIqFKRX+PzUEfepgXHNA==
X-Google-Smtp-Source: ABdhPJwXGt4KAL1E9tZXa9kclc9U7Aupn51I8H5g62CQb6x0hSfWsBnfI10eUK19eyCWKyEG0rT+Ww==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr5328341pjb.142.1603515846439;
        Fri, 23 Oct 2020 22:04:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm4090335pfd.40.2020.10.23.22.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 22:04:05 -0700 (PDT)
Date:   Fri, 23 Oct 2020 22:04:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC][PATCH v3 3/5] Fortify string function strscpy.
Message-ID: <202010232017.14FB7034@keescook>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
 <20201021150608.16469-4-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021150608.16469-4-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 21, 2020 at 05:06:06PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> Fortified strscpy detects write overflows to dest.

This commit log needs to be expanded to explain the "why" of the change
with some detail.

Also, please look at the git commit history of include/linux/string.h
for a sense of the kinds of Subject prefixes being used. I think this
Subject should be something like:

	Subject: string.h: Add FORTIFY coverage for strscpy()

> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  include/linux/string.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 46e91d684c47..add7426ff718 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -6,6 +6,8 @@
>  #include <linux/compiler.h>	/* for inline */
>  #include <linux/types.h>	/* for size_t */
>  #include <linux/stddef.h>	/* for NULL */
> +#include <linux/bug.h>		/* for WARN_ON_ONCE */

^^^ no longer needed

> +#include <linux/errno.h>	/* for E2BIG */
>  #include <stdarg.h>
>  #include <uapi/linux/string.h>
>  
> @@ -357,6 +359,42 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
>  	return ret;
>  }
>  
> +/* defined after fortified strnlen to reuse it */
> +extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> +__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
> +{
> +	size_t len;
> +	/*
> +	 * Use 1 as second argument to guess only p size even and not the

This isn't a "guess". Perhaps just say:

/* Use string size rather than possible enclosing struct size. */

> +	 * surrounding struct size (in case it is embedded inside a struct).
> +	 */
> +	size_t p_size = __builtin_object_size(p, 1);

A short-circuit path should be added here:

	size_t q_size = __builtin_object_size(q, 1);
        if (p_size == (size_t)-1 && q_size == (size_t)-1)
                return __real_strscpy(p, q, size);

> +	/*
> +	 * If size can be known at compile time and is greater than
> +	 * p_size, generate a compile time write overflow error.
> +	 */
> +	if (__builtin_constant_p(size) && size > p_size)
> +		__write_overflow();

Compile-time size > p_size is caught here.

Compile-time over-read on strings isn't catchable.

> +
> +	len = strnlen(q, size);

Runtime over-read is caught here.

> +	/*
> +	 * strscpy handles read overflows by stop reading q when '\0' is
> +	 * met.
> +	 * We stick to this behavior here.
> +	 */
> +	len = (len >= size) ? size : len;

This test isn't needed: strnlen(q, size) will never return larger than
size. (i.e. len has already been reduced to size.)

> +
> +	/* Otherwise generate a runtime write overflow error. */
> +	if (len > p_size)
> +		fortify_panic(__func__);

Runtime over-write is caught here, though I think this needs to be:

	if (len + 1 > p_size)
		fortify_panic(__func__);

since we need to fit "len" plus NUL in p_size. len + 1 == p_size is ok.

> +	/*
> +	 * Still use size as third argument to correctly compute max
> +	 * inside strscpy.
> +	 */

If we do this, then we run the risk of doing the over-read anyway. For
this call, we need to use len in most cases.

> +	return __real_strscpy(p, q, size);

In the unfortified case, -E2BIG will happen when strlen(q) >= size. When
fortified, strnlen is capped at min(size, q_size), so -E2BIG could only
happen when len == size. If len < size, there will never be -E2BIG.

So I think this means we need the __real_strscpy() call to look like this:

	// All safe from over-read  (len + 1 <= min(size, q_size): strnlen() above).
	// All safe from over-write (len + 1 <= p_size: explicit test above).
	if (len < size)
		return __real_strscpy(p, q, len + 1); // not E2BIG
	else if (len + 1 == size)
		return __real_strscpy(p, q, len + 1); // not E2BIG
	else if (len == size) // therefore size < min(size, q_size, p_size)
		return __real_strscpy(p, q, size);    // E2BIG
	else //  len + 1 > size
		return __real_strscpy(p, q, len + 1); // E2BIG

or simply:

	return __real_strscpy(p, q, len == size ? size : len + 1);

But the complexity here clearly calls for test cases.

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
