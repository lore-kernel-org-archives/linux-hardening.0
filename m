Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C3C19F28
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jul 2022 17:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiG0ROy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiG0ROJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Jul 2022 13:14:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6C76EB2
        for <linux-hardening@vger.kernel.org>; Wed, 27 Jul 2022 09:42:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so32569474ejc.3
        for <linux-hardening@vger.kernel.org>; Wed, 27 Jul 2022 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcPJOkIHEC0icvBEnpWtnVKxz/BvRtFJOpxpTEHoQRg=;
        b=dnnAblfbBitvVzSIxg4x60tAPSI8URVjg+EFtGQCO+Egbv95vWxxuJA0seKRUNvCni
         MH/l2lfP3y3m2n82QniX+RZ7l/z/R/u1/iB5fRHweoFmNcwnKUaQHfBq5L2Tk1oDNYlw
         q+xyWk2wZadVAhHiWbYj77fvxQHCyW96l9uJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcPJOkIHEC0icvBEnpWtnVKxz/BvRtFJOpxpTEHoQRg=;
        b=P6SSLWjKNEiSkVy7sbpQ9FGOweIJrZeFELyfgIhZRdQBlYY97J6b6SM5d/8pET303E
         XvOA+K6KaPsujwM7GUDeZL7itHb5bSoctvGsiRceIwX3uPbQxK6lhx3CyQexwGu8X+n5
         e34j9NDwQZxeK1K4oGQlPaPjH1ddznrI3By9vmSxA7YVU918wh9YHUuJCDfOUOm1RY6W
         M/aynG+WNhKcGPchb4Xm6nHznlDxyUioos15yuTB2tcmRnkXlKRvW7W/8PJEX+NYiCRj
         tCeP4UmG+s6WSud4Y8/62pedy3p5YnRFp+H7953ZLUrmpHaZjGZUjqWjN+9N5cX/I2nt
         BWsA==
X-Gm-Message-State: AJIora/Dsw4TZBpXXOe8Cdzqp3/AWWzRD92CTXlAg+Y8zcKpTVPVvIg9
        Te7RvtV7XpvsvBDPoo1ZjbZuLRLU+PdO3SQv
X-Google-Smtp-Source: AGRyM1uCkVi6PsnouQnRx7BkREn6ZzjHUiOFaa96uST0/KMVreKRc8W3ZXR/Kl5wpC9XEhM+DANjuQ==
X-Received: by 2002:a17:907:ea1:b0:72f:4443:d322 with SMTP id ho33-20020a1709070ea100b0072f4443d322mr18165548ejc.240.1658940148840;
        Wed, 27 Jul 2022 09:42:28 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906308d00b0072fb3704e49sm5871050ejv.46.2022.07.27.09.42.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:42:28 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b26so25346202wrc.2
        for <linux-hardening@vger.kernel.org>; Wed, 27 Jul 2022 09:42:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr3721170wmq.154.1658940137807; Wed, 27
 Jul 2022 09:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210929185823.499268-1-alex.popov@linux.com> <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1> <YVWAPXSzFNbHz6+U@alley>
 <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com> <7c567acd-1cc1-a480-ca5a-d50a9c5a69ef@ispras.ru>
In-Reply-To: <7c567acd-1cc1-a480-ca5a-d50a9c5a69ef@ispras.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Jul 2022 09:42:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSyNh2gZTnC-EoiGs5WNtVu99jcHXxLRUvwMabm37iKg@mail.gmail.com>
Message-ID: <CAHk-=wgSyNh2gZTnC-EoiGs5WNtVu99jcHXxLRUvwMabm37iKg@mail.gmail.com>
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 27, 2022 at 9:17 AM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
>
> We see a number of cases where WARNING is used to inform userspace that
> it is doing something wrong, e.g.
> https://elixir.bootlin.com/linux/v5.19-rc8/source/net/can/j1939/socket.c#L181
> https://elixir.bootlin.com/linux/v5.19-rc8/source/drivers/video/fbdev/core/fbmem.c#L1023

That first case is entirely bogus.

WARN_ON() should only be used for "This cannot happen, but if it does,
I want to know how we got here".

But the second case is fine: Using "pr_warn()" is fine. A kernel
warning (without a backtrace) is a normal thing for something that is
deprecated or questionable, and you want to tell the user that "this
app is doing something wrong".

So if that j1939 thing is something that can be triggered by a user,
then the backtrace should be reported to the driver maintainer, and
then either

 (a) the WARN_ON_ONCE() should just be removed ("ok, this can happen,
we understand why it can happen, and it's fine")

 (b) the problem the WARN_ON_ONCE() reports about should be made
impossible some way

 (c) it might be downgraded to a pr_warn() if people really want to
tell user space that "guys, you're doing something wrong" and it's
considered a useful warning.

Honestly, for something like that j1939 can driver, I doubt (c) is
ever an option. The "return -EBUSY" is the only real information that
a user needs.

               Linus
