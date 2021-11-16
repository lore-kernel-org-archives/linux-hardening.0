Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C23C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Nov 2021 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FD061BF5
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Nov 2021 14:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhKPONh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhKPONg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Nov 2021 09:13:36 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0552C061570;
        Tue, 16 Nov 2021 06:10:39 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h2so20471129ili.11;
        Tue, 16 Nov 2021 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/UEt3LXFYRGol9LnZjoBsvjbD91zGyozW9PiMcjgf0=;
        b=o5UmTOXKA65tzr3sMzbcDq563C2rXE/lBvpcrCHhReu4wZxYiEBpOhkq5XzxDzTdyn
         uiz2fnRi8F3kW8UqfVkRjPMfBNQAYf8Aol9xeDhVSPQUjgNCab3Z0SOvHwW4P0ovEiqL
         AuUW7UwtzH6zO42W8W+jJ26ffQ0G7LBpR1cCK7gA6duyqvUAfAc+tiLk/Bd0foV/meIO
         8zGj3vlkOo71fm9q6+IRvfuzDh9W8hYJSsFbErC/33i+90P4trAXX1iIXXQk72Z07Yt2
         IKtao8WVZhpFd4DsULHXJn3q/qjrZlFdN9/z/jAyp/weyd55bv+/VIGeYnN3568ZDaQl
         K20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/UEt3LXFYRGol9LnZjoBsvjbD91zGyozW9PiMcjgf0=;
        b=pfmfasZjmd5zcHkoQXeHChkW78uLMK5RdUOmA8JsME/OrK3k1cl7Y3CyddWKfemi7l
         gj9jjKGoHx7H9OmYN/bF0OMmMJjli0k1m/5hM2yvIEiTBHTntUMTLl1J1AXb4QRB7lnr
         xgseaWhVqmVCSiUF2FDu7NAA63ai8I9qp3BIEkSInJoLT4ej6uDZp193K6yoiXrIOdeW
         Hu5yKslJb8n0505jlzdouxOoNl0MoX69kxvf8fTsM+2s2UJZoQllEzUmwAOsc5FkIx/o
         YDSw0DmjJA/6Vmm/EQ7LUu5CP48nldVF892ALaQdA8G8GbzIgCl8RPxYINdqughRKS47
         9nTA==
X-Gm-Message-State: AOAM533yRFB210fDoHS7pBVlZerctQ1OKa0XVsIj+Mi3UOlOABCPAudw
        539dzDo55U+vnccO7xA8kmMZZtCJ3PXrxhhG4Is=
X-Google-Smtp-Source: ABdhPJz66c5fvd9boDQLu+2/Phx8msnTwkVmy2kGrvo652sefGuia5YaUinvm6SdqqX4xEk8wQ+a2lr8s+Ys7HUXBUY=
X-Received: by 2002:a05:6e02:15c9:: with SMTP id q9mr4825161ilu.28.1637071839309;
 Tue, 16 Nov 2021 06:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20211116004111.3171781-1-keescook@chromium.org>
In-Reply-To: <20211116004111.3171781-1-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 16 Nov 2021 15:10:28 +0100
Message-ID: <CA+fCnZcZ0eCPEjaLoQWc5a7pVHDKzYLL9ZbOQXv4wE5qA1NwoQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Silence intentional read overflow warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 16, 2021 at 1:41 AM Kees Cook <keescook@chromium.org> wrote:
>
> As done in commit d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
> for __write_overflow warnings, also silence some more cases that trip
> the __read_overflow warnings seen in 5.16-rc1[1]:
>
> In file included from /kisskb/src/include/linux/string.h:253,
>                  from /kisskb/src/include/linux/bitmap.h:10,
>                  from /kisskb/src/include/linux/cpumask.h:12,
>                  from /kisskb/src/include/linux/mm_types_task.h:14,
>                  from /kisskb/src/include/linux/mm_types.h:5,
>                  from /kisskb/src/include/linux/page-flags.h:13,
>                  from /kisskb/src/arch/arm64/include/asm/mte.h:14,
>                  from /kisskb/src/arch/arm64/include/asm/pgtable.h:12,
>                  from /kisskb/src/include/linux/pgtable.h:6,
>                  from /kisskb/src/include/linux/kasan.h:29,
>                  from /kisskb/src/lib/test_kasan.c:10:
> In function 'memcmp',
>     inlined from 'kasan_memcmp' at /kisskb/src/lib/test_kasan.c:897:2:
> /kisskb/src/include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   263 |                         __read_overflow();
>       |                         ^~~~~~~~~~~~~~~~~
> In function 'memchr',
>     inlined from 'kasan_memchr' at /kisskb/src/lib/test_kasan.c:872:2:
> /kisskb/src/include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   277 |                 __read_overflow();
>       |                 ^~~~~~~~~~~~~~~~~
>
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/14660585/log/
>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Fixes: d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/test_kasan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 67ed689a0b1b..0643573f8686 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -869,6 +869,7 @@ static void kasan_memchr(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_ptr_result = memchr(ptr, '1', size + 1));
>
> @@ -894,6 +895,7 @@ static void kasan_memcmp(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         memset(arr, 0, sizeof(arr));
>
> +       OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_int_result = memcmp(ptr, arr, size+1));
>         kfree(ptr);
> --
> 2.30.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
