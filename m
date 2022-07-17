Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADCC43334
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Jul 2022 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiGQVMO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Jul 2022 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGQVMN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Jul 2022 17:12:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10F1275A
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 14:12:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so6790233ejc.7
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW6ne7NX/MQH2keCY1T28GqN5Odh8+bR3Y4JfckUjzw=;
        b=fGm8hQQ8eUxP06yf85F7pPFkaBx3O3yo1wK9DD4XbIeo2GtzbzmYzDExIju1C1a60R
         Dzv0oONPL/fyrzdC81wDNIz/pDLCzxAPalxwEibU19Ogw3dmD4kDZ0qJ6xELiZw4kP9D
         8KUm870xtTCqoYrYUBQZlFDq0IBMxvsinLQd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW6ne7NX/MQH2keCY1T28GqN5Odh8+bR3Y4JfckUjzw=;
        b=gwZQCuOZRJCTQOjUTGa0y3cFGP37P+YpyC8a50P+DQd/eY3TikDlcDn34glOEBEJQW
         /Mq9ppcfxm9bO/ku3hCEP7RHQqfDkzOmCPpZ9lfd27qzlicD1HTdt43foY+ihNrgmOrt
         YVoGAPndZklBl4NVvuwfXBjZbisHtfgvVmnM9nNeYUkvA4EP+b05Xu2n0fBrxuQUiPK5
         tE5DaQJecFc2xn0XsExt1Y7QwvJkIM9ISbMhnl0PcVfc/c1zYSTy25MUJUqCv1YD+6bb
         gum+r7Dp3vfsA4/KHpj4qlbLgQPceY4AKW+E765co12RuREDjqn3l4Vrx17WQ3kZXx93
         HDHw==
X-Gm-Message-State: AJIora/YFf8BjRH7lw4j+23bxx49Kztjdm8FW1roOzrYPCpiAJRwKOYH
        S5Etv82Ra8OWt2+bj2BejWh0vTin+/tjUciV4t4=
X-Google-Smtp-Source: AGRyM1tFuOi4wPD13B1+UMH29VhvJmxBfVBFTg9inzSWW11JGLzUvwWmNAAXlo8AUuJCBNcr88olnQ==
X-Received: by 2002:a17:907:2888:b0:72b:4a91:b21a with SMTP id em8-20020a170907288800b0072b4a91b21amr23501403ejc.35.1658092330684;
        Sun, 17 Jul 2022 14:12:10 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7cb4d000000b0043a5004e714sm7288574edt.64.2022.07.17.14.12.09
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 14:12:09 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id e15so9298645wro.5
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 14:12:09 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr20297261wrv.281.1658092328759; Sun, 17
 Jul 2022 14:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com> <20220717205615.GC25951@gate.crashing.org>
In-Reply-To: <20220717205615.GC25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 14:11:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
Message-ID: <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
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

On Sun, Jul 17, 2022 at 2:00 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Calling mem* on a volatile object (or a struct containing one) is not
> valid.  I opened gcc.gnu.org/PR106335.

Well, that very quickly got marked as a duplicate of a decade-old bug.

So I guess we shouldn't expect this to be fixed any time soon.

That said, your test-case of copying the whole structure is very
different from the one in the kernel that works on them one structure
member at a time.

I can *kind of* see the logic that when you do a whole struct
assignment, it turns into a "memcpy" without regard for volatile
members. You're not actually accessing the volatile members in some
particular order, so the struct assignment arguably does not really
have an access ordering that needs to be preserved.

But the kernel code in question very much does access the members
individually, and so I think that the compiler quite unequivocally did
something horribly horribly bad by turning them into a memset.

So I don't think your test-case is really particularly good, and maybe
that's why that old bug has languished for over a decade - people
didn't realize just *how* incredibly broken it was.

             Linus
