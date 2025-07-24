Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89D265CB2
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382417; cv=none; b=nZTCxPSNR1S9U7TkwYz3w37CCXgmQ/7mRLZFAJBdJ5QZHLdbkU5QySJe2wnVqdLX5GMGA9fVt43SogKjuIKZ/TS4k2kWeP1bS5wGhdfn9wBOXhDpD3FKarqEZu9xDJq8nv4vWqLSPla9YfDDn6BrolFJUtzNgJY5DRMX20yNzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382417; c=relaxed/simple;
	bh=8GkZkXvRavBH9B3NFyyarkpIMnKHJRPaj9XdVoFyU2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWlW38rd3+XAgQCyzmU674Pa1M8BPt9huNM8OpjVQcPVozFYo4Bdi1FXpzGGnJouewSlNtfQKIpPcUXo69CRilBP5QiMlQNq04lHmr5/Yan8okf9IB1xanmErlypeR05bw35Rtxi5P9AM/HirprhK3qTd6nsOJ/Q/2FgLLR150Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OyaNlm1N; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyaNlm1N"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-306cce02908so33443fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382414; x=1753987214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BMNHZLCVEeiqDvQaiWaHPR4yi2NaTZkc3BJ0ttGl9Y=;
        b=OyaNlm1NcbDByicM7WWsifKr6iAMLDLlvPeQobtW1gfjOBXs576Ve74iA7uUgt5NpA
         jUfTQe9wD8v8F57rzaAGwEAlzVzlmBkvAhml1NFkuGIaR5mGtn2QQ2PGGXx2kVroChd4
         8AAzLc7i8J3Omc1CwTY0Rx46DdeUS57HsLhwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382414; x=1753987214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BMNHZLCVEeiqDvQaiWaHPR4yi2NaTZkc3BJ0ttGl9Y=;
        b=jmecT5OG5+Pr4DS8ynEQE+R4i1AnPZCfdu3pBqKqnys1svGQDxFCKXAbkxE25HPz40
         uNfK/GSalkrZ2gh/Rf4tuu7IZ1Tyb8N/98EHhHMC6hR5wQT4IVxEE7h+tpvqEBbnHdy+
         VHLpfaLo3Z1BoWvP3hMjkYYoaXchd/mQ4183PykeejXPooiKC+xumrSkJywGtW5uVbei
         toZ7Qpyrh14mn/9RLbwhSS3opwqKeHmBn72xZCfGEVeZmID7Mtnn36jcPVhuJtWJHBtM
         35EvySwARdpEIrr5E6V+/O98cvQR+IDAc3lD5cN8LNl3R40r10H9PyDr6d+AggAtiKfs
         aebA==
X-Forwarded-Encrypted: i=1; AJvYcCVicN89cE1iXYbSym1OJ4yHb2QcfiY/eUZaZJs/5qWTioROKuEWgoyK9vG4vdQOTPNT5MzlEUZY3NaWkS9lEsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdIcolldv8pXkde5aHAXDplOchB61HWCmuq50xnYkkbanMDt1
	wIlRMiMBrzUgwQo4cDvkErnmlauKlj6kZ+lT83F0PwTb/vkA7XF4CjbJsYU9Gcpb++ENn23JlJk
	LEqypBTZhuHiTMwgKD451yRF2YNhTNWfH88LbSH3Z
X-Gm-Gg: ASbGncvP7FkbGtxT/2umHNJdLo3Pv0RCakNOozWMs/Ip1b2ux97GICrbO7d128w+5D/
	YuRNMyRtg1HPVdzsiWRb6sVZgNGpH9vKZqQB2Z3Zi0vGZRJ2AdSAq86FOOVY47KyXa2qhFX1zrk
	NhpdUXmlCsfzvP0iNbE4hoZOKTtNQAr1pxzSbZJLwf9kDtp8A6BYMMGGiDeXcgvqy3xWe0gj4TX
	GwtvIUKCXg6e0Kcse9cy/+N32/KiSPOG1sy
X-Google-Smtp-Source: AGHT+IHIg+HNobqPln9IVjLqjazZFObcWO0xYiJwOyYA5v6NMPyUL45KIuuKS1EbBH0g5KjtFnTF/JHPrS1eWYH49pw=
X-Received: by 2002:a05:6871:3427:b0:2c1:b4ce:e43b with SMTP id
 586e51a60fabf-306c735ce5cmr2179176fac.12.1753382413658; Thu, 24 Jul 2025
 11:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <ac51c2a3c68a2475149b54180ff012fffab72c02.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ac51c2a3c68a2475149b54180ff012fffab72c02.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:40:01 -0700
X-Gm-Features: Ac12FXznMGya-BnO3U5H6mKpJLmpNyl0TeBQAlHn33pD748OLsKUzh_9L0k-wdw
Message-ID: <CABi2SkXHyF+dHo7Rv5V1jPZ4B5_v4Hva-A4XphtRMQJTrw_jqQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/mseal: small cleanups
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
> Drop the wholly unnecessary set_vma_sealed() helper(), which is used only
> once, and place VMA_ITERATOR() declarations in the correct place.
>
> Retain vma_is_sealed(), and use it instead of the confusingly named
> can_modify_vma(), so it's abundantly clear what's being tested, rather th=
en
> a nebulous sense of 'can the VMA be modified'.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Jeff Xu <jeffxu@chromium.org>

Thanks and regards
-Jeff
> ---
>  mm/madvise.c  |  2 +-
>  mm/mprotect.c |  2 +-
>  mm/mremap.c   |  2 +-
>  mm/mseal.c    |  9 +--------
>  mm/vma.c      |  4 ++--
>  mm/vma.h      | 20 ++------------------
>  6 files changed, 8 insertions(+), 31 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dc3d8497b0f4..da6e0e7c00b5 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1286,7 +1286,7 @@ static bool can_madvise_modify(struct madvise_behav=
ior *madv_behavior)
>         struct vm_area_struct *vma =3D madv_behavior->vma;
>
>         /* If the VMA isn't sealed we're good. */
> -       if (can_modify_vma(vma))
> +       if (!vma_is_sealed(vma))
>                 return true;
>
>         /* For a sealed VMA, we only care about discard operations. */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88709c01177b..807939177065 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -605,7 +605,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_g=
ather *tlb,
>         unsigned long charged =3D 0;
>         int error;
>
> -       if (!can_modify_vma(vma))
> +       if (vma_is_sealed(vma))
>                 return -EPERM;
>
>         if (newflags =3D=3D oldflags) {
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5b7fe8f36074..8e93eca86721 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1649,7 +1649,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>                 return -EFAULT;
>
>         /* If mseal()'d, mremap() is prohibited. */
> -       if (!can_modify_vma(vma))
> +       if (vma_is_sealed(vma))
>                 return -EPERM;
>
>         /* Align to hugetlb page size, if required. */
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 1308e88ab184..adbcc65e9660 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,11 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static inline void set_vma_sealed(struct vm_area_struct *vma)
> -{
> -       vm_flags_set(vma, VM_SEALED);
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                 struct vm_area_struct **prev, unsigned long start,
>                 unsigned long end, vm_flags_t newflags)
> @@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>                 goto out;
>         }
>
> -       set_vma_sealed(vma);
> +       vm_flags_set(vma, VM_SEALED);
>  out:
>         *prev =3D vma;
>         return ret;
> @@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned =
long end)
>  {
>         struct vm_area_struct *vma;
>         unsigned long nstart =3D start;
> -
>         VMA_ITERATOR(vmi, current->mm, start);
>
>         /* going through each vma to check. */
> @@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned =
long end)
>  {
>         unsigned long nstart;
>         struct vm_area_struct *vma, *prev;
> -
>         VMA_ITERATOR(vmi, current->mm, start);
>
>         vma =3D vma_iter_load(&vmi);
> diff --git a/mm/vma.c b/mm/vma.c
> index fc502b741dcf..75fd2759964b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1351,7 +1351,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
>                 }
>
>                 /* Don't bother splitting the VMA if we can't unmap it an=
yway */
> -               if (!can_modify_vma(vms->vma)) {
> +               if (vma_is_sealed(vms->vma)) {
>                         error =3D -EPERM;
>                         goto start_split_failed;
>                 }
> @@ -1371,7 +1371,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
>         for_each_vma_range(*(vms->vmi), next, vms->end) {
>                 long nrpages;
>
> -               if (!can_modify_vma(next)) {
> +               if (vma_is_sealed(next)) {
>                         error =3D -EPERM;
>                         goto modify_vma_failed;
>                 }
> diff --git a/mm/vma.h b/mm/vma.h
> index 85db5e880fcc..b123a9cdedb0 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -559,31 +559,15 @@ struct vm_area_struct *vma_iter_next_rewind(struct =
vma_iterator *vmi,
>  }
>
>  #ifdef CONFIG_64BIT
> -
>  static inline bool vma_is_sealed(struct vm_area_struct *vma)
>  {
>         return (vma->vm_flags & VM_SEALED);
>  }
> -
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> -static inline bool can_modify_vma(struct vm_area_struct *vma)
> -{
> -       if (unlikely(vma_is_sealed(vma)))
> -               return false;
> -
> -       return true;
> -}
> -
>  #else
> -
> -static inline bool can_modify_vma(struct vm_area_struct *vma)
> +static inline bool vma_is_sealed(struct vm_area_struct *vma)
>  {
> -       return true;
> +       return false;
>  }
> -
>  #endif
>
>  #if defined(CONFIG_STACK_GROWSUP)
> --
> 2.50.1
>
