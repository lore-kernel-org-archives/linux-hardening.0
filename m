Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243FC001B0
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjHJUPn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjHJUPm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 16:15:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B02718
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 13:15:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdb08e9057so4469465ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691698541; x=1692303341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMvbgtLm3o5PK9BxEA0pI7DAuLsjiB4F7y1PvOelLnY=;
        b=RW37KCo80cM+P0Mbw74kT7T+WaIbB0/vXrToVyJUMkfjcINUtf/QA11X8JjOiReL/i
         /nEwqJwmgfomIhtRdr+h4Nsg2rbUgfpz/rFV0NK3GpscFGF3B9v9weolkIBkV5gRrv3Y
         eaGosJLsqTFEyUlypwRteNKCrwSUKMNkRgTZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698541; x=1692303341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMvbgtLm3o5PK9BxEA0pI7DAuLsjiB4F7y1PvOelLnY=;
        b=chgiStuvazymo8Nvm3tJvIwLpyzQU/PfMCdjl8MpkS3s+b/opS73GfWuLqRkrWx59S
         eF3FBZSl0QuXKKWFRZE5oNjqTW3S3swSqsGKNntpbexM/YQhNE8+YdBhX4JZuqgTdzHp
         b7hObEjfhI5CwN3tzDrIonkd+po56SIS8XwiGlCtDDc8RNEszaRsz5vXh1K9jKD/PEfG
         TS0iVtvppxLH6GvLwUjYdUcD8Qp7D7ECcaum0w4+DmlXFhFrs/0w7MmQ9VQ2tRUiRUr7
         PjFSA32m45FECw4ZaohpzDEciIfun8nEKssw2QDgWKsRQBnG97Lekhc5amgbZRZGDET1
         YM3g==
X-Gm-Message-State: AOJu0YzvxHVc3sq+/bW9RtlTQu2z7M74rX4YjLm2g2AMbiZjxvMnCIPm
        f2TIa3TGT+vtvNUHMvkZU7o28JsrJ11Pi2/a0tc=
X-Google-Smtp-Source: AGHT+IGc8AdgH/YPAGqhTVton7wBhQe2kXpP36rX6A0KPMi035sdxnM7obZM3DacHYAXMWzb8lBUqA==
X-Received: by 2002:a17:90a:1002:b0:262:f8b8:dba2 with SMTP id b2-20020a17090a100200b00262f8b8dba2mr2910831pja.35.1691698541096;
        Thu, 10 Aug 2023 13:15:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090ac68200b00263f8915aa3sm3780733pjt.31.2023.08.10.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:15:40 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:15:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: ptrace: Restore syscall skipping and restart while
 tracing
Message-ID: <202308101314.11A15CDF9@keescook>
References: <20230804071045.never.134-kees@kernel.org>
 <f34c11eb-89b5-48a5-bd24-c215083575a5@app.fastmail.com>
 <202308101209.45CF7C6F80@keescook>
 <786b2d02-f649-4c5f-ae9a-ed2228e4a3fb@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786b2d02-f649-4c5f-ae9a-ed2228e4a3fb@app.fastmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 10:10:08PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 10, 2023, at 21:32, Kees Cook wrote:
> > On Wed, Aug 09, 2023 at 09:47:24PM +0200, Arnd Bergmann wrote:
> >
> >> If the local_restart code has to store the syscall number
> >> for an EABI-only kernel, wouldn't it have to also do this
> >> for a kernel with OABI-only or OABI_COMPAT support?
> >
> > This is the part I wasn't sure about. Initially I was thinking it didn't
> > matter because it's only a problem for a seccomp tracer, but I realize
> > it might be exposed to a PTRACE tracer too. I was only able to test with
> > EABI since seccomp is disabled for OABI_COMPAT.
> >
> > Anyway, syscall restart is done this way:
> >
> >         movlt   scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
> >
> > Can a EABI call restart an OABI syscall? I think so?
> 
> There are very few differences between oabi and eabi syscalls, I
> think it basically comes down to 
> 
>  - the syscall number, and register in which it is passed to the kernel
>  - a few syscalls that exist for OABI backward compatibility and were
>    deprecated before EABI was added
>  - a few syscalls that pass a struct with different alignment rules
>  - epoll_wait() uses a runtime check for the output format
> 
> It also seems like the __NR_restart_syscall path is only relevant
> for syscalls using restart_block for restarting, and that means
> it's only poll(), futex(), nanosleep(), clock_nanosleep() and their
> time64 counterparts. All of these are handled by the same entry

Right -- it's a tiny corner case I tripped over years ago while building
seccomp filters, so it got added to the selftests. :)

> points for OABI and EABI, i.e. there is no overlap with the
> exceptions above. Crucially, epoll does not use restart_block,
> unlike poll().
> 
> > So maybe we just need to add:
> >
> > 	str     scno, [tsk, #TI_ABI_SYSCALL]    @ store scno for syscall restart
> >
> > after that instead of moving it like I did originally?
> 
> Yes, I think that works!
> 
> For pure EABI and pure OABI kernels, this just does the right thing,
> storing a plain __NR_restart_syscall in the field without an ABI
> marker. For an OABI compat task running on an EABI kernel, it will
> call the EABI version of restart_syscall(), but that is exactly
> the same as the OABI version, as shown above.

Okay, excellent. I came to the same conclusion. Patch 1 in the v2
addresses this and tested okay for me.

Thanks for looking at this!

-Kees

-- 
Kees Cook
