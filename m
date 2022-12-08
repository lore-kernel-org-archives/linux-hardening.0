Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C654C63703
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLHQVe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLHQVd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:21:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501206FF02
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:21:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2062010pjh.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrJ14ayLT7F+1zAXfd85zeuS9jwgRhVrcw7Y0+tLb6Y=;
        b=g8P4/eojTrI2HBCiA4zp/WCQXL2NPFnOjDEnV/senXcKqmtpvz8/sl35IibIlf56Xb
         ZynllzhNzGK/ud3dS9sa5QvNDOO/hi6CMtTwElRCKkJcwqr16oyYBna2FSFSeQmU9wko
         JEFCS20QBntq7LbVs0aCBuYQzFzL9J9+gjq70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrJ14ayLT7F+1zAXfd85zeuS9jwgRhVrcw7Y0+tLb6Y=;
        b=c06/gwmVhIKitEXo8wjZ07y3w9uaZOL+ZzNl2UHNSLm6n6Hm6DuKBDwLiY7h9h2NsF
         FK68pxdNX66iKq4NQFza4r6JgqlCGw21gx6rcjc1Kx/cV6gIjCeYM+3ZyGDhig5vt0e8
         mFkTOImLp6uiI91rBqWtuthqZseEbc6h42iJmfhkWm5WW/cw0CT6wg99NrQ+lah1b3o7
         mkEWqIApPVygtAItZ/VNtm6gnZeRtRhkiA4I/XR+pyeVJc8olaEbsr7kJspMyHgl5vRi
         onk17z9uvQaqoqbsIBzKLPzYPCIGkTNSDKYWaYKcuaYZbl+lNUJE6QfqXtNTtmOv957V
         eeiA==
X-Gm-Message-State: ANoB5pkP/iSWHuFRr+laD1S1LUIFZoeUS0IiGaAwmzdTvD3pWAukid7E
        vUgtJ9MCfChp0YsaYBJcu3XlYg==
X-Google-Smtp-Source: AA0mqf7RMfVU6OSBfzQOkqOeCkx3TWMEkSgjK0ClXrEprodhsyI5WvH+XKjOP1ImKWPf16MmgfyfaA==
X-Received: by 2002:a17:90a:9f46:b0:219:b1db:f7e3 with SMTP id q6-20020a17090a9f4600b00219b1dbf7e3mr23917526pjv.64.1670516490729;
        Thu, 08 Dec 2022 08:21:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm7924158pjb.1.2022.12.08.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:21:30 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:21:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Message-ID: <202212080818.28476A4@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-3-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-3-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:35PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 129 ++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 94df2692e6e4..1d7e7b36bbdd 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -28,12 +28,44 @@
>  #define MFD_DEF_SIZE 8192
>  #define STACK_SIZE 65536
>  
> +#ifndef F_SEAL_EXEC
> +#define F_SEAL_EXEC	0x0020
> +#endif
> +
> +#ifndef MAX_PATH
> +#define MAX_PATH 256
> +#endif

I'd expect this to be named PATH_MAX, and it shouldn't need to have an
#ifdef? That's a regular POSIX define.

Otherwise, looks good. Though it'd be nice if this test use
kselftest_harness.h, but that's not your problem. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
