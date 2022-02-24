Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7BC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 06:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiBXGnq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiBXGnp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 01:43:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF44199E2B
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a5so193008pfv.9
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2qG7ZKq2LLWcE9zTz7YvTPglUi3xbVY2wEf6KvxxJ8=;
        b=WA4MOhJmYzzPc7ehM4B4Ly35+5OunOQ5WwzYoeDhWwfBxgwAJKi97bI3GpMydQ4Y71
         fvutOpNi0dXCT6E0dzUy2Ll8YyAfhG5l5r+85MBF93pbS8JG9iajJ2AzFnQzLhKpef4w
         ZjhwET9dBfwja8qz9sCjFkTLnCwWJt8G56WM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2qG7ZKq2LLWcE9zTz7YvTPglUi3xbVY2wEf6KvxxJ8=;
        b=ubmVJ7mYilY+x79bRab74RqTnMHWn5tagVHlZjZ4EPSTwXnd4EVe9GtfSqCiVdn1gr
         wBrSfkmYzDpou/CXMtx9kckOGFaunPzE00E1QdybhqCZhkLOx0ZnE8Fl5wOhXx4GSnm0
         dX4EXptJKr0VrUmZqZOUZv+TFPPNyae7t+pVgqXVlaqzbvb8Ka6sg4uFrYsDcIHqaMap
         d6id8R5JS5I12DI2rkLNKg3ZINqLeHQwbIZQX7zDUXrKXQlIPkykp3GA3239AGQgAoVC
         pqVFc7ZzfavLKdYOHvepCi5JV+VF3eifACIFSZsaDQUdBKtO81Doc4TXm9O/esBnf1W6
         B+Cw==
X-Gm-Message-State: AOAM532mjD5X1a9lmDRcH+kAuWtY5LjPhCXoSFbjwS2rWYf4uoFB0jRL
        X7hCB4USfNLq7+KrPuan5pL9TQ==
X-Google-Smtp-Source: ABdhPJyOHD+pCoqYXDMeb5HUndZCLOinHUyw1Y69stmNhu8tnwxXMVGmJohGfoX845ZLZwIxPKDDUQ==
X-Received: by 2002:a63:9d44:0:b0:374:a18a:17fa with SMTP id i65-20020a639d44000000b00374a18a17famr1198415pgd.293.1645684996377;
        Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm1873667pfj.44.2022.02.23.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:43:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, Marc Zyngier <maz@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xtensa: Implement "current_stack_pointer"
Message-ID: <202202232239.FF2343D42@keescook>
References: <20220224060503.1856302-1-keescook@chromium.org>
 <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 23, 2022 at 10:22:59PM -0800, Max Filippov wrote:
> On Wed, Feb 23, 2022 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > To follow the existing per-arch conventions replace open-coded uses
> > of asm "sp" as "current_stack_pointer". This will let it be used in
> > non-arch places (like HARDENED_USERCOPY).
> >
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: linux-xtensa@linux-xtensa.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/xtensa/Kconfig                  | 1 +
> >  arch/xtensa/include/asm/current.h    | 2 ++
> >  arch/xtensa/include/asm/stacktrace.h | 2 +-
> >  arch/xtensa/kernel/irq.c             | 3 +--
> >  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks! And apologies, my cross-compiler tricked me into thinking this
patch compiled without problems. It did, however. I've change the patch
slightly to deal with the needed casts:

diff --git a/arch/xtensa/include/asm/stacktrace.h b/arch/xtensa/include/asm/stacktrace.h
index fe06e8ed162b..a85e785a6288 100644
--- a/arch/xtensa/include/asm/stacktrace.h
+++ b/arch/xtensa/include/asm/stacktrace.h
@@ -19,14 +19,14 @@ struct stackframe {
 
 static __always_inline unsigned long *stack_pointer(struct task_struct *task)
 {
-	unsigned long *sp;
+	unsigned long sp;
 
 	if (!task || task == current)
-		__asm__ __volatile__ ("mov %0, a1\n" : "=a"(sp));
+		sp = current_stack_pointer;
 	else
-		sp = (unsigned long *)task->thread.sp;
+		sp = task->thread.sp;
 
-	return sp;
+	return (unsigned long *)sp;
 }
 
 void walk_stackframe(unsigned long *sp,

Shall I send a v2, or just carry this fix in my tree?

Sorry for the glitch!

-Kees

-- 
Kees Cook
