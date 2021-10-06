Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E03C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DED26120F
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhJFDIO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhJFDIN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:08:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07AC061753
        for <linux-hardening@vger.kernel.org>; Tue,  5 Oct 2021 20:06:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j15so759090plh.7
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h/B2/4lvsg/CGVwkkVTPAzFHikkG/kMza4mFfWJz56M=;
        b=RoIQ370OysL/Vat32I9DE1b65g2D9zD1Su7VuAiStesPYk8mNSoeyahvzP3MVGUf35
         9s7no6dpO/dT6vVvpKpHp23xb2HwN3BPV7urynVsqosllSY4TX1f72huqIqUzBWz2fVr
         g7bKg+U3G3fU6Z7TcAByj7Ma+/ydevcwWBjUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/B2/4lvsg/CGVwkkVTPAzFHikkG/kMza4mFfWJz56M=;
        b=afwD47E7tC6ysqV8F/rNKsRwQwYM8xIs7gM7qxwusCSWNFOFzCN0S4tggXuAgyxxv4
         fgz6q9r8iS3/Ah88ziyJJP5mCaXdXnqI67QbNqse8i3yZxdZGTNblnfYS5RPWJKswLcV
         kQ9nQgU8L4vt3ShGXrjgKXSkP4XeyEKZbHEVEtQy+m84W/T3hRCJvwQvvbwqVF/rzN0Z
         ZoZghSmZwRJyk+1GU1Q82C7kRiiwPmF/F3ItTcPpAQP/DKlbEbZQdFOMcY61hPeU+udi
         jRJrLOwfLnxSVxNgO23lOROof4F6KmtbrQy+JBPtG5ICb/s14Me8x/xmYSHB3W38hzZ5
         LSsw==
X-Gm-Message-State: AOAM5310RUjG1XC6NOXihzfNqCFDrEM1FTAFumbLnsFyKQLr2MV+UNS0
        3hjEhyQBhtc0N3KPxUsesOyq+WZZdJjgkg==
X-Google-Smtp-Source: ABdhPJxd3GTDs3AmQw6NUx7I6g3wW7HHJ1LFAkBIXJF6Fjyx/chs9vINb4JfHNqKo3KcWB3kTVCVCw==
X-Received: by 2002:a17:90a:6405:: with SMTP id g5mr7951706pjj.71.1633489581366;
        Tue, 05 Oct 2021 20:06:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm19333896pfe.217.2021.10.05.20.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:06:21 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:06:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/8] slab: Add __alloc_size attributes for better
 bounds checking
Message-ID: <202110052002.34E998B@keescook>
References: <20210930222704.2631604-1-keescook@chromium.org>
 <20210930222704.2631604-5-keescook@chromium.org>
 <20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 05, 2021 at 06:47:17PM -0700, Andrew Morton wrote:
> On Thu, 30 Sep 2021 15:27:00 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > As already done in GrapheneOS, add the __alloc_size attribute for regular
> > kmalloc interfaces, to provide additional hinting for better bounds
> > checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> > optimizations.
> 
> x86_64 allmodconfig:

What compiler and version?

> 
> In file included from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:55,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/mm.h:10,
>                  from ./include/linux/mman.h:5,
>                  from lib/test_kasan_module.c:10:
> In function 'check_copy_size',
>     inlined from 'copy_user_test' at ./include/linux/uaccess.h:191:6:
> ./include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
>   213 |    __bad_copy_to();
>       |    ^~~~~~~~~~~~~~~
> In function 'check_copy_size',
>     inlined from 'copy_user_test' at ./include/linux/uaccess.h:199:6:
> ./include/linux/thread_info.h:211:4: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small
>   211 |    __bad_copy_from();
>       |    ^~~~~~~~~~~~~~~~~
> make[1]: *** [lib/test_kasan_module.o] Error 1
> make: *** [lib] Error 2

Hah, yes, it caught an intentionally bad copy. This may bypass the
check, as I've had to do in LKDTM before. I will test...

diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index 7ebf433edef3..9fb2fb2937da 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -19,7 +19,12 @@ static noinline void __init copy_user_test(void)
 {
 	char *kmem;
 	char __user *usermem;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
+	/*
+	 * This is marked volatile to avoid __alloc_size()
+	 * noticing the intentionally out-of-bounds copys
+	 * being done on the allocation.
+	 */
+	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
 	int __maybe_unused unused;
 
 	kmem = kmalloc(size, GFP_KERNEL);

-- 
Kees Cook
