Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61539C83F14
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 21:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjH3VSv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbjH3VSv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 17:18:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817EE57
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:18:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so75872b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430234; x=1694035034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGe4Pd8w1XrhVdlP17guvu7l/IZfeNQ7rJWtm4eORLw=;
        b=J683F7Y+MNn61wydBMMz9tQRIvqoLVnywNW2hhlOpKahl9qw5biPuQb7N+gwngc8OV
         RWopjtRtnLmbP8QSGlfKqA+iaAn4mHKecyXCbU0IO+SodJ1H3+TmojsDrQ8D5xd/1AbS
         hlRieI2Ww1zoejwIvg3RIK9tLpy3Ii0vdcqag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430234; x=1694035034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGe4Pd8w1XrhVdlP17guvu7l/IZfeNQ7rJWtm4eORLw=;
        b=Cu7FQnDC2rhLmkSyhikPflNhZJRxckBJ5md/CdkhdiLOvWXTkFZPdA6fPr+zn2GAOa
         mclFmyLFNpTRfoHTArfpNXlWIFlGyeXMJBXeITTEx9W1MfryxGzXS/5XEn+LBGC8iAi+
         65VFuX3VfZj0jqbknXCwc2MubdobVru+/eaf1Y0OU1ExM37cPrtjgfh6DLd+mFlGJO0D
         I7J+QvuIpzjBf/AOtAMcd22cJbSF8NguhCPY563v806Qk5gk7Kq8dI4gGc4yNTCKQRcU
         Qe48fPPqJKFFoeNVQZ2XocbK6d7Hl1LleWAiGKP5gFsAhMYfHgifs3+YmWt0nVre8t6e
         Vv2Q==
X-Gm-Message-State: AOJu0YyDk/STh5SA+P2iVjAay8X+Jy0Nwh4Rlg27nhRDQwkh23NPs/Pn
        Czus4Of/vqLV+eIfvHq706tO9g==
X-Google-Smtp-Source: AGHT+IEhDIeNkXGeOol6NmD2a6/aKXuUj39+GPQFW3PVFsAxlOBUs8czLJdOIDe37aRlRtNO1kTfiQ==
X-Received: by 2002:a05:6a00:1799:b0:68c:3f2:6007 with SMTP id s25-20020a056a00179900b0068c03f26007mr3677865pfg.8.1693430233873;
        Wed, 30 Aug 2023 14:17:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78086000000b006889511ab14sm22956pff.37.2023.08.30.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:17:13 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:17:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
Message-ID: <202308301415.42CAF1C13B@keescook>
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 04:08:06PM +0000, Azeem Shaikh wrote:
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
>  init/version.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/init/version.c b/init/version.c
> index f117921811b4..94c96f6fbfe6 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
>  {
>  	size_t bufsize = sizeof(init_uts_ns.name.nodename);
>  	size_t maxlen  = bufsize - 1;
> -	size_t arglen;
> +	ssize_t arglen;
> 
> -	arglen = strlcpy(init_uts_ns.name.nodename, arg, bufsize);
> -	if (arglen > maxlen) {
> +	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
> +	if (arglen < 0) {

nitpick: this is no longer "length of arg", it's the length of the
destination string. Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

>  		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
>  			maxlen);
>  	}
> --
> 2.41.0.255.g8b1d071c50-goog
> 
> 

-- 
Kees Cook
