Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72D192D8A;
	Fri, 29 Aug 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483171; cv=none; b=ZGHhhXX5HAywgLO9RRq1DLnh+GyrmE1n/1PVkZpHCj1q5PyybhqES6lptnRdMbsFoyHu6AGCdEffQj+NuhRl6dfVHLXnB2T4wf2nlF+y5UjTMjAs4nFPZbbNHvpjyI6isMt6jUliTWV90peFo5mND81EMibFl2bx33EkCZ8ATB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483171; c=relaxed/simple;
	bh=Agff60TXGLwvmuEaw2NavACUa3icjRtY009OwnBqb4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cthW+9tDA0wiSR8km/ibnwX/KXvAJMUuDz3dauPT6N0Wde51k5Z22LcIPA6FB/w0hvWHLEqK1CHCp7OoUZsBVqcsQme5DHEglzIX/jChKZWgLIgPm56gfpSpzypQePQm0nu59LiUdWcyWS0o93AioejzmZoEw+Gh43D9uWvwYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG10N3Q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG10N3Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFBFC4CEF5;
	Fri, 29 Aug 2025 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756483170;
	bh=Agff60TXGLwvmuEaw2NavACUa3icjRtY009OwnBqb4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XG10N3Q8tpMLS1Hcq1C/IzmUogL+ESq8V6vOyyQggn/Ird8T3VNm80D62LLqrKiME
	 JMGdOj3kAyZUutbtdfBq+ZK2rx2BQgK7dkz1daJ+poNcAoNpzhXzSH/OcwRmeG11Le
	 rcu2lziavXlgs2aErjUCoi9qvYl4CtYYFKoGG+q+aWLQWRH7pO3qEZFGumVNzCLSF1
	 i97MpiwfFW5cyUGIgmKM38Qpzlxm+6sSCC/1Hgk91Bul1x6R5UhITing3z4WReRoc/
	 LwvJAciyRr02Q7tikYlIWGrpdjBAddV3AhPB9HKXM6fRsTui3POIHPDQ2fCyELyBOy
	 1+ex7pPJ5exPQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so707805e87.1;
        Fri, 29 Aug 2025 08:59:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWDAGLNOgoZN7bQKqOfNfkjDiR1JqD9H0Yh6GBB2FoWVlFl38AuDg1KkxQpeHHFFBkhjn9Y5vVoeuuAS66@vger.kernel.org, AJvYcCWmNVb5hSoM7/VB/+QT2JBZJ45VpslcSngA1ENaMzo9weAcCWmA7o+a/eYIrDGq8raxA5B4BFB1OMIliDoaBC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuQhSLkricxgJGlaQK6flSOMGjnTC/YWUXjAQooc4bKP71FJl
	MYUF9I29UtLt0k5JkrmW6t29niTa8XhJNOGZdreNURD8HIP7kQL3gLqqukodKLFjBNXveMAhbu9
	vWWDK6l2Wp4x/qCuRMqIxslg3gpoBSpk=
X-Google-Smtp-Source: AGHT+IE2uJmqErNpiUH2MoiCA7htuRpojl7+qvai6M2fJo7xfFtC2Vhb8xTNG066MqaQxG+wtoJn5sGv94PkmkI03TM=
X-Received: by 2002:a05:6512:140d:b0:55f:6c72:b727 with SMTP id
 2adb3069b0e04-55f6c72ba9bmr358005e87.24.1756483169155; Fri, 29 Aug 2025
 08:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829154913.work.943-kees@kernel.org>
In-Reply-To: <20250829154913.work.943-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Aug 2025 17:59:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEs5BiRo89FwnWfW1uR6d=F9yVw0dFb76Yt5Pyq8VtDWw@mail.gmail.com>
X-Gm-Features: Ac12FXzpjI0zTRoPfVkJGHhj0T6dAsq8Q5pBhlrd4fqSaz1jVC1vYe7nT4JL8S4
Message-ID: <CAMj1kXEs5BiRo89FwnWfW1uR6d=F9yVw0dFb76Yt5Pyq8VtDWw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
 function signature
To: Kees Cook <kees@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ryan Roberts <ryan.roberts@arm.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Joey Gouly <joey.gouly@arm.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, James Morse <james.morse@arm.com>, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	David Hildenbrand <david@redhat.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 17:49, Kees Cook <kees@kernel.org> wrote:
>
> Seen during KPTI initialization:
>
>   CFI failure at create_kpti_ng_temp_pgd+0x124/0xce8 (target: kpti_ng_pgd_alloc+0x0/0x14; expected type: 0xd61b88b6)
>
> The call site is alloc_init_pud() at arch/arm64/mm/mmu.c:
>
>   pud_phys = pgtable_alloc(TABLE_PUD);
>
> alloc_init_pud() has the prototype:
>
>   static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>                              phys_addr_t phys, pgprot_t prot,
>                              phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>                              int flags)
>
> where the pgtable_alloc() prototype is declared.
>
> The target (kpti_ng_pgd_alloc) is used in arch/arm64/kernel/cpufeature.c:
>
>   create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc), KPTI_NG_TEMP_VA,
>                           PAGE_SIZE, PAGE_KERNEL, kpti_ng_pgd_alloc, 0);
>
> which is an alias for __create_pgd_mapping_locked() with prototype:
>
>   extern __alias(__create_pgd_mapping_locked)
>   void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
>                                unsigned long virt,
>                                phys_addr_t size, pgprot_t prot,
>                                phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>                                int flags);
>
> __create_pgd_mapping_locked() passes the function pointer down:
>
>   __create_pgd_mapping_locked() -> alloc_init_p4d() -> alloc_init_pud()
>
> But the target function (kpti_ng_pgd_alloc) has the wrong signature:
>
>   static phys_addr_t __init kpti_ng_pgd_alloc(int shift);
>
> The "int" should be "enum pgtable_type".
>
> To make "enum pgtable_type" available to cpufeature.c, move
> enum pgtable_type definition from arch/arm64/mm/mmu.c to
> arch/arm64/include/asm/mmu.h.
>
> Adjust kpti_ng_pgd_alloc to use "enum pgtable_type" instead of "int".
> The function behavior remains identical (parameter is unused).
>
> Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")

Shouldn't this be

Fixes: c64f46ee1377 ("arm64: mm: use enum to identify pgtable level
instead of *_SHIFT")


> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> ---
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Yue Haibing <yuehaibing@huawei.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>  arch/arm64/include/asm/mmu.h   | 7 +++++++
>  arch/arm64/kernel/cpufeature.c | 5 +++--
>  arch/arm64/mm/mmu.c            | 7 -------
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 6e8aa8e72601..49f1a810df16 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -17,6 +17,13 @@
>  #include <linux/refcount.h>
>  #include <asm/cpufeature.h>
>
> +enum pgtable_type {
> +       TABLE_PTE,
> +       TABLE_PMD,
> +       TABLE_PUD,
> +       TABLE_P4D,
> +};
> +
>  typedef struct {
>         atomic64_t      id;
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9ad065f15f1d..e49d142a281f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -84,6 +84,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/insn.h>
>  #include <asm/kvm_host.h>
> +#include <asm/mmu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mte.h>
>  #include <asm/hypervisor.h>
> @@ -1945,11 +1946,11 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
>  extern
>  void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>                              phys_addr_t size, pgprot_t prot,
> -                            phys_addr_t (*pgtable_alloc)(int), int flags);
> +                            phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
>
>  static phys_addr_t __initdata kpti_ng_temp_alloc;
>
> -static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
> +static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
>  {
>         kpti_ng_temp_alloc -= PAGE_SIZE;
>         return kpti_ng_temp_alloc;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 34e5d78af076..183801520740 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -47,13 +47,6 @@
>  #define NO_CONT_MAPPINGS       BIT(1)
>  #define NO_EXEC_MAPPINGS       BIT(2)  /* assumes FEAT_HPDS is not used */
>
> -enum pgtable_type {
> -       TABLE_PTE,
> -       TABLE_PMD,
> -       TABLE_PUD,
> -       TABLE_P4D,
> -};
> -
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
>
> --
> 2.34.1
>
