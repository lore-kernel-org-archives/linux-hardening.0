Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710941F12FC
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696371; cv=none; b=Bv6JEbFeu8TDG9YOspCK2KSGmb1709Iu3GGYmCo6fY90MQAJwmuxv4AyCci4huwD8A0G4FWSlKB5EFSCMx08Um0KBPbDvYeMuVYuCfj48bx1ZwI/A0dAF0nkJy8zpPJWBfcCHJ0VwmN33gLAMnNxUo3+dLtPKJK6MXctZnUREfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696371; c=relaxed/simple;
	bh=87hIp6c78DiL87agGJnXiJJQtjvJP3j41yfq86lXmds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NidGiTXwPLguMtHX2HgIkGEHyjI7MtsT80oV8k1Y18xuOjyTSEnR+e7qWWXfD8xNFxKXooh+yaq30FrqkqdhgwIdhkibZKeX0pt/yJ961W0iDjb0CuUdKgsn2MRf8m3Ijii6X2TCp7Mwdp5KrbN483Wlq/5xYytQlWNjsqtfSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXZ3hEM7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXZ3hEM7"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso7485841e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747696367; x=1748301167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87hIp6c78DiL87agGJnXiJJQtjvJP3j41yfq86lXmds=;
        b=qXZ3hEM7A8Es2RaRD00qLTAG4VPuGm2+uFl2IP8ybAc7kLq9iCyNmDcH1qCfDhRJbn
         vRMp54Ntm1xVqoTt9J/c551kbnpsuIX+ry8rb5IShZPGTVTiJG8I4Ln2nQSbF7zeB8OV
         cWaAh0X9URhSntaRVpAugZPURml8KQmAbbH3mqvoBrVnxRdTcIuxuSSuXXi/XdyBHPEj
         wenVwWH6DvfYWT8GIU1ZGEGv7ZcTaXTJyiitGkVKv53SAMxNDzwAsbJdGTDbpxINcHZZ
         zH13K1c21BsCpT2rAa6Jb1bovG35nKupQFkjblSU7vijWrMaiQaliE4elP5sZ4gyRq2t
         z0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747696367; x=1748301167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87hIp6c78DiL87agGJnXiJJQtjvJP3j41yfq86lXmds=;
        b=QqK2Ohhczdbcq1yk8MAi5QEhU/iFoyKFeeGFK4IaMYuou1NiN/ghdyf6hZ8sdsgh8x
         aoZwxhZsB1w5D5MhbG06KoZOAAuQK/5IZ6chhL1suD1M6chelt/6fl6L7KH2XgscIeKm
         DXemrEYzmtKB9jtxHMBErQEyDHkO9nmDttIRrTH9Wjjy99nvKBHDnXnRwtTY1qJLeblQ
         CRFcvOiDkTeHjaYVRHfSHezhXzLbQgkcygj54eCu1+uZ1bcDMWZOjZdCUNYur+KWk1jl
         cm6KgTGVIEcUXs61u4d780E01C/vkpaHUE4+xYqIOjk6l9Jk87eNlviXiO/azdkd0APO
         bUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQTM7xozzuLzla6CsrmkPzQXDyjM2Ad6n/U0BOUT6myA5QgY6kv8Sw/qIpLDwiPf52E+RtoOl3wEWIZE2P3bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0n8Y6mBGi8gRp53nRtQWrST3KqxrqgKqEADI7Gr1QW1GYdlTM
	oqLjh7xlt8DXuErqMqE21g6G+vEBX9lpQr8teiEqBz2k8P3RWRmqevL6OG1NI4QMajgOKjhhoXU
	CkYSWmzSTXPb8HkSmkplHXxuR94Foz3t3a5N6L8n2Vv28JgyBs6NvQhEB7g4=
X-Gm-Gg: ASbGnctTjOdDXx+IEVe7p2MpfdFuVNmPQMb8aG4H/TIwy7ChTfsrndIIsct1Hlavj9/
	0Qqeg89Y/ovB95k1zRdTFaZAyTnGES5Bm+C1tfMhrKJCGCuVeXjcarZ1qU3haNlPeaDBx9NJasa
	iweFdTpZLlAAdUlJOqeDHToRBjufvQlH8TGcxqBYbhrIyZUGADsMdRW2Nuj1G4HcTr1rnvvZS6y
	A==
X-Google-Smtp-Source: AGHT+IFxjVvyKOGmjWHJznPp7p3rSwibUJdBaOZqXxE8AhRSbnaIU7l2iziSz1RfAcS4JYwrPiMZ+cyz28rt7IFl+Y0=
X-Received: by 2002:a05:6000:2311:b0:3a3:6715:afba with SMTP id
 ffacd0b85a97d-3a36715b0dcmr8982767f8f.44.1747696357043; Mon, 19 May 2025
 16:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
In-Reply-To: <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 May 2025 16:12:25 -0700
X-Gm-Features: AX0GCFtuAkg0Wlc1J3hEEvQ6t_eM5QI8HhiIJsVxpbsn_aW9f8RIs4Pivn9RMpY
Message-ID: <CAH5fLgiK3T24gf6tjXGGMsjqj17dh0PFbRZboE5oXXp16yOLTg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Jann Horn <jannh@google.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@google.com> wrote=
:
> > This is a port of the Binder data structure introduced in commit
> > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > Rust.
>
> Stupid high-level side comment:
>
> That commit looks like it changed a simple linear rbtree scan (which
> is O(n) with slow steps) into a bitmap thing. A more elegant option
> might have been to use an augmented rbtree, reducing the O(n) rbtree
> scan to an O(log n) rbtree lookup, just like how finding a free area
> used to work in MM code... That would let you drop that ID pool bitmap
> entirely. But I guess actually wiring up an augmented rbtree into Rust
> would be very annoying too.

If we're talking approaches to avoid the bitmap entirely, it would
probably be easier to replace the rb tree with xarray than to use an
augmented one.

Alice
