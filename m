Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1E30BBBF
	for <linux-hardening@vger.kernel.org>; Fri,  8 May 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257635; cv=pass; b=H+hKPZiGFM6kniLm0M6AVptCptBeUtgaumeV0hXLIliGnAuVFInnzB9OszdfUthWYzQ7fLkvAz8G85zvZsb2VkcEP4fFlCHtJEphs94q//1nRu55y4dFNNxYMO/eOTYZcwMokT42oS0QdxZAQa3ANf4Pftjr7dml3uSwxt/QG48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257635; c=relaxed/simple;
	bh=q9+X7pxW5kSsnaeT11MvKU+Neq6+weTqZPmaeqJBu9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqWyDHJ9xcWKiPfXIAEzAiT9zKYzigndIk+a/7Liiiv+JiRc6Tlm8WdFHtfdCDFLl55/EpkKSJ8PKdHsxzAJZX0f7JfHtK2rRwVLJTmNJPm50nYsNSmvDZpfAllVAiscZet9KeuhB1rixnKVfNaMYti3z9fMV+hWr2xxTzBc1+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3Qs6PD0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3Qs6PD0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9697so9309c88.1
        for <linux-hardening@vger.kernel.org>; Fri, 08 May 2026 09:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778257632; cv=none;
        d=google.com; s=arc-20240605;
        b=gs7e3cSQJw/hhvJR6BdL1oe0SrBMX3TBMm05ghohUu+HWsceCAAmH5E8zCZ7qik0yi
         CJnxyQR81DoITu4XgpWnA+TbzUt31CoL+itUi4JysyjNZoXGOWFV0cSDG2Td7VUXkNSS
         mOXaj8fGu/rzfexqW6qR7sjSv6kREfJ6GbU9kivLstsVxFWha+IOmH14rJK4xsXC1L/V
         lfJK6IwRsUjdtztvFKR5C7B+FLJmU55jn4grhdrJ5C8MQR5NDxAaxFt/OaKRv1e21vu2
         WruQWX8EtBRoXu0+OXHfObt8sxhZqUUVShx4ncLUiU2zF2cvhxNhLPSV0l8ywzzLmoX0
         7mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        fh=hZZbzeD+iMNcRDMSnAPdiktzyYXMSvPwSb8fbvPCP4Y=;
        b=Z9pQa4Ymk/SUarN96/tvoOxdDQB/xzhYzCgtRoGjV4o2jR6KN6Ye9vI/GrPkwkK+ri
         evI2ILRtvdYyBdJNmUA30fl2d+oxVGos1Q8y8+CFA5wzI8v7aDRu3HNTFJKH0lbjQmGS
         bpP4oGaL5Ow3NRaYo/NH/1S6qIlhl/Em4QA5VKHKc0AS3qxudnyX3fxGwX1ZdCGi4x1u
         FEHrsZe3L+8mJ1KuWc0WPw1O1l6jjQ5GA0ikFriYFAun6ln8wXKxc/rjMmsr/BizzkFJ
         8d07mk8pCFBT/Hh6y3QiY7x9cFyGIzgwMrn5VLTp311RBkl5+1GQ+0ggV1LMNt8WSJH6
         P4KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778257632; x=1778862432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        b=H3Qs6PD0zJCltlHQjAbX47JZXO4XNtngzDMvSAlbVtI/5taLqbtlRwZIYVSJ1urbxu
         1fyoY77sluDH6mvzhkinIWhkPMFtCc7ftFi55tNXyCsgRkNRQ5hsCNOxP1Ga+IE2Vu8n
         +j5lOQwfYqfHS6B1dxF/Lo5GLd+LBJP7zx9mrNMpd4F/w4VJxvfQbAugeIHeml5I9lqa
         +jkBtYc+wWDq/BpIiTlJEuR8Gyqmkn462VQ1v0V+My+6iuV0cWEWSHijNeDeZCkhXTRV
         usMheqhsoT/kOQ3FXsZocvzq+srT+WCPyVirbaeqyF/YTbKOFC6uUa15xq3qwqGT0tcA
         WUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257632; x=1778862432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        b=ej3MWauhAm2tqp1VS2k4pNCb9XfaWWA1of8kw/EmGTI5oaHc8rbVg9YyC0AlVk1q7d
         HOa7HMKuJZnshKdYxxZo887YIlIhwI6DfXOl6HjqaO6yc3OgRYLptxEBCSn52lvgno53
         rrE84EFmFlDjsEOD/nYItc/GEtym5AknZVMxU9tRIM/DUhxywqTESUDWgfrfixISMf0n
         ZjWCoHWK1vRS+5CBiM657UppSaKajwrwNiHNS4t6T0GEpyUbhxy26J1uQPl/wgEjGpPE
         lYbqsKUZnjfYU4aHDgeoj7ngaJvxYBaV/f+mZPuJDwPF0XkOIRN/1YRffmgGWSDyF05i
         M3TA==
X-Forwarded-Encrypted: i=1; AFNElJ++p2yV2tmrmhxgZHTLclO7oO9y0NNLVt0XNW/i7DbiiYjvX81if6Io/ndmEm13FG6dGTfUb7yMgfCSsMUPDnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRk9CZunrrOeaVeFLGsW5eUB5rVCZSJCO977EtA8bWACyQie3s
	d+74aqXBrepMaqd9+MQ6rxZekPpws9djnYU8ceioRiiOr/BVjazeln4MjMPfc2aFjISkdNKCEby
	oUa/RiNfYvzyY5X/LQtYQsC9d6/CmlwlPnQg1qmqQ
X-Gm-Gg: AeBDiesPiPdh51FxX9hwa4BiaU5dw1v2uXFwoDuxmhzmFdWr+AoGhh+nUe1iCYJOvcB
	Uk7CawUANsN2UihXe/q573QpEBtIjuOhtQBwvFR/7S0/jqXmN6HMYcuYHcrKNORVNKDpNOL4FEG
	8AAbfn1r6bm7PnF7hUUVYMB4zbEEHhpGwd+aY/KrWRNjkihPJPSnvR8xY2AhDiYyPJaPOF672AG
	taV5X9lCYuLu4HpJbEXnbH+py7dGscZHm8VbiiVHnvLZ706kKyvTGe3bvXnGxxN/OE28lP4TugT
	kFnNi1+urCUEOn7WrqhNRSafZ9IIDJPjDCOW4NdoPcDc3KGW
X-Received: by 2002:a05:7022:1b07:b0:132:1e01:86c6 with SMTP id
 a92af1059eb24-1326f1adf79mr146458c88.3.1778257631452; Fri, 08 May 2026
 09:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
In-Reply-To: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 May 2026 18:26:32 +0200
X-Gm-Features: AVHnY4Ie_zoehI8s5zgNqv30LukVADTdXtN2wjCtxwLZ63ygAkVHFVZmFiSPGIE
Message-ID: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Seth Jenkins <sethjenkins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 6:12=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> Put the zeropage in the read-only data section - nothing should ever chan=
ge
> its contents. Set up a new section .rodata..page_aligned to mirror the
> existing .data..page_aligned and .bss..page_aligned sections.
>
> There have been several security bugs where the kernel grabs references t=
o
> pages from some userspace-specified source, via GUP or splice, with
> read-only semantics; and then later on, the kernel loses track of the
> pages' read-only semantics and writes into them.
>
> I have seen such bugs in out-of-tree GPU drivers before, and recently
> upstream Linux bugs of this shape have been discovered as well.
>
> One problem with these bugs is that fuzzers and such will have a hard tim=
e
> noticing them, because the kernel has no mechanism to directly detect tha=
t
> such a bug has occurred. It would be nice if we had debug infrastructure =
to
> keep track of whether file pages are supposed to be writable, or such; bu=
t
> for now, the easiest way to make these bugs detectable in at least some
> cases is to make sure that writing the 4K zeropage is mapped as read-only
> in the kernel, so that attempting to write into it immediately crashes
> (unless the write happens through a vmap mapping or such).
>
> This patch might increase the size of vmlinux by 4K since .rodata is stor=
ed
> in the ELF file while .bss is not; but the compressed kernel image size
> shouldn't change much, since it's compressed.
>
> I have tested that with this patch applied, calling
> `get_user_pages_fast(address, 1, 0, &page)` on a freshly-created anonymou=
s
> VMA and writing into the page with
> `*(volatile char *)page_address(page) =3D 0` will cause an oops.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  include/linux/linkage.h           | 1 +
>  mm/mm_init.c                      | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)

Seth pointed out that this is more or less a duplicate of Ard's
<https://lore.kernel.org/all/20260427153416.2103979-19-ardb+git@google.com/=
>.

So this patch is redundant; sorry for the noise.
