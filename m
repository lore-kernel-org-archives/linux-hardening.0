Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB3AC7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjEVUQR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjEVUQP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:16:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441EFB6
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso1473339b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786573; x=1687378573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBzsEFEBaOoamjuMu6tkFnCdq33AsZWodYlngR5umYI=;
        b=NQpIylAo879lZg+bIGPMAEf7DDZr1HUjRDRjXgFFzOZAqJismdNG2vT6fvEGnxixbE
         AO59fHineVN3ZV8SGUip2kK2YNl7yCMhINlOucn3D9rFDYquHDJDjZqxyorrI6Aa1PG3
         dgDmEFNb5d5Gy4SPsHORvJXWSanJ+OBQLiiBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786573; x=1687378573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBzsEFEBaOoamjuMu6tkFnCdq33AsZWodYlngR5umYI=;
        b=VC+5Fz2TIo0d9cm/zQnprKkEm/ZWvPdtV/sh9LZh0o+NvVZmmfsiew9TUbg6uRB474
         Tej5mGvLQmP3/AsEKK2S8Eor1sQx7wuL2Bx1i/S1EJ1e2XdxpTsFA6nqBf16zAhrUgjF
         T+8bca6fVbxrxtadamYOv2EvFbYT9FMTePVo+JWgfjkcgjNVwf0az/NhaZwn01lcQE2O
         7NKR+9nMIuyV29vsPEhvipz8ePLwJENm+fj9HnQxM6/hLKWG0TA4HZVwFr+B7s/6ZhZc
         K3+xUMJ8wfa1RDKHRY0YkCS50DFRYOJS6Jj6uDBIuU1yZr6xRnxRhAaf3jhkoWVdQDfU
         YIzw==
X-Gm-Message-State: AC+VfDzTNxZ0YrIem8TX6/OQrP+h93+yQK/aTmLFx3MN0PCyhFycP1sH
        RJ0ac6ySFwhwkIc79NWoHG6vvschgbgBxHcN5Ek=
X-Google-Smtp-Source: ACHHUZ5ATfKSsDeoySmt4TpoCC/s6QT9JMih/7kH5QlewrwQzwJyKfURuuEBVyEFMexNU1NyLHmTzg==
X-Received: by 2002:a05:6a00:a20:b0:64a:4bfa:6b8d with SMTP id p32-20020a056a000a2000b0064a4bfa6b8dmr16642693pfh.6.1684786572799;
        Mon, 22 May 2023 13:16:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b00640ddad2e0dsm4512884pfo.47.2023.05.22.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:12 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.5C8770098@keescook>
References: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:53:06PM +0000, Azeem Shaikh wrote:
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
