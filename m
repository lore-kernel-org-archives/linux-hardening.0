Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE7C77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjE3XGP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjE3XGO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07372107
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d3578c25bso5874870b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487973; x=1688079973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zao+usj1MFnHO0lPVaYxKTWIh4Wrl1XUDw1PK7J3fWM=;
        b=JxW2OPW0HQsH3SYq6o+okCUEhDYhLDsnK1IuCG7HA6xFymgskDPQOJb3fsdobb+33b
         OytwBRj9myGzf6KufZCXuq8v1N449uBhWYJDYZr/WDjiEjkffVePnp2koTcOUJletBb3
         V+wiOOW5qxMjHFzU+yLJCZPoAi1X2q/uS84gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487973; x=1688079973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zao+usj1MFnHO0lPVaYxKTWIh4Wrl1XUDw1PK7J3fWM=;
        b=akm8iM+Aow/x8kJudq7VgZNQ1KDdTkAVylGpbVEc2yNbilERAF8fIiAgvPSFptl8JD
         usIIQxRojFNdOIqnjAN8cSVbKAaPq2lElOOfd9XhIQEsouYCz4KlpoSkLyW8OinnLtsc
         EM3LZ/l5biZO0AC+5Ox5lcinEBQC020RcfCbXVMiY1692vgXgrDkAEso5AgR0O2VSyip
         eFJ/qCcVk9scs+dnRC3RGPcrQavVoQE8bB//pVN+d+ol90kFhV8kjGrXD3tifHaOjjeG
         errKoxLDIMDve3kqZDRoR+ZlxfDFJe6kAzmKxoIV6GpL7L2578gB3CmkoN0k310KdqFl
         N3Mw==
X-Gm-Message-State: AC+VfDyxxM/l0o9CCRvedTL4j1o+9x0wq2wvoQ62CC1ajNFfe153OCng
        9ztJvNq9rqUsiWC6zzV3DalYoA==
X-Google-Smtp-Source: ACHHUZ5D1+tV1+lvxmaVwvByCrU2SFfVv0srtnoQzi2H74dwcr6jd0JM1qdxaJAJFzqXVqgoNVS1HA==
X-Received: by 2002:a05:6a00:150f:b0:642:fbed:2808 with SMTP id q15-20020a056a00150f00b00642fbed2808mr5705307pfu.25.1685487973579;
        Tue, 30 May 2023 16:06:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d4-20020aa78144000000b0064d7221529asm2162683pfn.32.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     heiko@sntech.de, azeemshaikh38@gmail.com, hjc@rock-chips.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, airlied@gmail.com
Subject: Re: [PATCH] drm/rockchip: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:04 -0700
Message-Id: <168548796306.1350188.1085117815557149174.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
References: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:51:49 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/rockchip: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/3bc490653e12

-- 
Kees Cook

