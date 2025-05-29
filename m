Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5E156CA
	for <linux-hardening@vger.kernel.org>; Thu, 29 May 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498467; cv=none; b=DugX0DH49lhyyG+0nGxxD8VWfE82jODajjIRftUqv+rnZS7NjwHz/gjcO1oF+9b4bXoDTetrc8YGRuz7xnHR9hg7MhWN4aXh3iIkVAeonlKqMMhNfxREx70pN28remFHs2qVUVvO29NU0/mSxAKcREzleMZ4Rrra3uJ13z1uo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498467; c=relaxed/simple;
	bh=ee6dPxxgizLJ75Ie6rGuft7Nj+pZxFsrYqyEC9SjHbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww04affTy2TONnEvMVIGxgXknhDlEsOpOkR5n//QQrmlX281zVwQwiQRjFNj+OOQ9ehD/fk6rInwfIhiGNi43IpaaZKOSEwOXJFAiOx3/i6zeHvaYbXjnxlSWkxx6VFaXmalq9dffOpMq4rZ3nsnd5CiSdLzKduo4sdHgMP6d9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7SwnRXV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7SwnRXV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3081f72c271so381890a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 May 2025 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748498465; x=1749103265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vaz1+/ZzyNRFGMST7layMZzaN7+WIlAIP9tFziyB+WI=;
        b=K7SwnRXVNwYCVPiJE4HnxYdzj0nDs+7sq4uluY6jVzgiFf6FHkN9J07qSV6R08liS5
         evjvQa7FIwSKTUEvkaWWdiMSaBXX1ZOa6xoiOmOhBsal8TbHobucZNeaulkygn/uJdrD
         6YSie/fBTAdl+ZddTLD3ce41bSKBaZ6zeqsZ2rAKpCGdp2QOHQCKwytDkdXOAQTLTNdp
         aKSHiC4mF13ObArsMxzkYfltaWsVNMkYP9kJYfv+uLEQADjBRPUG4BPiXqgfvDLCNlQt
         f4wFBL+3i+iVsO/jsiPdrTrQxUttVTkkT0/CjgGj/laOUnWyuFogojGCksBLh/kXKHjk
         TD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498465; x=1749103265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaz1+/ZzyNRFGMST7layMZzaN7+WIlAIP9tFziyB+WI=;
        b=FnFcozt32Mqh662KWwFjGjtJCGvej7hi9XG1Ds/dpgzWa1FCiXEY7Lwo2/l7wsUx33
         BsDUcrHo5zwGaIJCbGpnM2wYnVv7TGF8yArF67ruILUCt/3gfc5a28awjt8wBXC1Xjl0
         FaAIEAbanWh1/FYR6dusmbTJnb7n/TbBUXE8POhMJidHA4QJx0PaD4cMIKR9PFA36kdP
         fMn79KUZQMBG2uwuEWR4rxcvFM/j9hEmHlLLkPxnoj7pMZmQniOcV/+Rk/iew5nEv0UY
         EjvKyz0mqx5/irJ7oLrHzZguuO+hOIrfkA2UTGOBCV9ZXDNY0TGTG3m47m8f0ZMaa64v
         hh8g==
X-Forwarded-Encrypted: i=1; AJvYcCUnOr9i99bmRRH8goCN3PwgRHgzcmFiqx1nW2W6t34l1p2Z0QKnCrb4pYp58t1T8q5QB1Toxa5iLlnNfgg6xeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydfc2k7IhIPiZp8ErqPQH0Ys3JC4ohI6jn0zkIshK6oL53lCWn
	rO08kDGpnq+m05YHbC2hpJM/VUUHr2PrJze8923b0Apii9mtuVYVXdNURlSF7B/+tF813NzNcmc
	3QbP3HVmDfNKbJqPKXk31EUDMSzyW4WtHj9rZ2R5e2UDXm0ZvYsp6/HLFXWc=
X-Gm-Gg: ASbGncvyOTlr5dCjUeZtes5GYdgU2GJ6yUHolXlhG0OYWQzr81h+KNJsAqlayQIy1mF
	LdBoBOeyngzGmaQpPJANlDOWANjUoJ1xzII8yTexybBvFsRviSyNTFWqAfvx4ySEHInrMU2N54c
	8JhM2W2JGg82Its3dxGc4ooszJ/6vS1ohf7E//z+Fuq9y3+YXO3b9+EP5z9t8T+EOM3WZfjVy6E
	iFo4xPrittMQA==
X-Google-Smtp-Source: AGHT+IHjuvTVAXJCwbM+CJ0cJqVVQmFtXnQG4j1KUBe5D8/pDzRiNN6zp0kn7i3urzRkLpnfLornO0snBlrTDyUNKi0=
X-Received: by 2002:a17:90b:2f08:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-3121dc9a0a5mr1652394a91.2.1748498464732; Wed, 28 May 2025
 23:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528182616.work.296-kees@kernel.org>
In-Reply-To: <20250528182616.work.296-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 29 May 2025 08:00:00 +0200
X-Gm-Features: AX0GCFv05dumQmD3kZlNkUj0qoKmc2PEwVW3_kOZBhYxH81s34wEweRfqQ1cmc0
Message-ID: <CANpmjNPpyJn++DVZmO89ms_HkJ0OvQzkps0GjCFbWkk0F+_8Xg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this
 out of CI
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 20:26, Kees Cook <kees@kernel.org> wrote:
>
> Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
> CI because we can't stop it from being included in randconfig builds.
> This feature is still highly experimental, and is developed in lock-step
> with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
> from being enabled by anyone not expecting it.
>
> Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Marco Elver <elver@google.com>

> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: llvm@lists.linux.dev
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  lib/Kconfig.ubsan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index f6ea0c5b5da3..96cd89668467 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -118,6 +118,8 @@ config UBSAN_UNREACHABLE
>
>  config UBSAN_INTEGER_WRAP
>         bool "Perform checking for integer arithmetic wrap-around"
> +       # This is very experimental so drop the next line if you really want it
> +       depends on BROKEN
>         depends on !COMPILE_TEST
>         depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)
>         depends on $(cc-option,-fsanitize=signed-integer-overflow)
> --
> 2.34.1
>
