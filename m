Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C3BC07E9D
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiI0CdO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiI0CdN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:33:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF7E21E8
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x15-20020a17090a294f00b00205d6bb3815so626309pjf.4
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=beHOJoLMzhtQvwqCVFQE08wvFbsVkqCmgSaQLkojE3Q=;
        b=GgaqksQNT7cicjmr8VgOSy18SzVIWhA+3pfG4AqV2d7ivrbRQA9jxsvP1pfBShGzj/
         OvNqU5NPFlK+0R9qj3ayrs9rJ3IpaxXlAFgu1tPwntOP5mXcOTCS+Eh7FGqrCC7D5LcR
         2mrrZL+fahvKy6IbegfbZ4MQ1qtychGvEdPHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=beHOJoLMzhtQvwqCVFQE08wvFbsVkqCmgSaQLkojE3Q=;
        b=sW+kQPzlhfa18BUq20juXHxm0x2tG1EZMsLtEST7MwfGHU18rorPUdQ47DInwTk/dU
         BjllbG/ulvXnydXTATun/wXRN/wY0hY/PT9aTTrgtk+vnAfg/3Nj3WVn/LfijCD4RMib
         Y4J9Wo1SxjMLuv4o41HRuB+VvSs/IFIaacboztIiN+0xP8FCOQUN0P5vwhqxuxHsXG9g
         v5VUNqmGGdUHXj4+kFZPSOR9CyyS/LbYD+WeLcohe+u2n4x+DMUcKBUzWc09/TpVw4jE
         81Lze77Q5poWp0ZzBPv/GirXHdWlFp7mz01r0LtJYsZEOtsaTcpIuD3qs3feV+Mggu0L
         pNdQ==
X-Gm-Message-State: ACrzQf1JzCVNZ11JO2Y7DmWyt05+KFwIEmcAJu0fXYmqurNvVvPM2/X4
        GzFXySQ1ZI8iONLcZH49WRNK2A==
X-Google-Smtp-Source: AMsMyM5NGw1Q0GfafCgkdr3TRCr4jnFSRQlgeAjDLSIqENbtY3Pu0+GX+M5Sea67UDU9T9u8oKayRQ==
X-Received: by 2002:a17:902:9006:b0:178:b494:c15a with SMTP id a6-20020a170902900600b00178b494c15amr25467224plp.37.1664245991191;
        Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902f38900b001783f964fe3sm155268ple.113.2022.09.26.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:33:10 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:33:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261932.F68BBD85@keescook>
References: <YzIzUjUuJKf0mkKg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIzUjUuJKf0mkKg@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 06:18:42PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new __DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/227
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Some day after the __element_count__ attribute exists, we might want to
consider a __type_select__ attribute to tie union members to a variable
outside the union (like the "type" member here).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
