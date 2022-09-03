Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0098C38145
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Sep 2022 05:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiICFMa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiICFMa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Sep 2022 01:12:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45537E033
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 22:12:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j5so3743041plj.5
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DWQU4BjAk2RKJXcziV8gz7Em/gw7x1iBMRQeoGw/K1A=;
        b=a0Jq0XZYSQA1ZyBSSQtFq3BQ8vg873jp0dp5wazzJ6inOF195+lnsDAOPUGs6u3Knz
         z1zC7iYuExltCbr1CHrw+kG2wIrjr5zrW75GFzxfyyLEKJZmUAz4MkHYLh2c5VL0y9UD
         aqsiJxsNXtVG4DXUTWfcxZLABqciAZKarEbtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DWQU4BjAk2RKJXcziV8gz7Em/gw7x1iBMRQeoGw/K1A=;
        b=xkoWxIryGcxvtifin9syrMQEjAqiADtAguMR5XXA+lj/v7VA/fF3qJwcAhulUjqc7j
         CvF25Bb5hkZJEGlNTbxKND/FEOewSrbbkDx/bg/Weg9ZOHuYaNE/8fxmJ+7aXw+ffJdO
         WBq36eG9RYn8zyrwxWDwA2pG52l06I1UTvupGz6sCbgLPlbOEB4IRpqxudItTaFsA+QD
         SGrPfmaHXRF+A4jLqFWgF+NFf6ZmBUX8VlOpzB/YfN7APEQZ4ruEa3EFAucptJo3QGmz
         labhddB4f8MiPGVyHzJPyk6FrgbnzYVOXf+WQlejYPAyxF/wXoVahsffMn/fElii3IXm
         eviQ==
X-Gm-Message-State: ACgBeo08i6QRQ9mdVgj1o8umbCu5c8J+igsSr+t73Zgj46l8omkzLVey
        bQjg7BvSk2s0GdmCbr5fLIKolA==
X-Google-Smtp-Source: AA6agR79orMmne040IWFGp4YWTLDIAXoo56UMa3pGaPPoHU65ls6cjvq+KJexvX/CPOzSvzjZEMf7g==
X-Received: by 2002:a17:902:8ec6:b0:172:dc2c:306d with SMTP id x6-20020a1709028ec600b00172dc2c306dmr39278791plo.104.1662181947281;
        Fri, 02 Sep 2022 22:12:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a2bcb00b001facb7bc1adsm6140998pje.26.2022.09.02.22.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:12:26 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:12:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ocfs2: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022212.7F753284@keescook>
References: <YxKY6O2hmdwNh8r8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKY6O2hmdwNh8r8@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 03, 2022 at 12:59:36AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declarations in a couple of structures and unions with the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This helper allows for a flexible-array member in a union and as
> only member in a structure.
> 
> Also, this addresses multiple warnings reported when building with
> Clang-15 and -Wzero-length-array.
> 
> Lastly, this will also help memcpy (in a coming hardening update)
> execute proper bounds-checking on variable length object i_symlink
> at fs/ocfs2/namei.c:1973:
> 
> fs/ocfs2/namei.c:
> 1973                 memcpy((char *) fe->id2.i_symlink, symname, l);
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
