Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D96C77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjEVUQn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjEVUQc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:16:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E0E0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5346d150972so4728133a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786577; x=1687378577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXAgSSaBSjm1CetJruAB7G9vGtE1c+hHoYZB1utEDWk=;
        b=QQTUxhTD+GBKEguQUQDkEE7nMOAe18rTZR4yd2iaOBBDSLRz7YTvTiKzOUoz/KfNRX
         53a/09Vvla3KWcqtTiP3yI89difUnrz+iE00qjLf6kPKp7r7w0Bkpvbvvp7WqhswLcI5
         P7LmB9YrcotM+OM13H5iyJWT/jIaabCUXsyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786577; x=1687378577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXAgSSaBSjm1CetJruAB7G9vGtE1c+hHoYZB1utEDWk=;
        b=K+oT9ZNvepiPGaeJQxgrlfn8JEsGhhYILC3YaBPgOwTZ+A/MS3dJ6V2N0xg+KJs5Jr
         AbqtZb8wolB97bHuw7rQ1hpIdqnsvOagFOB5fxbKW4RI4pVyD9wALHR4g9et0gc6UCUt
         bqn0WerJn6/5zzE14dC2psAx+vwJRGOYq65f+8DhHl9rSD70plsmSXNIR/sjtGA8aKK5
         pGVPT2EcuzJ1lCCYrlAq7d2fu2VCkKpC4jNJ8vnfsRTTUwiob7/p8InVk3mjUaF8klZd
         Km9F4v4hfZkfGhug7X6eGf9J2IeZRaf05lxaHcD9M6IRJK6GQYHGCbRa+QJUUfPjK9Fe
         BG0g==
X-Gm-Message-State: AC+VfDw2NNnECcGzZnIEo3i7D+14nFJtHM2qUQwNlF/cHsoNAVXvGEBG
        gn6NJ9dmj9Aid9gof108IP5fXA==
X-Google-Smtp-Source: ACHHUZ51FT7XO9iVtfE7W8pRe2pp+oF+jrhOC7+wSnz9QKew8znPQk021RvlTVHrkhez485O6aBqLg==
X-Received: by 2002:a17:90a:a611:b0:253:2dc5:4e12 with SMTP id c17-20020a17090aa61100b002532dc54e12mr10854532pjq.46.1684786577531;
        Mon, 22 May 2023 13:16:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa12-20020a17090af0cc00b0024de3dff70esm4445821pjb.56.2023.05.22.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:17 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: hdmi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.FE9BC18975@keescook>
References: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:53:31PM +0000, Azeem Shaikh wrote:
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
