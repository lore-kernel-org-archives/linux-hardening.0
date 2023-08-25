Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB6C7EE2C
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 21:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjHYVuG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHYVtn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 17:49:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902ED26AD
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so327133b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693000181; x=1693604981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uXX3yWMumHoz9Ne0brtDEr7hVyliwSsmYAIn+H5H/I=;
        b=hvYCQ4ck9OTuXOrSASd6reczZDZbRFWik8y5PbNupSaE5FuhFpFik+7pBpNPwHvAXJ
         J5e1fHtsPxC9WiZt9x4xoWNlEiuJp7QMKHgVO0z2VHaE8FYpq/a7/F6p0DkduKU9vwuE
         2YSP02cD/U3CDGnoTjHNp7qsrx8qcemieW6hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000181; x=1693604981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uXX3yWMumHoz9Ne0brtDEr7hVyliwSsmYAIn+H5H/I=;
        b=T+B8l1t6zT4jEZ9qlyqcApKEOqJ+VfQrIRgTuNxuAoorsbiHvm336zTGGsZXCSvPJ3
         omItLNu7yDhF49OVGZxhe6i2v0HpKv2Ji1r6YH5kZNRpj/obU1y8HaXeVAzvfcqGqu/P
         YAopQbiEFfwizV8TmmzfaOvyxslX3W+qnWnB1rPu6fCvAb6ps/lPLMkmzFZhFsTTf+V9
         LTbCf+2s0wP5LU06mw1jJpNe/N9gEWwAQO0Gbf9kwun5BXwWWXcKm3Fc9sSUwTQVENaH
         FmZMUBMf1050U+mbAW3uPc9TPDpMKbbIvlZ4/ZgUNZ/U3bAOknzRWZkCFYZBQqgV4h5d
         3p1A==
X-Gm-Message-State: AOJu0Yxql2IJ69/ZPjlLnqsRmgzSNTp+Q5ZFrLNaWse+16/MUBRVdJ+Y
        Cf4LuXNDAdInf1HoZVDhtXwDZw==
X-Google-Smtp-Source: AGHT+IFiDJhuRdMmJIDMmTKeu70VLVj2TRKI6mZc1WbmzXoLqFaEbFFsyDL3seS95GCNOAQgR/80iA==
X-Received: by 2002:a05:6a00:b8e:b0:68a:45a1:c0f3 with SMTP id g14-20020a056a000b8e00b0068a45a1c0f3mr17743593pfj.18.1693000181021;
        Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b0068a6972ca0esm2030543pfo.106.2023.08.25.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:49:40 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:49:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accessibility: speakup: refactor deprecated strncpy
Message-ID: <202308251439.36BC33ADB2@keescook>
References: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 24, 2023 at 09:44:29PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Use `strscpy` as it guarantees NUL-termination of its destination buffer [2]
> which allows for simpler and less ambiguous code.
> 
> Also, change `strlen(buf)` to `strlen(ptr)` to be consistent with
> further usage within the scope of the function. Note that these are
> equivalent:
> |419 	const char *ptr = buf;
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/accessibility/speakup/kobjects.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index a7522d409802..8aa416c5f3fc 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -422,12 +422,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
>  	if (!synth)
>  		return -EPERM;
>  
> -	len = strlen(buf);
> +	len = strlen(ptr);
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
>  	while (len > 0) {
>  		bytes = min_t(size_t, len, 250);
> -		strncpy(tmp, ptr, bytes);
> -		tmp[bytes] = '\0';
> +		strscpy(tmp, ptr, bytes);
>  		string_unescape_any_inplace(tmp);
>  		synth_printf("%s", tmp);
>  		ptr += bytes;

Technically, yes, this is fine...

Reviewed-by: Kees Cook <keescook@chromium.org>

But wow do you find the most amazing code. :)

This thing is taking a buffer and chopping it up into at-most 250 byte
chunks (smaller than buf, I might add), and then sending it to
synth_printf() ... which uses a 160 byte buffer and silently
truncates...  and uses "%s" which is just a string copy...
why doesn't this just use synth_write() directly on an unescaped
buf??

I think this entire function should just be:

static ssize_t synth_direct_store(struct kobject *kobj,
                                  struct kobj_attribute *attr,
                                  const char *buf, size_t count)
{
        char *unescaped;
	char *p;

        if (!synth)
                return -EPERM;

	unescaped = kstrdup(buf, GFP_KERNEL);
	if (!unescaped)
		return -ENOMEM;

	string_unescape_any_inplace(unescaped);

        spin_lock_irqsave(&speakup_info.spinlock, flags);
	synth_write(unescaped, strlen(unescaped));
        spin_unlock_irqrestore(&speakup_info.spinlock, flags);

	kfree(unescaped);

        return count;
}

(Though honestly, why does this need unescaping anyway?)

-Kees

-- 
Kees Cook
