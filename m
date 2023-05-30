Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814ADC7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjE3XVo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjE3XVj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:21:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E1139
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:21:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso5676265b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488876; x=1688080876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXrqvWKS+nGr8mCgm8RAk3AjHAfZ4ATcF5aLBTNpjj8=;
        b=ezw18XkZa93bewhzvNi3R0B0kQfTJEXnFDhM+zht5cwBCp9qc1gr0C0PZTAGeE2lZ+
         kXCdtyS4mojGCd8csZRo5uW8VKTFlrjo+4D+Xw2BdddL9Hnyv6Hrt9nyDSK/34ydUS4n
         5j11a2Jn0iujep6UVn00JGln7czzer+JZU6HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488876; x=1688080876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXrqvWKS+nGr8mCgm8RAk3AjHAfZ4ATcF5aLBTNpjj8=;
        b=Hoa0zfnNPF0UNzlUkQISiBpNHZGZ4N8jnvGCpE7ZbbazdxaX34OwBJ/nQfjpsm70jE
         ioSGyQLcfLrd0rqsxvy12nXSjESE6kpUu3tpTICNBiUZXsHzneoOKq5y3RVbnhtrzWPO
         XpND5FJRVNN2jMluPMJromQhrMBpgERHbvq/CY7p69WKzKE0HZC2Fk2iZ8UrEZjP/KIr
         ngBGLxeVIKvtC6A2ZYLExX6LA9dIk5Mve1f+KxODf+oqMkGb0H83V71fLOSnzGNufO60
         i1mKzm27DEwm4xTwBDyJJnw74S3lrB8GixTeKNZsGB5tePo3LTmmJ+De1B9cRkx/DFDJ
         4w7w==
X-Gm-Message-State: AC+VfDz4S3wOqHwTqCRe56Unuz+uXktrMaxweEORimihigZFExzW4TLM
        nWIFHcCFdKgextltUxVMNslttw==
X-Google-Smtp-Source: ACHHUZ5338Jnt0Oo7GgByPkEFl4jNQ7BIOKJt9z+9w+3gSDhP0aqSKM/1yO2crs//in7mttyH7S1Sg==
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr5323277pfb.32.1685488876528;
        Tue, 30 May 2023 16:21:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b0065001705ea5sm1232849pfh.193.2023.05.30.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:16 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.239F666@keescook>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530164004.986750-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 04:40:04PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
