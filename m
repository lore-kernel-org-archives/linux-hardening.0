Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB1C76196
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Apr 2023 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjDGXew (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDGXev (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 19:34:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03039FF07
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 16:34:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id cv11so14358766pfb.8
        for <linux-hardening@vger.kernel.org>; Fri, 07 Apr 2023 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680910435; x=1683502435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06aeoqWpNiijpeI6eB3KfJuOvE83nAPBY5T1nVItygw=;
        b=eEqX5GQsSIT1ib03PuaWvCog9rPYAClxGQ6SYoayXujdj9Vwh3oFSXC/1mJtPeqxFh
         ZpSum1yFKCynUjMpq9rU2BWz7PYUDEcs2ifNSLaZslGJ1GwvqLnc+Onoky1nHCF2+yVS
         zrE/P2hNSmY6bElfXjJ9M9zMYtBXZd8K+Ote/FNSwc0PbnukyY2EdaUjW3dzN5edyorL
         tzpgmZHKeNU6PEYre0EU+f2cdqwdDpZOlj4uDszICEHHyU1TRMnS3u6R8nMUromyocrP
         yItCom/VSudEr1pZCo8WBYeEjue3dFpDeQmoKwAYacXjS9q+gC6DDLydCm6CbXBXi/LS
         254Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680910435; x=1683502435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06aeoqWpNiijpeI6eB3KfJuOvE83nAPBY5T1nVItygw=;
        b=mUjgLOxRdzjRtv5xkraF/+n9dyhCGs5c7BEMNE2H0HQdvTYscWVVTP9IX1oYnUCSL8
         ObTOhgw9urMl1F4AS2NmJtDahGe0KsDpHxiHTMbe225pdAE5NSvXeHMioleyBuga0SVs
         z4Xj3Z55Gk+CxoNiYnbJxVS7ddzaa/W5EEYzuQQHnBk/hD7ELMQoH89ftyN0SU/4m3M3
         ijtkpInp6WqaKk1CCUWf5FOYB0vpoUqCR0tlgHCevZhwWgN66Dwm1MnP2DbQXAaZekwZ
         7LvD6/GjgOAesY0nJ/zI2He0CPrx9pBI56GHIqKmcbOj/U/FWTr2bH75p3dEz/YTuUH3
         xjYQ==
X-Gm-Message-State: AAQBX9d0d1Xpu6VfQwTGFNQfl/pZHXUqA+avhAuqilqy2BP0tDv590ww
        FGwW6zYn9tA6FhoAwNA7DvEvuSsyqLlwYSIbZcoSEA==
X-Google-Smtp-Source: AKy350Y80laGeXozMwqopyOyp6O/Wc6NHSiXHA+TBD0qwgUXtD1pcGPHuzmDzQtW+NGkzGW9E4jcDIPqOEDpn/KvRag=
X-Received: by 2002:a65:6201:0:b0:4fc:2058:fa29 with SMTP id
 d1-20020a656201000000b004fc2058fa29mr792545pgv.1.1680910434569; Fri, 07 Apr
 2023 16:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-1-keescook@chromium.org>
In-Reply-To: <20230407192717.636137-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 16:33:43 -0700
Message-ID: <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
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

On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> running with --altests to gain additional coverage, and by default under

two L's in alltest?

> UML.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/kunit/configs/all_tests.config | 2 ++
>  tools/testing/kunit/configs/arch_uml.config  | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index f990cbb73250..0393940c706a 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -9,6 +9,8 @@ CONFIG_KUNIT=3Dy
>  CONFIG_KUNIT_EXAMPLE_TEST=3Dy
>  CONFIG_KUNIT_ALL_TESTS=3Dy
>
> +CONFIG_FORTIFY_SOURCE=3Dy
> +
>  CONFIG_IIO=3Dy
>
>  CONFIG_EXT4_FS=3Dy
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/=
kunit/configs/arch_uml.config
> index e824ce43b05a..54ad8972681a 100644
> --- a/tools/testing/kunit/configs/arch_uml.config
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -3,3 +3,6 @@
>  # Enable virtio/pci, as a lot of tests require it.
>  CONFIG_VIRTIO_UML=3Dy
>  CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> +
> +# Enable FORTIFY_SOURCE for wider checking.
> +CONFIG_FORTIFY_SOURCE=3Dy
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
