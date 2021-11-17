Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55828C4321E
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 22:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF44619EA
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhKQWEw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbhKQWEv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F13C061202
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 14:01:52 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d64so1422431pgc.7
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 14:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NrftdzRJB+iZXhfybj3wXjLC5DBwV9iU14DUg7paL24=;
        b=eBLjeWMGVqkF82f+ZTunl/5cPTL6s9LC1GIM2m29eHFzvFNKcBpgZYcng81TfXgUyt
         2Sk/PCTAChxnm4vANMcdfsEayCJ2EUOmPIIkJEwV2q67UPGWVq+c14pvSbyxVvy9LbPV
         FdxyxiAIRDJF4rof3OAUXlmdML5i9wTxnKiSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrftdzRJB+iZXhfybj3wXjLC5DBwV9iU14DUg7paL24=;
        b=ike1olb1cJJCkQRU15EgBe4WAXhdWPKzm8U5+KtNN25qHKYp15r6PNITCm+1PSe3aT
         mA7G36PsJY+EOoRawORb0KHFBF+1s08W8bSAs2QGPzJJDmiH42rITGfkrswOX+6vdA+o
         9a4asFVLPIZKHEjxX4SGX+emCnqsT/Mz/rWBHnz3Zpr381YY2jjBCddGl0sfhN4bdovb
         H4ihDLovKblHUY/nA3oQdMyi/UW3CcEzfM3WiktGmz8DpDzCiupOsPSVgKg5n+S/m8pA
         czlKd2kEkp/ktDDJgU4qRVUIqL29+gt5UwQzI/UePGOAEURkY+enWtamcaYNQSZhEC9y
         ywVw==
X-Gm-Message-State: AOAM5319F2da1QWSyfBJv1dGO2AuUHS6wh8UUIBZ16yVB4Ho4woUnQqo
        9h2PJL4yJfeAc/3O1djB6ctfJHhn5k8bTQ==
X-Google-Smtp-Source: ABdhPJytb4QuGhE0Dp5hS2yGoJ5gdfGFvXD2UKBYYQ+FwETV1QxzSJKBdU6XMk2BDAY7E94T1Ku81w==
X-Received: by 2002:a63:1125:: with SMTP id g37mr7864577pgl.118.1637186511589;
        Wed, 17 Nov 2021 14:01:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm605060pfj.46.2021.11.17.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:01:51 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:01:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
Message-ID: <202111171400.618456DCE9@keescook>
References: <20211117193244.31162-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117193244.31162-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 17, 2021 at 08:32:44PM +0100, Takashi Iwai wrote:
> When CONFIG_FORTIFY_SOURCE is set, memcpy() checks the potential
> buffer overflow and panics.  The code in sofcpga bootstrapping
> contains the memcpy() calls are mistakenly translated as the shorter
> size, hence it triggers a panic as if it were overflowing.
> 
> This patch adds the __NO_FORTIFY define for avoiding the
> false-positive crash.
> 
> Buglink: https://bugzilla.suse.com/show_bug.cgi?id=1192473
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> I took an easier path for now, as the attempt with a foced cast
> failed.  If there is a better way to handle, let me know, I'd happily
> resubmit.  Thanks!
> 

The way these have been fixed in the past is to declare these as char
arrays (see include/asm-generic/sections.h). I'd prefer something like
this (totally untested):

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index fc2608b18a0d..18f01190dcfd 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -33,7 +33,7 @@ extern void __iomem *sdr_ctl_base_addr;
 u32 socfpga_sdram_self_refresh(u32 sdr_base);
 extern unsigned int socfpga_sdram_self_refresh_sz;
 
-extern char secondary_trampoline, secondary_trampoline_end;
+extern char secondary_trampoline[], secondary_trampoline_end[];
 
 extern unsigned long socfpga_cpu1start_addr;
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index fbb80b883e5d..201191cf68f3 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -20,14 +20,14 @@
 
 static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
 
 	if (socfpga_cpu1start_addr) {
 		/* This will put CPU #1 into reset. */
 		writel(RSTMGR_MPUMODRST_CPU1,
 		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
 
 		writel(__pa_symbol(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
@@ -45,12 +45,12 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
 
 	if (socfpga_cpu1start_addr) {
 		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
 		       SOCFPGA_A10_RSTMGR_MODMPURST);
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
 
 		writel(__pa_symbol(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));

>  arch/arm/mach-socfpga/platsmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index fbb80b883e5d..d46b1af96a8a 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -5,6 +5,9 @@
>   * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
>   * Copyright (C) 2012 Altera Corporation
>   */
> +
> +#define __NO_FORTIFY /* need to avoid the crash with memcpy() calls */
> +
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/smp.h>
> -- 
> 2.26.2
> 

-- 
Kees Cook
