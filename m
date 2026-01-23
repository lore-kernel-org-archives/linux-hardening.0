Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690A33DEC9;
	Fri, 23 Jan 2026 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150611; cv=none; b=S+frG6hsyIQyEtYvlTju0E8xwLfdjPRwKPoRgl9D2oX1dwmS1ya4iZllDPQO5kvi9rqC6c40ZiUpbWY2Agvg2v+vhTEaYS8icWlVree2N199l8HJ8tse3nXbVWcEZCxksyO+NGijdIAqh3W4o2+ECD2wshG4z54KSoA8gAm1LTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150611; c=relaxed/simple;
	bh=mZuAf9FPK81t6biHR8k8iL+4ovCw84+OKCruJHr2tE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdgbuwxGSChimQQHJ4jMFeXlTaSJW9npp3poeT4u89uP5y9ECFRD5L5URVWFlJdHX3l7CFy9927GXZPy7thikMerdo6hmMdi87kjWvKIHc+aNbSGDYQTgSX8ZG+2yXBg+KwMJdWN3CJWnr/8EQ5v/2g41vlcrakvIILj6Q3zhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56961476;
	Thu, 22 Jan 2026 22:43:22 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334A83F740;
	Thu, 22 Jan 2026 22:43:25 -0800 (PST)
Message-ID: <ddb667ef-efd1-40f5-832d-9017f6bbbec5@arm.com>
Date: Fri, 23 Jan 2026 12:13:23 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: Move the zero page to rodata
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260119164747.1402434-6-ardb+git@google.com>
 <20260119164747.1402434-9-ardb+git@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260119164747.1402434-9-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The zero page should contain only zero bytes, and so mapping it
> read-write is unnecessary. Move it to __ro_after_init instead.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2a18637ecc15..d978b07ab7b8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -68,7 +68,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
>   * Empty_zero_page is a special page that is used for zero-initialized data
>   * and COW.
>   */
> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
> +					__ro_after_init __aligned(PAGE_SIZE);
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);

A small nit - could this be the first patch in the series here ? Becasue it is
not related to other three patches.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
