Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19346C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 06:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F02610D2
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 06:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhJVGN0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVGNZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 22 Oct 2021 02:13:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E27C061764
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 23:11:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so462708pjh.0
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fyzO1F4ahtscM0S8/Ls1NerSCJLcOZShd3+SKPjHxdE=;
        b=iSobfxHtpE36L7+1llhdw4vQPkB7nQ4iGzxIQBm2XleuVcihpTyzuidotB/ZQNyf7k
         LTxNMn7olN545JwZaFk7mTiqEAqMb5ZgZkopRehktapmIz5haxbhXuApnYJEK3BRKJE8
         ZhXoudqz9oNUxSxDuJFr0wDBLLmB/IGhr4TsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyzO1F4ahtscM0S8/Ls1NerSCJLcOZShd3+SKPjHxdE=;
        b=HgAO+dQPbkmFtvoHKW+wSYuGFJSU4ZCaSN96r8PtVeRRUSh+IQ7Xps1llJnmy1rXya
         dg8N3i6pg7pm7QoPYK04k10RTzyHz1vp163NW3JA2UtAySJScn1QXSVIPKr0DJ71lSRd
         5caSQafvjoUf8feDt07wQ1QJcmR79Bp23Pecon2rCx1jXAuXIiRwXoENg5rsVrDgcVok
         46P9AIBeHOFjhRxSTDV+39k+Cg3i6j9ObDBeTm3rf4nErWRD3y8rtbihh4HTRVIo5oO+
         rDRLyzzaQ5j7gw5erbr5rYzVe1/gpHt1NsBUoCwxqbSH5NWLEL8MDhfLaXpwxkdwkXjr
         VwLw==
X-Gm-Message-State: AOAM531r0KodFOi1dm/NYltRoEivxC46ZnX8hhPbpEJNuC07OlkqM5I8
        6i5UbsbGKq1edKbOkKxoPrfy8w==
X-Google-Smtp-Source: ABdhPJxbhThg6DsypVualz3z8WJ3Y9iH0RSB6+WKW71wJRCp5TgVt7GpgzrvVOMDoe0LFKGSGtwzGA==
X-Received: by 2002:a17:90a:f291:: with SMTP id fs17mr12248854pjb.102.1634883068243;
        Thu, 21 Oct 2021 23:11:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm11257560pjq.16.2021.10.21.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 23:11:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 23:11:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: stackprotector: prefer compiler for TLS based
 per-task protector
Message-ID: <202110211255.29DDB126@keescook>
References: <20211021142516.1843042-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021142516.1843042-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 04:25:16PM +0200, Ard Biesheuvel wrote:
> Currently, we implement the per-task stack protector for ARM using a GCC
> plugin, due to lack of native compiler support. However, work is
> underway to get this implemented in the compiler, which means we will be
> able to deprecate the GCC plugin at some point.
> 
> In the meantime, we will need to support both, where the native compiler
> implementation is obviously preferred. So let's wire this up in Kconfig
> and the Makefile.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Awesome! I built upstream GCC with the corresponding feature[1], but my
qemu explodes:

smp: Bringing up secondary CPUs ...
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: si_mem_available+0x110/0x110
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc6-next-20211021+ #791
Hardware name: Generic DT based system
Backtrace: 
[<809df62c>] (dump_backtrace) from [<809dfa20>] (show_stack+0x20/0x24)
 r7:80bc2838 r6:00000080 r5:80bd39fc r4:600000d3
[<809dfa00>] (show_stack) from [<809e8580>] (dump_stack_lvl+0x60/0x78)
[<809e8520>] (dump_stack_lvl) from [<809e85b0>] (dump_stack+0x18/0x1c)
 r7:80bc2838 r6:818ef000 r5:00000000 r4:80ebea20
[<809e8598>] (dump_stack) from [<809dff88>] (panic+0x118/0x34c)
[<809dfe70>] (panic) from [<809edcac>] (lockdep_hardirqs_on+0x0/0x1a4)
 r3:00000002 r2:00000005 r1:802e4e34 r0:80bc2838
 r7:00000002
[<809edc90>] (__stack_chk_fail) from [<802e4e34>] (__drain_all_pages+0x0/0x260)
[<802e4d24>] (si_mem_available) from [<8022d5ec>] (__rb_allocate_pages+0x30/0x224)
 r6:81905440 r5:81921dcc r4:00000002
[<8022d5bc>] (__rb_allocate_pages) from [<8022f790>] (rb_allocate_cpu_buffer+0x1e4/0x2c8)
 r10:00000002 r9:8180c300 r8:818ef000 r7:00000002 r6:81905440 r5:00000000
 r4:818df200
[<8022f5ac>] (rb_allocate_cpu_buffer) from [<80232fc0>] (trace_rb_cpu_prepare+0x8c/0xec)
 r9:8180c30c r8:8180c364 r7:00000002 r6:81805c00 r5:00000001 r4:00000000
[<80232f34>] (trace_rb_cpu_prepare) from [<801256fc>] (cpuhp_invoke_callback+0x278/0x4ec)
 r10:80232f34 r9:ef1e43a4 r8:80e100c8 r7:0000003d r6:8180c364 r5:00000001
 r4:00000000
[<80125484>] (cpuhp_invoke_callback) from [<801259e4>] (cpuhp_invoke_callback_range+0x74/0xb4)
 r10:ef1e43a4 r9:00000000 r8:00000001 r7:80e0fc04 r6:0000005a r5:00000001
 r4:ef1e43a4
[<80125970>] (cpuhp_invoke_callback_range) from [<8012774c>] (_cpu_up+0x128/0x2b0)
 r8:6e470000 r7:000000e4 r6:80e08fd8 r5:00000001 r4:80d743a4
[<80127624>] (_cpu_up) from [<80127940>] (cpu_up+0x6c/0xa0)
 r10:818efdc4 r9:00000001 r8:80e08f14 r7:00000008 r6:80e08fd8 r5:000000e4
 r4:00000001
[<801278d4>] (cpu_up) from [<801280a8>] (bringup_nonboot_cpus+0x78/0x7c)
 r5:80e08f0c r4:00000001
[<80128030>] (bringup_nonboot_cpus) from [<80d10e94>] (smp_init+0x3c/0x84)
 r9:00000001 r8:00000000 r7:818ef6e0 r6:80d733e4 r5:80d733e4 r4:80e2c028
[<80d10e58>] (smp_init) from [<80d014c8>] (kernel_init_freeable+0x1c0/0x324)
 r4:818f0880
[<80d01308>] (kernel_init_freeable) from [<809eecbc>] (kernel_init+0x28/0x148)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:809eec94
 r4:80e08ec0
[<809eec94>] (kernel_init) from [<80100108>] (ret_from_fork+0x14/0x2c)
Exception stack(0x81921fb0 to 0x81921ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:809eec94 r4:00000000
---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: si_mem_available+0x110/0x110 ]---

Using qemu like so:

qemu-system-arm \
        -M virt \
        -cpu cortex-a15 \
        -smp 2 \
        -nographic \
        -m 2048 \
        -kernel "$kernel" \
        -drive file=vda.raw,id=hd0,format=raw,if=none \
        -device virtio-blk-device,drive=hd0 \
        -serial stdio \
        -append "root=/dev/vda1 earlycon loglevel=8 console=ttyAMA0 $@"

I built against -next, does this require the unwinder changes?

(FWIW, I built with a patched 11.2 GCC.)

-Kees

[1] https://lore.kernel.org/linux-hardening/20211021165119.2136543-2-ardb@kernel.org/T/#u

-- 
Kees Cook
