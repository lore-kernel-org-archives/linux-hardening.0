Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14236C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Jul 2022 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiGQU33 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Jul 2022 16:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGQU32 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Jul 2022 16:29:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF0CCF
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:29:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z23so18043006eju.8
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5n4kSbt+tDnJOmMOFdBXx2xa6DkOaFuSU52FmmeggU=;
        b=aJ0ySncRL5xwy3/WJRusOdK8nCOceATdsP/LrESQ+9olCuwbS7L0orcpD4kg4D4J+f
         KbkqgAwS/00KYAzWOUWUp64AdQklzywMgBC25bxwJEUp2t8R4RI5hI6drZwEdRnOVoxi
         fCWhU2soygB4BoKsZzC3n71dPyEKBWfwoYlmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5n4kSbt+tDnJOmMOFdBXx2xa6DkOaFuSU52FmmeggU=;
        b=vxY88Q3a+ocAZBaCYRPMy2RNqcyRioo8G0UR5B/splKY1TdewEuHEmgrpStNHSqek0
         L5q6wwx1kZo6GIQda9aAY8krPOn7aWKdUFzD7PgqT14cN9yjiz6acsdj9kcdMw/OjkJp
         i/KlhpGID1Qz+1q247EHw3h6Ug3k3wJFJANXIBQKlZIGS5DyMIkb/BF/Oy0NMdmHZom3
         9kMHBr6YlZmGfQ4U5fSAEVXLllLUaIh8Ba9VuM7Pm1TyKOyx6Q8fMFi8tMbFUKHW13gA
         uzXPkn77U+0KGdgMpTqJvlgMHfaMth7npuyUSpT9QtWlp9AnwVNnhg/6r3ysyzPJZSNy
         fW8A==
X-Gm-Message-State: AJIora9+HPOaXNQ9nuCCYh4OigjLLU0pj98r0m6Ph/Dz0NX2eAU4SV/b
        X0G/1cMxn2xB0kQG/QCRWahv/Tl/Ai+uENeyYC8=
X-Google-Smtp-Source: AGRyM1s+WBBMBKUIf05fdpBtttwHjP49aeq1UnNdpHlNgOwsRl/WgLjD1C/tm9FVFOSUn2ZHf9rabg==
X-Received: by 2002:a17:906:9bdd:b0:72b:3cab:eade with SMTP id de29-20020a1709069bdd00b0072b3cabeademr23107476ejc.58.1658089765227;
        Sun, 17 Jul 2022 13:29:25 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id p24-20020a17090653d800b0072efb6c9697sm3515961ejo.101.2022.07.17.13.29.24
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 13:29:24 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r14so14506243wrg.1
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 13:29:24 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr20430637wrw.274.1658089764088; Sun, 17
 Jul 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com> <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
In-Reply-To: <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 13:29:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
Message-ID: <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
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

On Sun, Jul 17, 2022 at 1:25 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> And the generated assembly still has the memset for "struct prom_args".

Strange. That smells like a compiler bug to me.

But I can't read powerpc assembly code - it's been too many years, and
even back when I did read it I hated how the register "names" worked.

Maybe it was never the args array, and it was about the other fields.
Not that that makes any sense either, but it makes more sense than the
compiler turning a series of volatile accesses into a memset.

              Linus
