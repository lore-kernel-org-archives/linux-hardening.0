Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299416F287
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268416; cv=none; b=N9QNJNOZVxC8myVW/Dmd2NnpFpvXaLoaGx4epB4061aDdFg+q1JDtgBmWTzxTRl+4DdubIKNt/U6huGnvgjHl9QfxV9/wHZ1wFEF4TP9HD7HgsZXigxh9udNtI3ZKBxuZJCFzDMehzIurGioh6VoRRuAah51bF40cqpe9KAq3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268416; c=relaxed/simple;
	bh=yPKQceVlPlKwm4pgJ2pTlOEXhyGfmpk1MUlQVYNrhYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XicdSiW48C5r/z9GWUNc6XJClcdDlJzpxoPCiqJjoWemrNVxe5MiHqYvG/E5tBJg2z/lf+euI8Z0dJHBmKwJxOWyyEiHvrKD5bhXK9smV+jAh2JU0QKJREeBwNO2q4rgnLlV7tSxcCSCIVo+N+cV2QfrOM+rjW64pjN42/ZUAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hmVr/0/8; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hmVr/0/8"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-26110765976so152602fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726268414; x=1726873214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkIOvqXp0bknmVx1Vck74B49RD+y94/wq8LEP+SHHiM=;
        b=hmVr/0/8luBb8yTHCIOrViiI4/Xi18M610EyUrFDD3Hlm25hddSvPGcl9dsFCfh+wS
         u8EuYIN8HjySjszhB/H1GLXyIoUCswrZiwGA4NzXtNk9331yTkRssw5lHC617wUJNYgl
         P/KtdrIaGbzcdJ6plm0vdVAzdw5ZHYXCp6u7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726268414; x=1726873214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkIOvqXp0bknmVx1Vck74B49RD+y94/wq8LEP+SHHiM=;
        b=vr5Xe2KXTDGQwbTpQHgw5Nwit9nmovfQfa1lFE1EOmZkVyIpPF/hzjwZ27fu0N/i9R
         TJTvGJemlsGJGtFc/GB/OA7cjUZpdUlmz4fX/rcRLw5i1mDU7svGNGyDLD5ZzkrAyMte
         qSrYIwpgNeIRFn0mVRy5yJJcEsacDmSk9oPbmi/z4zhTimZM1vHSVv0cH+wpr6wxypyL
         EyClqv5+0wnU5vKRdbO3AKVjKjv++J3zLmYYUJoe91vPGrMUvKBb4HGBQXbIt9vsK5m4
         8xnHgqzsuUp594refOdhiQDlqnW/Khh8H1eRCT/njBPGc4dRjIvbPeoEWTRwAVBReB9d
         wGsw==
X-Forwarded-Encrypted: i=1; AJvYcCVDTlEsQA5V2EO8hbOCTKzDpQ181Rq0aAJCilqKKGEQ0YYLegsjA/paU3oFqV/kcmVSo+VhZYaXYYp8rmaVR9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsuCtN8JyAGcToQFaxjIxRY/02t0qTrvr7Kh097udrpyWTl51
	RojQh43lnQqUPwDeJt7UNoRLVMHbVONLZgIVABNGqnfboLkmY1MvcR29uaMVHLtjyfFsYVlu1dU
	jCwgn16nRhrhECGISeiVcwM11mo+uf0vVDM5u46aLWGUT35k=
X-Google-Smtp-Source: AGHT+IHPuIs8Xo6Q9Nqk9p5B4mSRmV8QUmXfFXF8O6+1IoOb5C/bPaCY7foKwpfjxOPYErsM3rEYqH12IqZ0JQPe9+A=
X-Received: by 2002:a05:6870:9381:b0:27b:9f8a:7a7f with SMTP id
 586e51a60fabf-27c3f68be4bmr1479138fac.12.1726268414034; Fri, 13 Sep 2024
 16:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
In-Reply-To: <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Sep 2024 16:00:00 -0700
Message-ID: <CABi2SkUDwuuwiFw7pDspPibUaQbdBaGaqvi8_XV7bjq+ZUrr_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Sun, Sep 8, 2024 at 2:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> I agree with most of the points. Sitting down here to write unofficial
> guidelines for mseal behavior.
>
> mseal should seal regions and mark them immutable, which means their prot=
ection
> and contents (ish?) (not _only_ backing mapping, but also contents in gen=
eral
> (see madvise below)) should not be changed throughout the lifetime of the=
 address space.
>
> For the general syscall interface, this means:
> 1) mprotect and munmap need to be blocked on mseal regions.
>  1a) munmap _cannot_ tolerate partial failure, per POSIX.
>  2b) mmap MAP_FIXED counts as an unmap operation and also needs to be blo=
cked and return -EPERM.
>
> 2) Most madvise calls are allowed, except for destructive operations on
> read-only anonymous _pages_ (MADV_DONTNEED is destructive for anon, but w=
e also don't care
> about blocking these ops if we can do it manually with e.g memset)
>  2a) The current implementation only blocks discard on anonymous _regions=
_, which is slightly
>      different. We probably do want to block these on MAP_PRIVATE file ma=
ppings, as to block
>      stuff like madvise MADV_DONTNEED on program rodata.
>  2b) We take into account pkeys when doing the permission checks.
>
> 3) mremap is not allowed as we'd change the "contents" of the old region.
>  3a) Should mremap expansion be allowed? aka only block moving and shrink=
ing, but allow expansion.
>      We already informally allow expansion if e.g mmapping after it + mse=
al.
>
> 4) mlock and msync are allowed.
>
> 5) mseal is blocked.
mseal is not blocked, i.e. seal on an already sealed memory is
no-op. This is described in mseal.rst [1]

[1] https://github.com/torvalds/linux/blob/master/Documentation/userspace-a=
pi/mseal.rst

>
> 6) Other miscellaneous syscalls (mbind, etc) that do not change contents =
in any way, are allowed.
>  6a) This obviously means PTEs can change as long as the contents don't. =
Swapping is also ok.
>
> 7) FOLL_FORCE (kernel-internal speak, more commonly seen as ptrace and /p=
roc/self/mem from userspace)
>    should be disallowed (?)
>  7a) This currently does not happen, and seems like a large hole? But dis=
allowing this
>      would probably severely break ptrace if the ELF sealing plans come t=
o fruition.
>
Jann Horn  pointed out FOLL_FORCE during RFC [2], and this is in mseal.rst =
too.

In short, FOLL_FORCE is not covered by mseal. On ChromeOS, FOLL_FORCE
is disabled. Recently, Adrian Ratiu upstreamed that [3]

[2] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426Fk=
cgnfUGLvA@mail.gmail.com/
[3]   https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@coll=
abora.com/

-Jeff

> When we say "disallowed", we usually (apart from munmap) allow for partia=
l failure. This
> means getting an -EPERM while part of the call succeeded, if we e.g mprot=
ect a region consisting
> of [NORMAL VMA][SEALED VMA]. We do not want to test for this, because we =
do not want to paint ourselves
> into a corner - this is strictly "undefined behavior". The msealed region=
s themselves
> will never be touched in such cases. (we do however want to test munmap o=
peration atomicity, but this is
> also kind of a munmap-related test, and might not really be something we =
really want in the mseal tests)
>
> Kernel-internal wise: The VMA and PTE modifications resulting from the ab=
ove operations are blocked.
> Sealed VMAs allow splitting and merging; there was contention about the s=
plitting issue, but it truly
> does not make sense to block operations unless they affect a VMA entirely=
, and that would also force
> VMA merging to be ABI ("vma_merge isn't merging these two regions and now=
 my madvise works/doesn't work :(").
>
>
> Do I have everything right? Am I missing anything?
>
> --
> Pedro
