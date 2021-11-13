Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F583C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26166610A8
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhKMUBe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 Nov 2021 15:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhKMUBe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 Nov 2021 15:01:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D1C061767
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 11:58:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c8so52097679ede.13
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 11:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHD2bTlUz5x6tjTp2HBj8sSROMtXQSdxPEpMQxK64s8=;
        b=IaaBUvEeymEULLdK7ddk8M4Yt36DhR8YRyneX1vtNJIq7VW7n4gHnonP0l16PEc1Uq
         XVbcfx81U2qDOR4W6XWmiSZ+feL8J2gkzOub47CFE6fEJNKXoDb2R4aQlUAJL9V7K8Xk
         SqCnRB4yAgnBzWWsirezpwNrkTD2vJAMUHCFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHD2bTlUz5x6tjTp2HBj8sSROMtXQSdxPEpMQxK64s8=;
        b=6rFiOGxHLeemwcDlcDzh8dP8PbgJpoZJC965MV0C6X+I3tGG9fUIf+XsdmwbC2y4XF
         oBC8ejgR18ZXVr76b4T+drrX0kbO11b4HncGtyyC94eru9FQF7dg/FTPxnF6L1RbJ1MW
         ZiMvozgnoGR+wxhk/cacVjaiJY7s2gwdAaD6IESewd1S2rEJ1/OIO8PtgkrqhBPtnwaw
         nzGGUZNtNaptr87urp/xH1efdqiLBCahlgFKmbTeERel4s9mNfeticFIAh674VIXLeay
         HhorRYYxoJjAVt+ZzSomhg1feN5xujXlxeGzD+rUi1vj4V2fcsR9hmPAXnHcNrVCkdHn
         RfKg==
X-Gm-Message-State: AOAM5331IeZxkG/R35IbpBWAfVrXWKbSfLtFvfLw0yzc6FGP3o+ywV56
        DqyrCwjopcYmZ7+a0XVPBQTv3ZWWT7e5kE/iglQ=
X-Google-Smtp-Source: ABdhPJxmtDFbnaNrct1QMgnbi2F4C7eawBgGaZk6IaJ0zjKwNFYDXblsffrO4RdwLEzrWY291oU8Qw==
X-Received: by 2002:a17:906:dfe4:: with SMTP id lc4mr35257012ejc.125.1636833519803;
        Sat, 13 Nov 2021 11:58:39 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a20sm4058780ejd.112.2021.11.13.11.58.39
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 11:58:39 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id e3so16041984edu.4
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 11:58:39 -0800 (PST)
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr30419974wrd.105.1636833509376;
 Sat, 13 Nov 2021 11:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com> <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
In-Reply-To: <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 11:58:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+UMNYrR59Z31MhxMzdUEiZMQ1RF9jQvAb6HGBO5EyEA@mail.gmail.com>
Message-ID: <CAHk-=wg+UMNYrR59Z31MhxMzdUEiZMQ1RF9jQvAb6HGBO5EyEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Nov 13, 2021 at 10:14 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Killing the process that hit a kernel warning complies with the Fail-Fast
> principle [1].

The thing is a WARNING.

It's not even clear that the warning has anything to do with the
process that triggered it. It could happen in an interrupt, or in some
async context (kernel threads, whatever), or the warning could just be
something that is detected by a different user than the thing that
actually caused the warning to become an issue.

If you want to reboot the machine on a kernel warning, you get that
fail-fast thing you want. There are two situations:

 - kernel testing (pretty much universally done in a virtual machine,
or simply just checking 'dmesg' afterwards)

 - hyperscalers like google etc that just want to take any suspect
machines offline asap

But sending a signal to a random process is just voodoo programming,
and as likely to cause other very odd failures as anything else.

I really don't see the point of that signal.

I'm happy to be proven wrong, but that will require some major
installation actually using it first and having a lot of strong
arguments to counter-act the above.

Seriously, WARN_ON() can happen in situations where sending a signal
may be a REALLY BAD idea, never mind the issue that it's not even
clear who the signal should be sent to.

Yes, yes, your patches have some random "safety guards", in that it
won't send the signal to a PF_KTHREAD or the global init process. But
those safety guards literally make my argument for me: sending a
signal to whoever randomly triggered a warning is simply _wrong_.
Adding random "don't do it in this case" doesn't make it right, it
only shows that "yes, it happens to the wrong person, and here's a
hack to avoid generating obvious problems".

Honestly, if the intent is to not have to parse the dmesg output, then
I think it would be much better to introduce a new /proc file to read
the kernel tainting state, and then some test manager process could be
able to poll() that file or something. Not sending a signal to random
targets, but have a much more explicit model.

That said, I'm not convinced that "just read the kernel message log"
is in any way wrong either.

                  Linus
