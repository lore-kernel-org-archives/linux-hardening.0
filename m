Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B33ECAAA1
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 02:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGChA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Sep 2022 22:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGCg7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Sep 2022 22:36:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF0E91D1C
        for <linux-hardening@vger.kernel.org>; Tue,  6 Sep 2022 19:36:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so18151999wri.13
        for <linux-hardening@vger.kernel.org>; Tue, 06 Sep 2022 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JGQk4Yytf6Zg4zT4gEe/PL2ZkzZ8fPqkUsY9qVM+pqs=;
        b=RbYSUwdDs2C68JbvIHxEXs2vUhp1qhiqoa4K/9IEZcZonH3tlSWdevFewCl22OlVDS
         5aQxIEpvxo7MQfQuTxDjyq/vIFITZWPawPLV2tqEM+NS73R4MEuESsG8QQjvTELCnnDI
         f/fbQDc6sPrGu3BX2TPwjq5fZH3Hkxm57BdLCN+vJbKgTPDnEh0ui39pcfGGQl2uKlPQ
         SCstofc0gxWJc07XVhSNvl27saMWn2qfqpc7YhXJOmMYe+ac+IIg08XGNirQ/hx/xLA9
         ElMUMPoONnipjWdoorq49p0aYn0ucwAWu82x8w1DcplDou/pOulAYciYHk3fK4gWNOIM
         Fe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JGQk4Yytf6Zg4zT4gEe/PL2ZkzZ8fPqkUsY9qVM+pqs=;
        b=Mq9Zqwupix+p1b+g5TBFLIDWKuqO1DLHK2i8YYpFSZLFHPUtRda0/rA0zD27O9T6MY
         CChjIECeIEbJM6XzqrgAq5DJ3JUXqfWJ1/fPCKT9ViH3Qk0oY3onQaOKhSCwP3c3QMnv
         PdsNx1JrFoCrzDx0QzXdhO1MhZVCj4un5yJd32PLXdQUw/VQxTXeMQLB6xWKdewPjoBS
         7DgCzo7oY3lpr9ZYwBToFtNVfXEOj48gmz4KbkOX0epftAUvCpu1iauJ4jdSlh1FTDe8
         w8kh7y0QlzDL7m2sYqDoBremThX+0yAxl/q5Vs8+Xmt9PbsEhNmRV/63MBsxC9TVauBj
         bwSA==
X-Gm-Message-State: ACgBeo2Ze2Q/LBz5YSBwp2PLrynoaTKT0mIfd1MQLAcd2qiTJhQAL3xe
        QSGv8w5Arqp4Be6+cK6s37sulumKPbxbGbbG8QbJaw==
X-Google-Smtp-Source: AA6agR6ZHmV5opBNE6+QYR8MCxikmETVbfAhDyULrVR6PaJX8J7kUYKWe3MS1oGyiPTUmdDCEW8xNpH+HI1qsoLZrZs=
X-Received: by 2002:a5d:6084:0:b0:228:67c1:e160 with SMTP id
 w4-20020a5d6084000000b0022867c1e160mr597899wrt.83.1662518217295; Tue, 06 Sep
 2022 19:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220902204351.2521805-1-keescook@chromium.org> <20220902204351.2521805-2-keescook@chromium.org>
In-Reply-To: <20220902204351.2521805-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Sep 2022 19:36:46 -0700
Message-ID: <CAKwvOdmeaUQYkd9kZPgwK0kK5BRxFi8aszyFzw8TA4JFF6y8EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 2, 2022 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Co-developed-by: Nick Desaulniers <ndesaulniers@google.com>

That's overly generous of you!

Anyways, the disassembly LGTM and the bot also came back green.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Android Treehugger Robot
Link: https://android-review.googlesource.com/c/kernel/common/+/2206839

Another thought, Nikita suggested that you could also compare mode 1 vs mode 3:
https://github.com/llvm/llvm-project/issues/57510#issuecomment-1235126343

That said, since mode 3 returns 0 for "unknown" I'd imagine that
wouldn't be pretty since it wouldn't be a direct comparison against
__p_size.

Thanks again for the patch!

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index eed2119b23c5..07d5d1921eff 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -19,7 +19,8 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
>         unsigned char *__p = (unsigned char *)(p);              \
>         size_t __ret = (size_t)-1;                              \
>         size_t __p_size = __builtin_object_size(p, 1);          \
> -       if (__p_size != (size_t)-1) {                           \
> +       if (__p_size != (size_t)-1 &&                           \
> +           __builtin_constant_p(*__p)) {                       \
>                 size_t __p_len = __p_size - 1;                  \
>                 if (__builtin_constant_p(__p[__p_len]) &&       \
>                     __p[__p_len] == '\0')                       \
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
