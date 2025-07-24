Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA926CE2A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382505; cv=none; b=klZzSFaBKOcZb8FMWSfNYTnOEzfmyD22tS/BXdAj66WfYB/SiszqFDcMLF8HZmGkso2eRcHlAJnscZgM3KDVGUawguGcEfOxdxfWbubqYMJhzzd4Tqua3iycL/sPa9qMngrw00e97TVEGiN4JD3iynEuQ5M5g67h7SQ/BWGCYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382505; c=relaxed/simple;
	bh=UOwoGaDOvoje/9q1jcfzkopAP+bmCXpqgcS9RU00fkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj8NkA3a08Gfsm2lIZ3PyLmNuqcudW+mrW1EtYoMZN5pYg9O39Kx5F1ibdPvzCUEBIReLxXdQhFGqQ2Pj8VtIFfFSYF1Kr/Qtd7wPv4yjg6C8L1bcHBqwNRyeAf0HDDgRRTi+osTSgMynGA/7nmjZ0iuUCxCG1Wp/K+YWq8ex8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LxTG8CRa; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxTG8CRa"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ff92caabcaso161036fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382502; x=1753987302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1HWlZ2q1kj2IfdBM1XqDySr0QM/i4rMvQ57Io2GLV0=;
        b=LxTG8CRaRwICQ+enPfg6ghra7oYvS6Iblco9sgqEVtQzt8t6zX9YN+gpqOf+pvkUBb
         mzxjpftet4NpvBb7YYXq+5MGSR03RcS8qRqa9UTDLzFhjNZe2SbWcXktF3AqPIeL8UAu
         Uj1pCe/DRd5+KAlNt1gyArow3BYGyABtOIEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382502; x=1753987302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1HWlZ2q1kj2IfdBM1XqDySr0QM/i4rMvQ57Io2GLV0=;
        b=tA5axlhnfgebKdQET0Fgywl7drH2up5u436iDOpVyhUjUR6ZA2vykwKhXUWR70RynY
         bd3f8TcmPCw/BFifvZTWdRIqAjyu5kiVnPITZpiLhuzv5IOZue3Rr599ShkI/EiW0Oy6
         W2UKAxxuT9AM05sTjWNPJgDUUCQaRyuaS6OyNI+i3Gs+MlyYaVCSMplDEd5uWphknkY8
         MXBXJxuWQwNXDcs3kG2ru5izgrRuwWut/nHOEZnlfcOMryK5UqZ8lEGgSjSmgVQJ19q+
         WDnUncPFiAS35oFRApndNa4QXG4JvKYwaLNwvY08n1mCSQUcXwzDfFnex5BFI+1Tujjx
         tqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjoasRVKw9nDCOWYBpb2qWCSMBF4soFWICL36juDa+6VZaa6DVvzJz4ibo+HtZastqUo//ZMpItE8/1/rkgeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPy+m87mX3P/GLHUqZl+wbuqzdKUrcgSBCnKbfQ/Bjp2Am/+q
	tfRU52g5ZLFkbM6+HCDM8Z9VMiz/cdOcXhOVhNzuEbpcFp5Cs6/RtVWwPH/ylBPEkKaBgyOeKZC
	HFfufJdGR4VS0Dzj5MWBv9SFTz0B0c8YoyAKjgMP/
X-Gm-Gg: ASbGncu1cYFhbSJIo2UERurYebsULbpPmvp+uYFFVRci5owPlDz2P4evrQx98ufdWpA
	8LJ4p7FCvuGf+y7eawy2c+ctNAjm1Y5fxzMgLggDqXCcBXHWfvapDy107/+cRYoPSGZQvyIjCY6
	CpCGOgTQ3RjQtvQWTV6SvDLBnwi0ik23pttp6XEPTwqzVeYym50S2seBsW+1dEyP1isYys+d9fn
	evabXMzUuTlUYIYyartffIp5XZgsvixptlY
X-Google-Smtp-Source: AGHT+IFGOCABTTvB+uzF9wmiyKAOSjp+0YvJguYqvnGbeIpD4kNUAbPp92D+Kc9fHRgycq+ZSZnoA+bqeSnlnTMvEN0=
X-Received: by 2002:a05:6871:71c5:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-306c6f21d67mr1770212fac.3.1753382502323; Thu, 24 Jul 2025
 11:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <9ae70e1c509d790cf174f16e491975efd9be50b6.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <9ae70e1c509d790cf174f16e491975efd9be50b6.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:41:30 -0700
X-Gm-Features: Ac12FXycf8JmBrOhOyz1OgvG94mrvgZe6JkSBqJucvHYxI-9914zkEue6RQd-ZA
Message-ID: <CABi2SkXQsao-S+uy63k6Zc=y4W-pik6XZSzw+05f_Ws_frqZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mm/mseal: rework mseal apply logic
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
> The logic can be simplified - firstly by renaming the inconsistently name=
d
> apply_mm_seal() to mseal_apply().
>
> We then wrap mseal_fixup() into the main loop as the logic is simple enou=
gh
> to not require it, equally it isn't a hugely pleasant pattern in mprotect=
()
> etc.  so it's not something we want to perpetuate.
>
> We eliminate the need for invoking vma_iter_end() on each loop by directl=
y
> determining if the VMA was merged - the only thing we need concern
> ourselves with is whether the start/end of the (gapless) range are offset
> into VMAs.
>
> This refactoring also avoids the rather horrid 'pass pointer to prev
> around' pattern used in mprotect() et al.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Jeff Xu <jeffxu@chromium.org>

Thanks and regards,
-Jeff
> ---
>  mm/mseal.c | 67 ++++++++++++++++--------------------------------------
>  1 file changed, 20 insertions(+), 47 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 61c07b1369cb..0ab12e09792a 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,28 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
> -               struct vm_area_struct **prev, unsigned long start,
> -               unsigned long end, vm_flags_t newflags)
> -{
> -       int ret =3D 0;
> -       vm_flags_t oldflags =3D vma->vm_flags;
> -
> -       if (newflags =3D=3D oldflags)
> -               goto out;
> -
> -       vma =3D vma_modify_flags(vmi, *prev, vma, start, end, newflags);
> -       if (IS_ERR(vma)) {
> -               ret =3D PTR_ERR(vma);
> -               goto out;
> -       }
> -
> -       vm_flags_set(vma, VM_SEALED);
> -out:
> -       *prev =3D vma;
> -       return ret;
> -}
> -
>  /* Does the [start, end) range contain any unmapped memory? */
>  static bool range_contains_unmapped(struct mm_struct *mm,
>                 unsigned long start, unsigned long end)
> @@ -55,38 +33,33 @@ static bool range_contains_unmapped(struct mm_struct =
*mm,
>         return prev_end < end;
>  }
>
> -/*
> - * Apply sealing.
> - */
> -static int apply_mm_seal(unsigned long start, unsigned long end)
> +static int mseal_apply(struct mm_struct *mm,
> +               unsigned long start, unsigned long end)
>  {
> -       unsigned long nstart;
>         struct vm_area_struct *vma, *prev;
> -       VMA_ITERATOR(vmi, current->mm, start);
> +       unsigned long curr_start =3D start;
> +       VMA_ITERATOR(vmi, mm, start);
>
> +       /* We know there are no gaps so this will be non-NULL. */
>         vma =3D vma_iter_load(&vmi);
> -       /*
> -        * Note: check_mm_seal should already checked ENOMEM case.
> -        * so vma should not be null, same for the other ENOMEM cases.
> -        */
>         prev =3D vma_prev(&vmi);
>         if (start > vma->vm_start)
>                 prev =3D vma;
>
> -       nstart =3D start;
>         for_each_vma_range(vmi, vma, end) {
> -               int error;
> -               unsigned long tmp;
> -               vm_flags_t newflags;
> -
> -               newflags =3D vma->vm_flags | VM_SEALED;
> -               tmp =3D vma->vm_end;
> -               if (tmp > end)
> -                       tmp =3D end;
> -               error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, newf=
lags);
> -               if (error)
> -                       return error;
> -               nstart =3D vma_iter_end(&vmi);
> +               unsigned long curr_end =3D MIN(vma->vm_end, end);
> +
> +               if (!(vma->vm_flags & VM_SEALED)) {
> +                       vma =3D vma_modify_flags(&vmi, prev, vma,
> +                                       curr_start, curr_end,
> +                                       vma->vm_flags | VM_SEALED);
> +                       if (IS_ERR(vma))
> +                               return PTR_ERR(vma);
> +                       vm_flags_set(vma, VM_SEALED);
> +               }
> +
> +               prev =3D vma;
> +               curr_start =3D curr_end;
>         }
>
>         return 0;
> @@ -185,10 +158,10 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
>          * reaching the max supported VMAs, however, those cases shall
>          * be rare.
>          */
> -       ret =3D apply_mm_seal(start, end);
> +       ret =3D mseal_apply(mm, start, end);
>
>  out:
> -       mmap_write_unlock(current->mm);
> +       mmap_write_unlock(mm);
>         return ret;
>  }
>
> --
> 2.50.1
>
