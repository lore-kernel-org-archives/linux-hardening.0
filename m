Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A60C6FD18
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Apr 2023 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDRS1Y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDRS1Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Apr 2023 14:27:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A499031
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 11:27:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so94749pjl.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681842442; x=1684434442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xan2Rb4LxJqnkwR/5yCpJ+HY7/yGaonUOCUizXrIxSQ=;
        b=5dflFAVkwrsWE1u98WIy85LkOvAI6qFWx1pATeB2f4ij7axRKfMTBzK++4jekGsLO2
         5KkXMdTJ6Nk/mMHiOjeR1SZMw1ht0js0q+qUFuCsUloFk/Kcqy3P5zyfrfOBZ3o59tBE
         XtJ3S70O2EbG6nZ55MqDrhL924yYH3ZuQUi9pC7I5AQPk5NbQk5ABnlIfZQs++uIaAtN
         7MvyRguXCuWASxxWy+cGZA8J11kl8fbDdzyglpYSG4tREh2Z+UkmEVHvGBHRzUKhUQ0V
         GlEDuPZidM2w73HG00MCci24EvunQ04MCWgVWOP8/TD9z6UonCHZ2+LmunHz4cwYDBZJ
         ZJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842442; x=1684434442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xan2Rb4LxJqnkwR/5yCpJ+HY7/yGaonUOCUizXrIxSQ=;
        b=aj7dZZYZzq8exfsu8ye/H8gDKXSl17d2PycK+R8Wjpr6uE/rWojXx00hfVgOON2AFT
         o9c5l4Q15Ki3P9EXAKQ3FSB7xMuXFxbn8Lga+NC94vM1DYhCbczx/7dpdEXzD5WIDw7q
         CI+GB0iDIMfqIlZq6UjBvXUo67OwixkZDJF3uXgJjnwbspToda2WjX0n4WSnyv/O7P1M
         lWs5K6QKXRRlBRPf1yAy2iunWx9Dw1gwFZXPgZ+bJCM2BOUi6d9jARLc2KC6/RTz0NRJ
         Q2ZnSNXosOapXMmz+5nn34w9AJvSdOD/4RQ9RI6Gi5C0emTq93VBVW68fq2/BmSrlW3L
         iRLw==
X-Gm-Message-State: AAQBX9eiMLYH0YAbuF1Cab4/3eWXgOdZdtcM1qVabLixkdE2Pp3hM59Y
        gp4oG5Xvh/GOupVNsrlWysHk6DKzdaPT639ZwBvKUJBBIUtvsy5meFl1qQ==
X-Google-Smtp-Source: AKy350bn9N834mGRnTfxRB/1sg3Gi0LNYnU/cXaXt6pc2dTMoJKCLYPpBlnafBq3HfEmUa+rzRWnlZEJ5MyF4YEvvsY=
X-Received: by 2002:a05:6a20:1445:b0:f0:b6e3:90f2 with SMTP id
 a5-20020a056a20144500b000f0b6e390f2mr776981pzi.13.1681842441499; Tue, 18 Apr
 2023 11:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230407192717.636137-9-keescook@chromium.org> <202304080811.nYP4KpPZ-lkp@intel.com>
In-Reply-To: <202304080811.nYP4KpPZ-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 11:27:10 -0700
Message-ID: <CAKwvOd=T5ownFTe5+M23ZLSPM876_7WAx23GzNeGxkqwGTHERQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] fortify: Add KUnit tests for runtime overflows
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
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
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 7, 2023 at 5:33=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Kees,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kees/for-next/hardening]
> [also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus=
/master tip/x86/core v6.3-rc5 next-20230406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/kunit-to=
ol-Enable-CONFIG_FORTIFY_SOURCE-under-UML/20230408-032959
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git fo=
r-next/hardening
> patch link:    https://lore.kernel.org/r/20230407192717.636137-9-keescook=
%40chromium.org
> patch subject: [PATCH v2 09/10] fortify: Add KUnit tests for runtime over=
flows
> config: openrisc-randconfig-r034-20230405 (https://download.01.org/0day-c=
i/archive/20230408/202304080811.nYP4KpPZ-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/d212962ef7682ee16=
0bf38fa455475558f031759
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Kees-Cook/kunit-tool-Enable-CONF=
IG_FORTIFY_SOURCE-under-UML/20230408-032959
>         git checkout d212962ef7682ee160bf38fa455475558f031759
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dopenrisc olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dopenrisc SHELL=3D/bin/bash lib/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304080811.nYP4KpPZ-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from lib/fortify_kunit.c:28:
>    lib/fortify_kunit.c: In function 'strnlen_test':
> >> lib/fortify_kunit.c:412:31: warning: 'strnlen' specified bound 33 exce=
eds source size 32 [-Wstringop-overread]

If we expect to validate the runtime behavior of fortify, but using
constants that the compiler can check for readability in this test,
then we might need to use the
_Pragma/__diag infrastructure from include/linux/compiler_types.h to
disable -Wstringop-overread; or disable it at the makefile level.

>      412 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
>    include/kunit/test.h:584:38: note: in definition of macro 'KUNIT_BASE_=
BINARY_ASSERTION'
>      584 |         const typeof(left) __left =3D (left);                 =
                   \
>          |                                      ^~~~
>    include/kunit/test.h:776:9: note: in expansion of macro 'KUNIT_BINARY_=
INT_ASSERTION'
>      776 |         KUNIT_BINARY_INT_ASSERTION(test,                      =
                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/kunit/test.h:773:9: note: in expansion of macro 'KUNIT_EXPECT_=
EQ_MSG'
>      773 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>          |         ^~~~~~~~~~~~~~~~~~~
>    lib/fortify_kunit.c:412:9: note: in expansion of macro 'KUNIT_EXPECT_E=
Q'
>      412 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
>          |         ^~~~~~~~~~~~~~~
>    lib/fortify_kunit.c:359:14: note: source object allocated here
>      359 |         char buf[32];
>          |              ^~~
>    lib/fortify_kunit.c:414:31: warning: 'strnlen' specified bound 34 exce=
eds source size 32 [-Wstringop-overread]
>      414 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
>    include/kunit/test.h:584:38: note: in definition of macro 'KUNIT_BASE_=
BINARY_ASSERTION'
>      584 |         const typeof(left) __left =3D (left);                 =
                   \
>          |                                      ^~~~
>    include/kunit/test.h:776:9: note: in expansion of macro 'KUNIT_BINARY_=
INT_ASSERTION'
>      776 |         KUNIT_BINARY_INT_ASSERTION(test,                      =
                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/kunit/test.h:773:9: note: in expansion of macro 'KUNIT_EXPECT_=
EQ_MSG'
>      773 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>          |         ^~~~~~~~~~~~~~~~~~~
>    lib/fortify_kunit.c:414:9: note: in expansion of macro 'KUNIT_EXPECT_E=
Q'
>      414 |         KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
>          |         ^~~~~~~~~~~~~~~
>    lib/fortify_kunit.c:359:14: note: source object allocated here
>      359 |         char buf[32];
>          |              ^~~
>
>
> vim +/strnlen +412 lib/fortify_kunit.c
>
>    387
>    388  static void strnlen_test(struct kunit *test)
>    389  {
>    390          struct fortify_padding pad =3D { };
>    391          int i, end =3D sizeof(pad.buf) - 1;
>    392
>    393          /* Fill 31 bytes with valid characters. */
>    394          for (i =3D 0; i < sizeof(pad.buf) - 1; i++)
>    395                  pad.buf[i] =3D i + '0';
>    396          /* Trailing bytes are still %NUL. */
>    397          KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
>    398          KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
>    399
>    400          /* String is terminated, so strnlen() is valid. */
>    401          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf)), =
end);
>    402          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
>    403          /* A truncated strnlen() will be safe, too. */
>    404          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf) / =
2),
>    405                                          sizeof(pad.buf) / 2);
>    406          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
>    407
>    408          /* Make string unterminated, and recount. */
>    409          pad.buf[end] =3D 'A';
>    410          end =3D sizeof(pad.buf);
>    411          /* Reading beyond with strncpy() will fail. */
>  > 412          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
>    413          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
>    414          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
>    415          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
>    416
>    417          /* Early-truncated is safe still, though. */
>    418          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
>    419          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
>    420
>    421          end =3D sizeof(pad.buf) / 2;
>    422          KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
>    423          KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
>    424  }
>    425
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests



--=20
Thanks,
~Nick Desaulniers
