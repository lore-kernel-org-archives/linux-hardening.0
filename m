Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752A31B117;
	Fri, 23 Jan 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151167; cv=none; b=k/Invvr9ATCPEPzQfDndmyyGqZgf2VutRC49w/iGsf1M6YZaIRUkkbylLhm+R1ael6TYKVmo/zXBTa3u99iFecK7bqkaNFNGd/UCgg9GDFo1KFzmIQNQ/Nwi/aRVwuNqfGiY8/GyMS5mRA6+OOB27ismL6uXMirbadt3yI4G28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151167; c=relaxed/simple;
	bh=3Ld18SMXNIG0BmdMZyNYEt+v98dSviEEItf7aF1XbG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9h3dOa1vmGdXBPbUI3nxVNlKlMndmTIh4WLXJFILm5aDAlDdhHNiJUIJ450MaUp/gHKRFypz6QCR0ZElHGElej8rhsZd9bTe+Wax0++M3PKQVUFV3mZ/ay38Oqdg6g1PzRFWhblnB3oLBYVBMXRpcXnCPb3l723MXtyizPDicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8E51476;
	Thu, 22 Jan 2026 22:52:38 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04B13F632;
	Thu, 22 Jan 2026 22:52:41 -0800 (PST)
Message-ID: <47fdacc6-1928-4d77-8024-28133daac0f4@arm.com>
Date: Fri, 23 Jan 2026 12:22:39 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: Unmap kernel data/bss entirely from the linear
 map
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260119164747.1402434-6-ardb+git@google.com>
 <20260119164747.1402434-10-ardb+git@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260119164747.1402434-10-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The linear aliases of the kernel text and rodata are mapped read-only as
> well. Given that the contents of these regions are mostly identical to
> the version in the loadable image, mapping them read-only is a
> reasonable hardening measure.
> 
> Data and bss, however, are now also mapped read-only but the contents of
> these regions are more likely to contain data that we'd rather not leak.
> So let's unmap these entirely in the linear map when the kernel is
> running normally.
> 
> Only when going into hibernation or waking up from it do these regions
> need to be mapped, so take care of this using a PM notifier.

Just curious - why do we need them mapped while going into or coming back
from the hibernation ?

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 35 ++++++++++++++++++--
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d978b07ab7b8..7b3ce9cafe64 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -24,6 +24,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/suspend.h>
>  #include <linux/kfence.h>
>  #include <linux/pkeys.h>
>  #include <linux/mm_inline.h>
> @@ -1024,13 +1025,13 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>  				 prot, early_pgtable_alloc, flags);
>  }
>  
> -static void remap_linear_data_alias(void)
> +static void remap_linear_data_alias(bool unmap)
>  {
>  	extern const u8 __pgdir_start[];
>  
>  	update_mapping_prot(__pa_symbol(__init_end), (unsigned long)lm_alias(__init_end),
>  			    (unsigned long)__pgdir_start - (unsigned long)__init_end,
> -			    PAGE_KERNEL_RO);
> +			    unmap ? __pgprot(0) : PAGE_KERNEL_RO);
>  }
>  
>  void __init remap_linear_kernel_alias(void)
> @@ -1041,7 +1042,7 @@ void __init remap_linear_kernel_alias(void)
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    PAGE_KERNEL_RO);
> -	remap_linear_data_alias();
> +	remap_linear_data_alias(true);
>  }
>  
>  #ifdef CONFIG_KFENCE
> @@ -2257,3 +2258,31 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
>  	return 0;
>  }
>  #endif
> +
> +#ifdef CONFIG_HIBERNATION
> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> +				     unsigned long mode, void *unused)
> +{
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		remap_linear_data_alias(false);
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		remap_linear_data_alias(true);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static struct notifier_block arm64_hibernate_pm_notifier = {
> +	.notifier_call = arm64_hibernate_pm_notify,
> +};
> +
> +static int arm64_hibernate_register_pm_notifier(void)
> +{
> +	return register_pm_notifier(&arm64_hibernate_pm_notifier);
> +}
> +late_initcall(arm64_hibernate_register_pm_notifier);
> +#endif

