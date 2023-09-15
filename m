Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C615EED61A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIOSy5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjIOSyu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 14:54:50 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521C468A
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 11:52:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c0b3cea424so1410664a34.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694803923; x=1695408723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0WyqAJ5yJOqId14DuOsChOBKAGV647ZGJyOmq2Fqjk=;
        b=i8Ye2DMtYiBYPRcERhlvAPVdDc0JMFPyMVCZUMGebxTOr3BXkUsK+cW0t7lFisIXSt
         /r7n+jFfKBE720LIDKSviYgQHk5IAqKqB13F8e3p+YGrGfZsIn1umOHi3rUcZY+EUaX0
         FEE/NaXtQh0TCtCkXNHVC30V14VpPr7Iah5Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803923; x=1695408723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0WyqAJ5yJOqId14DuOsChOBKAGV647ZGJyOmq2Fqjk=;
        b=cwyWSPVTC0kNLBP/kp+3VT+6O6wP/4XRQ39bbzk9dsXNJGFoessc9Uk1mMmLEjpetz
         GVRqkC7Q1lecftMQ9HO/iinQZTbuVONBRrxN9kWbaObyU1eLkQciUoRMrIgdRaKaWMn6
         ahi/y+mAmqDa4un69nnmLIanlxgZz7bl+UjJL/i9fI8/03xiSGtDGW75nzWjLRSPP1i4
         6cAY5YvtXWRwbY5x7UQAku+FboKwZ3xSB32j0K2wzbReBdJY9k6/v3HHQlYYPYC1XcPm
         edgk1wobfFIrF152PsK+8BrxQxjQvWKqMJQ3siH0wrfPAB8uqUDQ7+SBjqk3RX6t35rb
         ReGQ==
X-Gm-Message-State: AOJu0YwMOVLAD5NFTfIFfPp5KgVV9UfiCYPdPZ3Tl44Eg86RgYvQJJxI
        fXr/ibyCSyCqvPZ4yRlFhkweSg==
X-Google-Smtp-Source: AGHT+IFLeulKYJVZbtaYCC78ng58EYSEdkdd1lDUFANMECpbOAZc+gCpxueIstOyFv/ysLfUav4NJw==
X-Received: by 2002:a05:6358:71a:b0:134:28d6:be7 with SMTP id e26-20020a056358071a00b0013428d60be7mr3696470rwj.9.1694803923555;
        Fri, 15 Sep 2023 11:52:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a656a8d000000b00564b313d526sm2716841pgu.54.2023.09.15.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:52:02 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:52:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Peter Stuge <peter@stuge.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/gud: Use size_add() in call to struct_size()
Message-ID: <202309151150.74DBDCA039@keescook>
References: <ZQSlyHKPdw/zsy4c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSlyHKPdw/zsy4c@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 12:43:20PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_add()`.
> 
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index d2f199ea3c11..a02f75be81f0 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -503,7 +503,7 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
>  		return -ENOENT;
>  
>  	len = struct_size(req, properties,
> -			  GUD_PROPERTIES_MAX_NUM + GUD_CONNECTOR_PROPERTIES_MAX_NUM);
> +			  size_add(GUD_PROPERTIES_MAX_NUM, GUD_CONNECTOR_PROPERTIES_MAX_NUM));

There are both constant expressions, so there's not too much value in
wrapping them with size_add(), but for maintaining a common coding style
for dealing with allocation sizes, I can be convinced of the change. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


>  	req = kzalloc(len, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 

-- 
Kees Cook
