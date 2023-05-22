Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186AC7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEVUPX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjEVUPS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:15:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC9B7
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so46485925ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786517; x=1687378517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kJUhMwhu8pmB0S/reI91bCPURToQamQOJVM6YT2PQk=;
        b=K0i7JwPBVmGMOLMWLK/3kPh9tQi1cz1mf6ZiGbF/qmCvezU63ySpE7rp+c4R65Zjs9
         zimyPm3Odf3qhFjVr9OwQ7BCcY6Pec/gRL3wCPUSN4Gd+jk/oC+PnZ/s3udoM5zUnE5p
         20QdzjUctLVil0kxmBOGLAgfuZC2jtKYOjFz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786517; x=1687378517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kJUhMwhu8pmB0S/reI91bCPURToQamQOJVM6YT2PQk=;
        b=XRolOxbqsv4pRJHwmfXkwhOLzS6KqOVj8ONc6Q5F/9WQLTaLYQprXJcEmvKD/a7DI2
         N4rJhVMAdmz3geALic9ZwRb8OfrkO4vGmzmCrh/tCFc2yua91CVOarjJ4gH+kvdBvkjd
         y8flzp46k0Uf8Jd5xU6yBuMCVPpBQ5uNaVGpyJfLZJkmxpZ+yt7y+ynR20vI+52VI7pl
         11kX6PtRM+OOlFA4fuV0pHYjrvXHFmQOerMgPYzBTVcywuBf0x3CknTPc3CwFWJBh5eY
         Ye4QMXwptxx1y8KfVaX1VfihgzbN5wzwLImpBXymUeFg6dJ5OlqqHHIsblZB5MCl89yv
         4CGg==
X-Gm-Message-State: AC+VfDxGjvG1U5EZFo9D9CXcftC4BPcrnsvkcedf0wnWQwzU4avHOSvE
        s8keCh2zegt6OWirrgtO8r692Q==
X-Google-Smtp-Source: ACHHUZ5QSapbcHFKbYzfAO0Hf2n6h4/H3FAnhE+dze/4InLVr1Uc7D3qUfrMrjPffZ+EQHaD+UWsGQ==
X-Received: by 2002:a17:902:934a:b0:1af:c1af:8d83 with SMTP id g10-20020a170902934a00b001afc1af8d83mr1319174plp.45.1684786517491;
        Mon, 22 May 2023 13:15:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ab2b415bdbsm5247305plg.45.2023.05.22.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:16 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Lyude Paul <lyude@redhat.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/display/dp_mst: Replace all non-returning strlcpy
 with strscpy
Message-ID: <202305221315.9CD6F67@keescook>
References: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:51:24PM +0000, Azeem Shaikh wrote:
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
