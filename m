Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C403CC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 04:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2EE6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 29 Oct 2022 00:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJ2EEz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 29 Oct 2022 00:04:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B5237FB1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 21:04:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 20so6439897pgc.5
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 21:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMaMkImdQZaNqUgti1ui/K41+y+AL88pFosNOHMxJ84=;
        b=Ux1QnJSFsPhlOZ53YWzFTayM+PUEQP5+/uXEqueNh0EqtsgtSI9Prvj9twfgh5pDXw
         29+JZmQ5svNpUpDGhBNpo1dpbTcnNFcima2Y3Jg9Tc2OzMjiaQWtqgirDYvgaVHbOU/P
         06oSPhDdtRxnWGg7n39UhlmDp4mL6X13qdmyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMaMkImdQZaNqUgti1ui/K41+y+AL88pFosNOHMxJ84=;
        b=RBWo+4KEEoeoCxpz4tOZxwG+Yg9FqRuzVsOj3boS6QbWFV5EAMrC1uNZ5sHNBuKPhG
         tLquCYB8Bx/dZt/IftwlDEZn8OhLqBvlPVGUi7lhirmdrQllaRBDf4ZhdP/ZEyKeMx5Z
         jJoxIeWAC0+tf0qkaq/7wJMeOf0xliKcu20U5mpW9UbN7/2mSnKRzjFtiLjHqdXTBtq8
         FGzebzoiS4hZoWiIsLJZidEsYje6vbHZe+VrOBZMCY/Mx1/zNaeunVkDK81fiSpdyF7K
         DtSPuhxYtkcK7k7TGrv/h6ZLsMM40FtqkIrpRs7og2Bi37pBI8IdVjg/bE4mW4w1qQ3S
         YbUg==
X-Gm-Message-State: ACrzQf3zwXQamjP2jRNngpNrbIHzVOMxS+8XZ3x8/DXgiA/UxLVjqu5O
        g9ApzrOGKiK8ysgj0SylyFNwAQ==
X-Google-Smtp-Source: AMsMyM7t6QlEKQZM+4owmDR0tkjanbFz+ACEy3fBIM1prLQKttFi7mMcho6fjf8O7bNpqkxQyhRzVA==
X-Received: by 2002:a63:a06:0:b0:458:2853:45e4 with SMTP id 6-20020a630a06000000b00458285345e4mr2486144pgk.20.1667016293156;
        Fri, 28 Oct 2022 21:04:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4-20020a621404000000b0056c704abca7sm218661pfu.220.2022.10.28.21.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 21:04:52 -0700 (PDT)
Date:   Fri, 28 Oct 2022 21:04:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <202210282104.4981D58822@keescook>
References: <Y1trhRE3nK5iAY6q@mail.google.com>
 <Y1yetX1CHsr+fibp@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1yetX1CHsr+fibp@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 29, 2022 at 04:32:05PM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> refactor the rest of the code accordingly.
> 
> It's worth mentioning that doing a build before/after this patch results
> in no binary output differences.

Thanks for checking it!

> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/239
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
