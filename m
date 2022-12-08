Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7627C4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLHQQa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLHQQ1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:16:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C73AE4D0
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:16:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u5so2028536pjy.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lfY71TAViOQoe8YQHZ95RIFrQ+A11ZWICcAERJdWds=;
        b=hTN6H1OVBAFSCwo/nxyNAtyDzh106TmfYVB4USPC+RT73HCInYFg1auXkJ182+uwoX
         QrnwHu8oZr+KHn59TSvHWnjU3dea2id9D+YkQ6cfcXskt11hkUTHL3ZkGVE9SE2x66/4
         epv9mfaRYkC49+0DD6wlucjfoGmRJdF805Ny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lfY71TAViOQoe8YQHZ95RIFrQ+A11ZWICcAERJdWds=;
        b=RQqZ8ENGM7qhPaUoz774NdTUHuEaDVF+cv76VJRIPycAGkMPv/a8PavrvJrdzUWF0I
         A5bTxRDgQ/p/maDJ03d0cUaT1n8cXL9kq7YWVLNtNEmFL2HvB6DBbhcA5cMTRdDo8Thh
         mKDpnVqEkJNGuhTn0QN7pN8Q+dIgCbR3NGpdkc2kL9wWAOGxsJVw5wfOaKqo34aqK5Z+
         bJ5Yi40spGrczV665frDRonZpVOq8EZkLvTeOy+GYWgc7+bxOgv8zSnWMBJhpdSKYE8O
         qQrjlS8tzwT6ZGzkdOKY4njqoBe04leMwZ+9++bXS4v5hCLF9YDCxuIBqsi7HnpAdujU
         LmUA==
X-Gm-Message-State: ANoB5pn/ZBfIrNhjEBTMXU3/ixFkYv5IqaBhThQEvOnioWg61looVIqT
        ECmhg76bGaa/oz8RlYU04bFlxPtWMT5OQeUC
X-Google-Smtp-Source: AA0mqf7HpLsd2uW2CYrl0cCNhuhZbciNR3eUqo8jRlRor65NEX26E+Iv7KyDDQfTOVBuaHYoLQ2iHw==
X-Received: by 2002:a17:90a:ad85:b0:21a:1d94:568f with SMTP id s5-20020a17090aad8500b0021a1d94568fmr4818888pjq.51.1670516178264;
        Thu, 08 Dec 2022 08:16:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902a70600b00174f7d10a03sm7377321plq.86.2022.12.08.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:16:17 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:16:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/6] mm/memfd: add F_SEAL_EXEC
Message-ID: <202212080814.821C05264@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-2-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:34PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> The new F_SEAL_EXEC flag will prevent modification of the exec bits:
> written as traditional octal mask, 0111, or as named flags, S_IXUSR |
> S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
> any of these bits after the seal is applied will fail with errno EPERM.
> 
> This will preserve the execute bits as they are at the time of sealing,
> so the memfd will become either permanently executable or permanently
> un-executable.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>

It looks like my Reviewed-by: tag was dropped?

https://lore.kernel.org/lkml/202212021443.0F684E33@keescook/

This patch is unchanged, so please carry forward any review/ack/tested
tags, etc.

But for the bots:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
