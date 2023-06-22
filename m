Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6124EB64D8
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFVQQA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVQP7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 12:15:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EAB19BF
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 09:15:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-54290603887so3923690a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687450558; x=1690042558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/SMl2eUk/nDroYAOjSfGokmgVDDeq5auCGWm2t1cd4=;
        b=FeF2iB0zuvON+PcoW0KxPXvcdRmLDVLDoo8VOi3XMmtjRlYHyXMsbX8+cztJRaZ2T1
         hqZ9+GU2C06rTYgfpucx13oqSv4KdwPoefu/GZT0ukhpTJx2sHdp4p0KiuWFOZM6L6hP
         WCPiJBrQlHJRgQX2szMZwtAUrQnxS7wDuZtoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450558; x=1690042558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/SMl2eUk/nDroYAOjSfGokmgVDDeq5auCGWm2t1cd4=;
        b=LzcwglFhhvEjOQMjMhBWwh7KhhhaBTgbAOuTRTm5CwXRkqQo2oiC4HA8tk0ypVa7ZS
         nCLXqd/BAhA3oR1jCLXrpCO3riFz4E9tMxVhjOAmF1bbmEuTlu25hi2r8C+cp1SzJ5Y9
         qv+wzm1LbPTM4D0FkdzpQ3ItinaMP5LzxAsJdxP8SyW3bc0jvMT+wh8sB0NU0of0mZXb
         y8hDb/qs7MvmXcKOlajpz0r6H1/exCdBiF87dm0WfIAQeFwLvGTz880wJ/iHMp0CDUhg
         DMAHNz/itPnvinp8A5p0y3dTOPokopppE2gkP8U8LTV5pA1P3stVA9cmowBqbVMoIemn
         zCFA==
X-Gm-Message-State: AC+VfDyvHF0aalELCjMIKeFiHstdCQps6K932IJSDF43pKY1t5NSjNa7
        yW5J2+B4GJlrcIzs0imYX+FGwXWl2tjTSeAQzfc=
X-Google-Smtp-Source: ACHHUZ6cow/01J202NmnkrH4z1WXJPuOhV59qRx2HreC4rl8cdSjL0D9NbrNztTquV7zUiAEODQQLw==
X-Received: by 2002:a05:6a21:9992:b0:111:1bd6:2731 with SMTP id ve18-20020a056a21999200b001111bd62731mr9277943pzb.7.1687450558430;
        Thu, 22 Jun 2023 09:15:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00640f51801e6sm4734492pff.159.2023.06.22.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:15:57 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:15:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pstore/platform: Add check for kstrdup
Message-ID: <202306220914.E881234A2C@keescook>
References: <20230615025312.48712-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615025312.48712-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 15, 2023 at 10:53:12AM +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> Fixes: 563ca40ddf40 ("pstore/platform: Switch pstore_info::name to const")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks, this is looking better!

> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Allocate a copy earlier.
> ---
>  fs/pstore/platform.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index cbc0b468c1ab..727f8ce71062 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -573,6 +573,8 @@ static int pstore_write_user_compat(struct pstore_record *record,
>   */
>  int pstore_register(struct pstore_info *psi)
>  {
> +	char *new_backend;
> +
>  	if (backend && strcmp(backend, psi->name)) {
>  		pr_warn("backend '%s' already in use: ignoring '%s'\n",
>  			backend, psi->name);
> @@ -593,6 +595,10 @@ int pstore_register(struct pstore_info *psi)
>  		return -EINVAL;
>  	}
>  
> +	new_backend = kstrdup(psi->name, GFP_KERNEL);
> +	if (!new_backend)
> +		return -ENOMEM;
> +
>  	mutex_lock(&psinfo_lock);
>  	if (psinfo) {
>  		pr_warn("backend '%s' already loaded: ignoring '%s'\n",

In my suggestion I had included a kfree() for new_backend in this above
error path, which is missing here. Can you respin it with that added?

> @@ -630,7 +636,7 @@ int pstore_register(struct pstore_info *psi)
>  	 * Update the module parameter backend, so it is visible
>  	 * through /sys/module/pstore/parameters/backend
>  	 */
> -	backend = kstrdup(psi->name, GFP_KERNEL);
> +	backend = new_backend;
>  
>  	pr_info("Registered %s as persistent store backend\n", psi->name);
>  
> -- 
> 2.25.1
> 

But otherwise, yeah, looks good. Thanks!

-- 
Kees Cook
