Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B896C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 03:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbiBCDDk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiBCDDk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 22:03:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B7C061714
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 19:03:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so8695497pjj.4
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66kPZSC1iKeNoZfaiCMo3QKLREtWuEiSUFYFnGS139g=;
        b=ihbvWhnXjUqGyksHoCxaLOWMHnN3wfgtv7dKrlgWKZbFddRi9Z0b+C34pmZ2s20nFb
         AMNKO1bchTQlG6UoyPAjS99YoIUqdkTarHfGBTFVr9OHmTaOuGBJRT3z3I0WxpFid73E
         Se8912JdZFr8WL2FD6IF6zxaTYCxr6nwSCawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66kPZSC1iKeNoZfaiCMo3QKLREtWuEiSUFYFnGS139g=;
        b=x5hSgU2e0HcqyuPb3wBAe6d2nwfhhcEITjNOMgfuK8lTBTnVWScMUzZIjmuIH9lGYP
         /d6FEd0u2swly3o+bjyK1WDcpYtQKRdQQDkj9WzoID9m89T7ruHtEwKcIasPHmKlcaH5
         71yiOTI230mx+VKB14J/FpqLUs8ES+2FtukQxo3DwqcoR8g+Z0JRpr6PTf/GAwjc7CLp
         0akcB7FddTktz7zD7cIdDMu2Y/pLd6ODJRRPtBOGQ9LcDIqhMG5SBhqqc2oT4J5ROlJc
         1r4KpRQN5535+vnBp8HEP/9OX6CdXh/MtIKaBIXx4bJNF7pI/UYURM+fA7iYBR2PcRex
         kb+A==
X-Gm-Message-State: AOAM530phJZYSdbvuZCDaUsbdzMFckBiOHTDzZIOkYAqBF4QNGxJq9+L
        iqMb57CV7XfAa4U18US7YM1xuA==
X-Google-Smtp-Source: ABdhPJzWMLlRj3r57r7HmniPlCwu193I5JgQn3G2v/Fu4GCrKAcrUdJ+aJD+pcbrzfANakGXZzdo8A==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr4989551pjb.9.1643857420161;
        Wed, 02 Feb 2022 19:03:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb3sm8336560pjb.47.2022.02.02.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:03:39 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:03:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202202021902.97BAE673@keescook>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net>
 <202202021254.5A1FD4FFBF@keescook>
 <cbf0cf07-2350-ed23-f6be-b2686c6a0cea@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf0cf07-2350-ed23-f6be-b2686c6a0cea@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 02, 2022 at 03:33:11PM -0800, Guenter Roeck wrote:
> On 2/2/22 12:56, Kees Cook wrote:
> > On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
> > > xtensa:allmodconfig:
> > > --------------
> > > Error log:
> > > In file included from include/linux/uaccess.h:11,
> > >                   from include/linux/sched/task.h:11,
> > >                   from arch/xtensa/kernel/process.c:21:
> > > arch/xtensa/kernel/process.c: In function 'copy_thread':
> > > arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above array bounds of 'long unsigned int[16]'
> > 
> > I assume this is a weird cast. I will also check this one out.
> > 
> 
>                                 int callinc = (regs->areg[0] >> 30) & 3;
>                                 int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
>                                 put_user(regs->areg[caller_ars+1],
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^
>                                          (unsigned __user*)(usp - 12));
> 
> I think the problem is that XCHAL_NUM_AREGS can be up to 64,
> but the size of struct pt_regs->areg[] is fixed to 16.

Yeah, that's what I found too. The comment about pt_regs::areg seems to
hint that things treat pt_regs differently. I've asked on the xtensa list:
https://lore.kernel.org/linux-hardening/202202021501.DA6594BFC@keescook/

-- 
Kees Cook
