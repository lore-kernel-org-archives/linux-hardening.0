Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF62367DC
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408612; cv=none; b=Qw3l7MrIVot7OrAfxzaHssmX57bDVCXJU1Q2LR4JRg20HsPWzEMqHvUdIDGhYOnQgyhPbNHTvYlcRI++YZJHnUI2csHiRhEQQol4PX+m04EkU7nEmvyXhvKSlpDHphfWXdj09PUcm3Jbu+gN/cw2F9cjpfcTqIUCPu6DsWDErBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408612; c=relaxed/simple;
	bh=lM8ClZuxWRG/dPj6dEzB4uWbxDPqXAWHFLGyuMbLk5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6L0rMyzb3eQ69RTobTozb3jTJ2SzxboNH3BTLnGpzJeU2YqZ9X5la3EO/c0ucIJI2qOcaqctHJWFYQUYSaLGQNuvJFBms7rTxaXo+qsZaYx+KYeYYZ9X7iVHy5OoUwpZGLPqp4TqJMRbBRhqDf2kUSRFy4o6GORBf6jg+EFHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGJjM7O6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGJjM7O6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1501315f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408608; x=1751013408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU7fzM9iDfstegkNAKIaUxvWPHDRAUDT6UmYmOI8JOY=;
        b=LGJjM7O60ftIF9yHwzbdcDA5J/61ILIjNh4UCFaqalwRRdstiZhGXRIfcVTyi3TgvT
         G2KRswmxBVnkEW/agFM2JcBiedad7f3yFE6joMUl/pNtIkOLMBQq5sCXf7uLpGW0OeoC
         8Sl+ODpqfWgrJT/Wx2t9RKJazgZC07FzF+mG1XaRUKJCiyr8At1xFzS9CSwgN96q8sBT
         Nj/qvKof+F6gG6PYM0Wl5x38BF3uSnVJGrh8P7v6zAX2HSbSa0+RybC3yQVI+2pxR3F0
         1mUaoOuGbdnFb6Q+f/6PF8k0NjmWgDt7ZtWunAKg2Iu3j6+2yT713nBLdrMw/mWV5iNG
         fu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408608; x=1751013408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU7fzM9iDfstegkNAKIaUxvWPHDRAUDT6UmYmOI8JOY=;
        b=PZos4jQG9+lgrLhGvtv4frIzIVL9lJYvbodvws3YTxZtIqpCIID9ABFo8n393XYcH9
         bVkFVlRjzWmRByLB8465bc8nvXenAf/fPTu9HC09nCUMwnzrotW+qBPKrP+TVgveKjy9
         9fTTq9V/7AZJPXUhvMptz7QfXmCtmBGxTuMUc6L7uqGu2Lre20CQZ3ngNMzQHMErCFin
         7DriVOroKSAECR7ty6brc0bjAwL3NeK3U0gHl1W5KV71YmUAv3FwzH5sF6rFl140H5YS
         BZGkPCnQsT1f73w/VW/mnvcOYCBnYx/px/YjOn3oxUIhQouzMxOB30U3n1I1LcLtxy1c
         rxwA==
X-Forwarded-Encrypted: i=1; AJvYcCU6TDgMAOLv10lzfaA9/WiVgPPmcY3jsP+qelv6B9R2XSQ/EgjQ0hg8dXx5R73c2OWugn92QwnoaRrtBSVQixQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUtOW+KfbKMRZAhasVgT84sQByOIdzuFUNk/xAxyO7dkbhrps
	I1sWet9L7IB8a3UuC+AdR6G5ZYjemrILeMU9BQvu7quwSpt/awSi2e2cu9khC3sQ+YLbBPnCmIV
	7hKCxj7eGPAaEajoO8NoIQU3VjwK7J+7wX5+nWbBz
X-Gm-Gg: ASbGncsejKNvdw+SI39v5DuYHX7xIxBb2W4jwYxz9EgU2GTa4RTtNDty247fDEO9U60
	Rg9tY1ylRqsoy6QRw1oXVVLOOFLlIuPyqDZ2SJejkzafpEYegoMLE++MqWpcpe/a/oRnQKeO5Ta
	PSNFlQ0Dp+MAF4mTBZJd0H3pBBgzZWUXmA8wWpU4ktSXBmiltFOm6gEV9yyvhuH4llktO0MJrC8
	A==
X-Google-Smtp-Source: AGHT+IF4NsF4vxMOuxqxg8w50Y/+yHUkifBXKj0sFTc0mzTUo5N50IwMGJ5DvJzRBAJAGH5qKJWeKheEKgq3xvDVGG0=
X-Received: by 2002:a05:6000:4201:b0:3a5:3062:793a with SMTP id
 ffacd0b85a97d-3a6d12fba1dmr1372232f8f.33.1750408608086; Fri, 20 Jun 2025
 01:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620082954.540955-1-bqe@google.com>
In-Reply-To: <20250620082954.540955-1-bqe@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Jun 2025 10:36:36 +0200
X-Gm-Features: Ac12FXwsALrO-m84HwB3vGvFIw9yO1_lS0Ap7fbgrdBUZ90ZAMgj4rZv-EvpFWY
Message-ID: <CAH5fLgg134vuCCtL5B5vKY8LxAWJqTyY=Fr_xtAwBMTZ6WLX5g@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] rust: adds Bitmap API, ID pool and bindings
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:29=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
>
> The Rust bitmap API provides a safe abstraction to underlying bitmap
> and bitops operations. For now, only includes method necessary for
> dbitmap.h, more can be added later. We perform bounds checks for
> hardening, violations are programmer errors that result in panics.
>
> We include set_bit_atomic and clear_bit_atomic operations. One has
> to avoid races with non-atomic operations, which is ensure by the
> Rust type system: either callers have shared references &bitmap in
> which case the mutations are atomic operations. Or there is a
> exclusive reference &mut bitmap, in which case there is no concurrent
> access.
>
> This series includes an optimization to represent the bitmap inline,
> as suggested by Yury.
>
> We ran a simple microbenchmark which shows that overall the Rust API
> can be expected to be about 4.5% slower than C API.
>
> We also introduce a Rust API in id_pool.rs that would replace
> dbitmap.h from the commit referenced above. This data structure is couple=
d
> with the bitmap API and adds support for growing and shrinking, along
> with fine-grained control over when allocation happens.
> The Binder code needs this since it holds a spinlock at the time it
> discovers that growing is necessary; this has to be release
> for performing a memory allocation with GFP_KERNEL that may cause
> sleep.  We includes example doctests that demonstrate this usage.
>
> This is v13, see [v12] for previous state. Thanks everyone for all the
> helpful comments, this series has improved significantly as a result of
> your work.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
