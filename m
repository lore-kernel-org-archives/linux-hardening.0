Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51C23ABA6
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382362; cv=none; b=BiCv3g8HzuH8WnKj0RXhYUJSJ5qJDgwWH6TG3ymholGxEqCuRBRwkH/CbSyfuKpwR7rN6+ye1chpP73QON1JsE5aMfKRf36hyDFEtDG8mHDQYzCTQ4LO8H6HUBXV/YQs1RxfSMKS6mujg9nJO2mFhQxiiRTFmKTac0CqY0P0qWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382362; c=relaxed/simple;
	bh=izN76dgL5uq7ZS1LeY/BXi1Boq3cG7Q2OxJBo4CY7GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHohjsjS8r8M1ZfbuJsLmpt0usltYitlPpQWokFbNx/TEqFOIJcYPBmkNPRwjplBX4Im9RRsEwwTbkhMU5njw6kXCDf7VBoYQ2uvj7CfmQCvTR2KzR5twAhbroEZiDWmAmrzUUYJ24GPBmqE1eNUIQSzozb0psmVNIfWGJeyawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ForbO0QW; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ForbO0QW"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2ffc7c708a2so40575fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382357; x=1753987157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTygwA+Sg/2M91c6LKoJyN6AlUtwLV9EUMVMJxfPrDo=;
        b=ForbO0QWQggFZmWGo9bRNVjdRBLDdqNEA7SeudYXr7q2mNBoCzkmjXvjiLIt8PZTyq
         /fWRFOrOFHsp7FSvr98FtKg87DeYERZo88rBpMdJcRE2lRFPzyK8MvBSWvyevsPheCkk
         yC8HQVkgphnCw6dW6TU6WMKDWw5ExWAXG4hos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382357; x=1753987157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTygwA+Sg/2M91c6LKoJyN6AlUtwLV9EUMVMJxfPrDo=;
        b=eIa6TOUkxDwyctKPBrVIpeNDitAQ9OSXiI8izBUFxpkkAhzJIanPq3oCqTtZf/bO0o
         mv+U24rlCaLnL3KNstQBXNOlq3X0rgn3cdhulv21qhVcVsm0unAtLQysRNvV4GoYzpYb
         t0e56pb78gOA/uGfSC5rKWmcpSMr9w7Zb83XLjP+6Q33XCk+AVhfKQ6QSs6PJMWA7aAM
         hmcy7v+sKdB/ty8YSUHQmbYpWQo2LsE/ZiA+waKMqoRbI6EM9NzG/JV/bO6hwMxOsS56
         op+2+cmhSFyyo32/m0ytO1Woxul9Lj4BLKAHBrlG+EZ6IU9fPDKQuePsMeP+XD0EdaD5
         /Sug==
X-Forwarded-Encrypted: i=1; AJvYcCV3h7Xai3/5xXU/asrUdGkG1pivcj7i452CrcVfE1sQkQY2goe0bcrPe/BsU7zAXgWzLlms3BxNEaRN0uTTKZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvCRc+nouT6uiQ/eO+UVeoZIDBwrg3nV0u6HIQlOzqiLvDeZ+
	D9wdvfNn3psjNqx/ihju63Nmc5m830mwjHQCMXS/1EOM/OofckkBkIowvXa87CSprkZ9YXfLjFc
	Ycu3IXnaBm/BGWHwLwwOpLSv64sBz/gId81h37SXGQy08v58R7FQ=
X-Gm-Gg: ASbGncurUw62S72qy4lslimitGz1RrxKQtJTB4d9umnoocoOv1BqK6HWLy9EOEsDlfq
	ytGdKJsMDFb9BIDtIHI+5ciAdu0RiHu1Z3YJ39i5wTDJ5q2Ule+hO8J7Atv3pG6mJ8nPd8dy5D5
	+63fJsXtTsdjfxYgcD+j3tHvJWaBsS7roUHfUoF7NXFqgq4IEPRI5AS6k1t/Bbcfyxt56cc06BX
	qHYK0VxqakQSepnzM8OIKWCLr+lKXYHWaHr
X-Google-Smtp-Source: AGHT+IE5v9YXwfMOrt4s6GrcLKH0pUBp6im1qkTMz2i1XtnKS0z4XfcSpoeZckBljPkj00IULZuSGmCS50+4/FTBEaI=
X-Received: by 2002:a05:6870:9598:b0:2d5:d5f:3b12 with SMTP id
 586e51a60fabf-306c702ee61mr2152191fac.6.1753382356998; Thu, 24 Jul 2025
 11:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:39:05 -0700
X-Gm-Features: Ac12FXzeXb-f21M0mzyxQUbrHRmdaCixRPUSYkvBZx5nezL9EZHQfshIAmP4xVM
Message-ID: <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

This change has two parts: a non-functional refactoring work of moving
function from mseal.c to madvise.c, and a functional change to the
behavior of madvise under mseal. Would you consider splitting the
change into two parts? which seems to be a common practice at
supplying patches in lkml.

On Wed, Jul 16, 2025 at 10:38=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought
> to be located in mm/madvise.c.
>
This is part one of a non-functional refactoring work to move a
function from mseal.c to madvise.c.

There are two main reasons why I initially wanted to keep all
mseal-related functions in mseal.c:

1 Keeping all mseal related logic in mseal.c makes it easier for
developers to find all the impacted areas of mseal.
2 mseal is not supported in 32 bits, and mseal.c is excluded from 32
bits build (see makefile).This would prevent accidentally using mseal
in code paths shared between 32-bit and 64-bit architectures. It also
avoids adding #Ifdef in the .c file, which is recommended by the mm
coding standard (I received comments about avoiding  #ifdef in .c  in
the past).

Point 2 can go aways if 32 bits mseal support is coming soon, same as
my other comments for patch 1/5.

Point 1 remains. However, I want to focus on the functional change
part of this patch, rather than the other aspects.

> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
>
> Put a static function in mm/madvise.c instead - can_madvise_modify() -
> that spells out exactly what's happening.  Also explicitly check for an
> anon VMA.
>
> Also add commentary to explain what's going on.
>
> Essentially - we disallow discarding of data in mseal()'d mappings in
> instances where the user couldn't otherwise write to that data.
>
> Shared mappings are always backed, so no discard will actually truly
> discard the data.  Read-only anonymous and MAP_PRIVATE file-backed
> mappings are the ones we are interested in.
>
> We make a change to the logic here to correct a mistake - we must disallo=
w
> discard of read-only MAP_PRIVATE file-backed mappings, which previously w=
e
> were not.
>
> The justification for this change is to account for the case where:
>
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.
>
> If we were to now allow discard of this data, it would mean mseal() would
> not prevent the unrecoverable discarding of data and it was thus violate
> the semantics of sealed VMAs.
>
This is the functional change and the most important area that I would
like to discuss in this patch series.

Since Jann Horn first highlighted [1] the problematic behavior of
destructive madvise for anonymous mapping during initial discussions
of mseal(), the proper solution has been open to discussion and
exploration. Linus Torvalds has expressed interest [2] in fixing this
within madvise itself, without requiring mseal, and I copied it here
for ease of reference:

=E2=80=9CHmm. I actually would be happier if we just made that change in
general. Maybe even without sealing, but I agree that it *definitely*
makes sense in general as a sealing thing.=E2=80=9D

After mseal was merged, Pedro Falcato raised a valid concern regarding
file-backed private mappings. The issue is that these mappings can be
written to, and subsequently changed to read-only, which is precisely
the problem this patch aims to fix. I attempted to address this in
[3]. However, that patch was rejected due to the introduction of a new
vm_flags, which was a valid rejection as it wasn't the ideal solution.
Nevertheless, it sparked an interesting discussion, with me raising a
point that userspace might use this feature to free up RAM for
file-backed private mapping that is never written to,  and input about
this topic from Vlastimil Babka [4] is about MADV_COLD/MADV_PAGEOUT.

A detail about userspace calling those madvise for file-backed private
mapping. Previously, I added extra logging in the kernel, and observed
many instances of those calls  during Android phone startup, although
I haven=E2=80=99t delved into the reason behind why user space calls those,
e.g. if it is from an individual app or Android platform.

Incidentally, recently while I was studying selinux code, particularly
exemod permission [5] , I learned that selinux utilizes vma->anon_vma
to identify file-backed mappings that have been written to.  Jann
pointed out to me that the kernel creates a COW mapping when a private
file-backed mapping is written. Now I'm wondering if this could be the
answer to our problem. We could try having destructive madvise check
vma->anon_vma and reject the call if it's true. I haven't had a chance
to test this theory yet, though.

To summarize all the discussion points so far:
1. It's questionable behavior for madvise to allow destructive
behavior for read-only anonymous mappings, regardless of mseal state.
2. We could potentially fix point 1 within madvise itself, without
involving mseal, as Linus desires.
3. Android userspace uses destructive madvise to free up RAM, but I
need to take a closer look at the patterns and usage to understand why
they do that.
4. We could ask applications to switch to non-destructive madvise,
like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
switch the kernel to use non-destructive madvise implicitly for
destructive madvise in suitable situations.
5. We could investigate more based on vma->anon_vma

Link: https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426=
FkcgnfUGLvA@mail.gmail.com/
[1]
Link: https://lore.kernel.org/lkml/CAHk-=3DwiVhHmnXviy1xqStLRozC4ziSugTk=3D=
1JOc8ORWd2_0h7g@mail.gmail.com/
[2]
Link: https://lore.kernel.org/all/20241017005105.3047458-2-jeffxu@chromium.=
org/
[3]
Link: https://lore.kernel.org/all/8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse=
.cz/
[4]
Link: https://elixir.bootlin.com/linux/v6.15.7/source/security/selinux/hook=
s.c#L3878
[5]

> Finally, update the mseal tests, which were asserting previously that a
> read-only MAP_PRIVATE file-backed mapping could be discarded.
>
The test you are updating is not intended for the scenario this patch
is aimed to fix: i.e. the scenario:
1. A MAP_PRIVATE R/W file-backed mapping is established.
2. The mapping is written to, which backs it with anonymous memory.
3. The mapping is mprotect()'d read-only.
4. The mapping is mseal()'d.

The test case doesn't include steps 1, 2, and 3, is it possible to
keep the existing one and create a new test case? But I don't think
that's the main discussion point. We can revisit test cases once we've
fully discussed the design.

Thanks and regards,
-Jeff
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/madvise.c                            | 63 ++++++++++++++++++++++++-
>  mm/mseal.c                              | 49 -------------------
>  mm/vma.h                                |  7 ---
>  tools/testing/selftests/mm/mseal_test.c |  3 +-
>  4 files changed, 63 insertions(+), 59 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2bf80989d5b6..dc3d8497b0f4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/mmu_context.h>
>  #include <linux/string.h>
>  #include <linux/uio.h>
>  #include <linux/ksm.h>
> @@ -1255,6 +1256,66 @@ static long madvise_guard_remove(struct madvise_be=
havior *madv_behavior)
>                                &guard_remove_walk_ops, NULL);
>  }
>
> +#ifdef CONFIG_64BIT
> +/* Does the madvise operation result in discarding of mapped data? */
> +static bool is_discard(int behavior)
> +{
> +       switch (behavior) {
> +       case MADV_FREE:
> +       case MADV_DONTNEED:
> +       case MADV_DONTNEED_LOCKED:
> +       case MADV_REMOVE:
> +       case MADV_DONTFORK:
> +       case MADV_WIPEONFORK:
> +       case MADV_GUARD_INSTALL:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * We are restricted from madvise()'ing mseal()'d VMAs only in very part=
icular
> + * circumstances - discarding of data from read-only anonymous SEALED ma=
ppings.
> + *
> + * This is because users cannot trivally discard data from these VMAs, a=
nd may
> + * only do so via an appropriate madvise() call.
> + */
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +       struct vm_area_struct *vma =3D madv_behavior->vma;
> +
> +       /* If the VMA isn't sealed we're good. */
> +       if (can_modify_vma(vma))
> +               return true;
> +
> +       /* For a sealed VMA, we only care about discard operations. */
> +       if (!is_discard(madv_behavior->behavior))
> +               return true;
> +
> +       /*
> +        * But shared mappings are fine, as dirty pages will be written t=
o a
> +        * backing store regardless of discard.
> +        */
> +       if (vma->vm_flags & VM_SHARED)
> +               return true;
> +
> +       /* If the user could write to the mapping anyway, then this is fi=
ne. */
> +       if ((vma->vm_flags & VM_WRITE) &&
> +           arch_vma_access_permitted(vma, /* write=3D */ true,
> +                       /* execute=3D */ false, /* foreign=3D */ false))
> +               return true;
> +
> +       /* Otherwise, we are not permitted to perform this operation. */
> +       return false;
> +}
> +#else
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +       return true;
> +}
> +#endif
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with i=
ts own
> @@ -1268,7 +1329,7 @@ static int madvise_vma_behavior(struct madvise_beha=
vior *madv_behavior)
>         struct madvise_behavior_range *range =3D &madv_behavior->range;
>         int error;
>
> -       if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
> +       if (unlikely(!can_madvise_modify(madv_behavior)))
>                 return -EPERM;
>
>         switch (behavior) {
> diff --git a/mm/mseal.c b/mm/mseal.c
> index c27197ac04e8..1308e88ab184 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -11,7 +11,6 @@
>  #include <linux/mman.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> -#include <linux/mmu_context.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched.h>
>  #include "internal.h"
> @@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struc=
t *vma)
>         vm_flags_set(vma, VM_SEALED);
>  }
>
> -static bool is_madv_discard(int behavior)
> -{
> -       switch (behavior) {
> -       case MADV_FREE:
> -       case MADV_DONTNEED:
> -       case MADV_DONTNEED_LOCKED:
> -       case MADV_REMOVE:
> -       case MADV_DONTFORK:
> -       case MADV_WIPEONFORK:
> -       case MADV_GUARD_INSTALL:
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -static bool is_ro_anon(struct vm_area_struct *vma)
> -{
> -       /* check anonymous mapping. */
> -       if (vma->vm_file || vma->vm_flags & VM_SHARED)
> -               return false;
> -
> -       /*
> -        * check for non-writable:
> -        * PROT=3DRO or PKRU is not writeable.
> -        */
> -       if (!(vma->vm_flags & VM_WRITE) ||
> -               !arch_vma_access_permitted(vma, true, false, false))
> -               return true;
> -
> -       return false;
> -}
> -
> -/*
> - * Check if a vma is allowed to be modified by madvise.
> - */
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> -{
> -       if (!is_madv_discard(behavior))
> -               return true;
> -
> -       if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> -               return false;
> -
> -       /* Allow by default. */
> -       return true;
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                 struct vm_area_struct **prev, unsigned long start,
>                 unsigned long end, vm_flags_t newflags)
> diff --git a/mm/vma.h b/mm/vma.h
> index acdcc515c459..85db5e880fcc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -577,8 +577,6 @@ static inline bool can_modify_vma(struct vm_area_stru=
ct *vma)
>         return true;
>  }
>
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
> -
>  #else
>
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
> @@ -586,11 +584,6 @@ static inline bool can_modify_vma(struct vm_area_str=
uct *vma)
>         return true;
>  }
>
> -static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int b=
ehavior)
> -{
> -       return true;
> -}
> -
>  #endif
>
>  #if defined(CONFIG_STACK_GROWSUP)
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 005f29c86484..34c042da4de2 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1712,7 +1712,6 @@ static void test_seal_discard_ro_anon_on_filebacked=
(bool seal)
>         unsigned long size =3D 4 * page_size;
>         int ret;
>         int fd;
> -       unsigned long mapflags =3D MAP_PRIVATE;
>
>         fd =3D memfd_create("test", 0);
>         FAIL_TEST_IF_FALSE(fd > 0);
> @@ -1720,7 +1719,7 @@ static void test_seal_discard_ro_anon_on_filebacked=
(bool seal)
>         ret =3D fallocate(fd, 0, 0, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       ptr =3D mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>         FAIL_TEST_IF_FALSE(ptr !=3D MAP_FAILED);
>
>         if (seal) {
> --
> 2.50.1
>
