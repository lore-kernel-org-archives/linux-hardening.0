Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AAFC77B73
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEVRWZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVRWY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 13:22:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668AF4
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 10:22:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so5643304a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684776143; x=1687368143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgwrsrvR2OLewUEAKXpoKm83J7LNaLvisoBLwt+0FOs=;
        b=gtABt70s+9IRhefHIdX40Nvy/7/Fps4bT6TqqI7Byo1ca9Tuxp4rm4ipN3PbvMUN8e
         vCEuY71S2JwhiMyK9LLSHA3pVLflr2LCJisLdlzYhfU31GU61KrzHEEaCDnBAZ+aU6di
         qb8ESKrEtStarrlqNXhQy+nrCItEWzXv/R96s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776143; x=1687368143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgwrsrvR2OLewUEAKXpoKm83J7LNaLvisoBLwt+0FOs=;
        b=Y4MZyteaUfAvj2F4SXKa8e2PPk0k/WnCNnjIPVB3vIK3ZCx5RdYLWH3dHASGp4sM1H
         CxGoW/v31/akh9UVOMQECrNtZ5KW9QfyAKcx1M8XGn96RUaXYLee90xpdga63CFVI3rg
         0VRngdHwAfwRpy3eeKIAsHOo3RY0IEFBEsCStVQYVAFdsbQUDSZ7Q/Q1ddHJEI7ye7cO
         DeTSzmsVOgWJe+0jwtC6Bz2VIvk1qaQD4sNc5BqrpdDHgX04t2KQZLOWr9Dy4s70E1cs
         l2ryIJE1brcaDmt+8xZVoF/ovIXUc3A1aGlL2VxRQR9nRYtJ4r0/mNQCLRf1d4DNz/gC
         B+lQ==
X-Gm-Message-State: AC+VfDyyNLclF88ji/zi0xAN+CNBJtWNi6NtXqBscIdB7OPnm3WzCqq8
        Rydjic2MwU6WcOnwBX7oFP+hCA==
X-Google-Smtp-Source: ACHHUZ4CdndgtF5TE5I0shQjCG7A6gAGfSVYnQEfZuV10QNQNVvcrpr3N292VU27Q3HGk0NbiMTtxg==
X-Received: by 2002:a17:903:32c7:b0:1ac:43ea:7882 with SMTP id i7-20020a17090332c700b001ac43ea7882mr13774830plr.29.1684776143103;
        Mon, 22 May 2023 10:22:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001ac84f5559csm5087014plc.126.2023.05.22.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:22:22 -0700 (PDT)
Date:   Mon, 22 May 2023 10:22:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221014.70326C3@keescook>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
 <ZGuSeZcLfXNyCqtv@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuSeZcLfXNyCqtv@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 05:04:09PM +0100, Russell King (Oracle) wrote:
> On Mon, May 22, 2023 at 03:53:50PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> ...
> >  	memset(&cec_info, 0, sizeof(cec_info));
> > -	strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
> > +	strscpy(cec_info.type, "tda9950", sizeof(cec_info.type));
> 
> Please explain how:
> 
> 1) a C string can not be NUL terminated.
> 2) this source string could be longer than I2C_NAME_SIZE (20 bytes)
>    which is unlikely to ever shrink.

Yes, in this case, obviously none of those can happen.

> I'm not saying I disagree with the patch, but the boilerplate commit
> message isn't correct for this change, and is actually misleading
> for what the patch actually is.

One of the common code patterns in the kernel is copying fixed sized
strings (like here), but Linus refused (probably correctly) to allow an
API for that, since we already had "too many" string functions.

The long-term goal here is to replace all use of strlcpy(),
strncpy(), and strcpy() and replace them with strscpy(). The strscpy()
wrapper is already optimized to short-cut for fixed-size dest/src:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/fortify-string.h?h=v6.3#n337

Perhaps this goal needs to be stated in the commit log to be more clear
about cases like this?

-Kees

-- 
Kees Cook
