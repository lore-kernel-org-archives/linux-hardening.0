Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631DEC7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjEVUQM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjEVUQL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:16:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AAB5
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae763f9a94so31346025ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786564; x=1687378564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqoDgNZ9G+pnENJHcgKxrrSDm2QXQ2DN2DVXwRpe84M=;
        b=THb6a7A4+ZDhhztCUfCFsPY/zH0txXyjC+97nEgRFTe1FP6hH7wG4Rx1Ek+S2QkeNF
         rROT12GKEBSriZA/G+nXPcCRbwKUoWabsNyX9y4bwg6gYnpx4jqfuiWo86AeIMljKk3j
         mtLnQUhAfjXjiVaWPWRf4oLQqhq9xk4iIH0sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786564; x=1687378564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqoDgNZ9G+pnENJHcgKxrrSDm2QXQ2DN2DVXwRpe84M=;
        b=SnrDEgYKb8TvzbjrqXdbITi6sNGIGJpB4ADJQGUab2qbmd7+DUgaKV8Q/rjgrhIGP2
         pOI22KwLIyS81gjEVK9VyPKQDkPktccqTWP8zB3qFdgWPKf1DBkN64MPepJSLYt1nJEk
         efB3ChM1xbGd7UAHKMqdtU7R/UV+VfceD8cWw+PyFeAdS1MXsW/uXY1NPcy72NUS4DKS
         pMV7tmjG0SOGSxF9R895fW1b/NY/2UxbwkVupntYfAuwbJR/hKf4AL4cR9Fce7pIvty1
         YaLOh7XC0qFk/W1mzYBwaRqeWsNcMwexAne3kmGzUGE4Dh3o6vSLfQBY+H99om/i+vPq
         e5Mw==
X-Gm-Message-State: AC+VfDwXNu/u+O8j1QBV+5opLLpqq8gyE7rrUnKHhv9S7+2myjGwDFAa
        0wGiaHgIXTlgyNbLOZiPrvY76w==
X-Google-Smtp-Source: ACHHUZ5SQz5k2SFL2blrf696wn78BpsNXHQRqB45l9/xGKDzmS28pRewvtArfVcejoeUFg//+tPPxA==
X-Received: by 2002:a17:90b:1003:b0:255:5bde:e6cc with SMTP id gm3-20020a17090b100300b002555bdee6ccmr5042944pjb.17.1684786564102;
        Mon, 22 May 2023 13:16:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ei13-20020a17090ae54d00b0024744818bc5sm6340408pjb.9.2023.05.22.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:03 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Replace all non-returning strlcpy with strscpy
Message-ID: <202305221316.2817AA4FC@keescook>
References: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:52:28PM +0000, Azeem Shaikh wrote:
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
