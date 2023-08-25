Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5BFC3DA6F
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHYUcJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjHYUb4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 16:31:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124421FD7
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 13:31:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf1935f6c2so9748915ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692995513; x=1693600313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbK8/oWiBIVoC/jcfdbNeWkeAfPt8MN35+9MR6xg494=;
        b=SxnUxYAjr8JBfiuonQG266dkmNZ+5hxrKSEPI6Vea0liNat+HCYvAi9Sce60JmkTTS
         NkmK35yvV3w2ctId7cF5uOOTYxJncbBpHmtzNTtx2jY11mbHnkmKu+9ep3ALYca2Ryw7
         eNv610zPxC5b6fT7ht5Sbi2rsFWV6WE3Y2AWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995513; x=1693600313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbK8/oWiBIVoC/jcfdbNeWkeAfPt8MN35+9MR6xg494=;
        b=hAggpNa3a8GMKKuntAI8wGILn1Us4yeVweFUaXZlE0RcVlpNewM6pYJIiWFnR6aSF9
         dvQpg0NqWHEoUjFDTRzJl3Rn8R2T+X19wVqwtTLqTR1FPyFCdhcC/x+cqv9WvM0K8iIO
         ysymybx8xYCsi6FU+mlj0dWsiMcbV9Dp00uIg2SD9NX3UmAt0MbnfH30cGHSgHtLMuzi
         AfzND4bXDe53mLOUCLV5XNMYeYwlZgqhy6eGyAucYxbX1s0i7jf+6OKvwzY00W9l9Y3t
         UhiupgvYInSSBAfenREVxbLm06DT46Q2taL/4MRp98GuJNiSScM0WgbupDYlkXgWxcg1
         /alQ==
X-Gm-Message-State: AOJu0Yy9wh3B9xvigY4T5Z3v1lFgZ1T7h0lO7paNB23QU0nAS36cF3dD
        5MUH+5Jvgq+EyVgG/ZiGGqYGWkpf+ZJcX4kHX4U=
X-Google-Smtp-Source: AGHT+IFkHOomC5fDsX51fb+z+kMZfOW5mXRYL7CREwQSq5bU6xwcUnwTW+gBCrrDOo3EofQSeq3+Nw==
X-Received: by 2002:a17:902:d511:b0:1bb:55be:e198 with SMTP id b17-20020a170902d51100b001bb55bee198mr27660915plg.0.1692995513531;
        Fri, 25 Aug 2023 13:31:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b001bba3650448sm2158060plr.258.2023.08.25.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:31:52 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:31:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] habanalabs/gaudi: refactor deprecated strncpy
Message-ID: <202308251321.E19D664F0@keescook>
References: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 24, 2023 at 08:41:26PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!

For strncpy replacements the commit log needs to always address 2 items,
and really get spelled out for reviewers since the diff context is
rarely enough information to judge the safety of the change:

1) How did you determine that the destination buffer does or does not
   require %NUL termination?

2) How did you determine that the destination buffer does or does not
   need to be %NUL padded?

> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only
> ---
>  drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
> index 056e2ef44afb..f175456cdef0 100644
> --- a/drivers/accel/habanalabs/gaudi/gaudi.c
> +++ b/drivers/accel/habanalabs/gaudi/gaudi.c
> @@ -660,7 +660,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
>  	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
>  	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
>  
> -	strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
> +	strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
>  					CARD_NAME_MAX_LEN);
>  
>  	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
> @@ -8000,7 +8000,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
>  		return rc;
>  
>  	if (!strlen(prop->cpucp_info.card_name))
> -		strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
> +		strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
>  				CARD_NAME_MAX_LEN);

When I look at this string, I see it gets copied out to userspace
directly:

static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
{
        struct hl_info_hw_ip_info hw_ip = {0};
	...
        memcpy(hw_ip.card_name, prop->cpucp_info.card_name,
                min(CARD_NAME_MAX_LEN, HL_INFO_CARD_NAME_MAX_LEN));
	...
        return copy_to_user(out, &hw_ip,
                min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
}

So if "prop" isn't zero initialized, this is now a kernel memory content
exposure, due to the lack of padding.

If I track the allocation of "hdev" all the way back, I can see it is,
however, zero initialized:

static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
...
        hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);


But since it's still sent via copy_to_user(), the more defensive
replacement here should be strscpy_pad().

(Also, I think you can do all three files in the same patch -- it's
operating on the same struct and in the same way.)

-Kees

-- 
Kees Cook
