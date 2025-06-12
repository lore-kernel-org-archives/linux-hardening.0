Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611492D7BF
	for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718722; cv=none; b=bjaooYNc9rnMw2TCv5Y56b344SKlz7wTsEdHJnHAbNPuZN5nYNfEpxa5qM4xWD+ngXT5cMlTgxFt/spxUQRrdo4WijuOQ7fvpkTJuV6o8pVTaGOUik4uLVyL+sbwEY6Qkgr7BddcXBDd0u0kuWg+Zos2PeOg1flFzdqHpsDi4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718722; c=relaxed/simple;
	bh=YSXaTgjeKpKHJ7HT93oBk+FgRuAlNw+PeElQP4LI3y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Psl37Sa6U546JotqSOLqOojJz+FoVgO33ybwdz+AH7JLPXFD2xCVRJxTHDvHSFxxHp+q/fGSbijg4HCPmrqUChHR/8GyT/AtdmUM3oV1L6kjaqGwDkOkMLej1UAWdf4knVSL1HP62Wf/efatj31HYtE93PGq85v9Fkes5ZT3oC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aq8tH+A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aq8tH+A"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450d244bfabso5463365e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749718719; x=1750323519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91dJEkwkMLKiySKIEldfXQRqk4IyakL0amgtdeUw2Qs=;
        b=3aq8tH+AqAhDEb4qQljlfMaWuEou1Gsib+xVCmsTSiQwvUQzRjipUl4agNQ5Fv8EGr
         WST3I/5VIVCYIKVl0VIQvMSCcgtdISMIlrr1g0gJipy8KUuE6QQ6WaYAYNx2n5USvcM2
         ffKevN3claOC6VdjWgQKMKKIVodozwoYCy578+0U3EDqq6bz5iVKin53D3aR/F49/cI3
         gEoSxMIq2che+oR+pldlTOsOTc5erOvYe2uPCyJDy/BBG92dsUPk/Hle1ECI8VYyYQGk
         SUKDebkGW4PPLZHmcBM1raRH0efJ1+Dih4RNw9fifWoANTIlDImO0itVMvjXAgBrmbm0
         4Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718719; x=1750323519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91dJEkwkMLKiySKIEldfXQRqk4IyakL0amgtdeUw2Qs=;
        b=mCeeKX4s8HY0ykX6YQ0oVAOLGGW3YoDekQGHaRxEg6bhSbliyJl+RAb0+/X4Lt8KhU
         uKKIkVEfa4TknReLxRTM8jhM2fTU3hs7eVbHd6OE+Fbz3bCqgD5oFZSMB/JnBFdP49qP
         83jtPqEPmfNeKih497kDJMYKJZc8X06NosyG7sNyJamfJE2VVVOg66Vl/k0hzIB7E4Nz
         GZBYKDB7s1ZYojrleco9xIAuayfWCaI/axKg8zPX3+ljFocMMQCeb0kcBD2aiq4w25Eb
         c9FjWqhjc0MudoPRRwMy/boVFjAfP69KGPlcv+ksim8HgSiT9v70cydjYWaBUB5fZbCW
         k4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxnXDeGByfiooZgDCJdbIWCRgjBeYj57+OIGcMDIXpMezvhgu6PkiolqyNppdZsuH+c/yB6pCYMTKfO69t3H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkY8rj002BNY4xkxhe+t1tvBom0TVqtDv1uU9TNZSngwLAV0S
	sJ0OwWtKGRiaueQZla//H1zdUvDEgr44Gb6b8T5mqxLxWIJVbtpDiXY2wv6GaV3ageoPQjd/65G
	st8HMjLeFUVnwPCf7cg==
X-Google-Smtp-Source: AGHT+IHVCdZNs0nb0GD5dnugUwcB8P4Ww6VOM+q297qZtr+Qk4se15dACah+S2N8jEozkc9qWTE8gVGBAOnO7j8=
X-Received: from wmbji3.prod.google.com ([2002:a05:600c:a343:b0:442:fa3c:8612])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358b:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-4532d33d8ebmr18618375e9.21.1749718718932;
 Thu, 12 Jun 2025 01:58:38 -0700 (PDT)
Date: Thu, 12 Jun 2025 08:58:36 +0000
In-Reply-To: <20250611194840.877308-5-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-5-bqe@google.com>
Message-ID: <aEqWvIffNhh6Kzp8@google.com>
Subject: Re: [PATCH v12 4/5] rust: add find_bit_benchmark_rust module.
From: Alice Ryhl <aliceryhl@google.com>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jun 11, 2025 at 07:48:37PM +0000, Burak Emir wrote:
> +    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc sparse bitmap failed");
> +    let nbits = BITMAP_LEN / SPARSENESS;
> +    for _i in 0..nbits {
> +        // SAFETY: BITMAP_LEN fits in 32 bits.
> +        let bit: usize =
> +            unsafe { bindings::__get_random_u32_below(BITMAP_LEN.try_into().unwrap()) as _ };

This safety comment argues why the .unwrap() will not result in a panic,
but it should instead argue why the call to __get_random_u32_below() is
okay. I guess that it's because __get_random_u32_below() is always safe
to call?

I'm not a big fan of these .try_into().unwrap() conversions. I would
probably just have written `BITMAP_LEN as u32`. But I know that this is
a point of disagreement with other Rust maintainers.

Alice
