Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE4C001B0
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjHJTAi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjHJTAh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 15:00:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F62696
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:00:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68783b2e40bso944645b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691694036; x=1692298836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pDoIIBmfCvDO688KPmA5fczvqhk8UceQwraywNL9tc=;
        b=nYqpk2RC9oF28D912uGs1EAh+cTVjhhp83I9sUY8Wt7fx9Mwk2hDj4bLWCbb+xj9pN
         kRrMhprpPKQRNED4xixZCB3hTHHglGzHaqleHJ1B48V1ycfz73RTaWBoYw28xxgo6jnZ
         tj5p6NsGQBM8tVAZiAF4GKDq+7UC9tPmMKBfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694036; x=1692298836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pDoIIBmfCvDO688KPmA5fczvqhk8UceQwraywNL9tc=;
        b=U35Bls0RylM8rl1H5zAKGYr73jMU/El0BpueY7bng19aOukgFekWCZCqQvtDiLdZ9A
         oyeskNVriGerTAdzsN/mPtOXbZ78Magut26CHC4PxAMZaEH5e+82wUIs6DZwGRBYDGZI
         LSyypbHGSCZS2b3arkoM5Ih4oxe3koLiJXsxDT23JlL92jQWBbukuDVGKpzyrcoRA5OX
         CZZRcOYpYZL4Y/9CO/fsAafcLLE6lJh7Crh/MEBMm/RmA52s88h1bxFqwCkmZLTpLWja
         JW7drYL3egkhrKGy+Hiib1NwTJqSKBzr3984gzsTVe/vma6XlJka0H1q9GDN92hbFtOy
         MTmQ==
X-Gm-Message-State: AOJu0Yx6sNy0QyP2FR67ygUlg9iyzllFh627vbiGfp7qKBvVBndWUhsE
        GbGkTnj8utYojquD4oXr344zGg==
X-Google-Smtp-Source: AGHT+IHq/PIN+zQMWZEQ03Gl2aHm7aN7Itbvi7T0nJbs0wWH/4fy2NhkY52HWQNhsc5WbHhRFOKFsg==
X-Received: by 2002:a05:6a21:4841:b0:140:a0dc:c834 with SMTP id au1-20020a056a21484100b00140a0dcc834mr2938661pzc.24.1691694036431;
        Thu, 10 Aug 2023 12:00:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b00687087d8bc3sm1918804pfo.141.2023.08.10.12.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:00:35 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:00:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: refactor deprecated strncpy
Message-ID: <202308101155.81497C5B@keescook>
References: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 06:39:03PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1]. Which seems to be the case here due to the forceful setting of `buf`'s
> tail to 0.

Another note to include in these evaluations would be "does the
destination expect to be %NUL padded?". Here, it looks like no, as all
the routines "buf" is passed to expect a regular C string (padding
doesn't matter).

> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> In this case, there is some behavior being used in conjunction with
> `strncpy` that `strscpy` already implements. This means we can drop some
> of the extra stuff like `... -1` and `buf[len] = 0`
> 
> This should have no functional change and yet uses a more robust and
> less ambiguous interface whilst reducing code complexity.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> For reference, see a part of `strscpy`'s implementation here:
> 
> |	/* Hit buffer length without finding a NUL; force NUL-termination. */
> |	if (res)
> |		dest[res-1] = '\0';
> 
> Note: compile tested
> ---
>  arch/arm64/kernel/idreg-override.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 2fe2491b692c..482dc5c71e90 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
>  		if (!len)
>  			return;
>  
> -		len = min(len, ARRAY_SIZE(buf) - 1);
> -		strncpy(buf, cmdline, len);
> -		buf[len] = 0;
> +		len = min(len, ARRAY_SIZE(buf));
> +		strscpy(buf, cmdline, len);

This, however, isn't correct: "cmdline" will be incremented by "leN"
later, and we want a count of the characters copied into "buf", even if
they're truncated. I think this should be:

		strscpy(buf, cmdline, ARRAY_SIZE(buf));
		len = strlen(buf);

-Kees

>  
>  		if (strcmp(buf, "--") == 0)
>  			return;
> 
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
