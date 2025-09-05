Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7F4C9D
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064576; cv=none; b=m2gpu8Qyo+BmYdugToTSqzGRLANiNks20yAi5MDOrzWXeP2PFT3fAUpjVKF7yhDoVGo9ETaPD7R46TBZJDe0DCU3X0cNVjS9hVUPsBmM1YmLqBy2Ry6Q5lM3PQX3ZUdiEBbepZ2m1v8h1PuaR/rH0fR1398a3JjbLwzKR8Ob+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064576; c=relaxed/simple;
	bh=XJLm1AVv6uM85MnaVHgSBfa+5D+iLuyciRZXAoHcf1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0WJ8WtUVucLElTKPgvFfEAbAJSXtfTlU4pavcBrG8pqMBfISrDDGCwbs0tNTnRCKQ30VGiqY7DlGvaEhib4ABb/8qz+Tvg0T4TFWjFdpZpPn8POLOezAYc1RZJ4Hv2i3N7LOAyMGCnDN+QB63hdAZjCz5CqDcrkxoXTlUi1I9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTCux9mv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTCux9mv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32baaf13944so156411a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 05 Sep 2025 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757064575; x=1757669375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64x7tFu9vNW4A1Yx/Z+Ta3ooY2aSWmUmfoFqNjdxwWE=;
        b=DTCux9mva6bNLwiTLXXmR7uBJA5ywYjBDeo/Pa/ws1OJYMzjpc8L8vRjnkBnGSn+ro
         cPenb1blq2F6IG++n6mRaVSjbVktmUU5aNgE8Sv2CbOR8DCJ/i9NCR73fphmp2dzU+c+
         2CkOlX9liAR2vk9vSS184osk8Fc4EwGKD+2r2x5+kKYO7LBd05F48xt2RCL6UG3k67tz
         SVRripaX8G6yT8Rdz3N89JqEDrUg5AO8Rg2lkbvbw8PaAOsglzBrUX4nr+GwIBuo9z/7
         GHrs7aRrJFgi6InzfWkcncHoRWg124/cn5E+FZ9Qba1xjnZFNFoMbvUYAD50I03mWPBU
         O/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064575; x=1757669375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64x7tFu9vNW4A1Yx/Z+Ta3ooY2aSWmUmfoFqNjdxwWE=;
        b=rguGxlbXZ4pnMt5/FbK2zF/9/qkkYTW92BKyosIqPR46YyBlH3SE3jM+dKVLg2rlrp
         g07IFl6Uptbj3UdY3xv/rRVJ87nef6B5p2fjHjCbXf4Hk4PLgkUEoN+us0Di8lmhwi7D
         NFYollg0iNWkpB1QrVJ5BVuUDH6XeLC5CfFbh8fyd6xtkSFc2jBcXFTm6qHSegU84J+3
         ORjK+giah0HkKb4k/mKY9vtpswOwfYjmMNCaR96CO6odqw659cyWFbAQRwMepkItXCop
         tw4ZstpEoxadKmD49T8hUtCeWh9q7T+vDt/MXhNXPSU9dc0vSOo9Etvwcar3ZE12tx/O
         IE/A==
X-Forwarded-Encrypted: i=1; AJvYcCVYiA7dsTIvqSIQUmGFIBs86fLRPAlAkK0lJVCL+2wDjUSwkqz+yvNAD50J5qFFa2Em2oMmCJEzQXnzQz1tgvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsIyfI8IexMyBH5jpeImikVJzGIukdUC+NW4gFmE3mm1hjihm
	im8SudSJKyJA7BYLzGBeBP4vAW5/2/rYeql8ncwrcSrw9m/KAOQtzerEoCjXDWurYYFbsymQRyU
	1PjKmj2NEAINsYKIxTrNADZakPsuLL8s=
X-Gm-Gg: ASbGncsbP1E9YLNa4Mp9aSTS/oi1wwSc+pdEfrBkR3rjlnh02zpDIgne+UABCdJTDs/
	p0N/7CnBkYQlkezqIisaxFWFiPWnnP1K9YWJPUsYa4QwaOu0nC/1zz3pasCoW3cWfp9BHdyQoG7
	Ehhk9gyHla8t3JOYjJK95yBn9q2X6qOYhFeM1V+zCY4tLgD7tC0rZ23j3JwfGBTvqagmYZL3WA4
	mBq4pydPCWEGzexCN2CHxRykJazcp4dssChrvdM1avQVN3KHXBzPDLnBjJbM094wB8ppTBzsNZ2
	cE/LDglY3rUPdWZ4KJgxemvgZA==
X-Google-Smtp-Source: AGHT+IHgc21W7zKfsI2lsaF0NMo+Bvhu18XWT0Os3TXnu0za7ri+xyLrkcWJXeBkz5AvZXuKLhgpjoGoA4oOw4EI508=
X-Received: by 2002:a17:90b:4a05:b0:32b:87ef:5faa with SMTP id
 98e67ed59e1d1-32b87ef6076mr4514958a91.4.1757064574674; Fri, 05 Sep 2025
 02:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com> <aLnURXW_ZiX2iJd_@yury>
In-Reply-To: <aLnURXW_ZiX2iJd_@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Sep 2025 11:29:22 +0200
X-Gm-Features: Ac12FXw3K8-fRUZqrr8Rrbc-XWCMxkFwB1rv1F5RTm_1knNaTCBruur135vYY3U
Message-ID: <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:02=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Added in bitmap-for-next for testing. Thanks!

linux-next breaks with CONFIG_RUST_BITMAP_HARDENED=3Dy:

     error[E0425]: cannot find function `owned_bitmap_out_of_bounds`
in this scope
       --> rust/kernel/bitmap.rs:484:1
        |
    484 | #[kunit_tests(rust_kernel_bitmap)]
        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ not found in this scope

because the proc macro doesn't support `cfg`s (moving it below
`#[test]` wouldn't work either). I have filled:

    https://github.com/Rust-for-Linux/linux/issues/1185

so that we don't forget about it.

Meanwhile, I would recommend e.g. moving the `cfg` inside the
function, something like:

    diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
    index 6e0824579781..2f00e91e9c35 100644
    --- a/rust/kernel/bitmap.rs
    +++ b/rust/kernel/bitmap.rs
    @@ -551,18 +551,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocErr=
or> {
             Ok(())
         }

    -    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
         #[test]
         fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
    -        let mut b =3D BitmapVec::new(128, GFP_KERNEL)?;
    +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
    +        {
    +            let mut b =3D BitmapVec::new(128, GFP_KERNEL)?;
    +
    +            b.set_bit(2048);
    +            b.set_bit_atomic(2048);
    +            b.clear_bit(2048);
    +            b.clear_bit_atomic(2048);
    +            assert_eq!(None, b.next_bit(2048));
    +            assert_eq!(None, b.next_zero_bit(2048));
    +            assert_eq!(None, b.last_bit());
    +        }

    -        b.set_bit(2048);
    -        b.set_bit_atomic(2048);
    -        b.clear_bit(2048);
    -        b.clear_bit_atomic(2048);
    -        assert_eq!(None, b.next_bit(2048));
    -        assert_eq!(None, b.next_zero_bit(2048));
    -        assert_eq!(None, b.last_bit());
             Ok(())
         }

Thanks!

Cheers,
Miguel
