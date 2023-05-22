Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4586C7EE23
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjEVToI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjEVToF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:44:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF813E
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:44:03 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75b04e897a5so214031385a.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684784642; x=1687376642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf6BP7twGSDBospMz3gLuMbkNpoM+LqAkeRJFnDLhq0=;
        b=gQJUtf2A/Lyy5uzuYYyAlLsDa6/ZLaGjllhjLnGlzVc1QkkFu2bjYdi/WX7fL+SBZC
         SbxEPlkEikvrBwi4oEzm++APe2/OT/uVYlHVqvuPopJ+A6PJLFb3rXxQc3Yxeqr7T2R6
         09Mwfai1py/Rt2lT8FGmGQ9nweN7aWoNPCJ/NX80OpSVwW+SkJ7TQXjfLGn6lsVDh+Li
         Wnnz8hZJGAU91cVXgRtJstc6TTmkq94aSLoWZ0C0+cygNTR+DvsZauaXk5iGlRIeBDyE
         LF7qnwQRHZgXtzUYn8Qt8Um/yTYoj6nKIPyp+lPRATphvp23pZPI3kUNohBi6KKogCdC
         jzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784642; x=1687376642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf6BP7twGSDBospMz3gLuMbkNpoM+LqAkeRJFnDLhq0=;
        b=I1LXSLK5/Re72D2TtGLC6bqfCui9nC29gGaJdUFkao/V1hTQBep7nggNtGprsJGJPh
         q4qA71AR2n1AH2G4Gj6qoOqipmeKnsAQ5DM8xMseGd6fGSWiPbf9D+IX1fEO/G/IERKH
         pkZs9pafsbXZXc1PEM/SJbDEr8f1x/dBgeD4DuBUXI/c4GXut54/3b/vIuoTF9jvtJg8
         F0xqn3lSFfVQsqlffFT0vwUTYbWAQvrpqavgBP/3jeXJyhN4vU9GrdI7SCsB8CYzGHXK
         eOiKUTO8vBbcDz0xrrhzrqt+9v9WpWHC7JsH6qKoWNxscr+VYMP4L8EFTFvABa6M483e
         iMWQ==
X-Gm-Message-State: AC+VfDzA8qNFykq0rH7u0P8ShoUqr+hnJrljPM3VRCE6p/GG2KIW8/lh
        qTjtW3qMni2t1fONjrIrwb/B4I2uIP0CkzidDZn4CgNX8M2kSRj2HzhoYw==
X-Google-Smtp-Source: ACHHUZ6U/PyCxFJ2nf7jWAQFsY72P2kK2tmXLXmy/RS+oTAbPBeALj+1SlbJUhBD48s+dEOfKcxvdMBeHClwU4MeyJw=
X-Received: by 2002:a37:4114:0:b0:75b:23a1:3611 with SMTP id
 o20-20020a374114000000b0075b23a13611mr1926882qka.34.1684784642426; Mon, 22
 May 2023 12:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
 <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com> <202305101223.B940A881@keescook>
In-Reply-To: <202305101223.B940A881@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 12:43:51 -0700
Message-ID: <CAKwvOdn9ytF7EVykt3YXk2QzqYjTfWBzwwXm8LpgPpCLkCvH+Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 10, 2023 at 12:24=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, Apr 07, 2023 at 04:42:27PM -0700, Nick Desaulniers wrote:
> > On Fri, Apr 7, 2023 at 4:33=E2=80=AFPM Nick Desaulniers <ndesaulniers@g=
oogle.com> wrote:
> > >
> > > On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > >
> > > > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possi=
ble
> > > > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE wh=
en
> > > > running with --altests to gain additional coverage, and by default =
under
> > >
> > > two L's in alltest?
> >
> > Also, while testing this series:
> > ```
> > $ LLVM=3D1 ./tools/testing/kunit/kunit.py run
> > ...
> > [16:40:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D forti=
fy (24 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [16:40:09] [PASSED] known_sizes_test
> > [16:40:09] [PASSED] control_flow_split_test
> > [16:40:09] [PASSED] alloc_size_kmalloc_const_test
> > [16:40:09]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED
> > at lib/fortify_kunit.c:249
> > [16:40:09]     Expected __builtin_dynamic_object_size(p, 1) =3D=3D expe=
cted, but
> > [16:40:09]         __builtin_dynamic_object_size(p, 1) =3D=3D -1
> > (0xffffffffffffffff)
> > [16:40:09]         expected =3D=3D 11 (0xb)
> > [16:40:09] __alloc_size() not working with __bdos on kmemdup("hello
> > there", len, gfp)
>
> I'm still tracking this down. I'm not sure what's happening here, but it
> seems to be Clang-specific, and due to some interaction with the changes
> I made for Kunit examination. WHY it happens I haven't found yet.

Was this what exposed https://github.com/llvm/llvm-project/issues/62789?

--=20
Thanks,
~Nick Desaulniers
