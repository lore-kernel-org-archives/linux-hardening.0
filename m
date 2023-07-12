Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B5EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGLTFj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjGLTFh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 15:05:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA81BFA
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 12:05:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668704a5b5bso6568216b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689188735; x=1691780735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bU+fRF6x4YdBE9Cc80fX0ZMXBlJsLMV0Bk7zaDMBG0=;
        b=NgBEjBP3fB2u+/3TnxSFEAX9s0FffbnO0wWLqZ7FQ449iNgFQtDYLhZFbp/xCO3SzB
         3YXuS7+98WixkG1bYz7vKVjJyYKvXaIH2hd2WZnMJr2/UYmUA0cosDCk3WS/giw+4Hq0
         XhVEt3aq/hwBDCM6Dn9zDLQCmlfi2brWzihGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188735; x=1691780735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bU+fRF6x4YdBE9Cc80fX0ZMXBlJsLMV0Bk7zaDMBG0=;
        b=FnxYJDYQ7yiWe48u31p8ywGCsywIxYSlrvMN7HhMCuY8euxnakrvh6kkQDqk6NUPRx
         Bk1fc8LcXvNVCItP74xm+voEDJeX3YVBzua4H51/lch1ieAu10odlUg0OpqK/rxd6nEB
         YwprPjvMfgdrIpNEqzM4c9q+3S1ZanMupt53tUnHR3FLRaHxkC2lJUuGpWLKzH1rySqU
         Fj2I3YMQUdD6EYMw5damhwxO+TndMCNNskoWa44EyAZ+tfMIr6vV+P3D2T3Y5AVpT0mA
         WBiIozOXj0RtCCZRiTcxk9rKcNcRZF7G6lnvy7klHdZDzAm5cWeZRHcKXwXPd9P2MaJQ
         iffw==
X-Gm-Message-State: ABy/qLa90I4rfmHQrq0sNZhp3VyIvbxLZH/kozcC6dUdY0PJx022d8lg
        lKhXhlqzaYCYZHboyZuM4kst9Q==
X-Google-Smtp-Source: APBJJlGdfMhp/TGuNABeTjXEyYXOW37cNA5c+0SckjoOkSvUUZxRDlC9M1Vtjhajx9DaSwQJ+kNdRA==
X-Received: by 2002:a05:6a00:3907:b0:682:4c1c:a0f6 with SMTP id fh7-20020a056a00390700b006824c1ca0f6mr22784484pfb.3.1689188735674;
        Wed, 12 Jul 2023 12:05:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00663b712bfbdsm3961286pfo.57.2023.07.12.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:05:35 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:05:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix -Wstringop-overflow warnings
Message-ID: <202307121204.36EF4C1@keescook>
References: <ZK7wKS0NgZPfqrZu@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK7wKS0NgZPfqrZu@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 12, 2023 at 12:25:45PM -0600, Gustavo A. R. Silva wrote:
> Use unsigned type in call to macro mint_t(). This avoids confusing the
> compiler about possible negative values that would cause the value in
> _len_ to wrap around.
> 
> Fixes the following -Wstringop-warnings seen when building ARM
> architecture with allyesconfig (GCC 13):
> fs/udf/directory.c: In function 'udf_copy_fi':
> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
>    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>       |         ^~~~~~
> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
>    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>       |         ^~~~~~
>   AR      fs/udf/built-in.a
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/329
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/udf/directory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 1c775e072b2f..93153665eb37 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -95,7 +95,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
>  	}
>  
>  	off = iter->pos & (blksize - 1);
> -	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
> +	len = min_t(u32, sizeof(struct fileIdentDesc), blksize - off);
>  	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>  	if (len < sizeof(struct fileIdentDesc))
>  		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,

len is u32, "off" can't be less than blksize, so this all looks correct
to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
