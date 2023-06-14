Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F398EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFNTBd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjFNTBd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 15:01:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132662128
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:01:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3db8f3d94so20307235ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686769291; x=1689361291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9JGyDkQDIJSZxIxX7L6Ls/rWDUQJXrgQn5UA88eCfU=;
        b=P6ZnwSXpzz67icMrJ5H8fdnb2YBf5iQQudM/bE6d3qPEVh9oC8jmWeABsRwaPqayRj
         +QwYxJBZLQp+frbZkirHo6qLXc+Cm4PHiJ4E+JqzOEApjfnMnIV/CpTO8CrVmmSca065
         TD+EVOYS962ygJN2WmEkCUZLSxuMACdDPDl0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769291; x=1689361291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9JGyDkQDIJSZxIxX7L6Ls/rWDUQJXrgQn5UA88eCfU=;
        b=VxNTsJRXTNYZHQ4DKPdANJskhBTyDchmPhu7Bg/shZM09OoybztrSSFX1QbV4f1Cnl
         /BKMlu6n4fq6xLcaMOrSv+BQNW2+E4TGjnpFLswP6zPgsZEWy2XlWTRtbw+FpWEq3U1h
         +mO0WmP+VO3Ycb08Mvk2OdGF/jBakg1ntu4UiGn5BLg4nLTbyJR+2Fdose/ArqekSdbP
         0kLBjgwPYrcyfauZvvvp4dNh2tFgpdgYZjmqej/kAPKZeqxOztm0eBOe2GuCPb29QfqE
         bQih628QZkXnONUAaEeDHqwoxOBCmG24ISRCuRgyUvXWBk/ukpO3eJyZM+xwIvH6W0QX
         tyRw==
X-Gm-Message-State: AC+VfDz7uctMLCgsV3lRuCLFq4h12IJtggTJyBkrMMa8P0r/2Zc1q/KV
        s2sUG4TN27kMIYhf1bQWkLalDg==
X-Google-Smtp-Source: ACHHUZ5zxehGOSUhHcheUe8CJME1qgKj4ggeCpe2UfyLuyTis6fe0kfuB6R0zMb3qzUzSObR93C64Q==
X-Received: by 2002:a17:902:cec9:b0:1b1:dfbd:a192 with SMTP id d9-20020a170902cec900b001b1dfbda192mr15049762plg.57.1686769291559;
        Wed, 14 Jun 2023 12:01:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm12454978plf.214.2023.06.14.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:01:31 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:01:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/platform: Add check for kstrdup
Message-ID: <202306141155.FCA5D6F@keescook>
References: <20230614100020.39020-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614100020.39020-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 06:00:20PM +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> Fixes: 563ca40ddf40 ("pstore/platform: Switch pstore_info::name to const")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  fs/pstore/platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index cbc0b468c1ab..afe07f0d1216 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -631,6 +631,10 @@ int pstore_register(struct pstore_info *psi)
>  	 * through /sys/module/pstore/parameters/backend
>  	 */
>  	backend = kstrdup(psi->name, GFP_KERNEL);
> +	if (!backend) {
> +		mutex_unlock(&psinfo_lock);
> +		return -ENOMEM;
> +	}

Hmm, I think this isn't the right place since there's been a bunch of
other allocations and registrations. I think it would be better to
allocate a copy (but not assign to "backend" yet) earlier, perhaps
before the taking the psinfo_lock lock? Like:

	char *new_backend;
	...
	new_backend = kstrdup(psi->name, GFP_KERNEL);
	if (!new_backend)
		return -ENOMEM;

        mutex_lock(&psinfo_lock);
        if (psinfo) {
		...
                mutex_unlock(&psinfo_lock);
		kfree(new_backend);
                return -EBUSY;
        }
	...
	backend = new_backend;


-Kees

-- 
Kees Cook
