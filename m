Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28AEC433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7548A64DEC
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhA1VcF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhA1VcE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Jan 2021 16:32:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43DDC061573
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:31:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id q8so9572752lfm.10
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jge7+SvmIdKe+EfDsylHdHVfqtQTNyBnCxA66lMfr8Q=;
        b=GKpFrPZDfYQUHeDe8AiNPoLglZsvu3aI1Sjxe1zQpscy0OefqeOSO7vpuRBjPUHgch
         uZa9un2c41uGZ1Ypv2M8fQ1YK2gfkNTOb006i65jGkgUDz1VqOtBn3I8eOsRirlffDrr
         KWsmj8ulLnPpn448pe29K+RrQ+xS9kL9Bh3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jge7+SvmIdKe+EfDsylHdHVfqtQTNyBnCxA66lMfr8Q=;
        b=QO2kOLS1cRWjEGB0qSe457Pw4D4vBiBrofG6ZU139iYpiVLOZIU0iE+UDRr6V4gnUD
         u296qYjHSYkxPeMjoWjvom/bfZ4j2R0uLTcbyI9szYFWdv+aAc82Or6G37NNb/khPkTo
         9wSX11z//4BPGbi066YRAWupLr43Wixg549OV0/GOX5g6WNLPrePpIoVuDboWpn7VPzr
         dw4mCupLuh+mw+W9NrAeKk7/a4CY0OYY8uwHAUcsJsk1HTV1dMyNLjCQ5MZfHKLsvsqA
         FFy5wt3scVprnFUJ6SPqLmYGhxPfJ6/7fSQEdrTAyerTpzADJ5SC2hgK1GAaAVZ/Q9Jb
         w5LA==
X-Gm-Message-State: AOAM530mZ0GMi00ujTnwIVDRrcVBDuVGPSDXK12RU0UsNbuv6mpf4dic
        H1Xv49MANVU0G8b5NA+fIG9OayDmj7LF8Q==
X-Google-Smtp-Source: ABdhPJzSVPOab291ZppKBhXj24lIDIUTt0NAs1jWVjr51nkKDT+J5eUkhuWNpcDnfM/8OSYUJyPcpQ==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr486751lfi.616.1611869481979;
        Thu, 28 Jan 2021 13:31:21 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z5sm1786097lfe.64.2021.01.28.13.31.21
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 13:31:21 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l12so8132707ljc.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 13:31:21 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr109829lfb.487.1611869007726;
 Thu, 28 Jan 2021 13:23:27 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
 <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
 <20210128205207.awdbh4bmx56pxxjl@treble> <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
In-Reply-To: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 13:23:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+3PWi2NuoQ0hbSyLpOHjaBWKcgX6N7+PfPkXzNAfMwA@mail.gmail.com>
Message-ID: <CAHk-=wh+3PWi2NuoQ0hbSyLpOHjaBWKcgX6N7+PfPkXzNAfMwA@mail.gmail.com>
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

On Thu, Jan 28, 2021 at 1:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I really think the whole compiler version check is purely voodoo programming.

.. but there are obviously potentially things we - in the kernel - do
that may make certain compiler versions incompatible. We long long ago
used to have things like "you can't have an empty struct because gcc
version x.y.z doesn't support it", so even a UP spinlock would be

       typedef struct { int gcc_is_buggy; } raw_spinlock_t;

but only if you compiled it with a version of gcc older than 3.0. So
compiling one file with one compiler, and another with a newer one,
would result in the data structures simply not having the same layout.

That's not because of compiler versions per se, it's because of our
version checks.

THAT workaround is long gone, but I didn't check what other ones we
might have now. But the gcc version checks we _do_ have are not
necessarily about major versions at all (ie I trivially found checks
for 4.9, 4.9.2, 5.1, 7.2 and 9.1).

               Linus
