Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192143D9028
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510494; cv=pass; b=uIj9zwS5SsEfCWNjcv7cISjDbz7tJ2wega9qPIA7nbZTN8mMtJQRf2sY2bZAVnGQ2OZKpfF6yXry88x0qXD48Tfeo6otOhJqHZWD/N9huxqaOUAZW5AEG9Qi6T5/h4VQeo6tkxq/NkvJTpTp93lUeh2cSNbzXt1InNzQaxz1LmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510494; c=relaxed/simple;
	bh=GiADQYNsvJD57osJGhfe+F1XB5kGSaFvK/unm9lUQBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDM/RLjrqvKp3Qthf2MaZMcmQ5qlJD3oYh2Ty5XcmeFiemH/rvmaLMB53T54YmucAEyC5yNcnAHUb/OfXPFOUy9dyCptLzY+0u0wD0hk93uxdrTvVduQo0z8QLTxGlgdacpQP0Hrmimv3rLe5Y1zPVf9K8g1iVa0oyzvd6c8aJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGKC5p1L; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGKC5p1L"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso316a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 07:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510491; cv=none;
        d=google.com; s=arc-20240605;
        b=AMZG7hVlThFG2PaP3vGxfRs9NkSP/Ds34Y6BbnB+XgXAopXIH4tvpOQXU4aRPeIC+4
         Vz2DD63/f9zPviPGUTDYBz6Ir6ZjGPAf3e8/V3ch4LKAvJuTolpER2wGMQHHTLXyChqx
         vwmZ/BfFIBP1fOgUCRVq6SIFUBVWpfg3GXDVP79DpG1F06AeRG89fZTwffraQb72j/uT
         x4WtNy9T2/co1ltxsm9hdOTWRFjqQqxODSUipIJtMUrDc9oJhSvUFISvcY/aktRkNhQO
         2hYCGdhjPLIqjHUCRDCLuGkmpLVUkuYPrZygVcptv7KvUk3R67XkrgdyPkPs+EgbDoy5
         H8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z170Amak81rqK1Z7ArZ4RiigKBxs4M8ehBqJt+giuPU=;
        fh=jnw/EBD2Lo99RdM1JmWDBS5hBvOjA+1ELdokhXaMWzY=;
        b=VZngUNYN8q2wm4mt+UjPW96itV2ogpUHZp+Xuv3a2QKOw8KJAUnv5Bh2k2uLTwfj+Y
         f3wfxBy84rTi+8y0phE/jzQk7tNMBrp4R71YCCUqxF7SvN7pl1WKxkTKIq8u+Y71rgU/
         D/2+C4oA3sxrUzqWvCkSUuoowa/SslsfDiZ7Nsux2zSgkI/QhtrkeCvmkrN5USvft1Am
         MS5tgwBtyIW9MJ2CbNl8ykEp2LwcyniVf9yZswY+Bpps0xfjjB0pFY5AFdFuQoPZzhnr
         3OcigfUGAuuUCVcp08ZMmm3MiSIR3K7KTvr5tbxcPZfL+kRyNOWD9lm2U+YCNF2VSaMG
         nzYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778510491; x=1779115291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z170Amak81rqK1Z7ArZ4RiigKBxs4M8ehBqJt+giuPU=;
        b=wGKC5p1LZDIuzCdfDf+U60JYcReEY7l4MrGeB8SsKw8gNQskospwG99TpNUcVRPz3B
         aGiCSqMQxHxnhbIw7HQmqU1mtlt7Tktd9T5HGMx5mpk5w/f5jcd3pH4GU8zF1WrNVkbr
         YMjXuzqjJSMiDGFHesqsrzw3iveVBeb95/58kbnbuT/xkLhTbeTUAB3Scl8CkuSMRp6n
         G+1Kpfbo9G6Bt1A3QoALLLhT4aDSg5LeiYwdaZAkUwxNbtpag0/dXjWlxBeXBh2bYeJ0
         4xl7+OyfG5n5p7ftx4Gkk5EzSzccEYeKmLEZemFrjginEP/gBIlAWs6uym7OkbQ0xGHr
         hJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510491; x=1779115291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z170Amak81rqK1Z7ArZ4RiigKBxs4M8ehBqJt+giuPU=;
        b=nQ3Sdg+o9O/yt6zsQDGtF2wmoXfEGCrh5vQ4fHIIgTam248eO3e4xpPPWQWP4QnJRU
         9BP7AuvJEiSPjiI/cvtOyYCRcsnwnQct1vN2b3uy2znW5HzeWSw2Uwf3+BoA2/n9eruT
         ecWjbbIvW1oQXphj0HShAE5anx9SLnpGjGxEHNmGdVCnqdt/hI9xgHurkZpQ/c4xS2E4
         TcoWtfHzz3GoofgtI3J5ikdIBYEeTlA48yKiRrmwopjv1u4F8OzLERNs+U8qCwMvkfcA
         xt9s31wP0vjYVbFqtc4M0APzNNlK3EfpNdivSQLLVLXGsj0kGSybo8B8nlF9HCTeXMc8
         uoZA==
X-Forwarded-Encrypted: i=1; AFNElJ8Gzyn7prDZJbDrAizbBWLeiSvhnE3qZxApWW9NL1oMDDILWVtLAA3xmRJBMDZgDAgSi4ThkqdN9oGeRfieohc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOa+n0uoF6oohDDtRHFCVWoEpB2rnjfDAlEUK0v9kHDp5DSx3
	UHlvBHJr+qileQG5QzeOa/GbPd8ESr+5SFdW1larweMK/7DwAP6wKWelqfZT9OJiM9piDJ6b7Bm
	9fQHkwKzVpGDDYhtp6YjH/04lpGS8SGylZejC88Py
X-Gm-Gg: Acq92OE2BCQx7i4QEgcPNy6+OBrngPzVQyAjnGf6nJrdzy2q1Pw5wWczoD8/xCA1XX2
	G2O67uQif6TmfVWlLRkOuF1wJ4VWdcqFvMKzP5J7vkIBhaEXMEe62jDmonaUrcbTPMfjcioBXTW
	xe5AY15iVaYmLxnyukKNRIUVO47hD3iA9csLILNMil37ZJ9bevanJGzkvn4Ra55+Wp46VoyGntO
	3GvSRmo0LcYG8Fo4tT8uob/3yOH71a63cYscfN3KsVD5fvEr58wFZb8a/pN6jFczljsyDuSagD8
	G18pKFFiZzBNk1L2LLBdGQ4mJXSj0PloTgIZANoXg0rONseX
X-Received: by 2002:aa7:d702:0:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67f67ef588bmr85386a12.3.1778510490891; Mon, 11 May 2026
 07:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com> <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
In-Reply-To: <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 11 May 2026 16:40:54 +0200
X-Gm-Features: AVHnY4LoyjasIFmS74GQZueVkF8l7m5tKta7HqO6wHGgS7XuvrG5_IpYer7LdIM
Message-ID: <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> I think we should simply do something along the lines of the below,
> considering that the size of a data object tends to correlate with
> its minimum alignment.
>
> I do find it rather puzzling that the compiler emits empty_zero_page
> *after* zero_page_pfn - ideally, we'd combine the below with
> -fdata-sections so that the linker sees all individual objects, but
> I suspect that would create some problems elsewhere.
>
>
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -452,7 +452,7 @@
>  #define RO_AFTER_INIT_DATA                                   \
>         . =3D ALIGN(8);                                         \
>         __start_ro_after_init =3D .;                            \
> -       *(.data..ro_after_init)                               \
> +       *(SORT_BY_ALIGNMENT(.data..ro_after_init))            \

Oh, neat, I didn't realize that's possible. That seems like a nicer
approach... (Assuming that it doesn't cause cache efficiency issues
somehow, I imagine it could be possible that source-code-adjacent
objects should also be located next to each other for cache/TLB
efficiency... but I have no concrete reason to think that, just a
thought.)
