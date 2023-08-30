Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD35DC83F14
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbjH3WfV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjH3WfR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 18:35:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AB8E40
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 15:34:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56f84dd2079so234747a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693434893; x=1694039693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H349t5BLDzZGdOT/qIW4Y0MnkdkIeEkiYwVrHohy3Oo=;
        b=YGlkBxBmQrBjgH5SWS80zq2M8Bn2Nit6eKDvy9Ps4gw8HIxKHFiio1ezxn+ZleZD2L
         cGIaGblazYlvbFOd5z5kELgBT5sBggZ4ulo5XbqWUh6ncamQWeN4106vvbym4ygsklCm
         jg4mLvghoixQmHxEdXKiF5ZYUDQbIOhkajqog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434893; x=1694039693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H349t5BLDzZGdOT/qIW4Y0MnkdkIeEkiYwVrHohy3Oo=;
        b=hL2Dr+jZLFZybgc4azxmFzj9HxpxgoWn0COFpLZ7zwcyJVMxbO7VacBXQf3QOYAN2V
         O0ozZPBInV3kBKNAaCOCFuuYLFH93/XiCsF0zymuuIsS3ZyeZis0h4GwMHS7HjbhLEmu
         3YiB8w/zmjbm6EQFhg4W4XgDT4EyQ+SVDdzkOr9jDTkr7M4SGIpEBL9Wl5k7DPXoolI2
         Xjf2RVjzSiRsOZfrYICn51uO2Q+mF/p4kOW+OnjDncJPV2Y2ulvyeO2jlQjfZ3ywb5tF
         jg7fKJ4m/6K/NUeGlAeZzma5CtnjvPJdsTYgHKLlEU6driOJI40OpSJyTpe/1sWJ7bAO
         mlHA==
X-Gm-Message-State: AOJu0YzWsBdippHyo8mN5GAfDxyU+3G8Y+SO8rFwNlKtqkp+hymkbULf
        WU7m2m5VDnMzNDaojaXooKgNtf5aEXBkCn3C71s=
X-Google-Smtp-Source: AGHT+IHFl7iM6EXsgM8MgKuI4oOXAeizDRCFkDsV4FulHrVc0r/znpAO1pO4mZiU4kBmEFzxgLRLow==
X-Received: by 2002:a05:6a20:12d2:b0:14c:5dc2:659c with SMTP id v18-20020a056a2012d200b0014c5dc2659cmr4170802pzg.22.1693434893130;
        Wed, 30 Aug 2023 15:34:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b006871fdde2c7sm74459pff.110.2023.08.30.15.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:34:52 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kobject: Replace strlcpy with strscpy
Message-ID: <202308301533.D6E65EF5C@keescook>
References: <20230830202021.4134348-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830202021.4134348-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 08:20:21PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v3:
>  * Fixed weird indentation.
> 
> v2:
>  * Updated error message to remove @len which is errno now.
>  * https://lore.kernel.org/all/20230830150136.3798414-1-azeemshaikh38@gmail.com/
> 
> v1:
>  * https://lore.kernel.org/all/20230703180528.3709258-1-azeemshaikh38@gmail.com/
> 
>  lib/kobject_uevent.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..032d81b959f0 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -254,10 +254,10 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
>  	int buffer_size = sizeof(env->buf) - env->buflen;
>  	int len;
> 
> -	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> -	if (len >= buffer_size) {
> -		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
> -			buffer_size, len);
> +	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> +	if (len < 0) {
> +		pr_warn("init_uevent_argv: insufficient buffer space "
> +			"(%u left) for %s\n", buffer_size, subsystem);
>  		return -ENOMEM;
>  	}

I thought scripts/checkpatch.pl would warn about this, but kernel
coding-style (as it is) says to not split strings. I'd expect this to
be:

+		pr_warn("init_uevent_argv: insufficient buffer space (%u left) for %s\n",
+			buffer_size, subsystem);


-- 
Kees Cook
