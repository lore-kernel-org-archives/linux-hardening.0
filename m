Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072CC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjEVUQP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEVUQO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:16:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A811A
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so2691069b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786568; x=1687378568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
        b=a4/oSrRQtWRLaqbqVFZWY7qrHna387jLw1QMQLYbleIE1kd7KUiXqNFbF1hj/qyxeL
         u1g/ZpYLS57Lq8SdoOE1vTW6fiOdToSwphBQ415xl1AvhSYo0HTQyvVR5Fe4UifeqLOh
         hGHUHAnxcE/O6kVjnzpWzBPmEl0VRTz/fDV2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786568; x=1687378568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
        b=AyNiaOSPdxbd1K6dRr8PYl5vq7dYnatC7XUOkp24o9d+SporMbmwuL5Y2T/UF+Ez1d
         LktJJtS+bqDmch/A6WJE4kPBfmgiRlzYcGdtp9QY/nARdwUJzmg3VyDcP9LMEgN4ZrWo
         +1VwjHBLEpz61mj+8nh6wIP16S2RBaS1CzPcbr6FYFgBwM1kxu0n2zGd7K2txebSCEPi
         /Z7MSjakbJLjU6N3k8avJTi1uiAB+9bZRor2v/PWTNYKrekKErK1IjW/XN0Jqnxh53io
         1ogaH4cgZUXjFyM1r+92yIYDYKDtbBKyEg03nQ5xIrF9memhl+4OXOhrI3B01SH8rqgP
         OAWQ==
X-Gm-Message-State: AC+VfDwIW08tEvEGCZIZ6HG4IBeAYxvuWIwDvcYWHnA/Cj8g/mfrQntY
        4ZHM9VnDxSkLOwYkYEoYuPdN1Q==
X-Google-Smtp-Source: ACHHUZ7kSdg7lvscJChRXHco/lZQNRpJ7GeHs3ZD/B6Dkut0O0hFkEBB9llB/7LICw3wA0pe6/GJnA==
X-Received: by 2002:a05:6a20:428f:b0:10b:c843:9522 with SMTP id o15-20020a056a20428f00b0010bc8439522mr3203020pzj.20.1684786568532;
        Mon, 22 May 2023 13:16:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b0063b7c42a070sm4508531pfn.68.2023.05.22.13.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:07 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Evan Quan <evan.quan@amd.com>, linux-hardening@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.038CDF6B@keescook>
References: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:52:45PM +0000, Azeem Shaikh wrote:
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
