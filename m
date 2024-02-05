Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B320DCB
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139903; cv=none; b=S1LxwKK9zv1mXSY6JWTI/jFI4RgAYYHh8yIgh0dS8Lvt5aMcrCTNvrv4W3SKIXl42k0dgtdkC0EmCBGWD3cEHqZM/EZF3l1Y77uDGSCzxc45IRbvBcwYRuBrHxIbHAAhzEwIRyfHXiQGjfrP3zdj/KWDog2rHnzFlSJUWSkZjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139903; c=relaxed/simple;
	bh=KzxFTooi2xoS95wCF9cHhuJc+ZQaciAgLxyDyZEDEAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ3A9vAT6pGXoEjh6scU8xQCRVm9OT0YIZnXDsxKlGeU6Yp/cN+qd6lCpTXA1OKZmRjlmDn2lgYpVFLnvJjzDlKQKnV4W8bD6gZHs14I5AJB5mHCLEhKPhp4oQQ/mdfsv53XQi36OI+gMr0DpuQQMOnNVdhu9uTPhK697Fol0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2F/vN7k; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2F/vN7k"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4c03b2ac77aso127076e0c.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707139901; x=1707744701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ8GPCJMdPhwQhse++LGlzqMqm9PQ3tDH0LBh8kIu5E=;
        b=O2F/vN7k+CHEedtjp1uJ/OyRCEUQd0TT7SBegFIJJl6ShZr1h0KB7joFV0v6+mcNzi
         7wGxH4GiqZWg9eJWMerK3Mpf+hGm3wQiwmQ9JMh0QD1PfAPd7JN44kO5spwx/Ffqk3rd
         R6DoLD+Z4cO0f7Yquczlne7TojTUc6uKw8wVK5nPKYWv8pCo988uLYetqUivQJ7mWWGL
         m/j49LKetFMjoJaW4cUaH8iLKhRRtv+w/C6uCwzdUjXwBDDpGhtF8IH1mBc6IFet9u8S
         3oOP8SELmhb2K+6MLUsX7aNtfg4nR0uJ03yTOQtYAAhBDG2lsyR14hz0FGJ4DQXht5RX
         vbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139901; x=1707744701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZ8GPCJMdPhwQhse++LGlzqMqm9PQ3tDH0LBh8kIu5E=;
        b=PooU4X1iuLORkBattw+7YdAvAJqRtpH4Rr+rfWxB6X8GAIuBXt5KuccnkBtmfynUla
         UvXJ29cB4/NiQ1ShtPDwVpNIfa8LPtgxzIcWRgZcw4OPnBl9CSXsNRQqV/0lMPBFw1Xg
         7P/AQsSMKs2IXmamx1Xi1jtSaxUjaVR6lcLnLRI7AhGqmk6jbIWvBTXh9bwiSZTyXVW6
         6hpkqy6vHjiVWuVS1ZYCou7j8MeGhGPPPmHvMMWaCrylX8zi4h74u3bUY537hdp3MPbw
         HaEBT7TB3TluBADVCu9Af4icOFKmI/kh6NjL+XMkZjmRBN2sd0mGuBEW+EqlMN3JNkDD
         vP6w==
X-Gm-Message-State: AOJu0YzuOMIkFChk6JVMafnUR+umIQO0qU3b98VR2MOn2QDAnXGEWf6P
	EXwaNwhoZhUNtT9wkB7T6Y8TYlY0fyVq/WAp7iaA+rHr7Cmp2HSzb6V+SiiLCbBhFdZV7J9dCPG
	uAsezk2F/pfMGdVGtpal/FmZy0bBcQzR9qvjVaRKvcRVlgqCAEA==
X-Google-Smtp-Source: AGHT+IEQQfzzmSUTPC1/Xzns6ZjgUCbZz4xASKLlcFLhsbbowD8EnuWIEP3suxI6+HEm0qH8+9kCzywku64968PlVAI=
X-Received: by 2002:a05:6122:4104:b0:4bd:8926:8e15 with SMTP id
 ce4-20020a056122410400b004bd89268e15mr11439051vkb.0.1707139900932; Mon, 05
 Feb 2024 05:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205090854.make.507-kees@kernel.org> <20240205091233.1357377-2-keescook@chromium.org>
In-Reply-To: <20240205091233.1357377-2-keescook@chromium.org>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 14:31:04 +0100
Message-ID: <CANpmjNNExn8DX2+Cnz3GDWXNZv-jZcpFSedCYx+y6HEemFoHRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, 
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 10:12, Kees Cook <keescook@chromium.org> wrote:
>
> Provide helpers that will perform wrapping addition, subtraction, or
> multiplication without tripping the arithmetic wrap-around sanitizers. The
> first argument is the type under which the wrap-around should happen
> with. In other words, these two calls will get very different results:
>
>         mul_wrap(int, 50, 50) == 2500
>         mul_wrap(u8,  50, 50) ==  196
>
> Add to the selftests to validate behavior and lack of side-effects.
>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
>  lib/overflow_kunit.c     | 23 ++++++++++++++---
>  2 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4e741ebb8005..9b8c05bdb788 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_add_overflow(a, b, d)    \
>         __must_check_overflow(__builtin_add_overflow(a, b, d))
>
> +/**
> + * add_wrap() - Intentionally perform a wrapping addition
> + * @type: type for result of calculation
> + * @a: first addend
> + * @b: second addend
> + *
> + * Return the potentially wrapped-around addition without
> + * tripping any wrap-around sanitizers that may be enabled.
> + */
> +#define add_wrap(type, a, b)                           \
> +       ({                                              \
> +               type __val;                             \
> +               if (check_add_overflow(a, b, &__val)) { \
> +                       /* do nothing */                \

The whole reason check_*_overflow() exists is to wrap the builtin in a
function with __must_check. Here the result is explicitly ignored, so
do we have to go through the check_add_overflow indirection? Why not
just use the builtin directly? It might make sense to make the
compiler's job a little easier, because I predict that
__must_check_overflow will be outlined with enough instrumentation
(maybe it should have been __always_inline).
