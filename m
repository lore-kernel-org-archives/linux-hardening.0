Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D1C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FD560FF2
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhJVRcp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 22 Oct 2021 13:32:45 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:54199 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhJVRcl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 22 Oct 2021 13:32:41 -0400
Received: by mail-wm1-f45.google.com with SMTP id j205so2902008wmj.3;
        Fri, 22 Oct 2021 10:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yhmb7SMolTFSFPkuCtUT1R9/SpbKWVlxH0z/5kxG25Q=;
        b=gx9RYd739rwDE8H2BtLeK7l794eveXI+lWT7Atwl/VxgEB5uL38/MYzcqROJTcPsI7
         KPOIjC0Jo688kY8f1CdcaqN/oyevKzi1CIRWxvRAvzqQCLeTvuq1hxsXgtKpk94Jw7nM
         nc29OZh/FtOMuccsnuOLMveQuTo+eNfq5ECbrXE65QKIGZC0X+e0pTjSlMFguai602vh
         xywiERUh1Y4jxKQvpqHd1OISlgdMSaRKs/OEwoLf+xEq9Vi3nxWEcSct8cnlTBw7yUc0
         7WQoH76U7P9CQVklJPgVZ5UXmgtgUrsWvw77RaKcPQqqokrRW3Ve9MYsVGyiuigJg3Di
         IWnA==
X-Gm-Message-State: AOAM532MFxn+Rtml3ND7wRjTP48ZBuRy9KVVJD325Jbux8m6Smq/+JW5
        vyXeFUCMK4v35srENqhEbKGbmbKpHpU=
X-Google-Smtp-Source: ABdhPJx599sCveXhzPx/xzj7g4rGtKBwrNo9l+uSZOseIfrseHHHDJJYn54KfbvfhwYjKU6q64U4Cg==
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr30439519wmi.59.1634923822289;
        Fri, 22 Oct 2021 10:30:22 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id g7sm4289321wrd.81.2021.10.22.10.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:30:21 -0700 (PDT)
Message-ID: <23abb989-c20c-0dc0-019c-272beca8cee6@linux.com>
Date:   Fri, 22 Oct 2021 20:30:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
        Steven Rostedt <rostedt@goodmis.org>,
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
 <CAHk-=whrLuVEC0x+XzYUNV2de5kM-k39GkJWwviQNuCdZ0nfKg@mail.gmail.com>
 <0e847d7f-7bf0-cdd4-ba6e-a742ce877a38@linux.com> <87zgrnqmlc.fsf@disp2133>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <87zgrnqmlc.fsf@disp2133>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 05.10.2021 22:48, Eric W. Biederman wrote:
> Especially as calling do_group_exit(SIGKILL) from a random location is
> not a clean way to kill a process.  Strictly speaking it is not even
> killing the process.
> 
> Partly this is just me seeing the introduction of a
> do_group_exit(SIGKILL) call and not likely the maintenance that will be
> needed.  I am still sorting out the problems with other randomly placed
> calls to do_group_exit(SIGKILL) and interactions with ptrace and
> PTRACE_EVENT_EXIT in particular.
> 
> Which is a long winded way of saying if I can predictably trigger a
> warning that calls do_group_exit(SIGKILL), on some architectures I can
> use ptrace and  can convert that warning into a way to manipulate the
> kernel stack to have the contents of my choice.
> 
> If anyone goes forward with this please use the existing oops
> infrastructure so the ptrace interactions and anything else that comes
> up only needs to be fixed once.

Hello Eric, hello everyone.

I learned the oops infrastructure and see that it's arch-specific.
The architectures have separate implementations of the die() function with 
different prototypes. I don't see how to use the oops infrastructure for killing 
all threads in a process that hits a kernel warning.

What do you think about doing the same as the oom_killer (and some other 
subsystems)? It kills all threads in a process this way:
   do_send_sig_info(SIGKILL, SEND_SIG_PRIV, current, PIDTYPE_TGID).

The oom_killer also shows a nice way to avoid killing init and kthreads:
	static bool oom_unkillable_task(struct task_struct *p)
	{
		if (is_global_init(p))
			return true;
		if (p->flags & PF_KTHREAD)
			return true;
		return false;
	}
I want to do something similar.

I would appreciate your comments.
Best regards,
Alexander
