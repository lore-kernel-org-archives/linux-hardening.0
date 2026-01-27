Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A3145348;
	Tue, 27 Jan 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506459; cv=none; b=mUVSdSDJDJqhPE+t602C9R75BUg5pJGgDuqvytMg+HEI2GfzX0uOpLJ/LNq6fW4GI/LfRTMzIGpIG012z1x0/FJ9i3u2J4EUwGRuurKpTkNPEItKIgyinGOfP8otyYK0KQ6bBBgPxR5WKWzvaVB5h9jicRPwZkifAEvmLKlWfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506459; c=relaxed/simple;
	bh=6BjanRm3fGR3hWk6Lht9ENgnfuTCsg583c1KBzrB2rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLioH+RXyzJKw1vUV3MCqUeNbSJBunV4hIrNFq9PiWnK+9fB7Vpepo3nFd25lXNW1phIpvDnXK+g7lkvdC+e+1gU7zf4jZ7MjrD6lxoxjo4ODayS2T3kIUzFHcZXLNUNHJ3ryZreCFSzt7NBiYio1fRhBHlMbRiKv0dlDxFqYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F684339;
	Tue, 27 Jan 2026 01:34:10 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293ED3F632;
	Tue, 27 Jan 2026 01:34:15 -0800 (PST)
Message-ID: <3d59a8d9-a382-48d8-b79c-f5c23e86c1b7@arm.com>
Date: Tue, 27 Jan 2026 09:34:13 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] arm64: Move the zero page to rodata
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-13-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-13-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The zero page should contain only zero bytes, and so mapping it
> read-write is unnecessary. Combine it with reserved_pg_dir, which lives
> in the read-only region of the kernel, and already serves a similar
> purpose.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 1 +
>  arch/arm64/mm/mmu.c             | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index ad6133b89e7a..b2a093f5b3fc 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -229,6 +229,7 @@ SECTIONS
>  #endif
>  
>  	reserved_pg_dir = .;
> +	empty_zero_page = .;
>  	. += PAGE_SIZE;
>  
>  	swapper_pg_dir = .;

Isn't there a magic macro for getting from swapper to reserved? That will need
updating?

/*
 *  Open-coded (swapper_pg_dir - reserved_pg_dir) as this cannot be calculated
 *  until link time.
 */
#define RESERVED_SWAPPER_OFFSET	(PAGE_SIZE)


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9ae7ce00a7ef..c36422a3fae2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
>  
>  /*
>   * Empty_zero_page is a special page that is used for zero-initialized data
> - * and COW.
> + * and COW. Defined in the linker script.
>   */
> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);

What's the benefit of giving it it's own place in the linker script vs just
declaring it as const and having it placed in the rodata?

Thanks,
Ryan

>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);

