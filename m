Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320016F270
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269129; cv=none; b=VnPR6zDLu2bvNZ+FvcscyeTx0r8pI+CEFa4wMa+MyvLpOkj99ykmQhYU02AIJMcoVhlb2qVYbzXXzcmdKHPky27Z7t8kDafuk30HwjpPXuKVPEv11Dr0Nghyv3nfS4vCzrqkYHiVxb105vRIDv7qCvAMkPCvKAJvkyYpL+sdaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269129; c=relaxed/simple;
	bh=VbUryaWATGCZ5EXBoBZLCN4tFKqA1uiKbgb/q6kse1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC+4sezner+60sAJI4PJsKU73TAeRAXVEBvgYSvVLm1nBDpao7W219Ev18Js6wkjLaBRyC/LBYpyZniBFVVLQQI/IRL907YQa+8S8CcOdmCFEWaUdoWJ6fDDnSqbLJujKVnOpUvOj2wsj1KR/9GgxUoCxsHo1fWUt0AArgTE014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B3r5JkHR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B3r5JkHR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so246065466b.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715269125; x=1715873925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rcGIIRAYs5g7y2tSFAfBRRtjyll1Cgq8Dp6vv6m/q4=;
        b=B3r5JkHRn4S28scVky0RpYUj4PqttLFM8uOw4FqhUkPIb3nwHfP+Q/hMku5BRkXeZE
         vO3cJYRBbB0UZVm6pCOmQis8MqTyIqm3krqDEaO8jVGIGa1yINSmAwZTVdXTDFER1J/8
         jnBGjy6tpTB/DdRDj+laMqau1ze46UxS6HCZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269125; x=1715873925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rcGIIRAYs5g7y2tSFAfBRRtjyll1Cgq8Dp6vv6m/q4=;
        b=MDYjlLtknqr/H1aYvtPSL+agD6+oZ8O/zelvGYpI0Z7HfLkrFNQta+Qdfif6M2DVii
         hOyX0CJFwHMcH6/59aKtLxaUfu5PMF1CzhcDCGdNHowocpXzeUK3GtrXhzY0s9cSbMXn
         VqSDQexpr12IivtLQQ+12gK4TuDmZqlA0lOyq3Jzq4Nvl0eEAcuuVeS+KOmbM2Skj4jF
         GntckkS896HKu/UXelWfP8ufjkKjf7IlpSf9TUEj0z2OkjHskqtZnMa7K6dGDp0VG215
         /y3EZD9HfIqcYcxQuHEGDYfsydp0G86WSBnfdnX+3eKiHsOQrcAkbkRfVaCrAjupHFCm
         CS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWKTlOxuI1g7Ph0BPmLMqCaUvmWLXjcEPJaxTzNYeDlMevbaP498Sbjs/BStlJUKj8h5KgYwqWyjL7wOoZ7+1YtbI1BLwvteDj9h1PMCUV
X-Gm-Message-State: AOJu0Yy3upZwCqjj0cD3JY8dpn/H/aPsmwBukeQwfQOR5OfOGS9LMgJZ
	XT2bgqfrSLomrVq7fd7j2xt80sV4IPOmdo+8Y7bA1PEh9ij6BsQsfx6OqLr4PnxY2MDD9Da7Qw3
	2ul9e5Q==
X-Google-Smtp-Source: AGHT+IG0/ns5IJ+IQ7em2Ao0d76LB4UFP+ASa++4/UTGMJ6xMcMHQ0M9m1aMiUbl8gnjNEn/2PYp0Q==
X-Received: by 2002:a17:906:a3cd:b0:a59:9fc8:38c2 with SMTP id a640c23a62f3a-a59fb942533mr367440666b.31.1715269125654;
        Thu, 09 May 2024 08:38:45 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d73sm85284266b.67.2024.05.09.08.38.44
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 08:38:45 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a599eedc8eeso274365766b.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 08:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj61ezqNNI3xKH9bfDIac8s2ozN+oz9iE3PwF/HMC1M948qzaXi3Au87E4wzFGbQFR7Y6xhFGzO7n0sNWaDS4RiZJjrKNM6/zGwcYaFE4Z
X-Received: by 2002:a17:906:35c8:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a5a156255e3mr176942266b.55.1715269124579; Thu, 09 May 2024
 08:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
In-Reply-To: <20240509140854.GF3620298@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 08:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Message-ID: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 07:09, Theodore Ts'o <tytso@mit.edu> wrote:
>
> struct ext2_super {
>        ...
>        __u32    time_lo;
>        __u32    time_high;
>        ...
> }
>
>         time_t  now;
>
>         sb->time_low = now;
>         sb->time_high = now >> 32;
>
> This is obviously (to a human) correct,

Actually, it's not correct at all.

If time_t is 32-bit, that "now >> 32" is broken due to how C shifts
are defined. For a 32-bit type, only shifts of 0-31 bits are
well-defined (due to hardware differences).

> but because of stupid compiler
> tricks, in order to silence compiler-level and ubsan complaints, this
> got turned into:
>
>         sb->time_low = now & 0xffffffff;
> #if (SIZEOF_TIME_T > 4)
>         sb->time_high = (now >> 32) & EXT4_EPOCH_MASK;
> #else
>         sb->time_high = 0;
> #endi

This is the wrong solution.

But the solution to the undefined shift isn't some #ifdef.

The idiomatic C solution is to do

        high_bits = (all_bits >> 16) >> 16;

which works even if 'all_bits' is 32 bit, and the compiler will know
this idiom, and turn it into just 0.

Going the other way is similar:

        all_bits = low_bits + ((u64) high_bits << 16) << 16);

and again, the compiler will recognize this idiom and do the right
thing (and if 'all_bits' is only 32-bit, the compiler will optimize
the high bit noise away).

And yes, this is not great, but there you have it: C was designed to
be a high-level assembler, and you see the effects of "this is how
many hardware shifters work". The shift instructions on many (most?)
architectures end up being limited to the word width.

We actually have some helpers for this in <linux/wordpart.h>:

  #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
  #define lower_32_bits(n) ((u32)((n) & 0xffffffff))

but we don't have that "combine 32 bits into 64 bits" helper. Maybe
worth adding.

                Linus
