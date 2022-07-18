Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A4C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jul 2022 01:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGRBjU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Jul 2022 21:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiGRBjS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Jul 2022 21:39:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FDF582
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 18:39:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g1so13349096edb.12
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 18:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/uRnOSKXyMWXM6+egeORsxqIKlGjg8aotruYwUMQgQ=;
        b=f5lTMFAF9RgIRQCSACSOIOb6q62I+EN6h5/4yHht7d4KaQAPe6bswqW9WMWrHQGVkU
         t+MSmD2LZgUzfWUj/wRsQ3Q5bOlPSG7+EuHqu9plMDF8YmyFNJsl9cp/5Hijy6a55Auk
         ZF1pR/Ej+pYtQjpkLKl8KKH/AvqFf69lZyZwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/uRnOSKXyMWXM6+egeORsxqIKlGjg8aotruYwUMQgQ=;
        b=xOFIjf8WG6NGfn5g7smv92ImDGP8Yd+iGYlbeWKDxs0WOxBkJI/5S/v4A4AEu2jAnz
         x5LU3OSHzeu/hfy7iTiIShVbGV5kX1Qr9Y66SgBp3IljmRbweViFlLi73JTCYSNfRMx9
         /0SHw93P8gLOfexb4pCDPu0uDuhhmLDGqLwYfERePgAKAX2WknHoSLBNEUl3C4QsEcDP
         cITlBbc36+zStUbqbRYpq8SdW6PVpFJIoTDRvXoaprmI8yMLlKSgB6H2Hppiw28Ljf32
         J13WpyUeA79XbZdfqnARS9FDA4CjiUFxESG0YtqpnJ6fdI53nz2hAxjxaqWJmbiiafXK
         HP9g==
X-Gm-Message-State: AJIora96DCnW7aX1cMJ3Fr2NoOHDANMEeecGsKuJxYXTGn4d1hIhvlgg
        SAyP9LP9nS1fTz185dHJ4lA/Ye/aFaCC4lQbYfw=
X-Google-Smtp-Source: AGRyM1sv+H2gdoQ7PjvtFf3dyUKP6dmjxc/jII8EaZsZ4/CiOZAkJLbhZ3SesoH3sAvu2+Y41MThAQ==
X-Received: by 2002:a05:6402:3681:b0:43a:7c29:466a with SMTP id ej1-20020a056402368100b0043a7c29466amr33792891edb.367.1658108356240;
        Sun, 17 Jul 2022 18:39:16 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b00722e203633esm4868523ejh.122.2022.07.17.18.39.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 18:39:14 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id o8so6308914wms.2
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 18:39:13 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr23937555wmq.8.1658108352995; Sun, 17 Jul
 2022 18:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
 <20220717205615.GC25951@gate.crashing.org> <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
 <20220717214508.GD25951@gate.crashing.org>
In-Reply-To: <20220717214508.GD25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 18:38:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1LeRWPmA-2pit+aH0LKZoBbhnGzmwWrPz6bbchMkCzw@mail.gmail.com>
Message-ID: <CAHk-=wg1LeRWPmA-2pit+aH0LKZoBbhnGzmwWrPz6bbchMkCzw@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jul 17, 2022 at 2:49 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > I can *kind of* see the logic that when you do a whole struct
> > assignment, it turns into a "memcpy" without regard for volatile
> > members. You're not actually accessing the volatile members in some
> > particular order, so the struct assignment arguably does not really
> > have an access ordering that needs to be preserved.
>
> The order is not defined, correct.  But a "volatile int" can only be
> accessed as an int, and an external memcpy will typically use different
> size accesses, and can even access some fields more than once (or
> partially); all not okay for a volatile object.

That is not actually a valid or realistic argument in the general case.

The thing is, an operation on an aggregate type in C is fundamentally
different from the "do the same operation on the individual parts of
the struct".

Just to make a very concrete example of that, it's not at all
unreasonable to have a struct like this:

    struct io_accessor {
        union {
            volatile unsigned char byte[8];
            volatile unsigned short word[4];
        ...

and while that wasn't the example here, it's not completely insane as
a concept to use as a helper type so that you can do volatile accesses
of different sizes.

And while you'd be right to say that "assigning that kind of struct is
probably insane", and I wouldn't argue against it, I also think that
basically *any* union member is basically an argument that a structure
assignment is *NOT* about "assign all the individual members", and
never really can be.

In the above union, make one union member be a non-volatile type, and
suddenly it actually *can* be ok to copy the struct. Even though it
also has volatile bytes.

So once you start doing structure assignments but argue about
individual fields being volatile, I think you're on very shaky ground.

And I think "memcpy" is a reasonable way to say "we don't care - and
in the general case we CANNOT know - what the individual members are,
so we'll just copy it as one thing".

So the compiler emitting a "memcpy()" to assign a structure sounds
fine. Even in theory. Because the "but individual fields.." argument
just cannot work in general.

In contrast, when you access the members individually (like the kernel
does in this powerpc case), there is no such ambiguity.

There is no way in hell that it is ever ok to do a "memcpy()" when the
user has done the assignments one volatile member at a time.

So that's why I don't think your test-case with the struct assignment
is very good. I think it's very reasonable for a compiler person to
say "you assigned the whole struct, you get what you asked for, you
get a memcpy".

But when you do a loop that assigns individual volatile fields? No
such problem. Completely unambiguous that you need to do them one at a
time as individual accesses.

                Linus
