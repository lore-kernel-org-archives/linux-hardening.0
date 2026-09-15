Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E04349AF
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453938; cv=pass; b=sYxLBT5s8qDg35aDn9YH0376xk6pb9xwt922ot0JCYHM2wIP+9ykd1KqSI1ELYJFzvLFAjpqX1iNgBQ/Nce76JYXqc9OLIcmm6qxMah7B3C/KeLtwCeQhQqQ6AUGj1wgbPJQcscwZwEYJZzUGcK87tZQ1ghEL1mBs7vW7vCWCnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453938; c=relaxed/simple;
	bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hixPeLJxXhCslZwtWLeiv1zJRtLxmOxTv5cPG3SUXM4LK4hDDDpICWGQZW6Jg88na4huwjTxYkVWWHPz0Y2uLEx14Ap6EOz9tA32iGhTcOaqhKPCnfcgViakzyCUX3PJ9yw+ZFUPdD6lFHZVGp0FfJfttBj0P5s3fQ7LiuCYt6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5CRJ9r3; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5CRJ9r3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39da614ab21so476002a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 23:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789453936; cv=none;
        d=google.com; s=arc-20260327;
        b=boS8Pq2P3TkXt8wTTD/fV8XEZP8YxRF+6qqo4fapWe95S9fE/q6AP7hBPRVx2O3PSE
         gkRXiecAo2uFvG/8kbR3Dk1xgi6bC7LfPrHU7lN30KHP7Y2hc12UFJ0ZZh5NssGTOrc/
         FyOmiVSic7dqqrDF9a8Zu56IOlRWvLKwXGLZ3Xze7aN7CB9RjlRS5XknpL0Cq9qtTKZu
         5hZXHb1mvEdppapZ9bTbNffi8jwjxYXGVdaJkw3Ex0dwCdAf9hVSQaKrYz8PY/wYYM6i
         URcwNPRvTsQ2gDiWTlXokjbDFY8lAACbjfkEfS2oBX11eqEdq3wdCCMa8nBiw6TQRQva
         nSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        fh=9nX1gLoY7G8Rr5haX/HjYAE4snuwgCS7b5nXjWpyORs=;
        b=gg3LbOdOuyW9r/I03xfCNf/+bnDo9r8zYvpOvE60rLh6ox38UEg01+Fx6Ax+iocv7+
         erFhAs5dKc/NcCrZeV3JBcPgFZAo9McIQsFGOH3Na9CZp4QY6C4y7040sG1mng1VJDNj
         oBY7u8Bo9kHW8qV/5Ewhprv9gWIfIZJWPME1ahyWtVadhs49csK4t0okvPvvLeRE8LDY
         qD41OSCHfo4uCOIvDmp65/Ihu4Q4dt1Doe/3Jgc66ULqe3ml24JmAvXasU2voatxMVz2
         9m895mGQQxv3sFZnlrnUSrWhRp+Om2w7iKAFzxszjrNINE1r5olDs3p7tx85d0K0UDmI
         /Cmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789453936; x=1790058736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        b=G5CRJ9r3yU+mY0l+N74B7S/Mjb6TnQqtFCT50TddgkDTFjmeAX7LKtouzxIblxQu7Z
         h7Z4cg9OQsXlODWiJ4sgVavpB9ZRE2A1fqvhWaI1/oMaUm3ZJIy6GIsgazv3vqM5McEt
         xGkXdE0pqihCwZshnRy0aSMMIslo+uYXDX7ueQ3LEQJU48Z96j4JVTpAVHnxfBhXKjop
         mbYpAvHUDnqE3aI2WoyhirXJaLKHJWQBpEM8NK0EDDeCtbvcdTvgNOOCPFFavZBqhcMf
         Bups1FuNo0+Wrg5gZmFapMkMsrAxt8m5jDvfLJ8SCIT13V3atN0IADBmd6R01ATsyRkn
         s+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789453936; x=1790058736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        b=hv6glhaK+weFHg4n3VcdNFJ5GL8BtgvKD3oHmOd/pyP19Im4W8Q62/LKFqmWCrcqWn
         hrBg5CWHQhwuHSGPAp7o+0IMhGXYtKKkdsfva1vU9RABWzQRRMs9WDbIF5QIeazuVCSB
         KZ0zg+rdepw+eU+trAC0hRY5A09XmgcuBe47GMbHOD48EP9obHNcNUHFc2bGWJItwXrr
         D3GxOf7a5d/SnPKTTBbHnkefftf/mRlfGyWif+lLcHyEk5hSaJW5kq5UNsKy6pBWIBgP
         TwlRxmYeGVOKcQbJk7ZOBvTvoW+QdpHW8YEn6nNa4wuDyc9QtgPD8s7z3n719MeHSA9M
         z/dQ==
X-Forwarded-Encrypted: i=1; AKwUvByBe/790Ysoro3eSFIFtTrw0sgiu9A0X0L/7fjO8bqpxnAPyTn+TVJZk/a0SNfHkCKg3YsS3xP3nABxopqHf9k=@vger.kernel.org
X-Gm-Message-State: AFuF++lu/gblaoco61ZMyl0pd47kvYCbrGwzRXzUCOybe8KlMiPnyMOF
	CEiKqteE3aCpyBkd2MlrlzRZi326baCQx20xCYkTpnxB00Ddl1ikBsJIPeSu5nTum9QYVu/kZ56
	WLawFn5ANFtI6W7lED4N7+I1uwBXyd2M=
X-Gm-Gg: AYBFou0zRBOiGMGjTPv7kyQprfMhD8MPYLFwNsXgWE+kDnhgjNlz9NlQ/B3YDHA1nxQ
	jLUtfhqvfJwBetSnrsAMED3KbVIP5drEGOVF4+qgLHoiLWWv5eji/L+dNQ6SAX6GhmYmOybH3Ea
	5Op0mo5VQqPj+G5EeR3NmA4XdaT72hzsmfvlkxFECVKA93TkoJGbBsrWpWQJ8kuq4N8jBjwBCXu
	ogtw3P4pYqmKumUnPCsKtNCkbSJEOZkZ249ST0ytxCMLqhgpC2gElyJhKtTTRPMRvbFLvrBDuAD
	AfrD9U+jIhqzLAsom1qjqh3DZAwFGMOID0MdpgiIlPO0B3tMoVOEiBNR6yg+ZiCKpPol2Xj2k9R
	yAtITKopXnFKUeH0hYiBLn+rILpjqZ87cdKrU/BTyvnhCyHIDxMJFkez1LOw6bhAc0HAHiLqPBY
	GN1JINI7IXcPlKp16fXXn8zYBMSKwydHhqL6co0xIrq9tQmYmx/A==
X-Received: by 2002:a17:90b:390d:b0:396:d27b:86a4 with SMTP id
 98e67ed59e1d1-39dec02ca06mr8212249a91.2.1789453935885; Mon, 14 Sep 2026
 23:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org> <20260914-build-speedup-v2-18-39817ec5db23@kernel.org>
In-Reply-To: <20260914-build-speedup-v2-18-39817ec5db23@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Sep 2026 07:32:02 +0100
X-Gm-Features: AcwNN1XuX4yn0GdoJd77RsJx70W4snllWWAl7hBlEl0V9VQzhH3zC86aEhQjx38
Message-ID: <CANiq72naY0=iBaxfbWQaPv_06X4SjFSix4NybDQdht33+Tcs0g@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] kbuild: rust: optionally parallelise rustc front end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> Rust crates are compiled in a serial chain on the critical path - core,
> bindings, kernel crates and then the drivers - each a rustc invocation.

This confused the LWN article... :)

There is a critical path in the graph, indeed, and doing it in
`prepare` is painful, but to clarify: each crate is already built in
parallel with others where possible, and the fact that each crate is
built by one `rustc` is unrelated, plus the flag this patch proposes
is also unrelated to that.

I guess the LLM was trying to add context to the numbers below, but it
looks like it will easily confuse readers.

> Each time a change is made to any of the bindings, it triggers a rebuild.

This seems oddly focused (i.e. not sure why `bindings` is mentioned in
particular). It is also at least independent of this patch, i.e. it
will remain true regardless of the patch.

> rustc has a parallel front end, enabled with -Zthreads, available since
> rust 1.84 [0] and therefore on every rustc the kernel supports.
>
> It is not yet stable and its output is not reproducible, so it cannot be
> used by default - stabilisation is being worked on [1].

Not sure what it means by "by default". In any case, the main issue
with the flag is that it has had issues recently, not so much the fact
that it is unstable.

> Add optional build parameter KBUILD_RUST_THREADS, which when set passes
> that many threads to rustc.
>
> Observed build time changes with KBUILD_RUST_THREADS=3D8 (rustc 1.98, cla=
ng):

I assume the improvements are most notable due to the work being on
`prepare`, i.e. there is no other work available. When that is
relaxed, this should be way less needed. Though it will be still very
nice to have for full Rust rebuilds, like when changing the compiler
versions often, due to `core` mainly (e.g. I have to do that often, so
I would like it :).

In any case, I am not sure about adding a Kbuild variable already for
this at the moment, especially with that name, i.e. it is not really
"threads" but "frontend jobs" and the flag will not be called that in
the future anyway.

And if someone wants to risk their kernel builds, then they can
already pass the flag today...

(We probably also want to know what the flag will finally do before
committing to particular names, e.g. whether it affects
codegen/reproducibility in any way. But perhaps Kbuild doesn't mind
having new variables that may be replaced soon.)

Thanks!

Cheers,
Miguel
