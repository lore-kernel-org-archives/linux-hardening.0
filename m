Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB96C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6A761452
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhI3SaH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhI3SaG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:30:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CFC06176D
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:28:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bb10so4670287plb.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bJQp0EveKpDiPsOMFVpChuzPEuyjjWMfq0T7MgkOQX0=;
        b=SS7FBRJc10lBnPpZgIXDdMdmm/EW9rleR3LEp7dfEyZCCmQzOgUoe3gUB64poFf3ol
         FW44IgOssGzHzaTh5hgy4Jh9L1jrEC1ORjjI8uj8zwzHYUnYPk1+7te6iExLfAFlNNyQ
         rv1f/+ppsGC37whEoNQJKF+R8+7SIN1eMiaWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bJQp0EveKpDiPsOMFVpChuzPEuyjjWMfq0T7MgkOQX0=;
        b=HGOsSdi6RoTwmnaJXgUgESU20SW1d4u1i5x0U4/7k9fYxGVN1qxutM2nAVeSmCYd8o
         khpDJ1MelpKDZWq3N76xXFukKZxngeciqk3VcmFa9HkMgrOvlJCgMIwb52JPFWV/9orZ
         HQhPqK4ShOVI+T4qv1Df1TMX5aoJnQKvsjNHBqsa00TtANiAt07UP+UqFZSU1B//+13w
         INUEcDuT8VYbk9Sl6zQUpi8Nb3r8YwQvNyjsWHgvR0r+0NESc6AXySi5Q23+S8ENxxs/
         s83ZuklZAC1Doe0PNtxJXaUJ77Gf3RMIAceea5QRgzPpJV8CzaHRlzl8uG6MyRrnFf5c
         dn/w==
X-Gm-Message-State: AOAM533fUXreuDxGhwJAJGlk4Q35tZEMAtgSpvFVjV9iL8SZ4FekeJ+q
        IBx1XPK4xJqoYHHREaL0vnUndQ==
X-Google-Smtp-Source: ABdhPJx4LkSAVbqiILzXORBnmfPR1qsA1ApR/kA9pbF5PVvZyUo+BRz+h/bIAyJtOhSDqy5tEulKXQ==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr6536260pjb.123.1633026502202;
        Thu, 30 Sep 2021 11:28:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z17sm3718313pfa.148.2021.09.30.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:28:21 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:28:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
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
        linux-kernel@vger.kernel.org, notify@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <202109301121.7644668F3F@keescook>
References: <20210929185823.499268-1-alex.popov@linux.com>
 <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1>
 <YVWAPXSzFNbHz6+U@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVWAPXSzFNbHz6+U@alley>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:15:41AM +0200, Petr Mladek wrote:
> On Wed 2021-09-29 12:49:24, Paul E. McKenney wrote:
> > On Wed, Sep 29, 2021 at 10:01:33PM +0300, Alexander Popov wrote:
> > > On 29.09.2021 21:58, Alexander Popov wrote:
> > > > Currently, the Linux kernel provides two types of reaction to kernel
> > > > warnings:
> > > >  1. Do nothing (by default),
> > > >  2. Call panic() if panic_on_warn is set. That's a very strong reaction,
> > > >     so panic_on_warn is usually disabled on production systems.
> 
> Honestly, I am not sure if panic_on_warn() or the new pkill_on_warn()
> work as expected. I wonder who uses it in practice and what is
> the experience.

panic_on_warn() gets used by folks with paranoid security concerns.

> The problem is that many developers do not know about this behavior.
> They use WARN() when they are lazy to write more useful message or when
> they want to see all the provided details: task, registry, backtrace.

The documentation[1] on this hopefully clarifies the situation:

  Note that the WARN()-family should only be used for “expected to be
  unreachable” situations. If you want to warn about “reachable but
  undesirable” situations, please use the pr_warn()-family of functions.
  System owners may have set the panic_on_warn sysctl, to make sure their
  systems do not continue running in the face of “unreachable” conditions.


[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

> Also it is inconsistent with pr_warn() behavior. Why a single line
> warning would be innocent and full info WARN() cause panic/pkill?

Because pr_warn() is intended for system admins. WARN() is for
developers and should not be reachable through any known path.

> What about pr_err(), pr_crit(), pr_alert(), pr_emerg()? They inform
> about even more serious problems. Why a warning should cause panic/pkill
> while an alert message is just printed?

Additionally, pr_*() don't include stack traces, etc. WARN() is for
situations that should never happen. pr_warn() is about undesirable but
reachable states.

For example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4689846881d160a4d12a514e991a740bcb5d65a

> It somehow reminds me the saga with %pK. We were not able to teach
> developers to use it correctly for years and ended with hashed
> pointers.

And this was pointed out when %pK was introduced, but Linus couldn't be
convinced. He changed his mind, thankfully.

-- 
Kees Cook
