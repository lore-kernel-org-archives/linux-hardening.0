Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B76C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5EC61BA2
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbhKRASn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbhKRASk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 19:18:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B61C061764
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 16:15:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so18686253edd.9
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+58f0SyQ3Lb12arfHudpznsJpM8EH8QJRhqC+3D+/o=;
        b=GIK/XZDC7ZNVXEqtZ+tcRvrXQwqh/3lJY4yq2xqMR5g4v4WHdHdxBBddnKCXAxjOPb
         D4LDriIwmMmUqzawd5iS2gHre59nN6Ls/L0plgWyRkjMH6wccNzKmXtgD3O8sgwqJg2Q
         rLVrPCOoHEuMVi4eKbaeBXjnaPlOpyQXvrK0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+58f0SyQ3Lb12arfHudpznsJpM8EH8QJRhqC+3D+/o=;
        b=vhCq9BMIxGgqN7ze8h1rytSPT3LvYctW8jTPUJswH16vN3x1EbIrVLsWYVnHuPhVrC
         jg5AD/ag33zJe2mzv/41v2VaSWwGn4Vh5QrpkdX85Q78DsYRHW/hwU5TzDae31bsGg3p
         feoFmw/pvWpy9Jgza6PKzjiNjieCWKbdUeZQe9K1lr8P+xFy50rSIymLBodMEv2K1LKW
         NCsAcNgSqvnrejr7ZfsVfL2TX2ghu3DeShOHkjd+OtE/gLsuLxEwzAJVmV8M/MmhiaLH
         vRJmfQyCBu5W3NxloVjGe54FQG+HIK3nAKHXv7WhARIzZONYPQif7o+J0jGLyJ8XtS66
         SL0g==
X-Gm-Message-State: AOAM533aJ4iCocIG/uTPCxyR+pXqfvtoxVP0GMiHYRIkPHWQMGUhCUky
        NJIWFft6TVuC7tJ/e2AsQVlt3kUTDB0yLcNl
X-Google-Smtp-Source: ABdhPJyWbxO+6vOkkYvxiv1POsPE/pUlJ1f4MUFkQIPR5fsBW/j6yD0WT+KC9Qiig9yQFH0FZqis/g==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr4523861edd.29.1637194539227;
        Wed, 17 Nov 2021 16:15:39 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id k23sm684595edv.22.2021.11.17.16.15.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 16:15:37 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id s13so7954406wrb.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 16:15:37 -0800 (PST)
X-Received: by 2002:adf:d082:: with SMTP id y2mr24843502wrh.214.1637194537139;
 Wed, 17 Nov 2021 16:15:37 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com> <202111171603.34F36D0E01@keescook>
In-Reply-To: <202111171603.34F36D0E01@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 16:15:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsyDcohs=i0XGu0GRb6AkXUNyWCE_f6JMy0RY9wdXUXg@mail.gmail.com>
Message-ID: <CAHk-=wjsyDcohs=i0XGu0GRb6AkXUNyWCE_f6JMy0RY9wdXUXg@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kyle Huey <me@kylehuey.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 17, 2021 at 4:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> (nit: should the "sigdfl" argument be renamed "immutable" for clarity
> in this function?)

I don't think that would necessarily clarify anything. Neither
"sigdfl" nor "immutable" makes at least me go "Ahh, that explains
things".

Both "sigdfl" and "immutable" are about random internal implementation
choices ("force SIGDFL" and "set SA_IMMUTABLE" respectively).

I think naming things by random internal implementation things is
questionable in general, but it's particularly questionable when they
aren't even some really fundamental thing.

I think you generally want to name things not by how they do
something, but by *WHAT* they do.

So I think the proper name for it would be "fatal" or something like
that. It's basically saying "This signal is fatal, even if you have a
handler for it or not". That "set it to SIGDFL" just happens to be how
we made it fatal.

And then we should perhaps also make such a signal uncatchable by the
debugger (rather than just "debugger cannot undo or modify it" like
the SA_IMMUTABLE bit does).

Anybody want to take on that renaming / uncatchable part? Please take
my (now at least tested by Kees) patch and make it your own.

              Linus
