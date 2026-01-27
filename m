Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3638D;
	Tue, 27 Jan 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507913; cv=none; b=fkZvv/HWkdGDSJDSe0YxCSSOp6DbXaZgiCn/ux+fW0Jw50u8LD3QJyyooybTWsxgclUG9zeF9RWvD99ncfcmdaCyHROzb7aG/45FADSlLIb6BR940/WXks3Ni9gd3iGWe9AjEx5Gc2+5TVHIXfX02o34avlVKCg0CeDv1PxOHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507913; c=relaxed/simple;
	bh=prX+O8UOHO4zR9/a/9HxT+bEJhYFpBxrgaR7VDdBy9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDC53rEKyJMUgNYchOpW8MYJCDXVP+dIK1p4EordR878j/mj55z83m6zkLcvZw0z4R4X0S9LgFKxeX8WRPGL/BHI+1w1GqiThd5sBfYPer+sI9fh1TB2DF25RzDmZTLM8tMwvobiM8KFToj39R+wDXfmZr4gyEZqeCDnPHEcwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A26B1595;
	Tue, 27 Jan 2026 01:58:24 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0048B3F73F;
	Tue, 27 Jan 2026 01:58:28 -0800 (PST)
Message-ID: <487034a1-817b-4fc4-a1ff-3ab028dc80bf@arm.com>
Date: Tue, 27 Jan 2026 09:58:27 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] arm64: mm: Preserve existing table mappings when
 mapping DRAM
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-16-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-16-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Instead of blindly overwriting an existing table entry when mapping DRAM
> regions, take care not to replace a pre-existing table entry with a
> block entry. This permits the logic of mapping the kernel's linear alias
> to be simplified in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9d39de3cfe67..28cc3cda042c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -262,7 +262,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  
>  		/* try section mapping first */
>  		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
> +		    !pmd_table(old_pmd)) {
>  			pmd_set_huge(pmdp, phys, prot);
>  
>  			/*
> @@ -385,7 +386,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		 */
>  		if (pud_sect_supported() &&
>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
> +		    !pud_table(old_pud)) {
>  			pud_set_huge(pudp, phys, prot);
>  
>  			/*

