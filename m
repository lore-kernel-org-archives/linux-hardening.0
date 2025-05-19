Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609461D63F8
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681264; cv=none; b=BRTJYHVnwoFEwNA7hMdUp/tTwE5bhbdIYRp9boiafkNxeQ8qMST94r0c1mPuh8vA+O9QPek8p7RLWGbH602f0mGnkwKDGNbdGJKBnfNHxfDXMTfTZt7wjtk3032ecp+GpkM8HwsteWIzWmkSUNgWpxUHl9H+Voexx8mgGzJKp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681264; c=relaxed/simple;
	bh=MSErew5+ACRQkf28Wtt3Qf/GBeqTGkiL/tGZcTWms7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgV/L/FTqHeUjkK9CcubuDTzBCE+hbqSgbDol/zB5YHZuFVpYa0l2PJdASfMJ2TAwdhHZaMRx/GpNoNlrihtKefllqBbvroVu/r/dN6cE3QBUprU5ll8w2IMej3MQYZ6cJa8OBiaJxdOQaSRg7TE8SQkdAFqKmzFDqWFUi2OFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5hvdWvP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5hvdWvP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso17921a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747681260; x=1748286060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hN5vAz1EdbBwqFfBMnJq2dtp36ywL2p8BkzcpKWQzA=;
        b=I5hvdWvPziFhvK6K8O3MW/PHHsW3iGbPtWa2Z0CNA9Sc7fRuyFqoeqZC8peQd8vcqN
         g9YqrokGVStqZw4qo5Ip8JdsDn5L/TeKxO7tajR5c7ck/+vOJZ/dO22hNwuoh/YU+OAe
         MIkEoKlOUDGe5v+fj2z2nv3SC2lxeuqKlOdyIJzSjqWOjyvI7Gm5DhXHQs7pKL0xmYtH
         chJ8B/kGjKs+3Pd44QPUVYNakVCej5ZJXK3cIsR5pgP9RNwnS8QwU2FhHLroV69Bb2lL
         DWgC2V2jA02tt+1ZdKdzkW5abVGbuCGsR8W76DAOvyue1YtHRBvVAWnXvSu6wdYJFtk+
         V9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747681260; x=1748286060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hN5vAz1EdbBwqFfBMnJq2dtp36ywL2p8BkzcpKWQzA=;
        b=pGAxvsZIP9Va0XGEYpNCGdbMtqMajvi/RMWIFHeWqXH3tnFPIYkJc6To+b4DwO9LTu
         TxknMo/Z9sS+nfwKyAGWYRSm/zSGM9yUlqRXCsjspTsdEMr+kf0hSM5hoj75TcdmUQRG
         dt43RoXTKpt0+aGOnJRQE9WQbhgXeQEbnMxYfz52jJf3I++F+jSyYN70UzeJDy5LLiBu
         cCi13I6F8fKDrHObbVBHRhvom9HXTW0xEzwXAYj94TRiCe4eZblQ0oVE0+N00zPEQhIF
         Q5d+dBGbfB4pafQ3CzoMuZb+wPhhmK5ktS06Bdtnx//a9QMtp6qS+LWgoBQUCfXEYDCC
         BLjA==
X-Forwarded-Encrypted: i=1; AJvYcCVkaHmVSrVSQvtSne4Zp2m9bRK5fcXwd2XgcdPgI4iBQcMmKVXOdgjMeuoMjMCxkcEFu2BaGYv3DI1g5vyVGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNZDRBQ4cQ6biE2rUTq9MG2dy9hKCeOODeTt0gtgLId6z+fkN
	ie9Sk1cjHtnWQUm+F/ZkPxJH7pn+3VvTm3NWN5JciANI27XFI861MDDdH+95C7+mQbLzgk/H1hW
	e6rE9iqfaDkiQ7NEuOaVEJgBwbnhIi999qZxyHgt0
X-Gm-Gg: ASbGncvEKOhFJWsvlFYkDJOMcdc3m3p/30HwvgyVKJqtwvxMOMi3Gtz68wTPEiEsr8a
	MomAgAM9CktxEk4V5ykptW9z9QJfLnpDWJyHjr5nyBeK39ncbRPIYXzVKXCWHa8mAniCCxbRf3e
	iX8K1CLiw9EAWJI94j0yej2Kr0aC55O2uEg4QnyerFtuTr8UFENNmUDdWSLWLA
X-Google-Smtp-Source: AGHT+IEcaN3CHR93+zm/lsgdZIc2sCgH7bgflkmmx4M0eJD/BJhIbH+s8jRNwy9tFg4oqbe8ZmXIbSnTLREk8LUkNmM=
X-Received: by 2002:a05:6402:368:b0:5fc:e6a6:6a34 with SMTP id
 4fb4d7f45d1cf-6019c7917b7mr197976a12.6.1747681259363; Mon, 19 May 2025
 12:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-4-bqe@google.com>
In-Reply-To: <20250519161712.2609395-4-bqe@google.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 19 May 2025 21:00:23 +0200
X-Gm-Features: AX0GCFu5qYh4lvP7UwntlRr5HD6wtjX4sn_MaP3l7ErUgYn8ltQ96CWvd52R83w
Message-ID: <CAG48ez0rGwFeVtj6AKg8YY=D9Atvp1h5FdW3szswEJsRmkR86A@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 6:24=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
> +    /// Set bit with index `index`, atomically.
> +    ///
> +    /// ATTENTION: The naming convention differs from C, where the corre=
sponding
> +    /// function is called `set_bit`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This is a relaxed atomic operation (no implied memory barriers, =
no
> +    /// ordering guarantees). The caller must ensure that this is safe, =
as
> +    /// the compiler cannot prevent code with an exclusive reference fro=
m
> +    /// calling atomic operations.

How can atomic operations through an exclusive reference be unsafe?
You can't have a data race between two atomic operations, and an
exclusive reference should anyway prevent any concurrency, right?

> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub unsafe fn set_bit_atomic(&self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and the caller has ensured t=
hat
> +        // there is no mix of non-atomic and atomic operations.

Aren't non-atomic operations only possible through a mutable
reference? And doesn't the rust compiler enforce that, if someone
holds a mutable reference, nobody else can hold any reference at all?

You wrote yourself above: "all (non-atomic) mutating operations
require a &mut reference which amounts to exclusive access."

I don't understand what's going on here, unless you're saying that
Rust does not enforce that an object ownership transfer between
threads has proper RELEASE/ACQUIRE (or RELEASE/CONSUME) memory
ordering or something like that?

> +        unsafe { bindings::set_bit(index as u32, self.as_ptr() as *mut u=
size) };
> +    }
