Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C2C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Apr 2022 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiDUQpU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiDUQpP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Apr 2022 12:45:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9748E45
        for <linux-hardening@vger.kernel.org>; Thu, 21 Apr 2022 09:42:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e62-20020a17090a6fc400b001d2cd8e9b0aso5680146pjk.5
        for <linux-hardening@vger.kernel.org>; Thu, 21 Apr 2022 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGKEvdgYRQ7SM+AO2vjpmqYxP+BldJQN162qNBP3cZU=;
        b=mB7+i6aOyxqKX81weI4FoQBPHQS7Yc1HSgzDeU5y/1s3jioCgVQBAmxogLw3X4u405
         ATFSON/HUUhbKe5oLUTZgoght91a9ULLu35Mr6atCZrkVtOimFJMlRhT2KfW3BEIVjN7
         9fLhdFyUIDyvHVOyuKDh/goUflgsOwBuirkuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGKEvdgYRQ7SM+AO2vjpmqYxP+BldJQN162qNBP3cZU=;
        b=FthZpM7sNXSSQot+52/O9V9ADzsndAxb7p0JniUFdGJviue9tOH+e8cx17/G54HkuR
         yzOZLS1cMQKe3kecc5bdazXn2qi8578Ko3qx0ZdHN1ZM4JTb7jejdOuR0FenZcxBoNUM
         2p4ceoUtNtzcybiS4yBpMTkdw66FMWx7L29w9qG0KLm+wgNcddzqMolTsn8QX5iZHSDo
         oo7mZxghj0kLZoXW7Grtjmd2ZKIH4MsG2eoC4pN4/BxPp3r5UEZIWVW1DVix5MWsS6lS
         s0fLSqdWcy/mNOdBNjTS7wJM4lRPPWeyjBoioo2OkkjRmBdH3ih+VU+EpwI2t4Mp9hcA
         oZ+g==
X-Gm-Message-State: AOAM530ku/+FvRVQw4+ZzzcgH8+uOFbojDzEsPCvo85Rp1/tEeady2aR
        2OCSXcY+HjkY0hjUvrgR70OXSQ==
X-Google-Smtp-Source: ABdhPJzhFmMSZnztpRzJKTkyr58MC5Qtizd2jhpjoY39cLT1geTbd0SbOnPo810CxKtCMtjBkj76hg==
X-Received: by 2002:a17:902:778a:b0:158:da0f:f299 with SMTP id o10-20020a170902778a00b00158da0ff299mr366502pll.29.1650559344761;
        Thu, 21 Apr 2022 09:42:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm25268821pfh.83.2022.04.21.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:42:24 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:42:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <202204210941.4318DE6E8@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
 <YmF5s4KqT5WL4O0G@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmF5s4KqT5WL4O0G@arm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 21, 2022 at 04:35:15PM +0100, Catalin Marinas wrote:
> On Wed, Apr 20, 2022 at 04:21:45PM -0700, Kees Cook wrote:
> > On Wed, Apr 20, 2022 at 10:34:33PM +0300, Topi Miettinen wrote:
> > > For systemd, feature compatibility with the BPF version is important so that
> > > we could automatically switch to the kernel version once available without
> > > regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) should match
> > > exactly what MemoryDenyWriteExecute=yes as implemented with BPF has: only
> > > forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). Like BPF, once
> > > installed there should be no way to escape and ELF flags should be also
> > > ignored. ARM BTI should be allowed though (allow PROT_EXEC|PROT_BTI if the
> > > old flags had PROT_EXEC).
> 
> I agree.
> 
> > > Then we could have improved versions (other PR_MDWX_ prctls) with lots more
> > > checks. This could be enabled with MemoryDenyWriteExecute=strict or so.
> > > 
> > > Perhaps also more relaxed versions (like SARA) could be interesting (system
> > > service running Python with FFI, or perhaps JVM etc), enabled with for
> > > example MemoryDenyWriteExecute=trampolines. That way even those programs
> > > would get some protection (though there would be a gap in the defences).
> > 
> > Yup, I think we're all on the same page. Catalin, can you respin with a
> > prctl for enabling MDWE? I propose just:
> > 
> > 	prctl(PR_MDWX_SET, flags);
> > 	prctl(PR_MDWX_GET);
> > 
> > 	PR_MDWX_FLAG_MMAP
> > 		disallows PROT_EXEC on any VMA that is or was PROT_WRITE,
> > 		covering at least: mmap, mprotect, pkey_mprotect, and shmat.
> 
> Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> the vma is not already PROT_EXEC? The latter is closer to the current
> systemd approach. The former allows an mprotect(PROT_EXEC) if the
> mapping was PROT_READ only for example.
> 
> I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> replacement for BPF MDWE.

I think "was PROT_WRITE" is an important part of the defense that
couldn't be done with a simple seccomp filter (which is why the filter
ended up being a problem in the first place).

-- 
Kees Cook
