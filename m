Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE523ABA6
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382473; cv=none; b=Lp3x9hEw78eQ0bo+aF0QPcGcJlt4ix4F1mszECaM7ih8HKyLxoTkhDTlQVJ71tWHwN7apuTjgZ6mW8sy8ilE45QKikE8i9SEEKOMMeu+YfQWEiXluV3vJfxZlXIM6rOgzEWUrlx2mTPQe5tMnb25RW67Vg6qN3QUF5B7dbsH0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382473; c=relaxed/simple;
	bh=IlyfWnsgnG/qOi3cvsxobjLRobl4VgBJf+TWR2bCOfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAVmI/qaZVbCovo79wRWK8TZLUXISB5C1+S6wy+/BRP6AAFilZe2j978OlGQbDXTAktMU7ryh7GbTHgcmSrAJFMma+aufwWMb06+QsEszVbkNTzX3HWn1vfpzEO49zZD6FOAT7geBFr/hUq/0QblS7L7DnKQ5IKDV6RGKD4Qz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g7iV9rCz; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7iV9rCz"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ffc7c708a2so40833fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382471; x=1753987271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdGmQQBULDak1afO6wOGgGVbsIT5jshSzS0GzXEZM9Q=;
        b=g7iV9rCzSluWBP/LMdOvVIA26kXNpef6vaPXbosUoVyt9UtDmdq2aWuvH3b9XUyhKc
         ZkgQVGesg//dd3FwvLQGxznV5CDHOORzCq+5NRTjOp8kLOle3zRwM8+fsqjX4UJA3Ks8
         dFKV6TOXIPpM9MIZfNlQMd29NSQO+YbF0vOKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382471; x=1753987271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdGmQQBULDak1afO6wOGgGVbsIT5jshSzS0GzXEZM9Q=;
        b=e14U/NVBX93wvMDNTyGFpNTbfMrj5y4Mzh8oTFv1gEJkyzEg64o61G/eVFPkdwV7Uh
         5G3FEqgW26kO3x2OT5X7ivtvZfJHUGW5NTKvz54DiP+IESoeCMKFq50EZUiRZqHoJNQO
         VlkIPYrjQicZ8imLN+igMAsi0yAMfnJVkrySJTK+Vnmg9R+QFnnLglN+dY2GLJLI/USO
         zjr3hoLBYGFPZAIx/6VK6FNBskwnhBo9ebUqtmtD+2UqKewTivJokqw1UuoQZ+84EtqH
         iT4tI4kO+H0687/H9MRk5ibFBtyTzdIrSA7KKsY3UfqhXw2EIlGGJIMmMItaX7zvDGM4
         krAw==
X-Forwarded-Encrypted: i=1; AJvYcCXntjMIyGN7ohWyKi8js293VkTGtXprUiKc+dRdwskcjgpOP/ACiOTD3IBRNc4q3s8GMkmlpwOAmNma0PfqCYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsE2JkndNiRxowjr+SUuaXHSdp2AG8uwNgBAitUE7AbV8jBNM
	1tXSA5M1feoioMOCoKNG+7+veG8gAqT18v0qfKiLsYpRnjmxQTSCgzzPY+1Z7tccbytmTX1gyvM
	gQquGOk3iXNSaQYZBuDeCIwCFlyF8GzPLaYkX3jTD
X-Gm-Gg: ASbGncsSJ9mHUlWkkd9waidhkiaxL+o3RF2mmmAsU/86N2zFrSKVPw3rjqv7VKcoshk
	bKSZzPj2FmgaKBiz4VsMERESS5HFdABlb5fYYXKjCUrPu4GD7t2oqR2nq/0xQ49dvAlpRuL0vBE
	aL/xOs6fD/OJ3KGIIg0C1Jgy13FRVzkavNapnJX1AFS/3fWyRwFwJNM4NXJMLGAzGaq7ZD3e0QD
	Bo62KAjNa1Gy+bxT4fHdbDVoOg1jZtg6JYH
X-Google-Smtp-Source: AGHT+IEoYM1EWKvzwa2CPrTTDfzZ7Ksf2AOfnilQct0N6oYa/w+7054kRqvJaSR7CoWM8egO7TBFq4f8ZqpZ1JK1c6I=
X-Received: by 2002:a05:6870:d2c6:b0:2e9:fd62:9068 with SMTP id
 586e51a60fabf-306c73182d7mr2083260fac.10.1753382470954; Thu, 24 Jul 2025
 11:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <f4dda4c4840c69b2ea735bcb6d54ae70d527a48a.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f4dda4c4840c69b2ea735bcb6d54ae70d527a48a.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:40:59 -0700
X-Gm-Features: Ac12FXybD_pjPvOBCwcY-hNwuSV51_tRDl2BKwa1m5oQnEMvCGJNkN39CTK8H50
Message-ID: <CABi2SkWgp1M5FWbo8p6_byF+5FzQtcSg3ui0rQ9Mpy6z2_BB5Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/mseal: Simplify and rename VMA gap check
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
> The check_mm_seal() function is doing something general - checking whethe=
r
> a range contains only VMAs (or rather that it does NOT contain any
> unmapped regions).
>
> So rename this function to range_contains_unmapped().
>
> Additionally simplify the logic, we are simply checking whether the last
> vma->vm_end has either a VMA starting after it or ends before the end
> parameter.
>
> This check is rather dubious, so it is sensible to keep it local to
> mm/mseal.c as at a later stage it may be removed, and we don't want any
> other mm code to perform such a check.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/mseal.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index adbcc65e9660..61c07b1369cb 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -37,32 +37,22 @@ static int mseal_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         return ret;
>  }
>
> -/*
> - * Check for do_mseal:
> - * 1> start is part of a valid vma.
> - * 2> end is part of a valid vma.
> - * 3> No gap (unallocated address) between start and end.
> - * 4> map is sealable.
> - */
> -static int check_mm_seal(unsigned long start, unsigned long end)
Is it possible to leave the check_mm_seal() function together with its
header comments? My original reason was to have a contract that
documents the exact entry check for mseal(). That way, no matter how
the code is refactored in the future, as long as the contract remains
true, I won't need to worry about behavior changes for mseal(). This
could be helpful if you move range_contains_unmapped into vma.c in the
future.

Note: "4> map is sealable." can be removed,  which is obsolete, we no
longer use sealable flags.

Thanks and regards,
-Jeff
> +/* Does the [start, end) range contain any unmapped memory? */
> +static bool range_contains_unmapped(struct mm_struct *mm,
> +               unsigned long start, unsigned long end)
>  {
>         struct vm_area_struct *vma;
> -       unsigned long nstart =3D start;
> +       unsigned long prev_end =3D start;
>         VMA_ITERATOR(vmi, current->mm, start);
>
> -       /* going through each vma to check. */
>         for_each_vma_range(vmi, vma, end) {
> -               if (vma->vm_start > nstart)
> -                       /* unallocated memory found. */
> -                       return -ENOMEM;
> -
> -               if (vma->vm_end >=3D end)
> -                       return 0;
> +               if (vma->vm_start > prev_end)
> +                       return true;
>
> -               nstart =3D vma->vm_end;
> +               prev_end =3D vma->vm_end;
>         }
>
> -       return -ENOMEM;
> +       return prev_end < end;
>  }
>
>  /*
> @@ -184,14 +174,10 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
>         if (mmap_write_lock_killable(mm))
>                 return -EINTR;
>
> -       /*
> -        * First pass, this helps to avoid
> -        * partial sealing in case of error in input address range,
> -        * e.g. ENOMEM error.
> -        */
> -       ret =3D check_mm_seal(start, end);
> -       if (ret)
> +       if (range_contains_unmapped(mm, start, end)) {
> +               ret =3D -ENOMEM;
>                 goto out;
> +       }
>
>         /*
>          * Second pass, this should success, unless there are errors
> --
> 2.50.1
>
