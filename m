Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25044C47080
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE33613B9
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhFATWW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFATWW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D57C06174A
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 12:20:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so2023369pjp.4
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bFNYi6m++gbCXTaIyGQySmm0f86eYc/Qr6XGD1RfsTo=;
        b=nEqGKcRi6N4t0IegL+8HbfXnUJ+QjBc/I85UjwK8r+2W1OajAAHtMS52fDLvCq5I42
         VQf1aq9ltt4QTVpgYd8h00ZVL5ORJBjfBrIgvpKvAODbvgtZqYI0k2qAWnP7QvmYhjzE
         yzlvivuoc8Ey5s/YsQJXDgWJv/8i7HS9xfmQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bFNYi6m++gbCXTaIyGQySmm0f86eYc/Qr6XGD1RfsTo=;
        b=pl+DSRkgl8D78dJOCLxcOGLxtqLVkl08SoIsDKVbvTUUxCgzWN+XgYz7VcV52NMAgl
         78VN2hh4riumT6Jgpwj6T9pcFk4gUA9V4gZc0W+bcs7S4BFUYynaDF6zDpFTfNYnReuD
         fuTZOG0YrcgxcjkF+8cQ73wl/kCbEqqy4qhLgQ2lg+2h8nVtT861OVrCw43dCv/u1JL7
         K5L4fCHvbSIkSm1M66BiHsoxc+USWBl1Bqjc/CNT23yLl7HJojIKUjWukDU3UhsPymzU
         1EXYlY8Em1Ql0pEZmBTff98W5lr7O9wJAqC6vdb5XZI5JittZC+kkaMO1ArJqljJrW3k
         Iwsg==
X-Gm-Message-State: AOAM530RE1fASL4Opfc94mMBM7oivTnhcbkHarXaVoU7AYTGOmi0ZWgQ
        T+5JqPkOAyCIg6VCQMJnjVk4ILFQf/RVUQ==
X-Google-Smtp-Source: ABdhPJztxg/Xb8nFH28NC2W6Go33m7YavRvXsBAZ8lVlyjBoR2+/cOoRZPSGfs0lDQpJjGA2LHCwxg==
X-Received: by 2002:a17:90a:9f02:: with SMTP id n2mr1451581pjp.190.1622575240135;
        Tue, 01 Jun 2021 12:20:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c134sm13949779pfb.135.2021.06.01.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:39 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: rtl8188eu: Fix fall-through warnings for
 Clang
Message-ID: <202106011220.C226177E0@keescook>
References: <20210528200650.GA39289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200650.GA39289@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 28, 2021 at 03:06:50PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
