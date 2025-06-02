Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521CB22A7ED
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875223; cv=none; b=Oy82TZrvT4EWIWy1wcg7NR6u0xlY3MofDOxEfiujJCIAnpuJoOQHc7rGRfP5qJilT6k7AVmForfKQPH67WPJzW7FpiGoDOSMKsFW5qyVW8w/xxpBh6CySXKv9sySR15en5Lb7i3UaD1BaAOCGLUXEzTu7rbHZJOTqZR1iu0RMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875223; c=relaxed/simple;
	bh=07XG5x+QAeJhTjZQ2/UKCylVkGAFsJMZTfx4cUJDjGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npBDvros/FC2iz24lXgntGJl3u6RYmsMNFgcvN7clGSv/xgQgJ9sqYovvY6jy/lD1nMKOM+9P+YN4opsjDRS/+u0/uM/YqYYhhpqaRymPK86HxUIbs13vD91/qEL+HziPsa4jkJPVdFHuATaFrXf9SddKUufEX4YcLaz4w9CQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfiujJPO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfiujJPO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5123c1533so97465f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748875219; x=1749480019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzJqzJEUCc0XLsoz3b6HngePdRvcXa5BR8sAyxQH6Bw=;
        b=LfiujJPOaxdy40m0ZkY9eOfZVM8zwMmXk8bzlitLBCux/uqErObyEHr+hMF79EeI4g
         28xNK+QBOuFXJAAH6exY3+WUBoHyu6g0EQkz9etNOWu0r/3vmayuOMjLtZYQTRlVxf/W
         ooJwOMIQ6q4wyjup32k7+dfE5if4S3dFwY4Eux8Tfo/okaSlaArv14pB6qfX2IDf1c55
         gQnOF7sbfA5YtuMoZ7MJu9eY6ctVTxhdvmwND4CQy1U5NdWRrRC5Dio7Gt87+8Zuvic+
         y/gz/nGZ+Hsb5pG/a7OTEyhdn7840RscuUCAR8py3Ed3LB3/Ple/IV8rOYEKnKMz/i4m
         N6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875219; x=1749480019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzJqzJEUCc0XLsoz3b6HngePdRvcXa5BR8sAyxQH6Bw=;
        b=cZL4Xq4PDzUaKzcADvm0kI8NMaGhs1RnBLJXyesOHSFsKF/k9NzIjRUm3Qf6DyUIm9
         R6+zbLY6HNG4LkE75Y01q/5H/0P3yZCABR4Swd70EM7HF1fYg+kTM1nBGT+FoZ97yPK2
         INreN7OBP5NPIf/b6CkAvW3FHSFUyG3tG9UkwAz4iLrw/ZrOyulcHYH21kIP+ARuo4aV
         L9o6oz1Z1Db6ddtx9t0xvy0lGLPTA94Dh9x1I/nDc2KbFP+Or3Pwvg71CoaT/mphykEb
         sB5OyAaLJHMmAypRYjXctV2/xkul3Vk4V9va8IY8SkXwUtpRivaL3Et4kEf/PNttBB4j
         0WJw==
X-Forwarded-Encrypted: i=1; AJvYcCV+oD/H+qYZiFVtsYWIH31Y7fGj//Epwicl2z1ncGCq7YmTVoBP64LjD518t2Ncx01AmGZZaUk7lnTEFBkaHQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcrpZ0JHz305YEwriTTWO5N/noHmuuJTUJtVav+FsBCTIePHX
	Z7HhbfCrgPM/w1Eq8zKfqyw/svnUW2sp1V9l6cX8zqDN6SfvP5xfmeeQVVjolstlgxSertHgaaO
	2Xmo0PvBAGN5YtU5FcTJHehISAw1Y2GteI+TkYnGV
X-Gm-Gg: ASbGnctQApKXbOMTFRY8+HiQvRv2exWaL7rPJwmbGEgnwYhbD6f0yigRfKjd5iZEB0n
	R+PamvwaTfMAsIZZL4KYSaQHEzqNaxQA1wECjqo88ysJpUGwo6WZvm35kLY4OtdI89Ronpkv/QI
	gsALuRNcilCzTVZsHm4O0Pr8JWoEdfCbvB56wF6H2SXFW8
X-Google-Smtp-Source: AGHT+IFtXYNUotTHkadpuR3zhkQf1TtUFXklWZRqHyZgW9DzEoGcgbokF2oSS1iOj5zHldAAyXwronzMKN0qfxi3blQ=
X-Received: by 2002:a05:6000:2303:b0:3a4:da87:3a73 with SMTP id
 ffacd0b85a97d-3a4f89dcc3amr8905954f8f.42.1748875219346; Mon, 02 Jun 2025
 07:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com> <20250602133653.1606388-5-bqe@google.com>
 <aD2118mMOs8CZyGa@yury>
In-Reply-To: <aD2118mMOs8CZyGa@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 2 Jun 2025 16:40:04 +0200
X-Gm-Features: AX0GCFsPsbx9hoHYGMRNqYNAZfer2osv1pLFziy8aDAkBITPNbhAdtkRbp8KGC0
Message-ID: <CAH5fLghi4jgS+MuG48aLnYb6N6_FOeR0pLCjG3z5XdLve5tdhQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: add find_bit_benchmark_rust module.
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
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

On Mon, Jun 2, 2025 at 4:32=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> On Mon, Jun 02, 2025 at 01:36:45PM +0000, Burak Emir wrote:
> > Microbenchmark protected by a config FIND_BIT_BENCHMARK_RUST,
> > following `find_bit_benchmark.c` but testing the Rust Bitmap API.
> >
> > We add a fill_random() method protected by the config in order to
> > maintain the abstraction.
> >
> > The sample output from the benchmark, both C and Rust version:
> >
> > find_bit_benchmark.c output:
> > ```
> > Start testing find_bit() with random-filled bitmap
> > [  438.101937] find_next_bit:                  860188 ns, 163419 iterat=
ions
> > [  438.109471] find_next_zero_bit:             912342 ns, 164262 iterat=
ions
> > [  438.116820] find_last_bit:                  726003 ns, 163419 iterat=
ions
> > [  438.130509] find_nth_bit:                  7056993 ns,  16269 iterat=
ions
> > [  438.139099] find_first_bit:                1963272 ns,  16270 iterat=
ions
> > [  438.173043] find_first_and_bit:           27314224 ns,  32654 iterat=
ions
> > [  438.180065] find_next_and_bit:              398752 ns,  73705 iterat=
ions
> > [  438.186689]
> >                Start testing find_bit() with sparse bitmap
> > [  438.193375] find_next_bit:                    9675 ns,    656 iterat=
ions
> > [  438.201765] find_next_zero_bit:            1766136 ns, 327025 iterat=
ions
> > [  438.208429] find_last_bit:                    9017 ns,    656 iterat=
ions
> > [  438.217816] find_nth_bit:                  2749742 ns,    655 iterat=
ions
> > [  438.225168] find_first_bit:                 721799 ns,    656 iterat=
ions
> > [  438.231797] find_first_and_bit:               2819 ns,      1 iterat=
ions
> > [  438.238441] find_next_and_bit:                3159 ns,      1 iterat=
ions
> > ```
> >
> > find_bit_benchmark_rust.rs output:
> > ```
> > [  451.182459] find_bit_benchmark_rust_module:
> > [  451.186688] Start testing find_bit() Rust with random-filled bitmap
> > [  451.194450] next_bit:                       777950 ns, 163644 iterat=
ions
> > [  451.201997] next_zero_bit:                  918889 ns, 164036 iterat=
ions
> > [  451.208642] Start testing find_bit() Rust with sparse bitmap
> > [  451.214300] next_bit:                         9181 ns,    654 iterat=
ions
> > [  451.222806] next_zero_bit:                 1855504 ns, 327026 iterat=
ions
> > ```
> >
> > Here are the results from 32 samples, with 95% confidence interval.
> > The microbenchmark was built with RUST_BITMAP_HARDENED=3Dn and run on a
> > machine that did not execute other processes.
> >
> > Random-filled bitmap:
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | find_bit/ | C     |    825.07 |        53.89 |    806.40 |    843.74 =
|
> > | next_bit  | Rust  |    870.91 |        46.29 |    854.88 |    886.95 =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | find_zero/| C     |    933.56 |        56.34 |    914.04 |    953.08 =
|
> > | next_zero | Rust  |    945.85 |        60.44 |    924.91 |    966.79 =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> >
> > Rust appears 5.5% slower for next_bit, 1.3% slower for next_zero.
> >
> > Sparse bitmap:
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | find_bit/ | C     |     13.17 |         6.21 |     11.01 |     15.32 =
|
> > | next_bit  | Rust  |     14.30 |         8.27 |     11.43 |     17.17 =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> > | find_zero/| C     |   1859.31 |        82.30 |   1830.80 |   1887.83 =
|
> > | next_zero | Rust  |   1908.09 |       139.82 |   1859.65 |   1956.54 =
|
> > +-----------+-------+-----------+--------------+-----------+-----------=
+
> >
> > Rust appears 8.5% slower for next_bit, 2.6% slower for next_zero.
> >
> > In summary, taking the arithmetic mean of all slow-downs, we can say
> > the Rust API has a 4.5% slowdown.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Burak Emir <bqe@google.com>

> > +const BITMAP_LEN: usize =3D 4096 * 8 * 10;
> > +// Reciprocal of the fraction of bits that are set in sparse bitmap.
> > +const SPARSENESS: usize =3D 500;
>
> Is there any simple mechanism to keep C and rust sizes synced? (If no,
> not a big deal to redefine them.)

Rust can access constants from header files, so you can move it to a
header file.

> > +module! {
> > +    type: FindBitBenchmarkModule,
>
> I think we agreed to have the type something less unique, like:
>
>         Benchmark.
>
> > +    name: "find_bit_benchmark_rust_module",
>
> What is the name policy for rust? Maybe a more human-readable name
> would work better here?

I don't think there's any particular policy for Rust. Name modules in
the same manner you would C modules.

> All the above are nits. Please have my
>
> Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
>
> Thanks,
> Yury

Alice
