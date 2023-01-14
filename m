Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC5C54EBE
	for <linux-hardening@archiver.kernel.org>; Sat, 14 Jan 2023 01:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjANBic (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 20:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjANBia (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 20:38:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924D89BE8
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 17:38:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bj3so20863846pjb.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FufgUw2fqlY7QEwBJBytXvOldn4bZyfyqwhzJKALwe4=;
        b=LGjFLFVeQhyilSeBgpCX9oTZDmyJqsHWZniAk5sh+ZIa9/79Tp5cwxJc77KX6rkd6p
         Mf26WNrxRFxQOt8fr5AChIfbhCglt2LnkzNZE7ZwvnArzQT6oIf3Ui9Hju8CcnNCpuAA
         +MPTgpVlmQGpE758bzgDjBlISrvuaDZXpo32k+KuTk/LsDz852zLdtlFRuPbc2dDQToY
         pg7GTuZKGQt0ht9HVPH/lB5yBHnpJdUzCARLYxkEycHH8tNQsAwW8q8ydrVFdUy5adfY
         hetKp2YWriDyhM861MHEG9OZYOPB3mCUjFuDjADJVZ2wjTcvwpn0J56nCJV/rzka6A2I
         qdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FufgUw2fqlY7QEwBJBytXvOldn4bZyfyqwhzJKALwe4=;
        b=2JxDKADEWEI6eejZdppRjamkPZDQ21KxuXC13D/j3siMQqKLsxrIV8qoJ96dnzBQ56
         8NpSv+xUzuBM3/NRFm+ro87vsrn46iodyFid78mxEvwx5Mt2RmdqcenullzL+xaBQBiC
         cTyg1hjhyER8n3HQx1FaQpc/ehylQq2+NQW5sPtD2B1MTvJe+3YNnqyccDJCvHo3/Uh9
         kHapWBCxQG6VmTTJAtSkLj9ZtJiNiW1DbYmUrR9pcJ4YGF0XL+GCQxct7xaWdH+g5Enl
         v9gjkkWP5LnDphOF61cE6yTt5J3wK8p194YhH73eygOWnMIIsZaUw+l56Nwa7RwgeV6W
         DudA==
X-Gm-Message-State: AFqh2krBRkKGYEks4YvjlU6i/dd0Aza9pPr34yPiqPBN/giRbnteGfjK
        NEIPHW2e9sbLQQzuaekJ6BEhTjTRcB62t2r7+LzeTA==
X-Google-Smtp-Source: AMrXdXvgVMPaadk3FjzCg9dQFfBrULyf1BBRFZGq3lUy7NI9a2lpX1LWoLxvWNTcTSPuEhjIW7mrcQOny0palWCm1qI=
X-Received: by 2002:a17:903:292:b0:189:9973:fb58 with SMTP id
 j18-20020a170903029200b001899973fb58mr156924plr.59.1673660308451; Fri, 13 Jan
 2023 17:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20230114005408.never.756-kees@kernel.org>
In-Reply-To: <20230114005408.never.756-kees@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 Jan 2023 17:38:17 -0800
Message-ID: <CAGS_qxoeKishaVvHk-HCvstWJrZ8gXRrQipGd-sz=ONrPjteZw@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 13, 2023 at 4:54 PM Kees Cook <keescook@chromium.org> wrote:
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..5a545e1b5dbb 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>         }
>  }
>
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +               return -EBUSY;

Note: kunit_skip() here means you don't need explicit returns in the test cases.
kunit_skip() is basically
  kunit_mark_skipped(test, "reason");
  kthread_complete_and_exit(...);

So the diff in this file could be reduced down to just these 2 lines
  if (!IS_ENABLED(...))
      kunit_skip(test, "...")

But I can see the appeal of being more explicit about the control flow.
In that case, you could switch kunit_mark_skipped(), which just sets
the status and doesn't affect control flow at all.

Daniel
