Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51BC433FE
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F5361B00
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhJBQfL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 12:35:11 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:46892 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhJBQfK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 12:35:10 -0400
Received: by mail-wm1-f53.google.com with SMTP id o4-20020a05600c510400b0030d55d6449fso2348996wms.5;
        Sat, 02 Oct 2021 09:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XPPGkU56zJhC1We9hrBWJnpYMVu8F2L8QKrG+oAgNZA=;
        b=GiQyFy2Nwz42KBqTETpKBTHxTSNtgOnkLCANiRsyoQGMTJtY4L3O4vZyDoVmdIgDuS
         4VNJQNI1H4RBL3WY1JyAgHh+GY50rH8+zoBCMbotHGpLHKuKs+rlN+zvFhh9vWRw1cRC
         eIBMcAkSaJJjEa5BhlgdxpITdWjhVDxqApes3EluqCcC/mCRn/e0LzaKXj3ZarhIAkyk
         aqgaUM7UbK4Kyz3zX/C6wHfjis70tnrNPp7Fv9bVUkOJLtDfaUEZ4g4hFPuku4leZEFK
         BP5K3LRz43whMy3UdnPaJx0DVCZGl6NYY4efGr4Xtdg5Eg9bL4XQzoES3qvcljtfbHE/
         Pkwg==
X-Gm-Message-State: AOAM532iRdTiZ7WBzs9hos4vSvZTMyBbF8Og81+4ILfTCjnIVDzhvYcp
        vJEFCfJuUjNTOU0RDKS9Sr0=
X-Google-Smtp-Source: ABdhPJxnblRp0iST3pjMz+7tehqv68lMCKl8gTtuCPWUtdqmj3LGMvYGXoO4MgsXUEEqgbn3pAhWlA==
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr10013673wmq.184.1633192403799;
        Sat, 02 Oct 2021 09:33:23 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id q126sm10973918wma.10.2021.10.02.09.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:33:23 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Will Deacon <will.deacon@arm.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        notify@kernel.org
References: <20210929185823.499268-1-alex.popov@linux.com>
 <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1> <YVWAPXSzFNbHz6+U@alley>
 <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com>
 <ba67ead7-f075-e7ad-3274-d9b2bc4c1f44@linux.com>
 <20211002081359.5de4e2b1@oasis.local.home>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <62cd30d5-0982-5074-969b-a4ae1ee188c3@linux.com>
Date:   Sat, 2 Oct 2021 19:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211002081359.5de4e2b1@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 02.10.2021 15:13, Steven Rostedt wrote:
> On Sat, 2 Oct 2021 14:41:34 +0300
> Alexander Popov <alex.popov@linux.com> wrote:
> 
>> Currently, the Linux kernel provides two types of reaction to kernel warnings:
>>  1. Do nothing (by default),
>>  2. Call panic() if panic_on_warn is set. That's a very strong reaction,
>>     so panic_on_warn is usually disabled on production systems.
>>
>> >From a safety point of view, the Linux kernel misses a middle way of handling  
>> kernel warnings:
>>  - The kernel should stop the activity that provokes a warning,
>>  - But the kernel should avoid complete denial of service.
>>
>> >From a security point of view, kernel warning messages provide a lot of useful  
>> information for attackers. Many GNU/Linux distributions allow unprivileged users
>> to read the kernel log (for various reasons), so attackers use kernel warning
>> infoleak in vulnerability exploits. See the examples:
>> https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html
>> https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
>> https://googleprojectzero.blogspot.com/2018/09/a-cache-invalidation-bug-in-linux.html
>>
>> Let's introduce the pkill_on_warn parameter.
>> If this parameter is set, the kernel kills all threads in a process that
>> provoked a kernel warning. This behavior is reasonable from a safety point of
>> view described above. It is also useful for kernel security hardening because
>> the system kills an exploit process that hits a kernel warning.
> 
> How does this help? It only kills the process that caused the warning,
> it doesn't kill the process that spawned it. This is trivial to get
> around. Just fork a process, trigger the warning (it gets killed) and
> then read the kernel log.
> 
> If this is your rationale, then I'm not convinced this helps at all.

Steven, as I understand, here you ask about the security implications of
pkill_on_warn (not about the safety implications that I mentioned).

Killing the exploit process that hit a warning is MUCH better than ignoring and
proceeding with execution. That may influence the stability of the exploits that
hit WARN_ON() or rely on WARN_ON() infoleak.

Exploit development is the constant struggle for attack stability. Exploiting a
heap memory corruption is especially painful when the kernel works with the
attacked slab caches in parallel with your exploit.

So when the kernel kills the exploit process, some of the WARN_ON() infoleak
data becomes obsolete; the attacker loses the execution in that particular
kernel task on that particular CPU. Moreover, restarting the exploit process
would bring a lot of noise to the system. That may decrease the attack stability
even more.

So killing the exploit process is the best option that we have here to distress
the attacker who uses the WARN_ON() infoleak technique. I.e. that is
probabilistic attack mitigation, which is reasonable for kernel safety as well.

I hope I managed to show this from the attacker's side.

Best regards,
Alexander
