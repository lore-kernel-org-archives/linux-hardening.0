Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287E325706
	for <linux-hardening@vger.kernel.org>; Fri,  8 May 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259812; cv=pass; b=fiIHgeR1tVxbrhBXrWZMyfUoCmdRxzv9LuiwbnB0nwiuNL+i0gMXLhQ0uGF2Z4ha20/4406UxGscj5cCg0EELrUoyGPvEEvejq3avXAsaDk4Gb3l3/uJ0o6hU7qf0zRkUxQuDPLng/d1ApskI8WVGfwDVvQ3OBvWMudF19o8+as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259812; c=relaxed/simple;
	bh=L9rqEUbJkw/pR9oV1ZWXuO0VDYhmyUqnuvOT3T4KJvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wfn5RF6zGqMy5FXyMwR9wRsQiK01saisJYZlPb0ptGr5mn615HK69DQVtVy8qMqqDeSz/meB+eNkxvnInbJJFMuwXBoFLPOeMmBxxomybzML4GpaB4fR6uucd6iAR3HS6wffmuzZvdQsoWIXX1NkBlKkoLGAPWEWMhBahuP78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0mccKrG; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0mccKrG"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso219a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 May 2026 10:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778259809; cv=none;
        d=google.com; s=arc-20240605;
        b=iwI5jyPJ5BZtb6dKaYwPyh1ObUUP/bPfUf6IwhkY4FOZRNHgWP7MwNpknpGrVSnlWA
         pQtJpO2SPvtwkmtDlB59DGjU7Gb9oKInxEBtVmJXvucpd+gs4MnA5kfFC+4czhnotFFE
         lbM2Cyqu5sTSr2aHILZ4ZLQsFBodQzxRef4648j2AhikOlMUnT+87FRxJAVGLfsH6sRJ
         L9HLlLRkX5wpsEkeIQkQghuAzeZwIrET97eF0Uchbp47Re6ob+gvwuhrs+VOIs5CG0Kd
         AOt+RnjK7f2p3cJ7UTORiklgxrZmoR4OSkIzRYtcJM/qXuj8NvMywxD3hjckZj0S0WLI
         uFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qBZJCatbKW31QndpUrt3FNHubTaN2agrmTU0pE10pw=;
        fh=1BaHvalkCZvclv4MOQrzVDgYCmZXJj6AdFiMCg6RuNY=;
        b=Z4VYYNDVPaSM/DBHRGg898NB6QerwlYSR1tr9h54CfS7j1mMz8c3kdmWICWyUmedwl
         OZXpfypYXmLZpQw/YaYZjoRjsP8KyesNuc+W0J8QROFrBj0/5DiJdmgV7iGfSVvf6Eiz
         T2wPUThuXsckwIrJ+giwHhQt5CDhlDwK6UZxuaSsTH/DmkkKCc+NTHQopD5o4MIRuocr
         0KvkkPUt1ZwEsgHkGO6JYAYWtMVCypOEVuWsOmFXMWXM4UirbKLOF9qrSLdEvmuqS3og
         BBMdkOj7RR4eE5+0zk9YnYFGUoi3t1EmUt/Bjw6mIzNAEkxbOQAQOUkADHH0vW0PkuTt
         V8dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778259809; x=1778864609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qBZJCatbKW31QndpUrt3FNHubTaN2agrmTU0pE10pw=;
        b=v0mccKrGbCPZ/b6Aaf6/T/AZqq/cXJzshD0XnMqdcKmyaRwltw36JPlrgFbp3uSSoL
         lJJqeqh3jQXevZP//aMkZ4WGSUEWl3pveOcauBZpYeAmAJrbwkj6xu8vZ5RYaTX4leqC
         IphfSN2Q3dv7c0elk9T7cVELfg6TIAnJ4bZhiqSfgIZ+yirWaqnVUX1D1MjvsPlybJu7
         XQub11VZGrUxsa5RZ4tYjPI/EY81qr63WocSIBgVdGTFLkU1y5oNUo99MIn1Zmlm+3lL
         1TVDkFtStG++bAnwqh54ribQ8x1bQhuUDAbh42FdRFylHJUVk0y2RyZOSF/imK7P69uR
         kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259809; x=1778864609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qBZJCatbKW31QndpUrt3FNHubTaN2agrmTU0pE10pw=;
        b=Rpz242pXQYxZ/CWOJS1O5/ZFxXhnIxombA98ckxb77R4Lk2hCcj5uetC5OOS17jnEJ
         wdx9Lxo9uRuQ1516bKw8awHx+ABbAWwmZcNBaH4oJxCkHONanB2xoTiMLsxcFBnK8ZIO
         xiw1JXh2wxL7K2gS7cS445Ps6el7xuFadkGLVJfYrICh733wHl2l0mGr5HzrfCGYMQ5W
         Yy73KSo3ShOoo5NsfDFERi38vDIB5EzaDI+P3NoIz3qyFxHZZlVqe/frv/h+CHicgzUu
         fe+3egR/2uuFA4zGoaGp12YYRpgKa+N6CWKvSzELfFA6GkPitwhAZiHVGS2KjTB1syLS
         7+Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8CVAcDC37t6bEQolowFm1BwvYTCgw/WR8anUpiotIP53zkUSxfMbEDxrqT9+E/43kXpmFRPbKWBv1EnWgqeAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgrebiqu0be/h9Sgw6/g46vpQ/ajABp0btE27PyvNpVFD64cg
	FLjwXUEjIL8jNX7vytlbf/i7zMavCIx08up3KvOoJHYcseMjsuMaKxgB85SS8tKiLW8Zo6+MYMM
	yCBM3n2kKYVkykVEOMDFq92i6diGPQyvi/9hBzRvm
X-Gm-Gg: Acq92OGj4hCLCz7Pw6+JBes1k9p/bL+OPtHVndqg99QdU1gmi0sfQ9qQmzVkrxhpDs4
	KKgJEvSoPcEBM94ehnWkLcj4OYESZMeu0P64j6KCwXrYtzUty2CsYs4ppjOMYeXIM6WjIW7ogez
	vC/mj9bbpgP36giEopr31zyfQdj8M9Dj2220ADzs/shmbEDpEI4zo2VOkx5rAR8BL6I8eX2Yggo
	BFYTbak4gGmHF3S+AgVKdXZKM0B+XeyYR6agN79xlNDnMH35dnRtMESAvq9nQChbHe4hQWMwaEP
	EBhD8j1b1dHaingAyIz9z9jsOSkfYxTjA1es4O7oTRVA3/iH
X-Received: by 2002:a05:6402:2b9b:b0:678:93b4:1fd3 with SMTP id
 4fb4d7f45d1cf-67ec504bd96mr99834a12.6.1778259808513; Fri, 08 May 2026
 10:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com> <20260427153416.2103979-19-ardb+git@google.com>
In-Reply-To: <20260427153416.2103979-19-ardb+git@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 May 2026 19:02:51 +0200
X-Gm-Features: AVHnY4LQJXE4H1yzg2s_XNJ6vUI7RiUknwjEFltvEk-tdRdSsPKhVQM2Qli3gQk
Message-ID: <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:44=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
> The empty zero page is used to back any kernel or user space mapping
> that is supposed to remain cleared, and so the page itself is never
> supposed to be modified.
>
> So make it __ro_after_init rather than __page_aligned_bss: on most
> architectures, this ensures that both the kernel's mapping of it and any
> aliases that are accessible via the kernel direct (linear) map are
> mapped read-only, and cannot be used (inadvertently or maliciously) to
> corrupt the contents of the zero page.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

Sorry, I should have looked at this properly earlier instead of ending
up duplicating this patch with
<https://lore.kernel.org/all/20260508-ro-zeropage-v1-1-9808abc20b49@google.=
com/>.

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..6ca01ed2a5a4 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
>  EXPORT_SYMBOL(zero_page_pfn);
>
>  #ifndef __HAVE_COLOR_ZERO_PAGE
> -uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
> +uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);

I think this is fine as-is; but FWIW:
"__ro_after_init __aligned(PAGE_SIZE)" means that this will land
in the middle of the .data..ro_after_init section, with padding in
front of it to create 4K alignment. So this probably wastes some
RAM on padding.

Looking at "nm ../linux-out/vmlinux | sort" with this patch applied
(from a build without any LTO or such), I see this:
```
[...]
ffffffff8473d378 d shmem_inode_cachep
ffffffff8473d380 d user_buckets
ffffffff8473e000 D zero_page_pfn
ffffffff8473f000 D empty_zero_page
ffffffff84740000 D __zero_page
ffffffff84740008 D pcpu_reserved_chunk
[...]
```
So I think there are almost 4K of padding between zero_page_pfn and
empty_zero_page for alignment; and I think when the linker linked
mm-init.o with the rest of the kernel, it also had to align the
compilation unit's entire .data..ro_after_init section to 4K, which is
why I also got ~3K of padding before zero_page_pfn, resulting in a
total of ~7K of padding.

If you want to change this:
I searched through the arch-specific linker scripts, and I think they
all rely on the generic RO_DATA() macro for emitting the rodata
section; so creating an analogous page-aligned rodata section should
be as simple as adding "*(.rodata..page_aligned)" directly after
"__start_rodata =3D .;", as I did in my duplicate patch.
