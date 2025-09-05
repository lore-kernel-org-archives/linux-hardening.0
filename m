Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B734AB1D;
	Fri,  5 Sep 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078334; cv=none; b=MTDHO0fBbKQI3kXP1RCba+xBrVsRlUYqepiJA9JoVRXRExiyLuYPSeutyI/fcxYdRC7b4dl2LrXyZ0xVcwnd+av43r2SpRzK4iQwhLK503ogJUW4sQ6GbBEftTALn3msfsxW0LCgOC2iFVssGwIAwt6DC6Lqf/5TwOxCS7bcJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078334; c=relaxed/simple;
	bh=ny/A2p5gbcBaQSpVgqnsxmBtWkpq6taqfrkGe29oX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pff4o2MXgtRYQTHQ5Y7Amm+Xk6aLiino43GXjRVJubRqw2q5uklJwp7E1qwE2IkjzouLTn5Hglx9VeP4ajOk3RTrtj5bqbsO1WeQLPLvj6hhCaIrOlLkPXj53wvN+rxc+Lssw4BUAPAMGytZM7yvJIacQlRr9042u0JNG5apmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhD+kFkn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhD+kFkn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-248d5074ff7so21325465ad.0;
        Fri, 05 Sep 2025 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078331; x=1757683131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vE5oCxOckOECN6gRYk3jORDGGbCehZ7GCnaiRL+725k=;
        b=EhD+kFknK8EujeV1/sZuz6tLfHcRkn5pna39vbJpquj3Bf4YGkIFrw/y3qdSmIIVpk
         /6F0yuESgEDrXu5KfDzgau7lMsdjzMY+6CGGP079DqhYfIXOyilEjXABNgfihaf+dw1J
         WdpEV85JuIp207tGSO5Bq1Ona0F79hXKiXsdeG2QD0C/KwKmC44BJaTC2NEEkExlOrVo
         2syEeykx1t9HZ35MgSDUgPWGUIUB8gBGRRzMK5o/WfHueE01A8sJ7Adfk4jnNyqHJ3oM
         yHPM5/HddLHCVaUaghiNJCeKqyKuVJoNjCkNh6p8TpUxHJKN4Iv5o02rM2AXzhCD8DE2
         2Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078331; x=1757683131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE5oCxOckOECN6gRYk3jORDGGbCehZ7GCnaiRL+725k=;
        b=tSBO3lFyYoyvFNBymyYJQZ6CYWuBALY4mbR0b8smEvPoOcyPNMxhjaaBRFRK+BR+3+
         eDcR8LuZZODXA/b5uTJW1y5RsiSwrIchA6L/uJ8WQrsh4w4bNgAZVyqR7koskYbfZx3n
         si3a4GseS2K6FBRzUW9i5giW3k1o7QqyManTEd1NhnB5a6902tv9s687bGzJhOMBmlbh
         hkor0SIX/yaKQw1tepKd4Nl71pSlzwYAsFsppDfLXAKb6UkyqDG8pZIIhLc55CESNAc/
         OuDHAyKbudhUcg1cl5FqudRuuEHAjQF1BfPNug8iovzYtLbGnuBC1qaiyfxFxBektBM2
         q/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1lmwtb+9xxS1gV0xoR3drKHd7PGc7BDl/RdOHIYzMtd062AWjSB9z0ToxcWGps+peQO9eUWO9IlA0Ar5A@vger.kernel.org, AJvYcCVIRvdZwhWjdAA/au5xLuJ3dWb7wYqxIfp/4r4D7SPbzaQIvcAIa/zpmY5mowhsGOpJ6oQjjnf7Jnw8JytwMzs=@vger.kernel.org, AJvYcCVxMNXN93axTEWUhK1efml9FghZOrCvNTXylj77eEJP0hupvKK1riBuIm3sfjn1i6+nYWSZYNsT8N9okwhUivo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGRvkqWqIaWnn40iVMoICtzS9AR/qwEI/FZS3sY+O90Knpqib
	hJ8lKpSZo7bEhoZYp3jqSv+J1UKkr5M5ovgo3asHOU8G9qBwWmHOXbIH
X-Gm-Gg: ASbGncsfoKNXSldjJPLTNoOxBwHsE9J3wrPvdaw0aQXkdBo5qZrVZMt+Wceuj2lqAM5
	RDeig7dNjc9x1AL+D96RJnR66epY14izf3Z6HoYZL8X4Gz+VqqcnRud15VyKNxyvQm9jQX2PV72
	h0+SNKb2YhXVxIYEQYYN9ALt0fdvSPC0pvSH3HG3r0Oyn9mbneqeVK4aHgo54G49DY0QbuQeoLC
	mGucT8Fg148jHPqdWT1Sia7M+7pLGjxcOvZ7hrhRb2WWgsVDe5hwU9AaVcRnu2/idpRatepyNVm
	Gky/B5S9cah//rBkLk0geLHtPd3/AUO6/HT6sUUANFl5ox5BYhNsLIyNPJPERibLZYB4sRI3tBM
	6IQnEMkTvToCEX2mle0FjejESaMP8sEa9
X-Google-Smtp-Source: AGHT+IHAcL4T8yV1PZcm0QU3EQH6ydo5GkeGOb56QbE/EyrOvFaRkT+PiEsexQHyRuXKDzNt/g/n0Q==
X-Received: by 2002:a17:903:b88:b0:246:571:4b51 with SMTP id d9443c01a7336-24cefe277c2mr49034265ad.29.1757078330578;
        Fri, 05 Sep 2025 06:18:50 -0700 (PDT)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9c2b12f9sm68886835ad.101.2025.09.05.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:18:49 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:18:47 -0400
From: Yury ooNorov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLrjNze2_L_vAnWX@yury>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>

+ Philip Li <philip.li@intel.com>

On Fri, Sep 05, 2025 at 11:29:22AM +0200, Miguel Ojeda wrote:
> On Thu, Sep 4, 2025 at 8:02 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Added in bitmap-for-next for testing. Thanks!
> 
> linux-next breaks with CONFIG_RUST_BITMAP_HARDENED=y:
> 
>      error[E0425]: cannot find function `owned_bitmap_out_of_bounds`
> in this scope
>        --> rust/kernel/bitmap.rs:484:1
>         |
>     484 | #[kunit_tests(rust_kernel_bitmap)]
>         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ not found in this scope
> 
> because the proc macro doesn't support `cfg`s (moving it below
> `#[test]` wouldn't work either). I have filled:
> 
>     https://github.com/Rust-for-Linux/linux/issues/1185
> 
> so that we don't forget about it.
> 
> Meanwhile, I would recommend e.g. moving the `cfg` inside the
> function, something like:
> 
>     diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>     index 6e0824579781..2f00e91e9c35 100644
>     --- a/rust/kernel/bitmap.rs
>     +++ b/rust/kernel/bitmap.rs
>     @@ -551,18 +551,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
>              Ok(())
>          }
> 
>     -    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>          #[test]
>          fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
>     -        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
>     +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>     +        {
>     +            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
>     +
>     +            b.set_bit(2048);
>     +            b.set_bit_atomic(2048);
>     +            b.clear_bit(2048);
>     +            b.clear_bit_atomic(2048);
>     +            assert_eq!(None, b.next_bit(2048));
>     +            assert_eq!(None, b.next_zero_bit(2048));
>     +            assert_eq!(None, b.last_bit());
>     +        }
> 
>     -        b.set_bit(2048);
>     -        b.set_bit_atomic(2048);
>     -        b.clear_bit(2048);
>     -        b.clear_bit_atomic(2048);
>     -        assert_eq!(None, b.next_bit(2048));
>     -        assert_eq!(None, b.next_zero_bit(2048));
>     -        assert_eq!(None, b.last_bit());
>              Ok(())
>          }

Thanks for the testing, Miguel! I've folded-in your fix and added
your co-developed-by tag. Please let me know if it doesn't work for
you.

Philip, is it possible to add CONFIG_RUST_BITMAP_HARDENED=y/n in your
testing too?

Thanks,
Yury
