Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF67C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168F961881
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUQsb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQsb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 12:48:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13014C061764
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 09:46:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e10so813298plh.8
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n/5EhXRYzMioZhTzwEt1B3sZlW7YU6BtPiTYhWArG08=;
        b=DpYT6KHlxgLN41ePG8/20GwET6nYQq7rTFQLwjwoiYkcP0loJwEhnI8MzcDsfpLUHv
         g+kguESEFZVKHcFHCzVmlS69g08Uy5/owVJijUq35S+pPIxlH0cos4vNiZizsRwV2YEl
         4HHqEJwQJzZIvVN43+CbehZiGYywnL51LheEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n/5EhXRYzMioZhTzwEt1B3sZlW7YU6BtPiTYhWArG08=;
        b=7zNFXRskvQngVdootbCDxXNRphXS+73mnDx5iTpC6JLhD4k8NLhtd+tMsPNiCV/HvT
         EWDfGbMi4fLSLnPWFviQ9BCb3M8+JmpOASanmjA2DbBDo7I47Wa8mIEkIZ55a9oglqqL
         qy/bFGk534eb6IIE6E3oKEwZDkrTLtiFCw052A1E/KqXWdHwkAQCk3DNvVpLHZV7JEwG
         ADW7QApueeGhASPT38OZI38Bb33J0dp8KLQvlCRlgl/rX5SWD5SCfUq4JHkCZeHSZH6m
         ZJ9XKH5Qz3x3Trg7fowmWKRVacVuO+mSzh7EPaQpe6uODQggbyGy2VRXnbU38Uw3Fmm1
         Lueg==
X-Gm-Message-State: AOAM533odiNir0mCFMBzSN8k39P3iv+S85FfvJY0pE4cetHE/3sm7Le8
        noZxyj2CC5diyVP/DGC37o2yLw==
X-Google-Smtp-Source: ABdhPJxT2BNah7vKDouchucml+EXV/m5bFi2FAXekbm5XOM62EWaYNswMYY4gXLbAVFZshH6xjV21w==
X-Received: by 2002:a17:90b:4b90:: with SMTP id lr16mr4078908pjb.189.1634834774562;
        Thu, 21 Oct 2021 09:46:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm4792895pgs.29.2021.10.21.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:46:14 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:46:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, thomas.preudhomme@celest.fr,
        adhemerval.zanella@linaro.org, Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org, Keith Packard <keithpac@amazon.com>
Subject: Re: [RFC PATCH 0/1] implement TLS register based stack canary for ARM
Message-ID: <202110210944.D977EBD@keescook>
References: <20211021102327.1415789-1-ardb@kernel.org>
 <CAMj1kXEPRro8LeLhX46VHhbhoytzhu5tpW3T4Tjq5ya1GPOB4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEPRro8LeLhX46VHhbhoytzhu5tpW3T4Tjq5ya1GPOB4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 06:34:04PM +0200, Ard Biesheuvel wrote:
> On Thu, 21 Oct 2021 at 12:23, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102352
> >
> > In the Linux kernel, user processes calling into the kernel are
> > essentially threads running in the same address space, of a program that
> > never terminates. This means that using a global variable for the stack
> > protector canary value is problematic on SMP systems, as we can never
> > change it unless we reboot the system. (Processes that sleep for any
> > reason will do so on a call into the kernel, which means that there will
> > always be live kernel stack frames carrying copies of the canary taken
> > when the function was entered)
> >
> > AArch64 implements -mstack-protector-guard=sysreg for this purpose, as
> > this permits the kernel to use different memory addresses for the stack
> > canary for each CPU, and context switch the chosen system register with
> > the rest of the process, allowing each process to use its own unique
> > value for the stack canary.
> >
> > This patch implements something similar, but for the 32-bit ARM kernel,
> > which will start using the user space TLS register TPIDRURO to index
> > per-process metadata while running in the kernel. This means we can just
> > add an offset to TPIDRURO to obtain the address from which to load the
> > canary value.
> >
> > The patch is a bit rough around the edges, but produces the correct
> > results as far as I can tell.
> 
> This is a lie

LOL.

> 
> > However, I couldn't quite figure out how
> > to modify the patterns so that the offset will be moved into the
> > immediate offset field of the LDR instructions, so currently, the ADD of
> > the offset is always a distinct instruction.
> >
> 
> ... and this is no longer true now that I fixed the correctness
> problem. I will be sending out a v2 shortly, so please disregard this
> one for now.

Heh, I hadn't even had a chance to test it, so I'll hold off. :)

Thanks!

-Kees

-- 
Kees Cook
