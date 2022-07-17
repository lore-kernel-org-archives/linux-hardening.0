Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55BEC433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Jul 2022 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiGQU5R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Jul 2022 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQU5R (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Jul 2022 16:57:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698010FCF
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:57:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so18134862ejb.4
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZqPRM2qcyTueyhf1A6Ua5dmBCzOfbjpMoyDTZFWtJk=;
        b=dZZ0/J3Hz/3sOD/J3s9/31I0vY717Zhr1SM61AC5OANF6c/cfnYp6xRqg7y679cXn5
         BLxGuF6o+L2w7BzW6F/YG74lJOnkvammDYV/T49wCqFk9duszqWdnIAuQbC1zx/SkC4N
         KdH5J6w0VRithPFum3wWbH58hx2nhU2bkmYp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZqPRM2qcyTueyhf1A6Ua5dmBCzOfbjpMoyDTZFWtJk=;
        b=eoI+n+OTNNnyfH9cqdItv2DMSUgg7y1uK2u7IBYpAT89VmRXE+exwuKh8GCLhiMUYs
         +vHkkud8oKL5yzu/+mnelLjtZaN3AOX5VTIXEKmgActFRINhnuXlSWiMLd+oLk3b/Dob
         dl0jUH7LYbOlgJAgVnMEJ2X+pDUc1dlE24TOdeX4Fv5zNjQLxuTWJy8Jj30ro8o8LthX
         yDUbtvHqRIPUcuqbiwiQY3EuSaqYyMf37EEOK7To3DDDcwVnA2hfb+QTwEE31YujGpbD
         xQZMlv7F4gv+v977jTxi0qAJin+Xuvi3ac50rXf0oQkrbu+aEPzrnVw+Qe8Fw7d1GMn8
         fFrg==
X-Gm-Message-State: AJIora/kcXBL0xQ7J0Pqydu/KHSqoYEKRGmX6g/d8+pgpC3ER8GCssni
        HClU7wSAXUhyRY57VrGZKebQVi4/gwEP31FerO0=
X-Google-Smtp-Source: AGRyM1sZl/VorDYdyQ0N4LGHdk71bPzNdLiHP8xa/v5Aws3rDeVVqj2yiCiq61jPTyQtMU7ug+cOxg==
X-Received: by 2002:a17:907:a0c6:b0:72e:ea7d:6a98 with SMTP id hw6-20020a170907a0c600b0072eea7d6a98mr13847796ejc.140.1658091433728;
        Sun, 17 Jul 2022 13:57:13 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o1-20020aa7dd41000000b00436f3107bdasm7245884edw.38.2022.07.17.13.57.12
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 13:57:12 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id z12so14536097wrq.7
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:57:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr20888588wry.97.1658091432023; Sun, 17
 Jul 2022 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com> <CADVatmMRC-T3vUfgzya1hYmGOme79kBu2hK2CxBU3+C5h1TAYA@mail.gmail.com>
In-Reply-To: <CADVatmMRC-T3vUfgzya1hYmGOme79kBu2hK2CxBU3+C5h1TAYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 13:56:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw31_Q_5-UR6AD4xpG5Q3LieMtr+99jP2oqwPhh-a_SA@mail.gmail.com>
Message-ID: <CAHk-=whw31_Q_5-UR6AD4xpG5Q3LieMtr+99jP2oqwPhh-a_SA@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jul 17, 2022 at 1:38 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I have also tried adding volatile to all the members of that struct.  :(

Can you read the code to figure otu what the memcpy is all about?

Or maybe there is something that disables 'volatile' with pre-processor hackery.

Because a compiler that turns a loop over volatile members into
'memset()' isn't a C compiler, it's just a random noise generator.
'volatile' is fundamental enough that I really doubt both gcc and
clang can be that broken.

I just tested this

        struct hello {
                volatile int array[100];
        };

        void test(void)
        {
                int i;
                struct hello hello;
                for (i = 0; i < 100; i++)
                        hello.array[i] = 0;
        }

on x86-64, and sure enough, gcc-12 turns turns it into a memset
without the volatile (in fact, the above will just be optimized away
entirely since it has no user), but with the volatile it's a proper
regular loop that does 32-byte accesses one by one (and in the proper
ascending oder). Something that memset() most definitely does not
guarantee:

.L2:
        movslq  %eax, %rdx
        addl    $1, %eax
        movl    $0, -120(%rsp,%rdx,4)
        cmpl    $100, %eax
        jne     .L2

and honestly, anything else sounds completely unacceptable.

So I suspect there is something wrong with your testing, because gcc
simply isn't that incredibly broken. Clang is interesting in that it
seems to unroll the loop five times, but it still does the proper
"write individual 32-bit entities in ascending order".

The other alternative is that it's something else than that 'struct
prom_args'. Again, I don't read powerpc asm good.

                  Linus
