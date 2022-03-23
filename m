Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC0C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiCWTqF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiCWTqF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 15:46:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A178B6D1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 12:44:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so4930433ejc.12
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZIZzGdhOBGnHsioqyqxuLJwlYwQ7qfyB2kjkqeiq3s=;
        b=CtqyObMmDlU23CSgP6R8nQ3gK6/rQApKY3UEiUKCH+xgsNI+NGkEXoMmrXmHwu0P6e
         ZWFF6M0WFoA8uxqCq0OG2PX7LOiRghl9yPG2Qs5VWBlH5JRlFG97COQK/jWrYjx84p/i
         tr5Uii7gbuwne8QicIYBIT4NGnm4i1+7qSD/DsiBtG+nXGLi9fkpWGNT7K/3aH3CpzCw
         a3MvBxOVU1wl15OPKjACx0DgWHECMLY94TEuOUUYnJmwVz2rTTuTWPT/Nejr8HaJ49NW
         pZSc3O1wJcgelD3+ig/i12z14cSS74lU/hQYN8s084wVqIme5ceUqWpvj9VaRT2j0jlo
         N7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZIZzGdhOBGnHsioqyqxuLJwlYwQ7qfyB2kjkqeiq3s=;
        b=UmunIS4ha7pTTGB5wl3FLsYTowJFweyFNo+R+K8OeftIGYQTRZuBPl/SWGWqPilzxX
         gohyHem4G6FRRDKuvqgbYkw8jyGv0O8uEK1utHZQs+rF8EkoXEbgwlEaEjGEtQQ8S4gh
         tysirdR8Wg0yyFjcZYbqbVDDXKkMCklMsY6b02lIoOjzHMukO0kqD6mHqtjoaEToYNH+
         rQ0w+UeVizLjx5ySrgLN97Mo/aM/Wf9zFXu9u2DbBKeUiNa+N8cXVEtlTCFeN/emgHIw
         KOnnpZtBLaONvkRiQ6jP7BfkfZv9s4xEBmEhmORFCO3Q6WBm5ufoPFBmASlcXaDk7M7x
         0tNA==
X-Gm-Message-State: AOAM532rJkLfNRCx3P8IyaHL66HPn3HBCoLbt+TbNUjedCycbx1c13ld
        sI0UorI1wdFSX6942gH23h1s/HcAfF8cjLqUb5mnPw==
X-Google-Smtp-Source: ABdhPJz4jxF/bm3E54bJWRyAPii01eE5PlipdUE56ZR8yJ9uBi7HSRmf5LuCDPVuXVb0finliKSn8u5Ox3I+76D3/F4=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr1791769ejc.631.1648064673092; Wed, 23
 Mar 2022 12:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220224054825.1853314-1-keescook@chromium.org> <20220323151933.GA1363768@roeck-us.net>
In-Reply-To: <20220323151933.GA1363768@roeck-us.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 23 Mar 2022 14:44:22 -0500
Message-ID: <CAGS_qxrmfVppcaT0-q3=uh46NzS9tkTcEFtgE2_54rD_kE-3QA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: overflow: Convert to Kunit
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 23, 2022 at 10:29 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Wed, Feb 23, 2022 at 09:48:25PM -0800, Kees Cook wrote:
> > Convert overflow unit tests to KUnit, for better integration into the
> > kernel self test framework. Includes a rename of test_overflow.c to
> > overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
> >
>
> This patch results in lots of test build failures
> due to large frame sizes.
>
> Building i386:allyesconfig ... failed
> --------------
> Error log:
> lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
> lib/overflow_kunit.c:644:1: error: the frame size of 2480 bytes is larger than 2048 bytes

This is somewhat expected and should hopefully be fixed soon.


More detail:
Unless optimized away by the compiler, each KUNIT_EXPECT_* use will
add a struct to the stack.
I have a number of pending patches that will decrease that stack usage.
On UML (x86_64), they cut it down from 88 bytes => 32 bytes per
KUNIT_EXPECT_EQ/GT/etc.

Shuah sent a PR to Linus which contains these patches,
https://lore.kernel.org/all/d138a93a-997f-bfb6-6119-83aa2c00a49d@linuxfoundation.org/
Once those are in, hopefully all these warnings go away as we're not
over the 2048 limit by that much.

Daniel
