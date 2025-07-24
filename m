Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6E1FE461
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382087; cv=none; b=B6vw4+5pB7XvzrimTzJ65/Q9zpWQyeShCtZJzpan9PJnJyv/AAoYoLpmIydwcXXMrWpbLkpOWpxfoWRTjJkEqrSUXYB6JjDptn1imRrQl6QbAfML+5tz2J/R+nbYcg/I+GxnY4r8XjJ152kw/PVu6cmXQUHhqDIh850h3tTGirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382087; c=relaxed/simple;
	bh=EhYy9s6IyDVXM+dw7SM2pC7TkH7KW3mc/cdVVRI5hxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzLDInWtUDjBwrQmOWJOt456rp+XSVi7Hf4wOZqeXVZpRRY8mv2bkIpwpB/p1Xu0HhJXwiTuikMwuSYlEYLVtUqMvc7TVDKSU/wI3Za2qd69IdQtQNxOkt6BmhOv09fkkvHv1CCbEAkHW9hTJAIveki1JOaEYgjl71ZC2EmX73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fUEs5UEi; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fUEs5UEi"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e5487c4d7so50711a34.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382084; x=1753986884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hy19XYLYjogQ/4nZ2jE5q9A8m7TkG/b0NhBVuhbg9g=;
        b=fUEs5UEiBJAJ6FriDLb1FHnA/LmsjzJZmod3WMVT0CTHqFlW6G9JuVUS30mW0O8pPl
         +MNmrVSBCg+vr8eUA9qfmhaivCom84k6/Ag2AYtReM3dRFIVREYo87DhGi6GFhTkdqUb
         yEwTYGWjxVxGD24alOl3lBGT4ucyUUHz1mQOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382084; x=1753986884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hy19XYLYjogQ/4nZ2jE5q9A8m7TkG/b0NhBVuhbg9g=;
        b=oFC/ZUZa07NT1G1GANskh6ymEVZlkgzkSpSFDROCgaKAtK7ADq0BOWNIv35FCfiny3
         69u2Qzsz8ELyjpKtCjZDlWVFiXm/ZdVDtkpGsDT1xzEU4X1oOvHK9g8PZd2b6IErNDpZ
         NERusedf9je7Vt/wYXv51zsr8fMjT7ZBPlxQS9itHo+bYj5hAgn7j7/NRZ569LWq9lRS
         gBBvNd4JD+zpAFr6LlLd1+Nhx2QC3aJfBBtcCvyM3xmmrzslO8caci/MbnBoVcEDgK+A
         EZBwg2cUy+wED/Ml8+3MPexF2dov8XyjyZj4TJnqP5DHao/arfZ70aHA8/SK5s68DWwN
         pGcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJz0nDA/S9fQTfsD2XP8a1lGPMisNukjF8zX422HQ6pX884rD31XtQy0JafdKUowB4WMakaDCVJvkTsNvHCp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5uJh64wAlT9rZetVZdbwRbi3o8jMjKkWT+P5GYsR/pF6HrxT
	kmM99yzRpGNEOmxVlIU+BZDBUN9O6ypqmd5rt+KS6qa2eKP2wJOW+6Jn4TuXfK/13HnHfpgH0Jr
	dJ+Hi9BMA70zt42ZA1LfzxEnMwdF3q2jLGgBFjTtT
X-Gm-Gg: ASbGnctCJJ61O7OG2fz8Pn7ex71IKruqdY0IzQZUZDmtmeErxlbw4JPc8rSJRSVb5Op
	hHHmbF/lEA2B0ecuWB0irWzz0Vp5Tj0QPCvCf16dJ+u3F8799urq38+1jI68Q31uG84sTIDBhX0
	cy6lVJGHsQ+L3UGbtq2OGIdSt17BhxYNVVHZrUANzKnWFA2vLUj6R/l1BsDME2xhkCwGRkQC0DB
	U1SMysqZ8aULC7ERhxrHKtHiOiJyZW2RwuKUPXx001iIIc=
X-Google-Smtp-Source: AGHT+IExCMgwSyyh6fZVQDIoYTaFuZdsE+zuKDoymTdwp+61+7Vy2vinFRkoIRfsms0/uxkszHE5F4pscxTm40rOS1c=
X-Received: by 2002:a05:6870:bb17:b0:2c1:5011:56e2 with SMTP id
 586e51a60fabf-306c6ebb4fcmr2003452fac.3.1753382084438; Thu, 24 Jul 2025
 11:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <d0e9b39c9d1abceb0ffac341c6fae96186c5d843.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <d0e9b39c9d1abceb0ffac341c6fae96186c5d843.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:34:31 -0700
X-Gm-Features: Ac12FXzjuQzbVjnKfCaBaTm_N9qyhzxlzeAH9n1camAeM3s5LIPyo6jbvFBauj0
Message-ID: <CABi2SkXa2n+csjXgb0UWQFi-f5q2caazRkswAGY1LJ9N91m8UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm/mseal: always define VM_SEALED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Wed, Jul 16, 2025 at 10:38=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> There is no reason to treat VM_SEALED in a special way, in each other cas=
e
> in which a VMA flag is unavailable due to configuration, we simply assign
> that flag to VM_NONE, so make VM_SEALED consistent with all other VMA
> flags in this respect.
>
Originally, I wanted to avoid using VM_NONE for VM_SEALED to catch
compiler errors in 32-bit builds. This would serve as a safeguard
against inadvertently using VM_SEALED in code paths shared between
32-bit and 64-bit architectures.

Take an example of show_smap_vma_flags [1] :

#ifdef CONFIG_64BIT
[ilog2(VM_SEALED)] =3D "sl",
#endif

If a developer forgets to add #ifdef CONFIG_64BIT, the build will fail
for 32-bit systems. With VM_SEALED redefined as VM_NONE, the problem
will go unnoticed.

This coding practice is more defensive and helps catch errors early
on. It seems that you're working on introducing VM_SEALED for 32-bit
systems. If that happens, we won't need this safeguard anymore. But
until then, is it OK to keep it in place?  That said, if VM_SEALED
support for 32-bit is coming really soon, we can merge this change,
however, perhaps you could update the description to explain why we're
removing this safeguard, i.e. due to 32-bit support will soon be in
place.

Link: https://elixir.bootlin.com/linux/v6.15.7/source/fs/proc/task_mmu.c#L1=
001
[1]

Thanks and regards,
-Jeff
> Additionally, use the next available bit for VM_SEALED, 42, rather than
> arbitrarily putting it at 63 and update the declaration to match all othe=
r
> VMA flags.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h               | 6 ++++--
>  tools/testing/vma/vma_internal.h | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 805108d7bbc3..fbf2a1f7ffc6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -414,8 +414,10 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>
>  #ifdef CONFIG_64BIT
> -/* VM is sealed, in vm_flags */
> -#define VM_SEALED      _BITUL(63)
> +#define VM_SEALED_BIT  42
> +#define VM_SEALED      BIT(VM_SEALED_BIT)
> +#else
> +#define VM_SEALED      VM_NONE
>  #endif
>
>  /* Bits set in the VMA until the stack is in its final location */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 991022e9e0d3..0fe52fd6782b 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -108,8 +108,10 @@ extern unsigned long dac_mmap_min_addr;
>  #define CAP_IPC_LOCK         14
>
>  #ifdef CONFIG_64BIT
> -/* VM is sealed, in vm_flags */
> -#define VM_SEALED      _BITUL(63)
> +#define VM_SEALED_BIT  42
> +#define VM_SEALED      BIT(VM_SEALED_BIT)
> +#else
> +#define VM_SEALED      VM_NONE
>  #endif
>
>  #define FIRST_USER_ADDRESS     0UL
> --
> 2.50.1
>
