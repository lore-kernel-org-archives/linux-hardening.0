Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E591C43334
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 16:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378079AbiFPQAN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378030AbiFPQAN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 12:00:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6543ACE
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:00:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w27so2809542edl.7
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ2jAaiEzLNQ93crLBAe3sDvH4iCO/x2lZ+zRlgdV/4=;
        b=cxj6vejdZIrdWg7i57fno7dIoPvsbKilzHyEXWvFkAoBv9r+QoFdy7bpOwZp2Ylk3B
         pfE/wp7Kfj88bh8j/WDUFirzzoX10qWcVrp+aqFo0r03zBUiPzkWhr4H7OcxpoTJRrbK
         rSMSCgfc1ly2bqQk3lU50OAV7bXFWH86uHjt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ2jAaiEzLNQ93crLBAe3sDvH4iCO/x2lZ+zRlgdV/4=;
        b=TfeEwWJwc+/GVhFTP+xDzBEKkC5FbU4Lq5VUxqihyyrM2urnJQZGr+ttqdS/CcyPbJ
         mKn7sszkLUhefAIX/VTvoKDY3+wKme/4EbtWyAEJbcgqyp26sBQ8frE39ZhGj7NhGkb3
         IvYXbtEKEC93EfIE8eE1XFy/+I1dKLIV0Q7j+/ZVe/9orGkhWJGiQT/LQLTmTeBGBPPw
         X3of94M35fr6SkalEnQaRM/5tGbkgQjdLnZi0HrUvZa+qjpjbJbJj3LyXFSjYgdoQSyz
         ZPpacovc6iFTr2YBeSL1iKUUwqMbSGi5lPkwLHtea+8bxOQl6m2bLISVBew8u8SUYIUY
         p3bQ==
X-Gm-Message-State: AJIora8tTYOp6DuM588PJVFkFCt1fMjmU3Fq9ZaxDuhqqMM4BdawmpbA
        gg+MVImVbJnaT004Ljpx5HZCug4CZqXHxuskHWQ=
X-Google-Smtp-Source: AGRyM1uD3CVdDVnOiuS2PO/CmhHdE8uhJuVlEFRHjerQmV3yiJU/NAh3imwQstZ/bx91WFFd3p57SA==
X-Received: by 2002:a05:6402:ea7:b0:433:6141:840e with SMTP id h39-20020a0564020ea700b004336141840emr7405394eda.266.1655395210552;
        Thu, 16 Jun 2022 09:00:10 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id i21-20020a05640242d500b0042dddaa8af3sm2037985edc.37.2022.06.16.09.00.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:00:08 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id v14so2457819wra.5
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:00:08 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr5432558wrb.442.1655395207618; Thu, 16
 Jun 2022 09:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
In-Reply-To: <YqtKjAZRPBVjlE8S@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 08:59:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
Message-ID: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 16, 2022 at 8:21 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't know why people call uintptr_t a "userspace type".  It's a type
> invented by C99 that is an integer type large enough to hold a pointer.
> Which is exactly what we want here.

On the other hand, "unsigned long" has existed since the first version
of C, and is an integer type large enough to hold a pointer.

Which is exactly what we want here, and what we use everywhere else too.

The whole "uintptr_t handles the historical odd cases with pointers
that are smaller than a 'long'" is entirely irrelevant, since those
odd cases are just not a factor.

And the "pointers are _larger_ than a 'long'" case is similarly
irrelevant, since we very much want to use arithmetic on these things,
and they are 'long' later. They aren't used as pointers, they are used
as integer indexes into the virtual address space that we do odd
operations on.

Honestly, even if you believe in the 128-bit pointer thing, changing
one cast in one random place to be different from everything else is
*not* productive. We're never going to do some "let's slowly migrate
from one to the other".

And honestly, we're never going to do that using "uintptr_t" anyway,
since it would be based on a kernel config variable and be a very
specific type, and would need to be type-safe for any sane conversion.

IOW, in a hypothetical word where the address size is larger than the
word-size, it would have to be something like out "pte_t", which is
basically wrapped in a struct so that C implicit type conversion
doesn't bite you in the arse.

So no. There is ABSOLUTELY ZERO reason to ever use 'uintptr_t' in the
kernel. It's wrong. It's wrong *even* for actual user space interfaces
where user space might use 'uintptr_t', because those need to be
specific kernel types so that we control them (think for compat
reasons etc).

We use the user-space types in a few places, and they have caused
problems, but at least they are really traditional and the compiler
actually enforces them for some really standard functions. I'm looking
at 'size_t' in particular, which caused problems exactly because it's
a type that is strictly speaking not under our control.

'size_t' is actually a great example of why 'uintptr_t' is a horrid
thing. It's effectively a integer type that is large enough to hold a
pointer difference. On unsegmented architectures, that ends up being a
type large enough to hold a pointer.

Sound familiar?

And does it sound familiar how on some architectures it's "unsigned
int", and on others it is "unsigned long"? It's very annoying, and
it's been annoying over the years. The latest annoyance was literally
less than a week ago in 1c27f1fc1549 ("iov_iter: fix build issue due
to possible type mis-match").

Again, "unsigned long" is superior.

And the only reason to migrate away from it is because you want
something *type-safe*, which uintptr_t very much is not. As
exemplified by size_t, it's the opposite of type-safe. It's actively
likely to be type-confused.

              Linus
