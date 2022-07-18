Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70DC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jul 2022 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiGRTHP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiGRTHN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jul 2022 15:07:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0798F2F39E
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 12:07:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z23so23049075eju.8
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgjsZTbvQJX6D56jQTPEYTM5n0l6iiehUHolgd4Ce9Q=;
        b=hssRgYLn24Lw3qXe2EwOeLU2rpbVpcrr0gq1fZzk2oT4ZWnhDO4XXWRwks7LbqwMZd
         i+6c82W3/dvuvhnSYGYsFgmVoj+Cjp0nbYF4M92SjvCJ4Ce5vOdmpXyYQ5OpL8MDtgiw
         CWUZZi0MogKUpG4gNIMMisxiea+a5zCK8RaBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgjsZTbvQJX6D56jQTPEYTM5n0l6iiehUHolgd4Ce9Q=;
        b=4y1tGiNlTin2ITpPMOpIlYu4LzNw2pa6HVptbmfzl7HVfByR+yTGciH1QopDOi2t76
         tgohErGEw14ijywYUt5ZddDcHgPEbTYk9nEEBLaK0aiudQIqCf2Aa5gfYFrF0SJ3/Lql
         SPesWBLtaDXBOP6uILlu7YeXqhhGTSaHljOwauWZtre2XM46TUEvkDmWG96W2iKLAnrx
         4I3I2qTj3Nq28hAuAxeJ0RJ/h4NA0S2av7GQt6hfPgJhs1THtAjCsVXjjbsE4p/6aWra
         mEYPkHcHaWcQFjoVYjMb+G3OHcdse2d+2WcMtSWopGJqt/++50zM9RKOuksNK3wu6+Ec
         FR9Q==
X-Gm-Message-State: AJIora8Ar3zKWnQFE8MCTadPSEplIfWUkbmxqYhQJvybt9SPlXH1Ofl2
        aR4EEbciRNPom6cdq15JZ979hM+ifvCnHVXsEps=
X-Google-Smtp-Source: AGRyM1sDCPrs5S7aac3sZRnOtnKBV2/yo1Td4ig8Ca2WSiwyJYwfhrifSHUaj19ik5yKq3UiLtx6ZQ==
X-Received: by 2002:a17:907:2bc6:b0:72e:ceea:862b with SMTP id gv6-20020a1709072bc600b0072eceea862bmr24510730ejc.134.1658171230415;
        Mon, 18 Jul 2022 12:07:10 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm5781071ejx.150.2022.07.18.12.07.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:07:09 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7891939wmb.5
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 12:07:08 -0700 (PDT)
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id
 z17-20020a05600c221100b003a3214988e1mr1387069wml.8.1658171228317; Mon, 18 Jul
 2022 12:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au>
In-Reply-To: <87cze3docs.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 12:06:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Message-ID: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
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

On Sun, Jul 17, 2022 at 9:41 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> >         li 4,254                 #,
>
> Here we load 254 into r4, which is the 2nd parameter to memset (c).

I love how even powerpc people know that "4" is bogus, and have to
make it clear that it means "r4".

I don't understand why the powerpc assembler is so messed up, and uses
random integer constants for register "names".

And it gets even worse, when you start mixing FP, vector and integer "names".

I've seen many bad assemblers (in fact, I have *written* a couple of
bad assemblers myself), but I have never seen anything quite that
broken on any other architecture.

Oddities, yes ("$" as a prefix for register? Alpha asm is also very
odd), but nothing *quite* as broken as "simple constants have entirely
different meanings depending on the exact instruction and argument
position".

It's not even an IBM thing. S390 uses perfectly sane register syntax,
and calls things '%r4" etc.

The human-written asm files have those #define's in headers just to
make things slightly more legible, because apparently the assembler
doesn't even *accept* the sane names. So it's not even a "the compiler
generates this abbreviated illegible mess". It's literally that the
assembler is so horrid.

Why do people put up with that?

               Linus
