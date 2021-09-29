Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF7FC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96280611C0
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbhI2TDW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:03:22 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38639 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbhI2TDV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 15:03:21 -0400
Received: by mail-wr1-f51.google.com with SMTP id u18so5951206wrg.5;
        Wed, 29 Sep 2021 12:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mEoo1pQnu6pHp5PWM8SXaa1FHr3gfkl9owRi01q3hsE=;
        b=QT7dvnmOmfygOGlTKT9DUAqNlH1d0VnsXCcEFx23jb1dTu7JD0pzQcChEMsIksk6H0
         l3LUpWDybnbsu1d6jmAzQgYhGrMTP/NU3MIDoKtH3lHyLRzk1kRwHgIlDsqtAnL23Kmu
         5nWXgQRBXP6lP5ULtWkvNlohjsn+++qS57KLgjq7VWephB0AkS2T/hdGaBJfurhw61Tp
         rFN7jQRpxmQrUpGzbI3qM4uWKx5UPGtQ4m1pK/fGlWfjEm/x15hxQ/qsHx/DRclhpbZ5
         WHIZvTcgKEzsj3Ks1/vZX+Ew619WbjKUmvC15JM98O1oCLAmLIQt7+OuSseHgBIwv1Av
         4Xlw==
X-Gm-Message-State: AOAM533f+rrETvEPllGbUBFp4F11sn5W3kBzUcPYw2BQkgl/yKFkkadd
        /c+KrF5D/WC3jzd+orBTnQQ=
X-Google-Smtp-Source: ABdhPJy1ardq98oFiY34LpGEOjDmhtsZmRBhn3UkbjGJZMFFKb47vUt0fbZWbD1yt5tsb4oHfHeY7Q==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr1776663wry.305.1632942098923;
        Wed, 29 Sep 2021 12:01:38 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id t11sm686798wrz.65.2021.09.29.12.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 12:01:37 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
References: <20210929185823.499268-1-alex.popov@linux.com>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
Date:   Wed, 29 Sep 2021 22:01:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929185823.499268-1-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 29.09.2021 21:58, Alexander Popov wrote:
> Currently, the Linux kernel provides two types of reaction to kernel
> warnings:
>  1. Do nothing (by default),
>  2. Call panic() if panic_on_warn is set. That's a very strong reaction,
>     so panic_on_warn is usually disabled on production systems.
> 
> From a safety point of view, the Linux kernel misses a middle way of
> handling kernel warnings:
>  - The kernel should stop the activity that provokes a warning,
>  - But the kernel should avoid complete denial of service.
> 
> From a security point of view, kernel warning messages provide a lot of
> useful information for attackers. Many GNU/Linux distributions allow
> unprivileged users to read the kernel log, so attackers use kernel
> warning infoleak in vulnerability exploits. See the examples:
>   https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
>   https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html
> 
> Let's introduce the pkill_on_warn boot parameter.
> If this parameter is set, the kernel kills all threads in a process
> that provoked a kernel warning. This behavior is reasonable from a safety
> point of view described above. It is also useful for kernel security
> hardening because the system kills an exploit process that hits a
> kernel warning.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

This patch was tested using CONFIG_LKDTM.
The kernel kills a process that performs this:
  echo WARNING > /sys/kernel/debug/provoke-crash/DIRECT

If you are fine with this approach, I will prepare a patch adding the
pkill_on_warn sysctl.

Best regards,
Alexander

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  kernel/panic.c                                  | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..86c748907666 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4112,6 +4112,10 @@
>  	pirq=		[SMP,APIC] Manual mp-table setup
>  			See Documentation/x86/i386/IO-APIC.rst.
>  
> +	pkill_on_warn=	Kill all threads in a process that provoked a
> +			kernel warning.
> +			Format: { "0" | "1" }
> +
>  	plip=		[PPT,NET] Parallel port network link
>  			Format: { parport<nr> | timid | 0 }
>  			See also Documentation/admin-guide/parport.rst.
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cefd7d82366f..47b728bfb1d3 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -53,6 +53,7 @@ static int pause_on_oops_flag;
>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>  bool crash_kexec_post_notifiers;
>  int panic_on_warn __read_mostly;
> +int pkill_on_warn __read_mostly;
>  unsigned long panic_on_taint;
>  bool panic_on_taint_nousertaint = false;
>  
> @@ -610,6 +611,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  	print_oops_end_marker();
>  
> +	if (pkill_on_warn && system_state >= SYSTEM_RUNNING)
> +		do_group_exit(SIGKILL);
> +
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
>  }
> @@ -694,6 +698,7 @@ core_param(panic, panic_timeout, int, 0644);
>  core_param(panic_print, panic_print, ulong, 0644);
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
> +core_param(pkill_on_warn, pkill_on_warn, int, 0644);
>  core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
>  
>  static int __init oops_setup(char *s)
> 

