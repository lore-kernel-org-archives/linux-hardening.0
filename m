Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40F29B781;
	Wed,  8 Apr 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663158; cv=none; b=LKtwvRmLstRIi9dbNlRjvtkLT0PqGsPiOpOtO9bY5sXSjbxe8kbD2b6rVs6AeOnARnhZWWLKMfFL8NbUnJ9E0XyuXRFEiFQPvcn+eTUiN/K7S52M31tnLgG2RtshUac5edAU23q46tfYitYW/mAFPWLeV095AUXqOR0UhDoas/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663158; c=relaxed/simple;
	bh=wU4fl4TVjcDvpPsgzmCAzBUjdKqZzT3ruEAOqBLPur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFhgAZZIQip3UABQ9thx3PO6IIiUL9Qnxj8thQaanANQOgjfRZrHtlqDVAWrevFZ9eDZckyn+3JPc7MRzrhayuqxy7ZSKqXmZ7Tthnv5A4uoo7CdcJCy014KwG9q6kyIEvrztTMUi5LRSEgaUbmEu7gsDlFimE+GOyGpLHqVDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ssiz1u3d; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ssiz1u3d"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282BB2D95;
	Wed,  8 Apr 2026 08:45:49 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5B43F641;
	Wed,  8 Apr 2026 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775663154; bh=wU4fl4TVjcDvpPsgzmCAzBUjdKqZzT3ruEAOqBLPur8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssiz1u3djmV8rAMYAoclPL8g16hGcki6QruDxNI05/Y3ecc9dW9TqAIuuLFyW8JO2
	 n1teO/SX4wWUBVXyomhih13JTxZHQhdBdPd0Rs/ACO3Z/nRD/j66ovo4mVuaybMl/0
	 WWyhFHASYxpriq9JB8deqR+XLi/8uBuRwIiymPQc=
Date: Wed, 8 Apr 2026 16:45:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 07/13] arm64: mm: Use hierarchical XN mapping for the
 fixmap
Message-ID: <adZ4LpvJJz-3K20O@arm.com>
References: <20260320145934.2349881-15-ardb+git@google.com>
 <20260320145934.2349881-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320145934.2349881-22-ardb+git@google.com>

On Fri, Mar 20, 2026 at 03:59:42PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Nothing in the fixmap or in its vicinity requires executable
> permissions, and given that it is placed at exactly 1 GiB from the end
> of the virtual address space, we can safely set the hierarchical XN
> attributes on the level 2 table entries covering the fixmap, without
> running the risk of inadvertently taking away the executable permissions
> on an adjacent mappings.
> 
> This is a hardening measure that reduces the risk of the fixmap being
> abused to create executable mappings in the kernel address space.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/fixmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c5c5425791da..c3dd3c868cf5 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -48,7 +48,8 @@ static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
>  	if (pmd_none(pmd)) {
>  		ptep = bm_pte[BM_PTE_TABLE_IDX(addr)];
>  		__pmd_populate(pmdp, __pa_symbol(ptep),
> -			       PMD_TYPE_TABLE | PMD_TABLE_AF);
> +			       PMD_TYPE_TABLE | PMD_TABLE_AF |
> +			       PMD_TABLE_PXN | PMD_TABLE_UXN);
>  	}
>  }

Sashiko reckons this breaks kpti. I think that's valid but I couldn't
reproduce it on qemu (maybe it doesn't implement hierarchical
permissions). Then I tried FVP and the whole series panics (unrelated to
kpti). With kvm-arm.mode=protected, I think kvm_ksym_ref() is lm_alias()
and we have kvm_hyp_init_symbols() trying to flush the bss.

I'll drop it for now.

Unable to handle kernel paging request at virtual address fff00000748f7000
Mem abort info:
  ESR = 0x0000000096000147
** replaying previous printk message **
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000147, ISS2 = 0x00000000
  CM = 1, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000f40ad000
[fff00000748f7000] pgd=18000008fffff403, p4d=18000008ffffe403, pud=18000008ffffd403, pmd=18000008fffe9403, pte=00e80000f48f7406
Internal error: Oops: 0000000096000147 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc3-00013-g6bb20b972b8c #2 PREEMPT
Hardware name: FVP Base RevC (DT)
pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : dcache_clean_inval_poc+0x24/0x48
lr : kvm_arm_init+0xb48/0x1338
sp : ffff80008005bd20
x29: ffff80008005bd60 x28: ffff95c63230b000 x27: 0000000000000004
x26: 0000000000000001 x25: ffff95c631a160c0 x24: 0000000000000008
x23: 0000000000000000 x22: 0000000000000000 x21: fff00000748f7000
x20: 0000000000002000 x19: 0001101131111112 x18: 00000000ffffffff
x17: ffff95c6321fdd88 x16: 0000000031427afd x15: 0000000000000100
x14: 0000000000000000 x13: 0000000000077a9a x12: fff000087f805650
x11: fff000087f805630 x10: ffffc1ffe005db08 x9 : 0000000000000000
x8 : 0000000080000000 x7 : ffff80008005bc50 x6 : 000f63580145a000
x5 : ffff95c6322f8000 x4 : 0000000000000000 x3 : 000000000000003f
x2 : 0000000000000040 x1 : fff00000748f9000 x0 : fff00000748f7000
Call trace:
 dcache_clean_inval_poc+0x24/0x48 (P)
 do_one_initcall+0x60/0x1d4
 kernel_init_freeable+0x24c/0x2d4
 kernel_init+0x24/0x140
 ret_from_fork+0x10/0x20
Code: 9ac32042 d1000443 8a230000 d503201f (d50b7e20)
---[ end trace 0000000000000000 ]---

-- 
Catalin
