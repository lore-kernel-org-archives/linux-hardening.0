Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56479C48BE8
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Jun 2021 23:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE260FEE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Jun 2021 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhFRXqD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhFRXqC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Jun 2021 19:46:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A91C06175F
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m17so2321904plx.7
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VaxeR6kq1TatKHxRpRVY2RGQ7tO/m+vKgd0wWV7OHFE=;
        b=oKpBYtD2pXCHjq5y/Nt8YG3X6Hc+aprbg2b9ZkAsrU+kH2cTN5vRzPu4dhgdPq/BMg
         YXfowyn9ZKcrfjQU2uBOSxrSmWRwg+rw+35xxmHk+/WEnlFCFefwGdPe+yGDw18U+/v5
         fpDCZe8f7Xg4iY29vtdBl9/pA7c436jM7zKjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VaxeR6kq1TatKHxRpRVY2RGQ7tO/m+vKgd0wWV7OHFE=;
        b=sIOWz4+cGlGnWhXKDqaFkA5R3vf/l+/nKd4pDlgU1RCerYgm6h6ynalfZFwA2zfyvs
         TNzyU0g/2wk7WNaLVJ+mY2fchF/tVBEW+v87Phae/Sc5JkfDXgoS9zXPBVgREpPZOIZA
         6SOWYRb/6+GSJaz8HklVRUolHchEUXBLiXCNh8pVjS0z3UdeKn92J8lA6/h6xMAaoROs
         kuZ8uWAxAbobaAoCtdg8QZV9bf8xUX0JchceWWUf5BFYJ0qN36CmAe+u4gHHkLrm8Fo3
         j8Kw87yAW+yvxiYWTxpqa6HN3DinAZe/x821+6eKFggZfyzXSYPqpZJ7YZjSMjLJsrKF
         e+Vg==
X-Gm-Message-State: AOAM533yen1axTnbD45DggDvSLAHdl4Nra8hNRxwAIQiAMUej9s5qmax
        uxgpazi8fotJGJEbAjW0jcLJNg==
X-Google-Smtp-Source: ABdhPJxCYWIunQzevcI7fFjpJx4ABhcng0aYoYnWLpsnKsb7BHY1Kizbat1j8IK9uKd7lLwjs1tOIg==
X-Received: by 2002:a17:902:aa4a:b029:10e:f98c:2b83 with SMTP id c10-20020a170902aa4ab029010ef98c2b83mr6883721plr.62.1624059831217;
        Fri, 18 Jun 2021 16:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n23sm9178485pff.93.2021.06.18.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:43:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Fix multiple fall-through warnings for Clang
Message-ID: <202106181643.99B75165@keescook>
References: <20210616191714.GA104231@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616191714.GA104231@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 16, 2021 at 02:17:14PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix
> the following warnings by replacing /* fallthrough */ comments,
> and its variants, with the new pseudo-keyword macro fallthrough:
> 
> fs/xfs/libxfs/xfs_attr.c:487:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:500:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:532:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:594:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:607:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1410:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1445:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/xfs/libxfs/xfs_attr.c:1473:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> Notice that Clang doesn't recognize /* fallthrough */ comments as
> implicit fall-through markings, so in order to globally enable
> -Wimplicit-fallthrough for Clang, these comments need to be
> replaced with fallthrough; in the whole codebase.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for carrying these!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
