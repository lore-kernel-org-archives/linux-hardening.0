Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116B12D75F
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022008; cv=none; b=hMQ6agHjcJtvM+MCNwx1jzdnt7If5Dvu1cDKOFjpLh/y+M4qN8l+QFUTIdeRj0dkG25RURpkSdqe0SS1oK5jI4casTVjwrvxJW0bqEd5hNpBG3dwNKjIBgY9AG7KRGiSEzmi+AFb9E+PM0ClxecurQ9EfnPQsbQO/MLt/ZWod2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022008; c=relaxed/simple;
	bh=h7H4FBwDjtFZTfSMi65y7rCAC7HWqJMf/6EX7pmmTNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol4epbY9vy3KPT8wea5az9ATQrgpzF0O5xXtnVBUlE2JFEh0mgun0oqyLUv1WRCAamnC9T2Hz6TVvSRi4w/3DsRU80rriGM0vNsnQcSFpeEj+/8NPJdTu2UT0yCFSyvcx0ZleohTvpT9vud74d6saqm42zIogacimBTQwB3uNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltWU3OnK; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltWU3OnK"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c03beb85f4so360958e0c.3
        for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708022005; x=1708626805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cgjd8j0lGhuZAEPZiz3aSk342Nhzq+fv9nQyppW3Ak=;
        b=ltWU3OnKp4/3lUfq6gbTRBraf4nlO/dJ3zuK0NlTz4xkaBR9tb1WRSLg0yccEyxjby
         6j+lWkZrmghJ7PQcL6JXjy5pGoVRBQdhmLD5cujYHx6LYK2yE0gSojPIJ/R2Qa6MLZi6
         j2DRSww6Vm8EmMIrV3bU/756w9kH5FqmM1px2WhH7fGQAQuVI7wvDrv6FbBJWbbVzXJn
         CvAbCzNF5lQJ4PaGhTVmQS5j3R5gvIlY9uFCYdXB+2OeNlXZ9UabbjY1zu8hlYAMol8R
         AqZcyx00V5hTkkbyivnb3t/vHNXWpcRUmJw6gJq+Rd/hV0G9pWGoPoCQTxgw9BJ/0o3T
         leKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022005; x=1708626805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cgjd8j0lGhuZAEPZiz3aSk342Nhzq+fv9nQyppW3Ak=;
        b=rEq1gd+z721URs7s0NC/D0wUVmFxNkh2++mPktFHs8e7MV8cdQ0Pb5Xw8Pxjo/Wyvf
         WA8Qzksy2WrxlEg+icwWbCT2Zti93s2QxTyfdDNXUVa0CcKGreUTBui9DM+RXC2HZWzk
         sgqs+NTm2B2mm9B83HT5Fe/p/gklP4uTlhxuAIVepDdz4t8x7ImjwrGcMTFfzpKvIjEu
         nbGOtSIzCJT3fh9YUSW8fy4pefSI/AQDvmEgzd+ertqGLfQ0StNXfUD64RB0R123lH6W
         i+4SplqbL6nuEgz95sziTErztxt9j0wEKaHgNG/e5hl1PE0+Yi/En2a68GBCM6Zi3mjz
         HzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUixcOj6QNhXKTH27SoymTYFA8lEXiDasgangsuR3Q4tGJ9wFkPRR6h3BsBjTuEvjkN+BXW8Y4Uv+GbIhay7HfIpOGsIwBnHvJw2Y05MZMh
X-Gm-Message-State: AOJu0Yw8qAq9kGlbAwsXQUYKDToIB5aNSSvjcQKRpPXCFlihg85PT1El
	StUTPAk9S78ocfu+YudlxC+PD1d05JV47eT/7QRZzMG9coOhdljw+W/bxTrQQy7ilggdygCFQ2R
	f1PLhRspmbiVrdqRGON/FprMtvPZ3oNTZ0901
X-Google-Smtp-Source: AGHT+IFZ4HJEjg3Vz6yIN4Fq5nuDkARCsLfavxqSX51nzgIKhdpi/duElUIGLxNB4uANcUpSVO57gRQ5qWXvql+avEI=
X-Received: by 2002:a1f:4fc5:0:b0:4c0:1cc8:8821 with SMTP id
 d188-20020a1f4fc5000000b004c01cc88821mr2433933vkb.9.1708022003768; Thu, 15
 Feb 2024 10:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214194432.makes.837-kees@kernel.org> <20240214194605.602505-3-keescook@chromium.org>
In-Reply-To: <20240214194605.602505-3-keescook@chromium.org>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 19:32:45 +0100
Message-ID: <CANpmjNOf-+YH2qZPMQuLT5TigY4u41E+uw1XeqRMT8mHqFTn1w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	Eric Biggers <ebiggers@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 20:46, Kees Cook <keescook@chromium.org> wrote:
>
> This allows replacements of the idioms "var += offset" and "var -=
> offset" with the wrapping_assign_add() and wrapping_assign_sub() helpers
> respectively. They will avoid wrap-around sanitizer instrumentation.
>
> Add to the selftests to validate behavior and lack of side-effects.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++
>  lib/overflow_kunit.c     | 43 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index d3ff8e2bec29..dede374832c9 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -81,6 +81,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>                 __val;                                          \
>         })
>
> +/**
> + * wrapping_assign_add() - Intentionally perform a wrapping increment assignment
> + * @var: variable to be incremented
> + * @offset: amount to add
> + *
> + * Increments @var by @offset with wrap-around. Returns the resulting
> + * value of @var. Will not trip any wrap-around sanitizers.
> + *
> + * Returns the new value of @var.
> + */
> +#define wrapping_assign_add(var, offset)                               \
> +       ({                                                              \
> +               typeof(var) *__ptr = &(var);                            \
> +               *__ptr = wrapping_add(typeof(var), *__ptr, offset);     \
> +       })
> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> @@ -111,6 +127,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>                 __val;                                          \
>         })
>
> +/**
> + * wrapping_assign_sub() - Intentionally perform a wrapping decrement assign
> + * @var: variable to be decremented
> + * @offset: amount to subtract
> + *
> + * Decrements @var by @offset with wrap-around. Returns the resulting
> + * value of @var. Will not trip any wrap-around sanitizers.
> + *
> + * Returns the new value of @var.
> + */
> +#define wrapping_assign_sub(var, offset)                               \
> +       ({                                                              \
> +               typeof(var) *__ptr = &(var);                            \
> +               *__ptr = wrapping_sub(typeof(var), *__ptr, offset);     \
> +       })
> +
>  /**
>   * check_mul_overflow() - Calculate multiplication with overflow checking
>   * @a: first factor
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index d3fdb906d3fe..65e8a72a83bf 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
[...]
> +       /* wrapping_assign_{add,sub}() */                               \
> +       check_self_op(fmt, assign_add, +=, p->a, p->b);                 \
> +       check_self_op(fmt, assign_add, +=, p->b, p->a);                 \
> +       check_self_op(fmt, assign_sub, -=, p->a, p->b);                 \
>  }                                                                      \

Merely a curiosity, and am not suggesting this for this patch: I
wonder how much of this could be tested at compile-time. These are
very primitive operations, so I suspect the compiler could either
check these in a static_assert(), or if some of it isn't
constexpr-friendly, after optimizations with a BUILD_BUG.
