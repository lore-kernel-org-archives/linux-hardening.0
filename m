Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CFC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjEVUPN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEVUPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:15:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E386B7
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3742453b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786510; x=1687378510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
        b=Vt5mLw1zDYiyC23QcOz7VOSTUfaxfWt+kaBNXr4ct2pwiJ99N4MhY1NbeTx3uv1mm6
         qRnDKSWxiCoUPyGP6Z666O7SSigjCy/AdTJKWo5Ri/TUJ1xBsQ0HVb2fau6I/qb+yU8m
         1r5UJtw9NgpIXzOePa+QVYe0Qj0thwDN6wDuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786510; x=1687378510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
        b=AwQkHMLwQK8pl5dcTKokkY2dr1/JHIN2N+wrng7+5pM/MMtgWAMNxaD5Kxxicdt6Sx
         BKXdpYliA+hKtWcMbyEXGrtIeJGIjf8NT7exQ/9KfExzZ4ZWzHHF5OkMkGKvopk4tCU9
         Y0vh+EI8dSO+rnWACb3kYIdHeAJeqcH5EnCFU2PCB/z+ju3nDnj9RP2hdsPaZ5hTryH+
         8PvsrGeFquPR12EPrEyRAW19g/7qtC4maZQWV5+syUupN1vXVMeLMr0IWJzXrzoXoK3r
         7g7koCnk6yDQ4wIe2gdfC+AopKzmAeXfgGcnIFx/1EOxy6q+196f4YN+ANboVKbY75Xp
         eFwQ==
X-Gm-Message-State: AC+VfDxm8UN+BGtNjI9APAFmrASJyA6zyH/6Z5ZBaLPsgvrPkSfcLGx7
        Lcdah30XNflReOfxBFYi20yHvQ==
X-Google-Smtp-Source: ACHHUZ7puI3viaM9u3eCn1pWl+lXzpSStw8vQUJTeuU3YLnaPBQ6edr8Hq6qSp4lKa3v8WUp7Z99Kg==
X-Received: by 2002:a17:902:e74c:b0:1af:a349:3f0d with SMTP id p12-20020a170902e74c00b001afa3493f0dmr8517770plf.23.1684786510093;
        Mon, 22 May 2023 13:15:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b001a634e79af0sm5209204plb.283.2023.05.22.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:09 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        linux-hardening@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221315.4392080E4@keescook>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:50:32PM +0000, Azeem Shaikh wrote:
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
