Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E4E3148D0;
	Fri, 29 Aug 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483573; cv=none; b=mzZ/XCUt0mHWvDVTwNdXHLr2v/DcN1MOpVzzrGDPI9CvMZD1WvcESagWBsIhZNMxKeO5WBUlfJDZS0WIjcLzj+/KH0gIJpJthKcURPB/ubTUJEBQ/DE1DCLFzBgi2g1eTrpidnUZEgzC/G3XAY7Qp5ph6gjDpZpsphTAGe58d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483573; c=relaxed/simple;
	bh=RGa0MkVHJjcHVXyL4onxJ1nMh4o1QeG7lBRU0fTcCUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abb5a7dr2wIh9DQ9j0i85+XMjbzrIEmlRm9w5z97rB3fnX+18EtUnBTr4mD9j75I4ivH6hCf0uwJ5TDsZeaOifFqUS/ZJX04quJ8oFexNVrx6oMtj1IaXWzQRiMlYPm7UL+LRKhwgcXIfy3fxreqv7NnrEomljg2YHQC1FvILUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E2D19F0;
	Fri, 29 Aug 2025 09:06:02 -0700 (PDT)
Received: from [10.57.91.118] (unknown [10.57.91.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FCB03F694;
	Fri, 29 Aug 2025 09:06:06 -0700 (PDT)
Message-ID: <6b692d6c-2da6-413b-90fa-c1425c075628@arm.com>
Date: Fri, 29 Aug 2025 17:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
 function signature
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yue Haibing <yuehaibing@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Joey Gouly <joey.gouly@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 James Morse <james.morse@arm.com>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, David Hildenbrand <david@redhat.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250829154913.work.943-kees@kernel.org>
 <CAMj1kXEs5BiRo89FwnWfW1uR6d=F9yVw0dFb76Yt5Pyq8VtDWw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXEs5BiRo89FwnWfW1uR6d=F9yVw0dFb76Yt5Pyq8VtDWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Kevin Broadsky.

On 29/08/2025 16:59, Ard Biesheuvel wrote:
> On Fri, 29 Aug 2025 at 17:49, Kees Cook <kees@kernel.org> wrote:
>>
>> Seen during KPTI initialization:
>>
>>   CFI failure at create_kpti_ng_temp_pgd+0x124/0xce8 (target: kpti_ng_pgd_alloc+0x0/0x14; expected type: 0xd61b88b6)
>>
>> The call site is alloc_init_pud() at arch/arm64/mm/mmu.c:
>>
>>   pud_phys = pgtable_alloc(TABLE_PUD);
>>
>> alloc_init_pud() has the prototype:
>>
>>   static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>                              phys_addr_t phys, pgprot_t prot,
>>                              phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>>                              int flags)
>>
>> where the pgtable_alloc() prototype is declared.
>>
>> The target (kpti_ng_pgd_alloc) is used in arch/arm64/kernel/cpufeature.c:
>>
>>   create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc), KPTI_NG_TEMP_VA,
>>                           PAGE_SIZE, PAGE_KERNEL, kpti_ng_pgd_alloc, 0);
>>
>> which is an alias for __create_pgd_mapping_locked() with prototype:
>>
>>   extern __alias(__create_pgd_mapping_locked)
>>   void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
>>                                unsigned long virt,
>>                                phys_addr_t size, pgprot_t prot,
>>                                phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>>                                int flags);
>>
>> __create_pgd_mapping_locked() passes the function pointer down:
>>
>>   __create_pgd_mapping_locked() -> alloc_init_p4d() -> alloc_init_pud()
>>
>> But the target function (kpti_ng_pgd_alloc) has the wrong signature:
>>
>>   static phys_addr_t __init kpti_ng_pgd_alloc(int shift);
>>
>> The "int" should be "enum pgtable_type".
>>
>> To make "enum pgtable_type" available to cpufeature.c, move
>> enum pgtable_type definition from arch/arm64/mm/mmu.c to
>> arch/arm64/include/asm/mmu.h.
>>
>> Adjust kpti_ng_pgd_alloc to use "enum pgtable_type" instead of "int".
>> The function behavior remains identical (parameter is unused).
>>
>> Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
> 
> Shouldn't this be
> 
> Fixes: c64f46ee1377 ("arm64: mm: use enum to identify pgtable level
> instead of *_SHIFT")

You beat me to it; agreed. I've added Kevin, who made that change incase there
are any other subtlety.

> 
> 
>> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> 
>> ---
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Yue Haibing <yuehaibing@huawei.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: <linux-arm-kernel@lists.infradead.org>
>> ---
>>  arch/arm64/include/asm/mmu.h   | 7 +++++++
>>  arch/arm64/kernel/cpufeature.c | 5 +++--
>>  arch/arm64/mm/mmu.c            | 7 -------
>>  3 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 6e8aa8e72601..49f1a810df16 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -17,6 +17,13 @@
>>  #include <linux/refcount.h>
>>  #include <asm/cpufeature.h>
>>
>> +enum pgtable_type {
>> +       TABLE_PTE,
>> +       TABLE_PMD,
>> +       TABLE_PUD,
>> +       TABLE_P4D,
>> +};
>> +
>>  typedef struct {
>>         atomic64_t      id;
>>  #ifdef CONFIG_COMPAT
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9ad065f15f1d..e49d142a281f 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -84,6 +84,7 @@
>>  #include <asm/hwcap.h>
>>  #include <asm/insn.h>
>>  #include <asm/kvm_host.h>
>> +#include <asm/mmu.h>
>>  #include <asm/mmu_context.h>
>>  #include <asm/mte.h>
>>  #include <asm/hypervisor.h>
>> @@ -1945,11 +1946,11 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
>>  extern
>>  void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>>                              phys_addr_t size, pgprot_t prot,
>> -                            phys_addr_t (*pgtable_alloc)(int), int flags);
>> +                            phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
>>
>>  static phys_addr_t __initdata kpti_ng_temp_alloc;
>>
>> -static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
>> +static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
>>  {
>>         kpti_ng_temp_alloc -= PAGE_SIZE;
>>         return kpti_ng_temp_alloc;
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 34e5d78af076..183801520740 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -47,13 +47,6 @@
>>  #define NO_CONT_MAPPINGS       BIT(1)
>>  #define NO_EXEC_MAPPINGS       BIT(2)  /* assumes FEAT_HPDS is not used */
>>
>> -enum pgtable_type {
>> -       TABLE_PTE,
>> -       TABLE_PMD,
>> -       TABLE_PUD,
>> -       TABLE_P4D,
>> -};
>> -
>>  u64 kimage_voffset __ro_after_init;
>>  EXPORT_SYMBOL(kimage_voffset);
>>
>> --
>> 2.34.1
>>

