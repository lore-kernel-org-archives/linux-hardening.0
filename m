Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9150FC4708F
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9036135D
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhFATWx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhFATWu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D7C06174A
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 12:21:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x18so259727pfi.9
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=buLhPbHrFpi6KG0ErdpygLDLYcV9LBfIxFbXDWOKBP4=;
        b=nJQJkMdFCEKm3y3/x9E10xUE4aPzsu6vVkMeh1Y89Ap/86sznI718OOCm2FHLR7aVb
         MAep6R53Bjstw0NZACsB0x30q6XYaf1Gt5SBkqPn87sVXoBQLqAvA3ETFbRiz3SvxBhR
         Dx/kqyg1/CwpJHGPbXVmiIMAdJRxVOQl02YuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=buLhPbHrFpi6KG0ErdpygLDLYcV9LBfIxFbXDWOKBP4=;
        b=enKzJ1otl2HfVUKuIjtL1jDIpU7OzNenXIGIm+HLAti3TTB/CkIh1AjBnuxyJK5QZv
         hmTjQNe4Qme8RJdFfOxWkhcQTBueiuSvELGrGX+yhA+XgbUZt4CkC+MlEWjFZWbrEGrL
         93mwjDCkmvvr7gntBqd3R0J1eHtSGJGLsCrqjF5owBff1+uSDQgbBaBg2nib8JWxGb0u
         460wPY2qbON+P4XApSWuRhQYt0lPrpf4jQ3r5itiBud1e88rlBqPmYyTH8lNF8oVMtz2
         8TQ9i1pNzH1Xz/1r36zjfWAB534FYrh8HZdFTDtFHhO2xh2oxxmwEtSUSYQnFI+JLb/y
         zK9A==
X-Gm-Message-State: AOAM531msZg1rRLexBeHJ++EVGULxHWL9VajLtj7dafg2ENkum+oJ+Xc
        XZmFc2+vA387QUqv9v5d407xFw==
X-Google-Smtp-Source: ABdhPJyteTrnW0BHtAZrMYVkg3K+7X01zzTkWDHpLl34qK/KTkq2FaLhiurwLoG9HZLZaaCo9qlPsQ==
X-Received: by 2002:a63:db01:: with SMTP id e1mr29836130pgg.38.1622575267711;
        Tue, 01 Jun 2021 12:21:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s29sm10486657pgm.82.2021.06.01.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:21:07 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:21:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] octeontx2-pf: Fix fall-through warning for Clang
Message-ID: <202106011221.24B746FA@keescook>
References: <20210528202225.GA39855@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528202225.GA39855@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 28, 2021 at 03:22:25PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
