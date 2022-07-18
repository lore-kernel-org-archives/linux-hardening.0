Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E4C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jul 2022 22:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiGRW4P (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jul 2022 18:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiGRW4N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jul 2022 18:56:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ECBEE2E
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 15:56:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m13so7166707edc.5
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NG3iefGii64YvAHaqT9Gl2cXR0OyawcZjQPtQ480mA=;
        b=Gw/FjPF8Ur/vqmfSNWpe6ZDtwcSnfqg2tbke8spsSGZlJ7x2utphweVTjsB8WHOMjz
         p6g7G5FO5hU63p44BJkbSE0k+uBFvhbNpROGCudhA9t8TYokwLkoL3sUwcj3gOSpoPdm
         CaFniujP7FZBaTXIsrNxkqbX+X5r9AmD9U3EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NG3iefGii64YvAHaqT9Gl2cXR0OyawcZjQPtQ480mA=;
        b=pvd6wcd431/+HARR5ha6fLWcuRCVHv/iEquPyoWrPFoEvf4GPFaVQVgdZ+cdUVs4Hd
         Ti6gBvH9onAPVKS/hITS7yHDM7p6iWETBgI3Jm9gFCReBU97sH3AuEXllJPV9u8ZU+zw
         RU7OvRt1duZL9BUTZ3v5zULqfNac6zEvBKfFtV9ZRbs0YHh2exs5EopYUj8wmCyGRupJ
         jzGgmuQyRomzsbqsoas4QzTqf2D3xcDwxjqqDDq4LwYMe7CGsuQLEvBCzqthLQN4E7Ah
         ODCtWdzCDnGqDgOnQ6SC81vlvsI/2UXxKmL7sTz92HTyPvr4eoqlgerW7YzwUdrJZZCW
         59EQ==
X-Gm-Message-State: AJIora/zYK5fSdGvuMQ8NUHn22Q9wk/yW71kIBOtkuTn4An/Lmewyptn
        z2dPk9foZSVWJ4Io64Q9Br7SesQU3jkI/vUuCYE=
X-Google-Smtp-Source: AGRyM1td2+y8eKOD45u5RtDGwLt4NBrAQydX5qknEWFi8RLr+sB4gcTeyywYm7z0AeMIHtECOWP5Xg==
X-Received: by 2002:a05:6402:11c9:b0:43a:b054:52ba with SMTP id j9-20020a05640211c900b0043ab05452bamr40801759edw.344.1658184970163;
        Mon, 18 Jul 2022 15:56:10 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id h13-20020aa7c94d000000b0043ab36d6019sm9357610edt.9.2022.07.18.15.56.07
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 15:56:09 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v16so19090460wrd.13
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 15:56:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr24939012wry.97.1658184967334; Mon, 18
 Jul 2022 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au> <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
 <20220718220839.GF25951@gate.crashing.org>
In-Reply-To: <20220718220839.GF25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 15:55:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWez4jFa1sbkhMqGktFPDMvd3kojibwFyTkGOL2xrp5w@mail.gmail.com>
Message-ID: <CAHk-=wjWez4jFa1sbkhMqGktFPDMvd3kojibwFyTkGOL2xrp5w@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 18, 2022 at 3:12 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Assembler language is unforgiving.  It isn't easy to write, and most
> mistakes will not be diagnosed.  If the assmbler language makes it
> easier to read the code, that makes it more likely correct code will be
> written, and that correct code will be written in less time.

What's your argument? That it's unforgiving, so it has to be
unreadable and easy to make mistakes in too?

You can get the order of operands wrong, and it will still build -
just to completely the wrong thing.

> > Oddities, yes ("$" as a prefix for register? Alpha asm is also very
> > odd), but nothing *quite* as broken as "simple constants have entirely
> > different meanings depending on the exact instruction and argument
> > position".
>
> What is broken about that?  It makes everything very consistent, and
> very readable.  Sigils are just nasty, and having the register names the
> same as valid symbol names is also problematic.

Oh, I agree that sigils are good to make the type clear. So '%r4' is
better than 'r4' because the latter could be ambiguous and you could
have a symbol 'r4'.

But just '4' is plain garbage.  There's no "could be ambiguous" about it.

Type checking matters. Not just in C. In asm too.

The reason '$0' is odd because it's *just* a sigil and a number.

Which certainly is not unusual in itself, but it reads like it's a
number to me. Not just because of x86 gas ('$' means 'immediate'), but
Z80 ('$' means HEX), or at least 'Nth argument' (shell).

And yeah, alpha got it from MIPS, afaik.

And presumably MIPS got it from "we're hacking up the simplest
assembler we can".

> > The human-written asm files have those #define's in headers just to
> > make things slightly more legible, because apparently the assembler
> > doesn't even *accept* the sane names.
>
> That was true a long time ago.  And the "#define r0 0" thing caused
> quite a few bugs itself btw.

Those #define's still exist. Look it up.

And yes, they are horrible, and they are wrong, and they shouldn't exist.

               Linus
