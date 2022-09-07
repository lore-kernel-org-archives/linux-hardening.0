Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DFC38145
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIGXeq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIGXem (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Sep 2022 19:34:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BFF25596
        for <linux-hardening@vger.kernel.org>; Wed,  7 Sep 2022 16:34:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t3so11030211ply.2
        for <linux-hardening@vger.kernel.org>; Wed, 07 Sep 2022 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XSbBGffu2FVIOAcIwkeNSD8KuaOdq+iesnGMUCwAeTU=;
        b=KY+PrU0lGhQtTLQNN2pWFqcE1LnBpbbWDb0rbOdjRcryAGRzT10mekKUQs/hx5IWfc
         NFnigMwimobNFGgyI+x3a1uPOyWp+GJ57NrlduGzWlADCIfmi4DEvVyxP3klvjGSmK6S
         bIsg/2Kj75aYsnpvzhm/uSVj330L5WzCT/lBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XSbBGffu2FVIOAcIwkeNSD8KuaOdq+iesnGMUCwAeTU=;
        b=wnNxwzoHKOSlBz3RnQgrDVU0onOTuDdAJfP9gJw3n3F6LCIJEL1GjrEyeCT5MMpL2U
         TzAQ0ORgIjbXIyb2qwZFQgABt2uOoyJXCOytZvZXpnthTJRZSGNp4aP/+XYLIVMTyYQ1
         jIRDtr7B6QyPM1CyjVSxPQbvzk4c0VmdnD5VOLg7zr5pCevd+YR3OyXc4Mh1bRviFSbY
         smJmG9VawDmOjpsM5mIZcLQJWruxiif5fxsKeMIiGiDFqvRKKWmr4NZ7KNjLG3N66FUu
         s2BWeTwBEzkgqNwSbQSdxHi2pcEoFyVgmTxb4JAZVKqUUFf1UNOhJ1+gwoH56SgnG8wN
         m5tA==
X-Gm-Message-State: ACgBeo0z/bklxjuHHgRKClwzc1wYhfN5Ax13lQIHrHPoRvQ2mKN/kOjY
        iaaBAgNCaqk3REvgpwJvb+lFSQ==
X-Google-Smtp-Source: AA6agR6Rj3Ng4uD4eI/0C1clYjJ/SoLai8r45C+puUVjcvUnjiFrRX0IS6jpxhbi09w8xzFyK3bhEg==
X-Received: by 2002:a17:902:d2cd:b0:177:4940:cc03 with SMTP id n13-20020a170902d2cd00b001774940cc03mr4538114plc.98.1662593680649;
        Wed, 07 Sep 2022 16:34:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10-20020a63da4a000000b0042c0ffa0e62sm11192333pgj.47.2022.09.07.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:34:39 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:34:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc: Fix fall-through warning for Clang
Message-ID: <202209071634.7CEEF9A@keescook>
References: <Yxe8XTY5C9qJLd0Z@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxe8XTY5C9qJLd0Z@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 06, 2022 at 10:32:13PM +0100, Gustavo A. R. Silva wrote:
> Fix the following fallthrough warning:
> 
> arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> Link: https://github.com/KSPP/linux/issues/198
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202209061224.KxORRGVg-lkp@intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
