Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCF148830
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381961; cv=none; b=Uu3M9oxkBFUIZxGcaOUr02CKennsFY7zq7l/6BrdckH1GsnggJBRgD9mvyELFqEDs2Qr37nQC84hmZVSpX9cq8jdtflX/ZUjJDSk5zl9lfLYe2kHPNrtZ9B4ZlwkFeXz8p30ZMd8dHO/F7va1iNS9SxhnUbP8X/N3ulawp7Zkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381961; c=relaxed/simple;
	bh=GmbiL8iYCG1UQmihDFnlY08O2Td3VL/UPhO2brn2dvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCbDLKOexxMmiHh1LoTucazEokfc+fDa8XjHg9lqbBPY6b1aSUrJqvvJQgeQU71zaJmzoXFPIHKw/JdFT0ZOwEGduVtUAWKzDbYbwlkqWSMzI207d88S6NjmyZO8geBHSvivEsiq8C6TwHdqtlh/kFp8CjuU+SdUEZVWpCOFhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtLjUBVK; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtLjUBVK"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-306cce02908so31950fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753381959; x=1753986759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30rlnSB27npgJWbqBMQFO+7pkMsstYfilIqdkjSj02k=;
        b=gtLjUBVKUNyhr6hxiQQtTRj4OhnLwITT+75wz9PFroSHtXyNu7PamlIDqOkDB0tYth
         zIFmC0PThdv+KILnfkDASfFo4PO80DVZGII8M9kEagtr8EwQ727mECuRsmgcUZ0tc3kD
         h+JNpNK1n+y3QIz9l4ueg0eZrbVtt2cynZosI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381959; x=1753986759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30rlnSB27npgJWbqBMQFO+7pkMsstYfilIqdkjSj02k=;
        b=biAkXyNtN7GSk7TNYlC2D3NYl/7ffIsXKcSHBgStEKYVshARn878cGZcInNnO+aF6J
         XRV8yIYzJf1j9iB8r9nldirZB2yKEV/FBoCr4B5QX19lQBiEVvsWg05yZzphljhX5zpD
         LtghhZK17ZuieYGrUpFqDV2F5rshdoAW9xUt7K8liS8x3CNwg4Aco1WGPZYGr3fdK+mU
         AF9Obxub9upOByrXYbu30j2aE7t8ZZphe/LXS3CYmI+4TQCc5SxIUU4Jc1EukM8kTh/C
         O2Bqg63wkZE+T7fVhbOR8BwpnbK1TVYOWlXTxYDsqvaLAs1YYLeiZyI0W+2CnPODIZVE
         DTfw==
X-Forwarded-Encrypted: i=1; AJvYcCUdljtFYyw6sLlMO4Gxy2zC4OH/Q4JXNGh0EAExQMwS4CbYEqkQ/dmpDMsq7Ly6HR7+otjsmnnF9hK3+S6m/44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAcd0Z3/ZVA7EhirkClxZXPSuYevp86wkIjxmB4WqpF7bWtVh
	wlzyMJUuBzXCWaPnIxLG+IuQyoPQGmTPbSfLB8mikRVnt1Ph1RDVI70vSoN4U7iPw21/WfeCV7O
	KOBGS0vunu/RLHRBp2NyCyoMIACu3VyZU+7NIWICJ
X-Gm-Gg: ASbGncsT6tZ3HTHBG9fYwpB8hIbo2gzZkUz4JkYYDlop8MT8vTHu+SWHiCEyK1A2T/x
	kPKB4c6ME0J1yc5cuoVeJfNjbadjHmWz2T/iiXlI/6dvT6QptHLodZfe7JdStE0mEyp3V+ZOZXV
	/VLuL7saiB+uaWnaIzT/1NOzBVdVsQG0L2qb3L/tR+kFYtD9MguNs9mb/6gW7WEkvfilhDOx+Tw
	eszw5c1+t6A+4zsLb0Yj2Rs+41IiSXECt3V
X-Google-Smtp-Source: AGHT+IE/v8/QcDYMq5rcXlGAzua42CVQDWzWzn2XXU5Eo9ZmM+YPZpj2WCQ58zMFcZj9ilRciyOvuOU/eAmRuaHjmtQ=
X-Received: by 2002:a05:6870:bb17:b0:2d6:1e7:f583 with SMTP id
 586e51a60fabf-306c6f2f38fmr2016132fac.3.1753381958752; Thu, 24 Jul 2025
 11:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:32:26 -0700
X-Gm-Features: Ac12FXzJWfvxsyQk1Xr5HsYL_xRb49zP3u1pqHeWkzOCB4ps3luILJW3LOiNn98
Message-ID: <CABi2SkVVswRr+H5OWRcbFQSLq_457a0eXwn0OrtkcMEbGphz6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mseal cleanups, fixup MAP_PRIVATE file-backed case
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

Thanks for including me in this thread. I've just returned from
vacation and am catching up on my emails. I'll respond to each patch
separately in the following emails.

Could you consider adding mm/mseal.c to the HARDENING section of
MAINTAINERS? Please include Kees and linux-hardening in future emails
about mseal - Kees has been helping me with mseal since the beginning.

Thanks and regards,
-Jeff

On Wed, Jul 16, 2025 at 10:38=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Perform a number of cleanups to the mseal logic. Firstly, VM_SEALED is
> treated differently from every other VMA flag, it really doesn't make sen=
se
> to do this, so we start by making this consistent with everything else.
>
> Next we place the madvise logic where it belongs - in mm/madvise.c. It
> really makes no sense to abstract this elsewhere. In doing so, we go to
> great lengths to explain very clearly the previously very confusing logic
> as to what sealed mappings are impacted here.
>
> In doing so, we fix an existing logical oversight - previously we permitt=
ed
> an madvise() discard operation for a sealed, read-only MAP_PRIVATE
> file-backed mapping.
>
> However this is incorrect. To see why consider:
>
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.
>
> At this point you have data that, once sealed, a user cannot alter, but a
> discard operation can unrecoverably remove. This contradicts the semantic=
s
> of mseal(), so should not be permitted.
>
> We then abstract out and explain the 'are there are any gaps in this rang=
e
> in the mm?' check being performed as a prerequisite to mseal being
> performed.
>
> Finally, we simplify the actual mseal logic which is really quite
> straightforward.
>
>
> v3:
> * Propagated more tags, thanks everyone!
> * Updated 5/5 to assign curr_start in a smarter way as per Liam. Adjust
>   code to more sensibly handle already-sealed case at the same time.
> * Updated 4/5 to not move range_contains_unmapped() for better diff.
> * Renamed can_modify_vma() to vma_is_sealed() and inverted the logic - th=
is
>   is far clearer than the nebulous 'can modify VMA'.
>
> v2:
> * Propagated tags, thanks everyone!
> * Updated can_madvise_modify() to a more logical order re: the checks
>   performed, as per David.
> * Replaced vma_is_anonymous() check (which was, in the original code, a
>   vma->vm_file or vma->vm_ops check) with a vma->vm_flags & VM_SHARED
>   check - to explicitly check for shared mappings vs private to preclude
>   MAP_PRIVATE-mapping file-baked mappings, as per David.
> * Made range_contains_unmapped() static and placed in mm/mseal.c to avoid
>   encouraging any other internal users towards this rather silly pattern,
>   as per Pedro and Liam.
> https://lore.kernel.org/all/cover.1752586090.git.lorenzo.stoakes@oracle.c=
om/
>
> v1:
> https://lore.kernel.org/all/cover.1752497324.git.lorenzo.stoakes@oracle.c=
om/
>
> Lorenzo Stoakes (5):
>   mm/mseal: always define VM_SEALED
>   mm/mseal: update madvise() logic
>   mm/mseal: small cleanups
>   mm/mseal: Simplify and rename VMA gap check
>   mm/mseal: rework mseal apply logic
>
>  include/linux/mm.h                      |   6 +-
>  mm/madvise.c                            |  63 +++++++++-
>  mm/mprotect.c                           |   2 +-
>  mm/mremap.c                             |   2 +-
>  mm/mseal.c                              | 157 +++++-------------------
>  mm/vma.c                                |   4 +-
>  mm/vma.h                                |  27 +---
>  tools/testing/selftests/mm/mseal_test.c |   3 +-
>  tools/testing/vma/vma_internal.h        |   6 +-
>  9 files changed, 107 insertions(+), 163 deletions(-)
>
> --
> 2.50.1
