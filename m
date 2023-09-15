Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475BEEEAA42
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjIODSv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIODSu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:18:50 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E7270C
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:18:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb07d274feso942375a34.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747925; x=1695352725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIUnQqFZgZoW5zFDnou379D0ZMOfFB2pLkMih4DagjA=;
        b=I6UVjJtTHx0WZEKI34bFsUf6qQ3566kdSaiS1HB5SQmWHD8ayAPV5L6J71Uw0Dl2EF
         U0uX2srehKYPqwzTssY0lhOiyb9i5zFtj1bTCwoqszK33/72hdJkpVUcZkVoe4xed8tI
         CkkXJ8J4n/WqTebBT+G3D9EqbdSxx8MJVSACM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747925; x=1695352725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIUnQqFZgZoW5zFDnou379D0ZMOfFB2pLkMih4DagjA=;
        b=r/9Ezf7+3TbdMh86GPpZBm4N/Hq/YO/+q7vyzEao5MfbwjGCoUo+KoFKKkbS+Z3yjq
         9j7tGkfgm0DNuZC+dkKprmDuymeLU3S8XEuns4tNPfwlPeaW23dVmZLrKc6TJ2rDLykE
         co4vhXVHKccasquwuY+1gwU7eJoNZZdqRI6IaYt0FiBA7DD3lsAQjf3iyK8fe+gdSSDz
         6WqCCRetzLqEFXkc3wfzZb7oD9eREfHxZBQK2k1R+YKw566zxVqrBNEEfvRvkI3fwCe5
         C4tSAcwmddAAZ8kR8RzWZD/W0bzM8RnQqKB/KPuHdh5g4gTgN0OLQNUoK7kYqlGhai9j
         eL/w==
X-Gm-Message-State: AOJu0Yxag4VrBukrzAIRO/sRvSMPJv/D7NGErT461fd+dHwb/ikegvix
        Rl8HtaNEyvXYTIF8tVFJapJNuA==
X-Google-Smtp-Source: AGHT+IFPtc4pwEwkZXzgRLfUOF1sf36Tbrcod+lMLus/e74ANEGchjwRem592DQm9lbwuMINKWzpvA==
X-Received: by 2002:a05:6358:7212:b0:142:e357:e777 with SMTP id h18-20020a056358721200b00142e357e777mr950454rwa.25.1694747925657;
        Thu, 14 Sep 2023 20:18:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a63bf05000000b00563826c66eesm1564290pgf.61.2023.09.14.20.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:18:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:18:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: panel: refactor deprecated strncpy
Message-ID: <202309142018.CAD22C6D@keescook>
References: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 11, 2023 at 08:51:04PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous interfaces.
> 
> In this case, all of `press_str`, `repeat_str` and `release_str` are
> explicitly marked as nonstring:
> |   struct {	/* valid when type == INPUT_TYPE_KBD */
> |           char press_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char release_str[sizeof(void *) + sizeof(int)] __nonstring;
> |   } kbd;
> 
> ... which makes `strtomem_pad` a suitable replacement as it is
> functionally the same whilst being more obvious about its behavior.

Yup, this is exactly what strtomem_pad() was made for. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  drivers/auxdisplay/panel.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index eba04c0de7eb..e20d35bdf5fe 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -1449,10 +1449,9 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
>  	key->rise_time = 1;
>  	key->fall_time = 1;
>  
> -	strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
> -	strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
> -	strncpy(key->u.kbd.release_str, release,
> -		sizeof(key->u.kbd.release_str));
> +	strtomem_pad(key->u.kbd.press_str, press, '\0');
> +	strtomem_pad(key->u.kbd.repeat_str, repeat, '\0');
> +	strtomem_pad(key->u.kbd.release_str, release, '\0');
>  	list_add(&key->list, &logical_inputs);
>  	return key;
>  }
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230911-strncpy-drivers-auxdisplay-panel-c-83bce51f32cb
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
