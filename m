Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A1C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Feb 2022 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiBQTC3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:02:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbiBQTC2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Feb 2022 14:02:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B218090D
        for <linux-hardening@vger.kernel.org>; Thu, 17 Feb 2022 11:02:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p14so9425724ejf.11
        for <linux-hardening@vger.kernel.org>; Thu, 17 Feb 2022 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ikRVBzBT/FT2DEDw+8BeKqhzPIo0bpn2iXDMO301p4=;
        b=qFy+upxzo8ujjI4h3pWNkOcceHresXDg4chqjvXmO1gJOLQHTOmQiJp9M5nXqQA0i6
         Y3AsL9Njs1xcoOEJDj02riua7dj8JMXn6+iHKCY4cpnREFJvlGan+/lVQTNvysmjIAp0
         B7vTNa07K6DD5yVU7uB21jCxB0K+s0VlSQe0dAM8bhWsdtCi4eaK+VhVcwMl5fMvqqxY
         MLhQChU0xlQdzq2e+4ypchsozEWXWcq7m+Oe1ZyA8wSCDIcqbDo0QEOPebT4SbhwBtQy
         9RmQ/FuXGoT2+ISuAQt1b3yLDoeaDwYp4j1sAq54DIjMiH9CRk5wG5q2nZi0QVUnNYS2
         uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ikRVBzBT/FT2DEDw+8BeKqhzPIo0bpn2iXDMO301p4=;
        b=fo4F29UgXCqElmZn3E4U7/aaeHDxJZFuqZHSdX0KAH6VnJ0IXZ3C1F8K5gv6DFSQRY
         C2Ms6YmdfCNrgLWSNx3Diuuf0R/xjKJO1Y3iAKXmCeCM71ncY/wMepV7Nk8R63zc1+yy
         wSp7vWKc8evJpZnisera/msEM2TnoceYfCv8SL4nHPeObvl3Xua+di6YXSCSgUKOgcqU
         am3Kt0SiRDSwKBG1zcxSYQxHOrRJuXTZkH1CcnIMAc2m4oq5kr8IMZUDPB7x1cyo7ipn
         xiA+sKXzQtmDJAZrQMs7jy2K/tyNHnOaLeZdkVvWhSneme3cUQ/h1jL3jIPge3v8R/VH
         3Eyw==
X-Gm-Message-State: AOAM531CsRpY5EI7ipnySXlWHf/sgnFATa+u5i8WFxPgTFLk0kXWmIPO
        yK8yDkWRE/PIXF9Q0jwjPKdResTFWYvyYXA+XhZw8g==
X-Google-Smtp-Source: ABdhPJyi9cQ8LbwZQgUUVctT0gJzfoA9B70Zeo1OeZWEXAfLo3b+lmQnPmAQzcOMYohHi1PnV3R1uS0lxC0Ac0YgBxc=
X-Received: by 2002:a17:906:ce23:b0:6cf:7203:ded6 with SMTP id
 sd3-20020a170906ce2300b006cf7203ded6mr3412467ejb.170.1645124531438; Thu, 17
 Feb 2022 11:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20220216224153.2242451-1-keescook@chromium.org>
 <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com> <202202170903.E39554DF@keescook>
In-Reply-To: <202202170903.E39554DF@keescook>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 17 Feb 2022 11:01:59 -0800
Message-ID: <CAGS_qxpQGcJJQ9qT-rEXO8Qo_vq5R0hhdHAtBMTSbBbyhas_wg@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 17, 2022 at 9:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 16, 2022 at 02:57:12PM -0800, Daniel Latypov wrote:
> > On Wed, Feb 16, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Convert overflow unit tests to KUnit, for better integration into the
> > > kernel self test framework. Includes a rename of test_overflow.c to
> > > overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
> > >
> > > $ ./tools/testing/kunit/kunit.py config
> > > ...
> > > $ ./tools/testing/kunit/kunit.py run overflow
> >
> > JFYI, you can run this as a one-liner via
> >
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> > CONFIG_KUNIT=y
> > CONFIG_TEST_OVERFLOW=y
> > EOF
> >
> > The above is taken from my own duplicate version of this patch
> > [1] https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/
>
> Ah-ha! I thought I remembered this conversion being proposed before but
> I totally failed to find it. Thank you! I'll compare/adjust this patch
> and add you as Co-developed-by.

There's a lot that's already identical line for line.
I think I pointed to all the places where they differed in any
meaningful way down below.
So you can probably save yourself the time of looking over.

And yeah, I vaguely remembered that Vitor had worked on it, but
somehow failed to find that as well.
Something about this test :)

>
> > > ...
> > > [14:33:51] Starting KUnit Kernel (1/1)...
> > > [14:33:51] ============================================================
> > > [14:33:51] ================== overflow (11 subtests) ==================
> > > [14:33:51] [PASSED] u8_overflow_test
> > > [14:33:51] [PASSED] s8_overflow_test
> > > [14:33:51] [PASSED] u16_overflow_test
> > > [14:33:51] [PASSED] s16_overflow_test
> > > [14:33:51] [PASSED] u32_overflow_test
> > > [14:33:51] [PASSED] s32_overflow_test
> > > [14:33:51] [PASSED] u64_overflow_test
> > > [14:33:51] [PASSED] s64_overflow_test
> > > [14:33:51] [PASSED] overflow_shift_test
> > > [14:33:51] [PASSED] overflow_allocation_test
> > > [14:33:51] [PASSED] overflow_size_helpers_test
> > > [14:33:51] ==================== [PASSED] overflow =====================
> > > [14:33:51] ============================================================
> > > [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> > > [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
> > >
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Vitor Massaru Iha <vitor@massaru.org>
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> >
> > Looks good to me, some minor nits/suggestions wrt KUnit usage.
> > Nice to see this test converted over!
>
> Thanks!
>
> > [...]
> > > index f6530fce799d..4cc27b9926a1 100644
> > > --- a/lib/test_overflow.c
> > > +++ b/lib/overflow_kunit.c
> > > @@ -1,9 +1,13 @@
> > >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> > >  /*
> > > - * Test cases for arithmetic overflow checks.
> > > + * Test cases for arithmetic overflow checks. See:
> > > + * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> > > + *     ./tools/testing/kunit/kunit.py config
> > > + *     ./tools/testing/kunit/kunit.py run overflow [--raw_output]
> > >   */
> > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > We can drop the pr_fmt now, I think
>
> My instinct is to leave these in place just so that anything weird that
> gets inlined and sneaks a pr_*() call into the code will have a
> meaningful prefix.

Ack, sounds good.
We've historically dropped it and assumed we'd use kunit_info() for
all the pr_*()'s we cared about.

But there's definitely concern that some macro might use it to print
an important and relevant message, hmm.
