Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519953;
	b=WEON9oEQ+lVa5it4r6LuGt0XzplGnT7ienIPB9aQSforO7R4e3H6WWrksWFjU8urf5HO
	 uVsWTE+iX9Ko9/ApaNna3A8qqlLUvwRRW3SOHK5ktQeLJhguhMeWLJv8jLluyUD0x0Eo6
	 fEba+YupeIZhB3oVG4t5Sg4SX8vdJQ7yNLsqug/UE/mP6+KResq2KK/Z67qdU4BxkFs3P
	 D43I+Xa5tZmdvXsa9CmEEr4fVD8S0mi74pHYJZlg6PZO9aBtSs5efwIlO9E6nOChOyDKl
	 dfSAaPYOo/ZP/nSpgnsiiF7aohiIj0JEyryreBgQD8wTj1UowKMwmOQFaGf2Qdfl0PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Q0IBvTQMEWBs8o9DTQ9g44FzT6wyIyEPpp62Eq3IeX4=;
	b=GkGNDQ/r/e3/MsKG+/bMqLsKmHFtIt7RKeOMPswYq8AGdFe0DCqfdnUEacuicq3LzQ90
	 VJdv73L4MRkR+atH6QqLlqGkVV7N/JqcB3+RmleNIvyqyfeA9bUetC4dxpI5aG25+Swp+
	 jgAwGvFGEWtQFLPRM8gPSSD8JYffD5winYQ5tFJFN/As6ebS9CoOKE8gpPrYHddS2eoAf
	 j4TNrLJ4PMNMbN0Nq+wXW3D9yaNUAPT7D7R0gWCZ4cByvS/imTIAYnLQ/57/SQSSUzg9T
	 I00fh8l7RdOj803CXCu5O70DuV6wqJwh9PoX++2H3tiwe0WSdUKZl7nIcpSCT+0XTFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Rpyz8FE/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B5606A326
	for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 18:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rpyz8FE/
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8acca77f6d8so894887b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 11:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519952; cv=none;
        d=google.com; s=arc-20260327;
        b=DDN2e+ep6t5FpU8qEYO219Hy+ayqguyra3buN13vVSSQE89XrY5XNxmxHUNdfE3mYc
         P5BmYWs4aaSrJDlGVyBOgnT5TFq06VXzBMAHp3fUvPB1ruJny/PR4LgnUh95Dl63QFLF
         psYAA6DJ3lcz+/5mLcL6AAQhXagyY0BqeaBYP4tz/6mo3ZWeHUBfUiD/I8oGQHcm6HRE
         3DBz8VAunBthoUU7RFuv74iqcZ5smj9EY4ug9CcBbAqvzdnHqW26DqHME7oHzfPWnARD
         LMCs2NRTpDFnpVagEYUwHij0cT2+8SCSWDLnUjr5/2sNOWIvZFeSV38sN/Zlikw2RY5g
         zKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Q0IBvTQMEWBs8o9DTQ9g44FzT6wyIyEPpp62Eq3IeX4=;
        fh=zPUlOXCUhGNUrpry7DgREOoIotaJL2Y44HcpalOpP4g=;
        b=eh2lWEzHDvn1I4X6mTe8hao15hg/4cFoaSTbw9NeUo93QPuFDspPCszb+8pukJ9G+O
         xPqMeFXLMqRqdruk3pcCeQaS3IfknNOv7xceGJa7uqwyJ7/RDEPk4ICdHVj92SEeOmxD
         Sh6WRgAt0sGxKEv1GVxK74gkjfylViareyiHa2Y7wQeLDjiwffiAsIdzYz9dFkTXL2DT
         v9CDqRX9/PFugM0QyVkvrqJFvnXwPibPkLpNbwlxE10LVDxDeXrxLFKmsqlODZL6jBP0
         lZ6/ZaiHUJILi0qAcvVtK/IUYAckP3Be/R/A2qap3nvaLXqITcMQuaOVVm31LDoXvEK+
         IjWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519952; x=1793124752; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0IBvTQMEWBs8o9DTQ9g44FzT6wyIyEPpp62Eq3IeX4=;
        b=Rpyz8FE/zl6iXibma0Zqpa+OLazoPLBE5pEDxzjte57NT8qb0NRhS186Xa01FS46/7
         tPquEOW/scZ0jp6dgMuk39p1GBgEHjp8hFRUQxZEau3U7YBmuUM2QXm8LNRig+z62mkG
         vNmD1IqYZFzeZnF+TDT5WEX9lUYX7zYfp5NNRshBDdbfXzW51xWyx13QcMZivtG4vZ9Q
         XqPxhyR8CVJvuva9mA056GKFPYzODdOoMf/WZORo7KDKil9G0wdkyZr+rmg2C1iVLkiM
         8d1EJKh20VcyZGJa1GnZiafrx6tvKrz+Hst7+7YoJ0+OG+Met5EoCNBdd5/ZWbR6R/YZ
         LiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519952; x=1793124752;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0IBvTQMEWBs8o9DTQ9g44FzT6wyIyEPpp62Eq3IeX4=;
        b=s9Q6Ia3BvoWKYu3aRPo4wAWUCqK3ffLHPi9VjiSaO/156H9/GkxXQ2KSvoU3sa5NqR
         fbYc4Ear2Gr4JZFy6mzGCG9YVDJXRsZaZV3NtLUTULa0v+C9Hgp/oQRgYZjNAlHzGdcy
         ZN64zGYgFY19Afc51OiFg/dgFczpvh7lm3Z0SzHnJ1lAoPS4c4lmUbOHberMZ1+gJL/n
         Eu0/tM4G2oLd0SdCoHyX31u+DeixtV6nS2Gddw33rB1ExLQjZ4IT9iZQz6vPMij1ogoS
         xikVnikJzqr49phMUd3Gi1Dv2WHboHaVOFbqipmETf9bxq/9WD4aUQ5F1gVB9kpMhBJf
         gwOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5iS2tXJqVmbb4txTiuMFmbUtm1OIb7qp41EOxXENNTRey7WLd6EWOlgq7XBQL8hqgzaN4OUC9/F/wWssRUdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKslrWq6agt5ZF5qBq89FGAV7lqhGabBYV7cYTCZepO2gJD7xlo
	nKgVLpJUTlvvQnHkKQ9D4iJ/W7k0MzPASF9sr0h6Oo5RXAy8vMd54eQ0ayGt1WaBGkA08BuxZRc
	yEuh4IbYvyp8f/DOIm3sfCCiojuQQGRc=
X-Gm-Gg: AYBFou2eLuB8zdX0lTHFysvaUVOoiC3scBTvjlmk9XCQud7M9VBoMZaDr14w1EfWNNS
	rq5Ne7PK9fAJBGsc+J1gwCQ6lNEqoOpgF2BOaH0T2vIc64L8MWC0qq8sG9l8vpl9Cm6foWXSImO
	848qA95yrMr/6TkllgKkyaQ4k4p7klbs9/ad7X1B35pLhmSCtlpeE3tgGCMY1sHS2EGrjXW4QjT
	8s0EytH+5ixoMlUDrnT4xuL+R4HOsnZ+DwT3KfOiXN+RuRkNrpbzTGVmyhOfqkUjnDcyNtTkdkb
	BgRnoVw9CNG2TIDNZ3CFyK1O6j/rPfZXiqazAIxlbF7K2Rpq/N4xwWIBiEDlDLBo
X-Received: by 2002:a05:690c:6303:b0:8b0:d28b:7120 with SMTP id
 00721157ae682-8b0f20640fdmr73203517b3.1.1792519941846; Tue, 20 Oct 2026
 11:12:21 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 14:12:20 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 14:12:20 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
References: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 14:12:20 -0400
X-Gm-Features: AclHuK8jxheInEZQp88vwy8iR4LpiWZaam4FG48zif5YZiKEGKaYGQuCm2rDABM
Message-ID: <CAPAsAGxVSdCKhUVq9zq7ASRC6JSuXDexxr8MH4og1tQv9RNjrQ@mail.gmail.com>
Subject: Re: [PATCH v2] string: copy byte by byte in sized_strscpy() under KASAN
To: Qiliang Yuan <odys.yuan@gmail.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Collingbourne <peter@pcc.me.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

> sized_strscpy() copies a word at a time. The loads go through
> read_word_at_a_time(), which checks the first byte of each word with
> KASAN, or through load_unaligned_zeropad() on architectures with
> CONFIG_DCACHE_WORD_ACCESS. Under KMSAN it copies byte by byte instead.
>
> load_unaligned_zeropad() is inline assembly that the compiler does not
> instrument. Since sized_strscpy() switched to it, generic and software
> tag-based KASAN no longer report strscpy() reading from a freed or
> out-of-bounds source on x86_64, arm64 and the other architectures that
> select CONFIG_DCACHE_WORD_ACCESS. On x86_64 the kasan_strings KUnit
> case, which expects a report when the first source byte is out of
> bounds, fails as a result:
>
>   KASAN and string KUnit suites      failures
>   on x86_64, generic KASAN        before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Copy byte by byte under generic and software tag-based KASAN too, as
> under KMSAN, so that every byte strscpy() reads is checked. Hardware
> tag-based KASAN keeps the word loop that load_unaligned_zeropad() was
> brought in for.
>
> Fixes: d94c12bd97d5 ("string: Add load_unaligned_zeropad() code path to sized_strscpy()")
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> V1 -> V2:
> - Copy byte by byte under generic and software tag-based KASAN instead
>   of checking the first byte of each word (Andrew Morton)
> - Rebase onto v7.3
>
> v1: https://lore.kernel.org/r/20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com
>
> The other callers of load_unaligned_zeropad() are covered by a separate
> series (Peter Collingbourne):
> https://lore.kernel.org/r/20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com
> ---
>  lib/string.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index a3778d5aab4af..d14e42ae3903b 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -124,8 +124,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	 * uninitialized bytes after the trailing zero and use them in
>  	 * comparisons. Disable this optimization under KMSAN to prevent
>  	 * false positive reports.
> +	 *
> +	 * KASAN does not see load_unaligned_zeropad() at all, and
> +	 * read_word_at_a_time() only checks the first byte of each word.
> +	 * Disable it under software KASAN as well, so that every byte read
> +	 * is checked.
>  	 */
> -	if (IS_ENABLED(CONFIG_KMSAN))
> +	if (IS_ENABLED(CONFIG_KMSAN) || IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  		max = 0;

I think this has been discussed before several times.
The rationale for introducing read_word_at_a_time() with a first-byte check was
to preserve the word-at-a-time implementation while allowing KASAN to check the
access.

We should avoid changing semantics or implementation under KASAN unless
absolutely necessary. Changing the implementation specifically for KASAN means
we test a different code path from the one used in production. That defeats
part of the purpose of testing the kernel with KASAN.

The only missing piece here is the equivalent first-byte check in
load_unaligned_zeropad(). So the proposed instrumentation series [1] is the
right way to fix this.

[1] https://lore.kernel.org/r/20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com
