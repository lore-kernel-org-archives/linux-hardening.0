Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC40C7EE32
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Mar 2023 20:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjCCUgP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjCCUgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Mar 2023 15:36:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979B62D81
        for <linux-hardening@vger.kernel.org>; Fri,  3 Mar 2023 12:36:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so3791102pjg.3
        for <linux-hardening@vger.kernel.org>; Fri, 03 Mar 2023 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677875771;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=geAmPjDQxdljXtlXmphTlxxF1JLXM9iUHwEO1xPqi18=;
        b=U41Mag/c9CHHfte/BaVhSK7Yl0vhq3mrqmh3RRfl6XuCTyx3VeZgJdw8M44ftCDf+I
         lkLMuIIbBkM4j69mSN7DPIYqqUMH8j1knPYp11zDWxDVL7aX1P5anqGeh/wA1HxD1YAb
         +YtZ/ArzfKpN7b35FHO5Ds0H/vpc3ZSb4kOFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875771;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geAmPjDQxdljXtlXmphTlxxF1JLXM9iUHwEO1xPqi18=;
        b=VvwElS8WcB/a1sVwurePAYj9LCnrFAk0ySsJPuysRr4G2RQ32S+BPTlLpgq+LOHcv2
         DV0XizXSyT2NLHVci4kGLe4jEruCByBTx3ZUcbeQ0lrge3RPM6sPPSlj0zTYXFUmfLYc
         LR98Oq9N0BDZ5e2LxK/zib/8lu08DstnX18nDFeopLp19ub43iDQG6gRdHM78GDV674x
         1wtAAgwDCwazkAXzdcfQsd68B4CnNlFNruavVqL1cOByayRHI/iPwuAWyUQRZofTic6O
         Y7u8J5gMHFnV4JYb6rwcLY0h1GEK0jJkM1kqw7uPHqni4mKcgAziddFvFuLGl4iwNrBj
         tfCw==
X-Gm-Message-State: AO0yUKURhvy3DgYpi9z+IAVJqp7EUn2fsAfX8rG5rsSH/AGadKPt+rvf
        5tp3OHPKOy3rmEfVQU0ZJR6ZileuTg1KyYUK
X-Google-Smtp-Source: AK7set9ywfSft3cMRiD0v6Edcwehkcu8/K7S+id3Tl9yCFXURbPhno3Wwnvqlg/u7NhF2oxqRYuxxA==
X-Received: by 2002:a17:902:ed11:b0:19d:af21:dc2f with SMTP id b17-20020a170902ed1100b0019daf21dc2fmr2568711pld.33.1677875770781;
        Fri, 03 Mar 2023 12:36:10 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b0019e81c8fd01sm1896816plg.249.2023.03.03.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:36:10 -0800 (PST)
Message-ID: <64025a3a.170a0220.dba96.3fcf@mx.google.com>
X-Google-Original-Message-ID: <202303031231.@keescook>
Date:   Fri, 3 Mar 2023 12:36:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kheaders: Use array declaration instead of char
References: <20230302224946.never.243-kees@kernel.org>
 <89e3ecb6-0e1a-3d86-cb05-cbb034c68dc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89e3ecb6-0e1a-3d86-cb05-cbb034c68dc4@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 03, 2023 at 04:19:51PM +0100, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Thu,  2 Mar 2023 14:49:50 -0800
> 
> > Under CONFIG_FORTIFY_SOURCE, memcpy() will check the size of destination
> > and source buffers. Defining kernel_headers_data as "char" would trip
> > this check. Since these addresses are treated as byte arrays, define
> > them as arrays (as done everywhere else).
> 
> Yet another array-as-one-char, I wonder how many are still here...

Yeah, good point. They do tend to stand out; we could find them:

$ git grep 'extern char [^\*\[\( ]*;'
arch/alpha/boot/bootp.c:extern char _end;
arch/alpha/boot/bootpz.c:extern char _end;
arch/alpha/boot/main.c: extern char _end;
arch/arm/mach-rockchip/core.h:extern char rockchip_secondary_trampoline;
arch/arm/mach-rockchip/core.h:extern char rockchip_secondary_trampoline_end;
arch/arm/mach-zynq/common.h:extern char zynq_secondary_trampoline;
arch/arm/mach-zynq/common.h:extern char zynq_secondary_trampoline_jump;
arch/arm/mach-zynq/common.h:extern char zynq_secondary_trampoline_end;
arch/hexagon/include/uapi/asm/setup.h:extern char external_cmdline_buffer;
arch/ia64/include/asm/smp.h:extern char no_int_routing;
arch/ia64/kernel/process.c:     extern char ia64_ret_from_clone;
arch/mips/dec/prom/memory.c:    extern char genexcept_early;
arch/mips/kernel/traps.c:       extern char except_vec3_generic;
arch/mips/kernel/traps.c:       extern char except_vec4;
arch/mips/kernel/traps.c:       extern char except_vec3_r4000;
arch/mips/mm/c-octeon.c:        extern char except_vec2_octeon;
arch/parisc/boot/compressed/misc.c:extern char output_len;
arch/parisc/boot/compressed/misc.c:extern char _startcode_end;
arch/powerpc/include/asm/smp.h:extern char __secondary_hold;
arch/s390/include/asm/kvm_host.h:extern char sie_exit;
arch/sh/boards/mach-ap325rxa/setup.c:extern char ap325rxa_sdram_enter_start;
arch/sh/boards/mach-ap325rxa/setup.c:extern char ap325rxa_sdram_enter_end;
arch/sh/boards/mach-ap325rxa/setup.c:extern char ap325rxa_sdram_leave_start;
arch/sh/boards/mach-ap325rxa/setup.c:extern char ap325rxa_sdram_leave_end;
arch/sh/boards/mach-ecovec24/setup.c:extern char ecovec24_sdram_enter_start;
arch/sh/boards/mach-ecovec24/setup.c:extern char ecovec24_sdram_enter_end;
arch/sh/boards/mach-ecovec24/setup.c:extern char ecovec24_sdram_leave_start;
arch/sh/boards/mach-ecovec24/setup.c:extern char ecovec24_sdram_leave_end;
arch/sh/boards/mach-kfr2r09/setup.c:extern char kfr2r09_sdram_enter_start;
arch/sh/boards/mach-kfr2r09/setup.c:extern char kfr2r09_sdram_enter_end;
arch/sh/boards/mach-kfr2r09/setup.c:extern char kfr2r09_sdram_leave_start;
arch/sh/boards/mach-kfr2r09/setup.c:extern char kfr2r09_sdram_leave_end;
arch/sh/boards/mach-migor/setup.c:extern char migor_sdram_enter_start;
arch/sh/boards/mach-migor/setup.c:extern char migor_sdram_enter_end;
arch/sh/boards/mach-migor/setup.c:extern char migor_sdram_leave_start;
arch/sh/boards/mach-migor/setup.c:extern char migor_sdram_leave_end;
arch/sh/boards/mach-se/7724/setup.c:extern char ms7724se_sdram_enter_start;
arch/sh/boards/mach-se/7724/setup.c:extern char ms7724se_sdram_enter_end;
arch/sh/boards/mach-se/7724/setup.c:extern char ms7724se_sdram_leave_start;
arch/sh/boards/mach-se/7724/setup.c:extern char ms7724se_sdram_leave_end;
arch/sh/kernel/cpu/shmobile/pm.c:extern char sh_mobile_sleep_enter_start;
arch/sh/kernel/cpu/shmobile/pm.c:extern char sh_mobile_sleep_enter_end;
arch/sh/kernel/cpu/shmobile/pm.c:extern char sh_mobile_sleep_resume_start;
arch/sh/kernel/cpu/shmobile/pm.c:extern char sh_mobile_sleep_resume_end;
arch/x86/entry/vsyscall/vsyscall_64.c:  extern char __vsyscall_page;
arch/x86/include/asm/vvar.h:extern char __vvar_page;
kernel/configs.c:extern char kernel_config_data;
kernel/configs.c:extern char kernel_config_data_end;
net/bpfilter/bpfilter_kern.c:extern char bpfilter_umh_start;
net/bpfilter/bpfilter_kern.c:extern char bpfilter_umh_end;
samples/bpf/task_fd_query_user.c:       extern char __executable_start;
tools/testing/selftests/kvm/lib/aarch64/processor.c:    extern char vectors;
tools/testing/selftests/x86/test_syscall_vdso.c:extern char int80;

Of those, it looks like only a handful might trip FORTIFY:

$ for i in $(git grep 'extern char [^\*\[\( ]*;' | grep -v boot/ | awk -F' ' '{print $NF}' | cut -d';' -f1); do git grep -E '(strcpy|memcpy|memset).*'"$i",; done
arch/arm/mach-rockchip/platsmp.c:       memcpy_toio(sram_base_addr, &rockchip_secondary_trampoline, trampoline_sz);
arch/arm/mach-zynq/platsmp.c:                   memcpy_toio(zero, &zynq_secondary_trampoline,
arch/mips/dec/prom/memory.c:    memcpy((void *)(CKSEG0 + 0x80), &genexcept_early, 0x80);
arch/sh/kernel/cpu/shmobile/pm.c:       memcpy(vp, &sh_mobile_sleep_enter_start, n);
arch/sh/kernel/cpu/shmobile/pm.c:       memcpy(vp, &sh_mobile_sleep_resume_start, n);
arch/arm64/mm/trans_pgd.c:      memcpy(hyp_stub, &trans_pgd_stub_vectors, ARM64_VECTOR_TABLE_LEN);


-- 
Kees Cook
