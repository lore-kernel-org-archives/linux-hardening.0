Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A59C433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 21:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8517961B25
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 21:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhJBVHs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:07:48 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45034 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhJBVHs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 17:07:48 -0400
Received: by mail-wr1-f49.google.com with SMTP id d6so21593498wrc.11;
        Sat, 02 Oct 2021 14:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5H/GFVPqJxpNuzq9DTTrJ9nYbSkD2Uo4JrRe91cjYbs=;
        b=Cfzp417lJRS/JZWt6dVI/eGKzZ2WLYUx5iavfxBij8RnJxA8myy9EbEqqIG+x4lpSx
         LtPbvC2lHmaTylfO1rJiRYrIo1/jEr3Jb3aw7GCzu8KpWftutvZQLMV5N1rcXxFviMs1
         E4NISm11mhpO5T5B427nG6sy0qlie9jeIS8ZSJs1WmAXvWcd0yG1j6wCLo/Fy7byNT+4
         XWoKsMP1/Slg3pIdrRYtBxLZOEfUG3N6bdIXkEoelZAGBQs35qjeK0ZZYMcyxNssc35a
         +LEfmCN/DhK1Mg35o/ADrbjjnpgdwr/othIcyxUD2GHqfwud8j8iT/+cUNXCnqdWOY33
         OTdg==
X-Gm-Message-State: AOAM531BXQYHNO3Pw5BvMWXtmwglCUiNfuUcTbr6hRruV7dIgetJbAcA
        F2bgvJTQMsnuYPZCEFyodS4IZNyJg+g=
X-Google-Smtp-Source: ABdhPJwYfEVPx9sGnNGcKfk+RdHjOSBlPv7Nzvdneo7e6BX2JSVXpOIrqI0GJQjGi7+1lZHBuoznpw==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr5072345wrj.438.1633208761027;
        Sat, 02 Oct 2021 14:06:01 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id q8sm9509980wrv.26.2021.10.02.14.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 14:06:00 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <0e847d7f-7bf0-cdd4-ba6e-a742ce877a38@linux.com>
Date:   Sun, 3 Oct 2021 00:05:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whrLuVEC0x+XzYUNV2de5kM-k39GkJWwviQNuCdZ0nfKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 02.10.2021 19:52, Linus Torvalds wrote:
> On Sat, Oct 2, 2021 at 4:41 AM Alexander Popov <alex.popov@linux.com> wrote:
>>
>> And what do you think about the proposed pkill_on_warn?
> 
> Honestly, I don't see the point.
> 
> If you can reliably trigger the WARN_ON some way, you can probably
> cause more problems by fooling some other process to trigger it.
> 
> And if it's unintentional, then what does the signal help?
> 
> So rather than a "rationale" that makes little sense, I'd like to hear
> of an actual _use_ case. That's different. That's somebody actually
> _using_ that pkill to good effect for some particular load.

I was thinking about a use case for you and got an insight.

Bugs usually don't come alone. Killing the process that got WARN_ON() prevents
possible bad effects **after** the warning. For example, in my exploit for
CVE-2019-18683, the kernel warning happens **before** the memory corruption
(use-after-free in the V4L2 subsystem).
https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html

So pkill_on_warn allows the kernel to stop the process when the first signs of
wrong behavior are detected. In other words, proceeding with the code execution
from the wrong state can bring more disasters later.

> That said, I don't much care in the end. But it sounds like a
> pointless option to just introduce yet another behavior to something
> that should never happen anyway, and where the actual
> honest-to-goodness reason for WARN_ON() existing is already being
> fulfilled (ie syzbot has been very effective at flushing things like
> that out).

Yes, we slowly get rid of kernel warnings.
However, the syzbot dashboard still shows a lot of them.
Even my small syzkaller setup finds plenty of new warnings.
I believe fixing all of them will take some time.
And during that time, pkill_on_warn may be a better reaction to WARN_ON() than
ignoring and proceeding with the execution.

Is that reasonable?

Best regards,
Alexander

