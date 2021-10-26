Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C538EC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBAB60296
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhJZRTb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJZRTa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 13:19:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971FC061745
        for <linux-hardening@vger.kernel.org>; Tue, 26 Oct 2021 10:17:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v193so128321pfc.4
        for <linux-hardening@vger.kernel.org>; Tue, 26 Oct 2021 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jS/Bb8HlBeXqBieknFa/sF/Lj+vFn0yJ+1yyDaWDOro=;
        b=SlbA97RgFmReoxDo2sQ4uaMAJ1WFI/4jMnoGIQG+HMpFaWq8WZVWBYz3HE7O19AAhI
         N9AGWBiYUy+cDOfw3nlYPFSOcRBlDPjNwTJTvB96MMZT3UHHaap4Qoh2XJTHzL4WYbRn
         thoBlvHlxlooKrUCBZjGCXL3NJoBML/xdDfMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jS/Bb8HlBeXqBieknFa/sF/Lj+vFn0yJ+1yyDaWDOro=;
        b=ZkAyBCSZw9MxOIo3Eft5NW9Lp+Rx+eFPbHdkMVupkBm49w3Vpp7FAK3hdWfSzerRJL
         7e4GX1p+59cFhUURutLnujNP8VjR6Ktv8mSg34Y2BjY/9Cle05fqo73mG1pVEV7v9aj6
         m1CGvKtJ5K+cHMaRlQl+hDvm/Ar0+9j452B4C6ilyGaNNifejjcr4UbHfNtLnoaBQGw9
         FMRGfc4nq7CEEabnYZILKUoMvuSD0O50agXk8ZzeTO+/DE7gILL+n0qx7n0Md9Bj1QD/
         dD/JSP2cZTf0c+ChoOAKMc6JPcB+sBIKKFslkN3EBj64AbSqKQ2d05cYVSkyB/PiYVY4
         ecpQ==
X-Gm-Message-State: AOAM533a5/g0eNSO7BSSUNq5Z5pL3+x20XccV5MtKeRECd5poCwuaLB7
        Z0SSYe6VSLB+GD84b0JAECtekA==
X-Google-Smtp-Source: ABdhPJy3wcwbRrDjTLAyIluKSke1KBFc/7opoyClAa4a0Aad9xqEBPHL5L/WIQBY6FtASto34NbzBw==
X-Received: by 2002:a05:6a00:b92:b0:47b:e437:9ba with SMTP id g18-20020a056a000b9200b0047be43709bamr18624429pfj.39.1635268626307;
        Tue, 26 Oct 2021 10:17:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u193sm18979323pgc.34.2021.10.26.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:17:05 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:17:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: stackprotector: prefer compiler for TLS based
 per-task protector
Message-ID: <202110261015.D992D69@keescook>
References: <20211021142516.1843042-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021142516.1843042-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 04:25:16PM +0200, Ard Biesheuvel wrote:
> Currently, we implement the per-task stack protector for ARM using a GCC
> plugin, due to lack of native compiler support. However, work is
> underway to get this implemented in the compiler, which means we will be
> able to deprecate the GCC plugin at some point.
> 
> In the meantime, we will need to support both, where the native compiler
> implementation is obviously preferred. So let's wire this up in Kconfig
> and the Makefile.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

With the v3 GCC patch[1], this works for me. Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

And since this is doing a compiler feature-test, this can get landed
without waiting for GCC, IMO.

-Kees

[1] https://lore.kernel.org/linux-hardening/20211026081836.3518758-2-ardb@kernel.org/

-- 
Kees Cook
