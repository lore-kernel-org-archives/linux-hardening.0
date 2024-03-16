Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C11FBB
	for <linux-hardening@vger.kernel.org>; Sat, 16 Mar 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710558863; cv=none; b=U0Zp8FPuWQ59SNFWMwzDNJyMHDoL/HfDU3qrwMGE72F5RtAj9dMjgvQHtCYGq9NY9ej/1ZeIbvI0OBxMnWKJO2P6x0ooK/SVeaD55xl4w4l3/l4gOErZdObRGiVzECEibBPatx76PCXOdTsghJaIOzs+z3+VKYudpUt5/EFlAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710558863; c=relaxed/simple;
	bh=6eLdmh8za8M9SlO1/FdsHENEjex9kkHmDzLpfZLWkEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUB4YHPCT6vi+9LqmJ057BsqELVkGB4vIA4oMc+Krr6g5z7GBDJYA1Y6fnbK+r8fu9lnrX5Stbq5jRsoYhhikRdHdYKSeK59qHGWyXGPdlUHBD5+9J2rTzIbwuRG7x/gckJoLKZcME+Zj43EruYvsrgStpQ+18B+SgLNLlznpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sempervictus.com; spf=pass smtp.mailfrom=sempervictus.com; dkim=pass (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b=xjP0N31B; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sempervictus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sempervictus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b="xjP0N31B"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso2681370276.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Mar 2024 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sempervictus-com.20230601.gappssmtp.com; s=20230601; t=1710558860; x=1711163660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE8ReMJXOBRMOJPX+O2xrNy0SwcxcCJ3CQ8iZfhs2B0=;
        b=xjP0N31BkJwoKbJEJt0kWT/kayz9V6eWPX0oORv4CR3MVspQgOCP/n9FrRvXwO1QWI
         MC2rZh9x8GWjdROgsozPc/dtajhrFCfW8XS1904C41whGnxljMwyIPs0m7PC3TrUkfSS
         xcNx558/luvYipEuPvzdCdr6ZGBc9jpcrrY1M2vtuto8cc3Bm8htuqCLQbyie5Rhi5iW
         noyeIKz2KJR1OZd/bjw++JXxGjTALnA753LvJrV09HDRWzLNVj1noFWkEjn83NgWfZaX
         icw+mRck1J/Fqrnk4hsKW2A1ktjw50FuxhCVJLml2OP8cQzXfauUQNM5onLTxPWsxr3B
         Q22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710558860; x=1711163660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE8ReMJXOBRMOJPX+O2xrNy0SwcxcCJ3CQ8iZfhs2B0=;
        b=PkqeyrBzBonZuqeSfSXLGnCJ4RUG6FTqhFtsX7bJw9LeBwx+FiuGJyaunYpfwN13gK
         WSL9++6TgLQda7DyNOFoFo2p8hSWV1i3WjkomvkfTnJnC1BBtcp534Vr4Nvou2GqKTo6
         UlUlJEEIBYzYYFoSQ/Z22ptBRdXz21LczIx8rNVYpRgPh6ugU5KWHuSEwxcsQXx8OOWY
         PxZ8xHTbXLYSNRHAE+TnDWfFp+S1njEjUzycNll5Z8A+wcJpLmWsK7Xfbl2u/gXt82T9
         GQ9npjhUdkv4aqVJ7LgEm+eRmWbgIazYcenFiA1Tu9K4b9vFAG78z5YNEA568w9Wr7B2
         htaA==
X-Forwarded-Encrypted: i=1; AJvYcCVAuf/qV0Sh4FHkwJoNvPrhv+g2TDujf/b3lu3gM2iGgiuJ7k/1sxIxgt/TbeYxuK2CV4fUYa0yN5vFKSZ6PH8pQeiVJfeo9yBIy0wxLHi/
X-Gm-Message-State: AOJu0YwsiuZMeGr3bNeAFKXxIjpl2deKQoji7H2uzgcoiOrgK0v3B3Ea
	mUCfkMcl4IEewh0Aof0lC1SOTF3qH2l12S4k4xpu5QqziSxTYWFkO9hiNL/i7kiG4+WRZBBh8A9
	qKutrpRE/ZKxJvg0PY4qOxS49wVE40BA4sp7PjQ==
X-Google-Smtp-Source: AGHT+IFyhoPSc7JGdV+oe6psqd2uVvvZN4Som/ELZ4Ld8+Wk1xchMqIF+Bg6WUGCWLR3cdz5i24uA4aJxYVCqEJ29MI=
X-Received: by 2002:a5b:a90:0:b0:dcc:84ae:9469 with SMTP id
 h16-20020a5b0a90000000b00dcc84ae9469mr5780484ybq.64.1710558860175; Fri, 15
 Mar 2024 20:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
From: Boris Lukashev <blukashev@sempervictus.com>
Date: Fri, 15 Mar 2024 23:14:09 -0400
Message-ID: <CAFUG7Cfy6nmWk9xmTD4rp80i4_RA12V7SA6851BvD=JaWRZeyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/19] PKS write protected page tables
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org, 
	x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org, 
	shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IIRC shoot-downs are one of the reasons for using per-cpu PGDs, which
can in-turn enable/underpin other hardening functions... presuming the
churn of recent years has softened attitudes toward such core MM
changes.
https://forum.osdev.org/viewtopic.php?f=3D15&t=3D29661

-Boris


On Mon, Aug 30, 2021 at 8:02=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> Hi,
>
> This is a second RFC for the PKS write protected tables concept. I'm shar=
ing to
> show the progress to interested people. I'd also appreciate any comments,
> especially on the direct map page table protection solution (patch 17).
>
> Since v1[1], the improvements are:
>  - Fully handle direct map page tables, and handle hotplug/unplug path.
>  - Create a debug time checker that scans page tables and verifies
>    their protection.
>  - Fix odds-and-ends kernel page tables that showed up with debug
>    checker. At this point all of the typical normal page tables should be
>    protected.
>  - Fix toggling of writablility for odds-and-ends page table modification=
s found
>    that don't use the normal helpers.
>  - Create atomic context grouped page allocator, after finding some page =
table
>    allocations that are passing GFP_ATOMIC.
>  - Create "soft" mode that warns and disables protection on violation ins=
tead
>    of oopsing.
>  - Boot parameters for disabling pks tables
>  - Change PageTable set clear to ctor/dtor (peterz)
>  - Remove VM_BUG_ON_PAGE in alloc_table() (Shakeel Butt)
>  - PeterZ/Vlastimil had suggested to also build a non-PKS mode for use in
>    debugging. I skipped it for now because the series was too big.
>  - Rebased to latest PKS core v7 [2]
>
> Also, Mike Rapoport has been experimenting[3] with this usage to work on =
how to
> share caches of permissioned/broken pages between use cases. This RFCv2 s=
till
> uses the "grouped pages" concept, where each usage would maintain its own
> cache, but should be able to integrate with a central solution if somethi=
ng is
> developed.
>
> Next I was planning to look into characterizing/tuning the performance, a=
lthough
> what page allocation scheme is ultimately used will probably impact that.
>
> This applies on top of the PKS core v7 series[2] and this patch[4]. Testi=
ng is
> still pretty light.
>
> This RFC has been acked by Dave Hansen.
>
> [1] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe=
@intel.com/
> [2] https://lore.kernel.org/lkml/20210804043231.2655537-1-ira.weiny@intel=
.com/
> [3] https://lore.kernel.org/lkml/20210823132513.15836-1-rppt@kernel.org/
> [4] https://lore.kernel.org/lkml/20210818221026.10794-1-rick.p.edgecombe@=
intel.com/
>
> Rick Edgecombe (19):
>   list: Support getting most recent element in list_lru
>   list: Support list head not in object for list_lru
>   x86/mm/cpa: Add grouped page allocations
>   mm: Explicitly zero page table lock ptr
>   x86, mm: Use cache of page tables
>   x86/mm/cpa: Add perm callbacks to grouped pages
>   x86/cpufeatures: Add feature for pks tables
>   x86/mm/cpa: Add get_grouped_page_atomic()
>   x86/mm: Support GFP_ATOMIC in alloc_table_node()
>   x86/mm: Use alloc_table() for fill_pte(), etc
>   mm/sparsemem: Use alloc_table() for table allocations
>   x86/mm: Use free_table in unmap path
>   mm/debug_vm_page_table: Use setters instead of WRITE_ONCE
>   x86/efi: Toggle table protections when copying
>   x86/mm/cpa: Add set_memory_pks()
>   x86/mm: Protect page tables with PKS
>   x86/mm/cpa: PKS protect direct map page tables
>   x86/mm: Add PKS table soft mode
>   x86/mm: Add PKS table debug checking
>
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  arch/x86/boot/compressed/ident_map_64.c       |   5 +
>  arch/x86/include/asm/cpufeatures.h            |   2 +-
>  arch/x86/include/asm/pgalloc.h                |   6 +-
>  arch/x86/include/asm/pgtable.h                |  31 +-
>  arch/x86/include/asm/pgtable_64.h             |  33 +-
>  arch/x86/include/asm/pkeys_common.h           |   1 -
>  arch/x86/include/asm/set_memory.h             |  24 +
>  arch/x86/mm/init.c                            |  90 +++
>  arch/x86/mm/init_64.c                         |  29 +-
>  arch/x86/mm/pat/set_memory.c                  | 527 +++++++++++++++++-
>  arch/x86/mm/pgtable.c                         | 183 +++++-
>  arch/x86/mm/pkeys.c                           |   4 +
>  arch/x86/platform/efi/efi_64.c                |   8 +
>  include/asm-generic/pgalloc.h                 |  46 +-
>  include/linux/list_lru.h                      |  26 +
>  include/linux/mm.h                            |  16 +-
>  include/linux/pkeys.h                         |   1 +
>  mm/Kconfig                                    |  23 +
>  mm/debug_vm_pgtable.c                         |  36 +-
>  mm/list_lru.c                                 |  38 +-
>  mm/memory.c                                   |   1 +
>  mm/sparse-vmemmap.c                           |  22 +-
>  mm/swap.c                                     |   6 +
>  mm/swap_state.c                               |   5 +
>  .../arch/x86/include/asm/disabled-features.h  |   8 +-
>  26 files changed, 1123 insertions(+), 52 deletions(-)
>
> --
> 2.17.1
>


--=20
Boris Lukashev
Systems Architect
Semper Victus
