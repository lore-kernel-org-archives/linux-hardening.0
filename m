Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE1DEE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjIOE7e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjIOE7d (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:59:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97EA271C
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c06f6f98c0so15525795ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694753967; x=1695358767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYRpyQlIT436zPtN6nLdUj+VpyPz7BPfenc2yhNBnyA=;
        b=kn7dvYybNkJRobdb6fmVvLdZR+A3XSsfiz3ovZfnaJDL2Z/QnZrbeZhtiDMdt5UXdw
         TSE/dgk83EnytXgxVcR0hz1lnKV3LxJDl76Q745AC497I6ms0PvLpczFecuaefaUwp9G
         7IZD4tu2bOPTZRpTjpnH2RM3IhY+BeZQ9FRYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753967; x=1695358767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYRpyQlIT436zPtN6nLdUj+VpyPz7BPfenc2yhNBnyA=;
        b=hb8MP5Otq34UAFn68wT+ckdqdp45i1NEMHE9OppiK/4+lTTks/b2II3nYLaRuzc40h
         vKpIc3u+H9+rQUBbNK35KbaC7X0V2Dnjp5JQ7643VXA9YTQTLwlMLi5mLDDp8a88vCvT
         vFy659qaYOX14lYlxZxlaFjlLRIFClWO8bFCdM2Lf00ALMCncSu3CXOMXEHYO3L8+Gts
         BNJ0ejSiBzCezXDaOWIWLzbpc8e2t8zajvsl2q7RU8wgfqZH5V73Jeh8WGrhmVviAa1+
         KCfSK7HGEalr4mMqUL/rx3e7X86ABVeiK+LK+7JVZ/qOlb2Z7V+l/gJ88SQqp0OlacPL
         lSWQ==
X-Gm-Message-State: AOJu0YzK351nfVSz/VibvfPXVk0lwol8ADfA81GbEdAXEidPBhacX+dO
        1TcSRTrWa2MMH+BoPY0M8XVFCg==
X-Google-Smtp-Source: AGHT+IHpnSwhbI66lN4Z3sU7pXA6O9Wq2OcHhE6YgrndvyVXYXJ9PNFRMH9fyCLkUgX/bGvjpC5C/A==
X-Received: by 2002:a17:902:7081:b0:1b7:fd82:973c with SMTP id z1-20020a170902708100b001b7fd82973cmr618871plk.39.1694753967460;
        Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001c0a414695bsm2461749pld.43.2023.09.14.21.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:59:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:59:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
Message-ID: <202309142158.59A6C62F@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 10:17:08PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

The "- 1" use in the original code is strong evidence for this being a
sane conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
