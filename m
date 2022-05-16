Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DBC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiEPLQU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbiEPLQS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 07:16:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5163E5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 04:16:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v4so17658643ljd.10
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ltURKW8gvbadTPdBR99MO1ZYVrXD44ckRO80E//PPJI=;
        b=EyP2QsX4G+DdHVs2wWffX4Ijt2YetlVRQxSeh12G/bUeDnrNuyxYVntYH9yqb3TH1K
         VAGfQnmmMSav5oJxMmOB8XW7NjlrEuy4igrHjIrLgkC901y/c5PQsjFy1m7bAtToSynr
         3nQBYS+dSv2AxMonV8rNSQtCRbDRmO68DaMRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ltURKW8gvbadTPdBR99MO1ZYVrXD44ckRO80E//PPJI=;
        b=4M+fRpOpmCpEqeHb8nfTm+swRY61/f6XJmZXZIX+52jnAC5M9ZCHpOMfPgkHiC598f
         K1gdqO4S8W8CjEqExZ5kPxqVOvrSPhLCEZL8KbdipSGTpMbCfTQ6OUVnxmXkDrcKifkG
         RRn9OUNbQngkuHxn/VJJeqhqcyItIbuETo042ssBLhAGYjD6xuaP3ktqquwwlpc80lZf
         7p84IwChzSM0QmoBv2WZSf1jv0VOSaKLLlXNT/pgkYB6ZYS4Rn0PMAV+uBhDh0aGVdgp
         waZHCGe1tlRhtUrFVNk4u6Oxk+fyJN735X/jVW0uN4IeLpAn9/FeTHePmYHbcJB9oQFL
         1VOA==
X-Gm-Message-State: AOAM5317ZX4lu6+SSX8txh2hQw12orVAvAnpK/4CVVdmDBTM+octjYHY
        g1pHBHddeDky5clxz8GxtgfL1w==
X-Google-Smtp-Source: ABdhPJywKeCUSJE/2pGhaU0NCO0q5MemgsrruYo6Q2m0bZAqygT4yu3cTvoPROEtejkGKGdjULT93w==
X-Received: by 2002:a2e:9616:0:b0:250:80ec:2418 with SMTP id v22-20020a2e9616000000b0025080ec2418mr11109326ljh.359.1652699774703;
        Mon, 16 May 2022 04:16:14 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l5-20020ac25545000000b0047255d2111esm1280835lfk.77.2022.05.16.04.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 04:16:13 -0700 (PDT)
Message-ID: <6f55c3f0-7c10-1697-17da-79b4807c2498@rasmusvillemoes.dk>
Date:   Mon, 16 May 2022 13:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
Content-Language: en-US
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220511174531.1098548-1-keescook@chromium.org>
 <5304dada-51d2-e955-b620-c5c97f3b0dbd@rasmusvillemoes.dk>
In-Reply-To: <5304dada-51d2-e955-b620-c5c97f3b0dbd@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 12/05/2022 14.10, Rasmus Villemoes wrote:
> On 11/05/2022 19.45, Kees Cook wrote:
>> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
>> systems; the types exist there too. Remove the #ifdefs.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
>> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> 
> The patch is fine, but I disagree with that Fixes tag. Back then, i.e.
> when the overflow checkers were implemented via macros on old enough
> compilers, they simply didn't work for 64 bit types (because of the
> usual 64 bit division problems) - so anybody trying to use the multiply
> overflow checker, including of course the test suite, would get a build
> error on old compilers. You yourself did that: "[kees: add output to
> commit log, drop u64 tests on 32-bit]"
> 

And if you want something that can be backported, getting rid of that
"defined but unused" warning while also enabling checking of the
overflow fallbacks that were actually usable (the add and sub ones), you
could do a two-step thing, the first step being something like
(completely untested)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 475f0c064bf6..f46c0f6e26c4 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -236,8 +236,10 @@ static void do_test_ ## t(struct kunit *test, const
struct test_ ## t *p) \
        check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
        check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
        check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
-       check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);   \
-       check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);   \
+       if (BITS_PER_LONG == 64 || sizeof(t) < 8) {                     \
+               check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod,
p->p_of); \
+               check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod,
p->p_of); \
+       }                                                               \
 }                                                                      \
                                                                        \
 static void t ## _overflow_test(struct kunit *test) {                  \
@@ -255,10 +257,8 @@ DEFINE_TEST_FUNC(u16, "%d");
 DEFINE_TEST_FUNC(s16, "%d");
 DEFINE_TEST_FUNC(u32, "%u");
 DEFINE_TEST_FUNC(s32, "%d");
-#if BITS_PER_LONG == 64
 DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
-#endif

 static void overflow_shift_test(struct kunit *test)
 {

and then in a second, not-for-backporting, patch remove that if() again.

Rasmus
