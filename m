Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A693DEB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 23:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGLX5G (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjGLX5F (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 19:57:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F741FCC
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:57:04 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1ebb79579so120084b6e.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206224; x=1691798224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYROqSK0oGJBA8nxTpmL+2rtwtyb8ppjHpWlTiycuKo=;
        b=AZTKaFYYXON4rgsnRbf3f/htNSktLIa7GziRaeoZhHru0aYHY04rcSunBeh8mzMsgm
         eu7l9CedpWX3IP0/3g0x/1pegm3t7l8KywxFZiQFuffX6Dh6/e+JZCzwvgtTTKBFlBoG
         fIwMbca317JWpsuBHvDBG/TdYvbf+VF72ppTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206224; x=1691798224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYROqSK0oGJBA8nxTpmL+2rtwtyb8ppjHpWlTiycuKo=;
        b=fzfD1pBUaT/zqDfMiWmm8Ki6GycETC1eHpIxA1sPD5tQJ05MTEYzhstFMyLpnAawJE
         /lbMJsIcFMim+tMx4FNPSeqAtellx1Prpy+tNxReMNN8tZDNGAty33t+uVDQAvvK2oPr
         8cxuKjS9TtAaupXyXcja4JI42AKo5hlRnl8tV2hz5ofHMskR2Z7MSR0Jw6qDh/KPrMoh
         NCQDaPwKWouhuj8Pcceuja+nz90D4ktGcIyjwCA1MS2rJqlB358nDC3u3Grmap1usxW8
         RIobggsvip4XxAoze3XNmyjphn+tVfFx4Gm4aNiRKrHaHLfOHS7NrC5AjGVEKnkItml9
         uRrA==
X-Gm-Message-State: ABy/qLamvFjvpdnWAu+6FcejN17NFzkQGWJlMs/ymHavTH8DajOGf+04
        sBhND1x66Mq103V1rMknZKwn1g==
X-Google-Smtp-Source: APBJJlGkuv3xzrFZa1CbUFIQB39M3wGoMPlRAgtPPH6QwfuF1YKCuvoHZyltzxMVwxohnGxyvw0gqA==
X-Received: by 2002:a05:6808:130e:b0:3a4:2460:2b9a with SMTP id y14-20020a056808130e00b003a424602b9amr5257820oiv.34.1689206223773;
        Wed, 12 Jul 2023 16:57:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00663b712bfbdsm4163550pfo.57.2023.07.12.16.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:57:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:57:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] um: Remove strlcpy declaration
Message-ID: <202307121657.9B32681D6@keescook>
References: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 03, 2023 at 04:06:41PM +0000, Azeem Shaikh wrote:
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
