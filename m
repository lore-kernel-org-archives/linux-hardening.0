Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B6C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Sep 2022 21:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiI2VCU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI2VCT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Sep 2022 17:02:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076081432AF
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 14:02:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u12so2471400pjj.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yPbVFvVuRribQUu7HCsJ3swo023fEVuPKRX1doGnSnU=;
        b=j5F/q7V32C5y6cRe71oqYgPbFIBfPnFjhUzGApadrldXKKgLMLTnmS9Y9CA5IL8yGk
         3tLOvMaHPVzc6MSUGaw+b63UEE6wQ2pT8z19XpPI0S5g17oXKGm1NgJm9n4tCfP9/u5t
         fbPAbQ3vn328rP6MdkgNTjUrfzMQQhXXebzFFNjkI/xBEHwifWZ5UWkzeGjoW6zLQL61
         fYVWryMywux0hCby1CCYb0uBsvQXAGOGEvjnuPujpzcvYe7S4G8hcl1qOLjUiEb3vNWR
         tL+x3CGH+CRB1KBOaQrtK/fI6IKJHRp8r5tc7SMAiZshFnVedCwkAVeq5lbumW/iBRvZ
         TvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yPbVFvVuRribQUu7HCsJ3swo023fEVuPKRX1doGnSnU=;
        b=W/7T6nXhHfC+guRGJ0XM5T32B7t9LILEyFNh+sVAXhGfwJLdNjBpuGu76iApPPoXja
         BJIy/EUt7fenjQZwexQch+2RiJ5pFA4RGX3tKsnBjdbrMJ3QhZmddh2OOylxHCNDUFsO
         PldrPwJtze7BELvKCDyJsL/W53ThjKsx67XRj172TBmqp3GWCcdrovntkuPa4VZ0/JFq
         SiK+INHhh1MdSR+Q04bAW0lcNoSRX1jXSmlikSAMPiPEFFr1rjEUIEjh89Q3zb7W4LpK
         f8AbyBt/JzeZXthd1anlg+Ad1z+bWfsiGEooTGWlhH7+ECBp6hhUtwnzXPWfRICBlnb1
         eawQ==
X-Gm-Message-State: ACrzQf0uLYMJeuYk0y3l0oYn+WL1Tmo4DjOXA+EfkrmUtnIkNLSYCvk/
        MzSe112ss3kayX4MuadS/PubcbpGX6acC+kFrn/JUiIqJLE+fw==
X-Google-Smtp-Source: AMsMyM5Wq5ao//n36pkk79Wf5asvLjZc9F9fNUOoymhjQFjFftabB0dehgHCQYb+9vv5OdOP9ttUwpc+nXZD9VjIz1o=
X-Received: by 2002:a17:902:e74d:b0:178:796c:e1b7 with SMTP id
 p13-20020a170902e74d00b00178796ce1b7mr5101087plf.33.1664485337061; Thu, 29
 Sep 2022 14:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220929030846.1060818-1-keescook@chromium.org>
In-Reply-To: <20220929030846.1060818-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Sep 2022 14:02:05 -0700
Message-ID: <CAKwvOd=aCGPP54qxoO4-K8MDBB8VEmXpUdo156FiBVxkpdxirg@mail.gmail.com>
Subject: Re: [PATCH] kunit/memcpy: Adding dynamic size and window tests
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 28, 2022 at 8:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> The "side effects" memmove() test accidentally found a corner case in
> the recent refactoring of the i386 assembly memmove(), but missed
> another corner case. Instead of hoping to get lucky next time, implement
> much more complete tests of memcpy() and memmove() -- especially the
> moving window overlap for memmove() -- which catches all the issues
> encountered and should catch anything new.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/lkml/CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Regardless of my comments, I ran this through:

$ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy --make_options LLVM=1
$ ./tools/testing/kunit/kunit.py run --arch=arm64 memcpy --make_options LLVM=1
$ ./tools/testing/kunit/kunit.py run --arch=arm memcpy --make_options LLVM=1
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 memcpy --make_options LLVM=1
All were green for me.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Do you have any thoughts on the test in my v4 wrt. potential for
conflicts in -next?
https://lore.kernel.org/lkml/20220928210512.642594-1-ndesaulniers@google.com/
It looks like even without this patch of yours,
$ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy --make_options LLVM=1
demonstrates the bug in my v3.

I also tested my v4 on top of this change with the above command line;
it passes. :)

> ---
>  lib/memcpy_kunit.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
>
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 2b5cc70ac53f..f15daa66c6a6 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -270,6 +270,190 @@ static void memset_test(struct kunit *test)
>  #undef TEST_OP
>  }
>
> +static u8 large_src[1024];
> +static u8 large_dst[2048];
> +static const u8 large_zero[2048];
> +
> +static void init_large(struct kunit *test)
> +{
> +       int failed_rng = 0;
> +
> +       /* Get many bit patterns. */
> +       get_random_bytes(large_src, sizeof(large_src));

I know sizeof == ARRAY_SIZE when we have an array of u8, but please
consider using ARRAY_SIZE.

> +
> +       /* Make sure we have non-zero edges. */
> +       while (large_src[0] == 0) {
> +               get_random_bytes(large_src, 1);
> +               KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
> +                                   "Is the RNG broken?");
> +       }
> +       while (large_src[sizeof(large_src) - 1] == 0) {
> +               get_random_bytes(&large_src[sizeof(large_src) - 1], 1);
> +               KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
> +                                   "Is the RNG broken?");
> +       }

The above duplication could probably be separated out into another
static function where you pass in the address of the array element to
set to non-zero.

> +
> +       /* Explicitly zero the entire destination. */
> +       memset(large_dst, 0, sizeof(large_dst));
> +}
> +
> +/*
> + * Instead of an indirect function call for "copy" or a giant macro,
> + * use a bool to pick memcpy or memmove.
> + */
> +static void copy_large_test(struct kunit *test, bool use_memmove)
> +{
> +       init_large(test);
> +
> +       /* Copy a growing number of non-overlapping bytes ... */
> +       for (int bytes = 1; bytes <= sizeof(large_src); bytes++) {
> +               /* Over a shifting destination window ... */
> +               for (int offset = 0; offset < sizeof(large_src); offset++) {
> +                       int right_zero_pos = offset + bytes;
> +                       int right_zero_size = sizeof(large_dst) - right_zero_pos;
> +
> +                       /* Copy! */
> +                       if (use_memmove)
> +                               memmove(large_dst + offset, large_src, bytes);
> +                       else
> +                               memcpy(large_dst + offset, large_src, bytes);
> +
> +                       /* Did we touch anything before the copy area? */
> +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst, large_zero, offset), 0,
> +                                           "with size %d at offset %d", bytes, offset);
> +                       /* Did we touch anything after the copy area? */
> +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
> +                                           "with size %d at offset %d", bytes, offset);
> +
> +                       /* Are we byte-for-byte exact across the copy? */
> +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst + offset, large_src, bytes), 0,
> +                                           "with size %d at offset %d", bytes, offset);
> +
> +                       /* Zero out what we copied for the next cycle. */
> +                       memset(large_dst + offset, 0, bytes);
> +               }
> +               /* Avoid stall warnings. */
> +               cond_resched();

I'm just curious what that is? ^
Should it go in the inner loop?

> +       }
> +}
> +
> +static void memcpy_large_test(struct kunit *test)
> +{
> +       copy_large_test(test, false);
> +}
> +
> +static void memmove_large_test(struct kunit *test)
> +{
> +       copy_large_test(test, true);
> +}
> +
> +/*
> + * Take a single step if within "inc" of the start or end,
> + * otherwise, take a full "inc" steps.

I still have a hard time following what this logic is doing,
particularly the clamping to 1. Can you elaborate more in this
comment?

> + */
> +static inline int next_step(int idx, int start, int end, int inc)

Please drop the inline keyword here.

> +{
> +       start += inc;
> +       end -= inc;
> +
> +       if (idx < start || idx + inc > end)
> +               inc = 1;
> +       return idx + inc;
> +}
> +
> +static void memmove_overlap_test(struct kunit *test)
> +{
> +       /*
> +        * Running all possible offset and overlap combinations takes a
> +        * very long time. Instead, only check up to 128 bytes offset
> +        * into the destintation buffer (which should result in crossing

typo: s/destintation/destination/

> +        * cachelines), with a step size of 1 through 7 to try to skip some
> +        * redundancy.
> +        */
> +       static const int offset_max = 128; /* sizeof(large_src); */

I thought large_src was 1024? Perhaps this comment is stale or
contradictory to the comment in the block above the variable
definition?

> +       static const int bytes_step = 7;
> +       static const int window_step = 7;
> +
> +       static const int bytes_start = 1;
> +       static const int bytes_end = sizeof(large_src) + 1;
> +
> +       init_large(test);
> +
> +       /* Copy a growing number of overlapping bytes ... */
> +       for (int bytes = bytes_start; bytes < bytes_end;
> +            bytes = next_step(bytes, bytes_start, bytes_end, bytes_step)) {
> +
> +               /* Over a shifting destination window ... */
> +               for (int d_off = 0; d_off < offset_max; d_off++) {
> +                       int s_start = max(d_off - bytes, 0);
> +                       int s_end = min_t(int, d_off + bytes, sizeof(large_src));
> +
> +                       /* Over a shifting source window ... */
> +                       for (int s_off = s_start; s_off < s_end;
> +                            s_off = next_step(s_off, s_start, s_end, window_step)) {

Might a while loop with a distinct update statement look cleaner than
a multiline for predicate?

> +                               int left_zero_pos, left_zero_size;
> +                               int right_zero_pos, right_zero_size;
> +                               int src_pos, src_orig_pos, src_size;
> +                               int pos;
> +
> +                               /* Place the source in the destination buffer. */
> +                               memcpy(&large_dst[s_off], large_src, bytes);
> +
> +                               /* Copy to destination offset. */
> +                               memmove(&large_dst[d_off], &large_dst[s_off], bytes);
> +
> +                               /* Make sure destination entirely matches. */
> +                               KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[d_off], large_src, bytes), 0,
> +                                       "with size %d at src offset %d and dest offset %d",
> +                                       bytes, s_off, d_off);
> +
> +                               /* Calculate the expected zero spans. */
> +                               if (s_off < d_off) {
> +                                       left_zero_pos = 0;
> +                                       left_zero_size = s_off;
> +
> +                                       right_zero_pos = d_off + bytes;
> +                                       right_zero_size = sizeof(large_dst) - right_zero_pos;
> +
> +                                       src_pos = s_off;
> +                                       src_orig_pos = 0;
> +                                       src_size = d_off - s_off;
> +                               } else {
> +                                       left_zero_pos = 0;
> +                                       left_zero_size = d_off;
> +
> +                                       right_zero_pos = s_off + bytes;
> +                                       right_zero_size = sizeof(large_dst) - right_zero_pos;
> +
> +                                       src_pos = d_off + bytes;
> +                                       src_orig_pos = src_pos - s_off;
> +                                       src_size = right_zero_pos - src_pos;
> +                               }

Looking at the arms of these branches, I see a fair amount of
duplication. Mind deduplicating some of the statements here? The
assignments of left_zero_pos and right_zero_size look invariant of the
predicate.

> +
> +                               /* Check non-overlapping source is unchanged.*/
> +                               KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[src_pos], &large_src[src_orig_pos], src_size), 0,
> +                                       "with size %d at src offset %d and dest offset %d",
> +                                       bytes, s_off, d_off);
> +
> +                               /* Check leading buffer contents are zero. */
> +                               KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[left_zero_pos], large_zero, left_zero_size), 0,
> +                                       "with size %d at src offset %d and dest offset %d",
> +                                       bytes, s_off, d_off);
> +                               /* Check trailing buffer contents are zero. */
> +                               KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
> +                                       "with size %d at src offset %d and dest offset %d",
> +                                       bytes, s_off, d_off);
> +
> +                               /* Zero out everything not already zeroed.*/
> +                               pos = left_zero_pos + left_zero_size;
> +                               memset(&large_dst[pos], 0, right_zero_pos - pos);
> +                       }
> +                       /* Avoid stall warnings. */
> +                       cond_resched();
> +               }
> +       }
> +}
> +
>  static void strtomem_test(struct kunit *test)
>  {
>         static const char input[sizeof(unsigned long)] = "hi";
> @@ -325,7 +509,10 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
> +       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_test),
> +       KUNIT_CASE(memmove_large_test),
> +       KUNIT_CASE(memmove_overlap_test),
>         KUNIT_CASE(strtomem_test),
>         {}
>  };
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
