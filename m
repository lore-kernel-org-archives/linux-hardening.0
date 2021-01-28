Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF892C433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B726864DE0
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhA1VE3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhA1VEQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Jan 2021 16:04:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BDDC06174A
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:03:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v24so9483342lfr.7
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdDuCRzkz9xp+XJsVq7mYn0DfZeI0K4LQW2Z/nEcmQg=;
        b=CuBesJ1LP2UaDvKAEEK9ty4JNIugW6e5APVFSm9E7fiJHWA1KPAf2iH8izI6RoPs65
         G836VUTI89SC+kl1ZPl9l4OgX/cECS+G1kYkfmV/UQBF0i1mf5GuGzIwbuCYArHK+FB6
         knl7IYoNkyPRHrFhmo03wZoUvIqYUTzW/LwZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdDuCRzkz9xp+XJsVq7mYn0DfZeI0K4LQW2Z/nEcmQg=;
        b=Qf2KK+GYu9prh83/hPEMHJfQ7shUK3AH3DqAqNsyhRnK+ybB9VhkRcnI8KoNA8WkSg
         P0A9p+er0sxhkeEPpWX88dRsm5GcMCnvF7YuSNdk5TY2lWEWZXARZAgR7CVgvmsq2dNx
         4Gw0aS/GQuTesoL3AQZ8TXX1MiZP07Y14jcJ9i5VSMy+9U58KN0axgGbhmiG7e40Ds0C
         vSTpNOi31lB0DH++CFqszLfD/U1aYvhlwy5ZsCQA3u2/zYLqx8EhXIodTRN+8aNkJ5wo
         6ksNJEM3F5PYSALeLyxkfv9JQYSdBiZ3gNrE68q0MmIlPlnDBFhrCBvETrR+wxWINI82
         LS+g==
X-Gm-Message-State: AOAM531othIP9p64jvB4BG3Lncv0pA8pPo/uXdfDvg0sfEJH/pwyyXoJ
        XH1ThLATuYFKlBlxiMjB4jOSQnE0sbxbFA==
X-Google-Smtp-Source: ABdhPJxslPnx0qlD0d5Rx+soGkpQJCgl8tWtcsfYXKuDiWSmEOXx6llj5nSC3k6SjRdXsOPZL+zxlQ==
X-Received: by 2002:ac2:596e:: with SMTP id h14mr431892lfp.423.1611867814421;
        Thu, 28 Jan 2021 13:03:34 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g8sm2203608ljk.66.2021.01.28.13.03.32
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 13:03:33 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a8so9480819lfi.8
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:03:32 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr424761lfh.377.1611867812567;
 Thu, 28 Jan 2021 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
 <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com> <20210128205207.awdbh4bmx56pxxjl@treble>
In-Reply-To: <20210128205207.awdbh4bmx56pxxjl@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 13:03:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
Message-ID: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 28, 2021 at 12:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Huh?  Why would you do a "make oldconfig" on a distro-released kernel
> before building an OOT module?

I guarantee you that this patch will *make* people do that.

> Hm?  Are you saying the check is too strict, since GCC9 binaries _might_
> be compatible with GCC10?

I'm saying that your argument about minor and major versions is bogus.

There is absolutely nothing that makes gcc9 object files not
compatible with gcc10.

And this is not just some theoretical issue: this is a fundamental
fact of EVERY SINGLE LIBRARY OUT THERE.

Do you think that when you compile your binaries with gcc-10, you need
to link against a standard library that has been compiled with gcc-10?

I really think the whole compiler version check is purely voodoo programming.

                 Linus
