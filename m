Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01826375ADF
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788724408; cv=pass; b=N9hpOhiqOpepajFEd7wtWmt/GBJIClfrcCxOyCzk7tq0dfpWPJ1Dk/3Rb4UvhVjI7mUCwTcoDAVoWAzkbNUWugKFH95n5c0lupDgGfde1SKjIa1TnsB9IlXK7yTR0WaetXByZJBlytwEs0mORlc/8SMD/YBNYMTLDSqlrW4QtjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788724408; c=relaxed/simple;
	bh=hSYT7Bdx66+CfzHQHP4O4JmmdfZPM3QZr35weq55SDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJHdRPk0n5NORd+g0a9PdsQ1zBHyL+FukxCHXJjKYp4WO5QtL+cP931qdYGRllLCCyVkUqYSk2ng7ZzfBgNLRLpiOIBlkUcQW0v9aWStmhFPjm11J9vCckRmJm4/zqIc31gqRG/DZuh/Lww90tV5easivW6xiHxw3NSs0x3Fxl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzWMh9UC; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzWMh9UC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so3998828a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 06 Sep 2026 12:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788724405; cv=none;
        d=google.com; s=arc-20260327;
        b=Kax9GPt/cYMTNhJPrlcFQSwxhfW4u5lFxHSEEOPslwEGWzSdBz0dbrKBE6tYb9GmUY
         SqJ3mc/PquA+4zgDGKG0aNzKn0tp0Ise1UPrBmS4ndIIRAfhn868F1D4kqj3noYl3b/n
         YBUmGVIWYUA5leYp2GAhGIjufiR2XLkPm+QSpfQS1XP4PEpmTuCJifcIGEHR/+Go/I74
         w9rIxMMyWdDE/d2+nYORHYHFCXtVsJ7jD4OlejhDmfMLuDehg8VsOguyISff/FmEp9SC
         g51llyV/c3h5sG3cYW0odI+WESunMlTv9Fqpj8IpSlYXh14tUYyN6fz4VhY+gmXVv3Pl
         NNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DxbCH9V+QwRl/rwfPKpCRxtVrgQCFOwACk6jwY2+Cv0=;
        fh=7KgUZiZHqVBLmHzJgeWvUPU3bvJ8DIaNIxMP4S4ds6E=;
        b=I8Rpkpe+1JtgOkuCsKJr9q5YJzsuZvCaoYOnBeRlro7OZItRxiDlMh1Ph/JeNvTEBg
         9wD0jRoc7MdmbzyGOJ/uVKJzo/SKqJlUiqDzEY7aWf8EktM7W5jkFe7NDM5q8ywvvJTe
         5q9skA8MUQ2m9J2fJdYA0oAzYNCItQbfkr2vwVzsPG8dqhpVQ7NK3TZUCSm8wWDMHh93
         olDfu2rosvapzUMkK6Jni+rhATfM8H3tu+/4XzxkaVRD3cjXsYxPF3f2YegYMUb0Hj/L
         Obqx5fA9W9tjTXyH6uTaInR5N+GLrZ8wXgLXKFxoiyu0Z24EAacxLji2gVgiD1cLeQb5
         euxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788724405; x=1789329205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxbCH9V+QwRl/rwfPKpCRxtVrgQCFOwACk6jwY2+Cv0=;
        b=OzWMh9UC5Kh70Ch1R76xE23eGWOVSAOID3BsCrc6GAuvQvkWJkBfFLRCnuS7qE/17q
         iUdFtwm4UF/sSJ3QpsE397YLo/s6vZXPFJa61RmwO4QXP8Uu88IQeIOTPVmFCrjF9oxz
         DZgta+HbGgxnAxBr8h3kD7WTlwaixQOL8bXiDbMl7NPNQCYaO62HjERqH1GwyuQlDTC5
         lVbofwBXHIxWrcE4gRdYfbLZ4wJJ3tBLuMEXwFraHgxndjVGMoupiT4v0pTNJRsaQ1eP
         NVkX77abMv14+Vj7VdfgYNRJIg53PhjuLRaJchOji1d6CsxXRDzixu0iHviIuCqHv/QT
         cJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788724405; x=1789329205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxbCH9V+QwRl/rwfPKpCRxtVrgQCFOwACk6jwY2+Cv0=;
        b=HOvcwsj6WPTDx5PZeRklt56A6Lm7RqK/oKZKBzl/9s1oesICxmdP4lNWWFQIO0drLo
         D0b9YU4PZE+tM9jRchBLL9yvCqogj8HuS5BYj12r2WgEPUoW/lrH4rxmLEb2PAL7RH8Q
         tQ8ePF7aOXbKrc7OaKwnoytUrJSa0OGhdTsu6QZeHyU48mDjGN8j9dDkghqDPQtnvHnz
         89RxNGp/yvoLcJAGlZUfRpg/4Mn0Dlayr5NWI6bpwYbXEm/iGXn6ubxU/cDNgRz+ezvC
         r/bklsRW6bMlbombfwsh5g76PD2BDEgCTAHvnCWOWtHOX2C1VJuqs/1QKdZrmqdpY+MC
         QL2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMZbG0kiJKE/Pe/NaOKCwszt8bQ+IgeJvDKR2x7sNylqZeXiKh4GGSh4dEARxUCBAjkCl7bYJTQQvKSp5QGYM=@vger.kernel.org
X-Gm-Message-State: AFuF++mbLV7IiP+0FkTJ4kiKdtaM0U0AyNJFi9veMMKBGQl7rsrv/Cfn
	i/cS2qXh8odeYUIqd/ZWC4EKygYH5mpx13Kyb/etkhsOrHMYo1dyCvZJfAy4U1TjQkyEkkOzqIc
	PRnGgPu/e7eph4tkvG9BLsutnuTMG3IQ=
X-Gm-Gg: AYBFou06F1K/KB2QLjdPxVCHF8h198UPwebD8U6jW+2Vudk/w+IF0CKlE7aVlv3Hlnm
	bgy+xoBsS1pe8f8yT9byJtW5LZnm63uXdwZn9OSjjlI8r0x6XFPQVhyPrEZ+bqHUbzRgc5tkywC
	Opz6Qx+BKpXcRqTCg5k5KgwZ0zrpGCn8zsRnqV3wKFSmdpyzTZU8iAcyQRRtlrJJZOtCbt2CBSt
	Vy0wNo7VznaYNzcOpH+VeowtdWD/oC7aX1gk+Jbd6+ujVQ6yT8oRcHvnjIbvYsrjL1FECKgfCuz
	lvG+20TkWIIUy5qUobzW/NZLzahhxa75fNKTS8KR/RfeJvCV1r8O2HTjFNGL2r4H2eFLJVjUZZM
	7QqUp1bZh5JpWewLRJvS8jQy2D9H4Sfk=
X-Received: by 2002:a05:6402:270a:b0:6a6:32f5:90b4 with SMTP id
 4fb4d7f45d1cf-6a7e90a5f76mr10811303a12.22.1788724404883; Sun, 06 Sep 2026
 12:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com> <20260905-arch-kconfig-options-v2-v2-13-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-13-83e8245761a2@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 6 Sep 2026 21:53:13 +0200
X-Gm-Features: AcwNN1XQRPDvO4h0CLOCTqDWdsWEz7RUDSJzPl7o_oxwW7z9viJRHQIo11NfJJY
Message-ID: <CA+=Fv5REcH-Vj71gWidKiKiOvFUULV-uNKBP-sZGJ2XwBQa-BA@mail.gmail.com>
Subject: Re: [PATCH v2 13/22] alpha: add ARCH_SUPPORTS_PAGE_TABLE_CHECK support
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Sep 5, 2026 at 9:29=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> Add the page table check helpers needed for CONFIG_PAGE_TABLE_CHECK
> and select ARCH_SUPPORTS_PAGE_TABLE_CHECK in Kconfig.
>
> Alpha does not support huge pages, so pmd_user_accessible_page() and
> pud_user_accessible_page() always return false. pte_user_accessible_page(=
)
> checks for present PTEs with user read access (_PAGE_URE).
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Matt Turner <mattst88@gmail.com>
>
> Update the helpers to the three-argument pxx_user_accessible_page(mm,
> addr, pxx) signature introduced by commit cf8771ca4cdb ("mm/page_table_ch=
eck:
> Pass mm_struct to pxx_user_accessible_page()"), matching the other
> architectures.
> ---
>  arch/alpha/Kconfig               |  1 +
>  arch/alpha/include/asm/pgtable.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 1d28fa8d3b66..da4ec8399517 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -19,6 +19,7 @@ config ALPHA
>         select ARCH_NO_SG_CHAIN
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> +       select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select FORCE_PCI
>         select PCI_DOMAINS if PCI
> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pg=
table.h
> index bdff33b505bc..6ebdd90f3035 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -232,6 +232,25 @@ extern inline void pud_clear(pud_t * pudp) { pud_val=
(*pudp) =3D 0; }
>  extern inline int pte_write(pte_t pte)         { return !(pte_val(pte) &=
 _PAGE_FOW); }
>  extern inline int pte_dirty(pte_t pte)         { return pte_val(pte) & _=
PAGE_DIRTY; }
>  extern inline int pte_young(pte_t pte)         { return pte_val(pte) & _=
PAGE_ACCESSED; }
> +extern inline int pte_user(pte_t pte)          { return pte_val(pte) & _=
PAGE_URE; }
> +
> +static inline bool pte_user_accessible_page(struct mm_struct *mm,
> +                                            unsigned long addr, pte_t pt=
e)
> +{
> +       return pte_present(pte) && pte_user(pte);
> +}
> +
> +static inline bool pmd_user_accessible_page(struct mm_struct *mm,
> +                                            unsigned long addr, pmd_t pm=
d)
> +{
> +       return false;
> +}
> +
> +static inline bool pud_user_accessible_page(struct mm_struct *mm,
> +                                            unsigned long addr, pud_t pu=
d)
> +{
> +       return false;
> +}
>
>  extern inline pte_t pte_wrprotect(pte_t pte)   { pte_val(pte) |=3D _PAGE=
_FOW; return pte; }
>  extern inline pte_t pte_mkclean(pte_t pte)     { pte_val(pte) &=3D ~(__D=
IRTY_BITS); return pte; }
>
Hi Matt,

I tested this on a two-CPU UP2000 with PAGE_TABLE_CHECK enabled and
enforced. A userspace test exercised anonymous, private file-backed,
and shared mappings, together with fork/COW, mprotect(), madvise(),
PTE teardown, and refault.

Single-process and concurrent CPU-pinned runs completed successfully,
with no page-table-check warnings, BUGs, or oopses.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

Regards,
Magnus
