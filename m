Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B733C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61F060C4A
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhJYUNl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbhJYUNg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 16:13:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD6C04CC87
        for <linux-hardening@vger.kernel.org>; Mon, 25 Oct 2021 12:34:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l203so6997512pfd.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Oct 2021 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYhrHXHR80eY0SdY9PUIFGGXOjjfNyiUnBpm6exbdn4=;
        b=L8NKVE6oAl+yzLhAi8lJobqZETTz5f3yATk4PSp2lAB3cuh7W9ROy4Ub3Fs0p8rN4J
         OtPudyKAVLpu4Goq97XPPLY/TihCLbfXHvYm+jGircynQcIWuBfYrsy5HjE0+tNlCoGT
         zJcmzqnJH5vqWIqUa1jB6lAnCyHAMTnrfxsPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYhrHXHR80eY0SdY9PUIFGGXOjjfNyiUnBpm6exbdn4=;
        b=iNgR47k7uj1GBrh+b52TZ1KkU9rl6zx0omiOW46kEN2odwX90lX7nyqhB075xW9aYv
         K53TfVUDbwLKl/70FeKZ4wiPuDEUHCP1Qz/06zbCc/neYQvM87wP9R8kil/9a644rRao
         eFPHNYkZzrNrn6ybtbqX/fx8lW78fOq2+kbu6lQq0k5+SoyZBSlTePAoqJFVeD6PEGm7
         YS9MpsTFKm0ce1g0lzB+mRc3HWvcsmaA7RCtOQtUxqggdfu/t9hgI2/Zp2U6XCyWB8UC
         2Z6g6huxJRvHCnl+VkTASMnuCHWdAAeokZ9cQ1xxq8w9QyMypIW4vlIUEV5cm3MuvfaV
         wprA==
X-Gm-Message-State: AOAM532MQt6xS8+5MRQlpQpVhgSrqL0/Z2ppkxcUM+uma8HZwfRywFjo
        IGZmLISMy2YAH3Fljmmd2kKyBHZqFCkD7g==
X-Google-Smtp-Source: ABdhPJy0Tl/Ws3py1xu4ik/n7nuEYsVGnJv01KcsJAMFzXesiVHPqXN3/4Ys4P+pNwBAdAbhdEzAsw==
X-Received: by 2002:a62:8496:0:b0:47b:d189:5ce9 with SMTP id k144-20020a628496000000b0047bd1895ce9mr18078276pfd.19.1635190444222;
        Mon, 25 Oct 2021 12:34:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gn1sm5711388pjb.34.2021.10.25.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 12:34:03 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:34:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Avoid shadowing previous locals
Message-ID: <202110251232.652ACB6@keescook>
References: <20211025183728.181399-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025183728.181399-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 25, 2021 at 02:37:28PM -0400, Qian Cai wrote:
> __compiletime_strlen macro expansion will shadow p_size and p_len local
> variables. Just rename those in __compiletime_strlen.

They don't escape their local context, though, right? i.e. I don't see a
problem with the existing macro. Did you encounter a specific issue that
this patch fixes?

-Kees

> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  include/linux/fortify-string.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index fdb0a74c9ca2..155c622e4f24 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -10,18 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
>  void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
>  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>  
> -#define __compiletime_strlen(p)				\
> -({							\
> -	unsigned char *__p = (unsigned char *)(p);      \
> -	size_t ret = (size_t)-1;			\
> -	size_t p_size = __builtin_object_size(p, 1);	\
> -	if (p_size != (size_t)-1) {			\
> -		size_t p_len = p_size - 1;		\
> -		if (__builtin_constant_p(__p[p_len]) &&	\
> -		    __p[p_len] == '\0')			\
> -			ret = __builtin_strlen(__p);	\
> -	}						\
> -	ret;						\
> +#define __compiletime_strlen(ptr)				\
> +({								\
> +	unsigned char *__ptr = (unsigned char *)(ptr);		\
> +	size_t ret = (size_t)-1;				\
> +	size_t ptr_size = __builtin_object_size(ptr, 1);	\
> +	if (ptr_size != (size_t)-1) {				\
> +		size_t ptr_len = ptr_size - 1;			\
> +		if (__builtin_constant_p(__ptr[ptr_len]) &&	\
> +		    __ptr[ptr_len] == '\0')			\
> +			ret = __builtin_strlen(__ptr);		\
> +	}							\
> +	ret;							\
>  })
>  
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> -- 
> 2.30.2
> 

-- 
Kees Cook
