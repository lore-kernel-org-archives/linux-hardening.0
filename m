Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8237E2EE
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814467; cv=none; b=e7QP5gDMTbDUzzLZV7R3Cw23tL26J1NpoPDXz5SjMEx9T0v3dyJrnVTOcovo+yv2rLikTAMQUgyEkdkNFh+S7avTBIGPoY3PQGcr5uP1hYNSuPRrm1RsmQB8yyUySdywSZFg9ftg/O8BUH9jBzdCKZ7lmmBL05BUopk7/Kc1XGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814467; c=relaxed/simple;
	bh=/zVhl/58ppW4f8bSySDdz7RMQAkYtKlqpvoNw49/sj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC1lkeA1Kqr9QDcXg3cgBXWbhiT2Rz23t4iNuE7cBcCgRpMF5l/gc6j02eGLvSp6tiATESPzP2vA3X0PfzAaAlCo2AOmz7etbIyvs0hG5J8ILYaSQuiinWhOnnDw+j9MOZcOga7Q+kBxMKY83hsjSZ8bVIoLg/mRQ9lJ5/B3Bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVxzNdvi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVxzNdvi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso10463465e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789814463; x=1790419263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x47tJsyRRuS9WWsrQkleNMY57Cc3HHS/YjAw1Ng37/U=;
        b=gVxzNdviichMzd2yMzrIoEvqk/U1s+6VzqyL5823Kt+CLSxSRO8k412xbU+X8Re3Dn
         I+RBzPJlwVfAEkTmqAdagEywzzSlJfGjNMP2gjNWzm79ZI1rKixefbsTngQYwi+9bcJI
         sHBmHlh+Ry2Hkz5mZpddGOI3o7xpzd2cJ5AWufzk9VZh5gX1IT/B6UrXkaQy0wxk+b2Z
         fFKRRYUuOjZF651Z9V/mNfCbg6og+w8/JqWuRh1+6NjpwmMlGvdRfuExZkIGE6kw59s4
         MwFi2sf6kxardcOXjBDW+ZtgpOguv4cS/DCzVjHCadd/lBqaPSrE8unmEIwsNuDhgE8A
         Z9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789814463; x=1790419263;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x47tJsyRRuS9WWsrQkleNMY57Cc3HHS/YjAw1Ng37/U=;
        b=xqXuc6lJz5A4hoefBkF38EreFIhxbNtHyHrkvYiR+YPpG1/0EugfniqyJjfdwTlNvE
         EgKTnjhmr04SNEmw1Gd/WzoAWqltFZseqHaXOg59fpyoiMFkiLkyAfao+Xya2PxPKTsT
         ESOa8K7nX14JT21iuosQUrYxMmRlada7Yth5PfZ/nFOXS1ttVwu3PF99zrKlTyUEkX5T
         kk2esMRim++lW6fax/WIl52AywfWM+HCA6+rSMpnkKHTGWaltULN2yhuRDc65sAM4NPW
         ndUF8vIVeprecua0ABKoZb1iNS5XYz0AVvEXii2ZVviYJDwPZWTlQAK7ifVDRfFy+H9B
         k8zg==
X-Forwarded-Encrypted: i=1; AKwUvBx89ZvC/bVZFYUeytI793xUyzIUq3640A7zu4RGQVc3rD2m8bo1Gga3wcCYwOQF0gJ16kX6Jnd7bfWsa/Mz2lQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m8wubvdKqFn+89R2/EQwOntVsoPfLQGxIwqVNZK6g9sueHug3O
	zWuWucaQohwpyl+Qbe0eIcsX8/9SqPFV8jJcKLajyyUyPzWUm1Wf2Jdd
X-Gm-Gg: AYBFou0tlL0xk6RAWCbHSzRxkx/f+qbRfZ6q2IH9ls4JpAECMXvNymLb70vbp89Q4b6
	n676bWZjDCXiObH3hQpVV+3yd1YHvluQpn/ImAt/bhMr3QdP2yp4m/f7jrhVp0badnc7sgNVaVU
	O74zZzQ+8Xv1d/ZbI9Tq5NHXt/DymxfjjuiAXRoQY/SE1znBriqEfyhubea4xSXS28yxmnFppXl
	AfCLkZ2XI5KRERc1I9rAlxWq8qBDse71K3TjxODVFX0M0K2oZE+AqvEqYhG9lKbMA8smavIAgJi
	Ec5y++KkLEFPUgVagdag7V7tW4s/tfWAxfJQ9LDNVbT8L+NXP5KLawy3e53nQ5gVW3sO1I5A0TU
	lqDLwvheCvqqBkdaaE1SwGQcAqAkMiRQZjdy6Bf5JqQRj9gKGJIwizTvM/meyomYGkdd5M1wnVZ
	rbvVYKVXdaoCruAdt9f5sfyxu3UhCZ0RUdXSpD+1u3lFA5wdLIY3ExA7r/Xd29CdEsTdp4h6adB
	2GmxFm/doNR1eAmgONe1+d1V43DTvC1lPA=
X-Received: by 2002:a05:600c:8518:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49fc5741563mr73992215e9.29.1789814463336;
        Sat, 19 Sep 2026 03:41:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc521f5d9sm32797955e9.2.2026.09.19.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:41:03 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:41:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, Kees
 Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3 1/5] slab: align ZERO_SIZE_PTR to
 ARCH_KMALLOC_MINALIGN
Message-ID: <20260919114101.34423251@pumpkin>
In-Reply-To: <20260903203720.63689-2-kmehltretter@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
	<20260903203720.63689-2-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 22:37:16 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> The kmalloc entry points are annotated with __assume_kmalloc_alignment
> but return ZERO_SIZE_PTR, currently (void *)16, for zero-size requests.
> This violates the annotation when ARCH_KMALLOC_MINALIGN exceeds 16.
> 
> This can mislead compiler optimizations. Clang's UBSAN_ALIGNMENT detects
> the violation on armv5. GCC and Clang retain the ZERO_OR_NULL_PTR() range
> check but eliminate an exact ZERO_SIZE_PTR comparison after an annotated
> allocation.
> 
> Define ZERO_SIZE_PTR as the greater of 16 and ARCH_KMALLOC_MINALIGN,
> retaining the existing value where it is already aligned. Assert that
> ARCH_KMALLOC_MINALIGN remains below 0x100, the value of LIST_POISON1
> when POISON_POINTER_DELTA is zero, so the sentinel remains distinct
> from that poison pointer.
> 
> Fixes: 94a58c360a45 ("slab.h: sprinkle __assume_aligned attributes")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  include/linux/slab.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index cda126def67a..563dadc16d82 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -262,13 +262,16 @@ enum _slab_flag_bits {
>  
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> + * It satisfies the alignment promised by __assume_kmalloc_alignment
> + * and keeps the historic value 16 where that is already aligned.
>   *
>   * Dereferencing ZERO_SIZE_PTR will lead to a distinct access fault.
>   *
>   * ZERO_SIZE_PTR can be passed to kfree though in the same way that NULL can.
>   * Both make kfree a no-op.
>   */
> -#define ZERO_SIZE_PTR ((void *)16)
> +#define ZERO_SIZE_PTR ((void *)(ARCH_KMALLOC_MINALIGN > 16 ? \
> +				ARCH_KMALLOC_MINALIGN : 16))

If ARCH_KMALLOC_MINALIGN is just a constant (I suspect it has to be)
this would be better as:
#if ARCH_KMALLOC_MINALIGN > 16
#define ZERO_SIZE_PTR ((void *)ARCH_KMALLOC_MINALIGN)
#else
#define ARCH_KMALLOC_MINALIGN ((void *)16)
#endif
to avoid bloat at all the expansions.

David

>  
>  #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
>  				(unsigned long)ZERO_SIZE_PTR)
> @@ -625,6 +628,13 @@ static inline bool kmem_dump_obj(void *object) { return false; }
>  #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
>  #endif
>  
> +/*
> + * Keep ZERO_SIZE_PTR at most 128, i.e. below 0x100: LIST_POISON1 is
> + * 0x100 when POISON_POINTER_DELTA is 0, and no architecture currently
> + * has an ARCH_KMALLOC_MINALIGN above 128.
> + */
> +static_assert(ARCH_KMALLOC_MINALIGN < 0x100);
> +
>  /*
>   * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
>   * Intended for arches that get misalignment faults even for 64 bit integer

