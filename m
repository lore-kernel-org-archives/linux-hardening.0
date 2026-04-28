Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3331E833;
	Tue, 28 Apr 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385795; cv=none; b=uO7mrlUh/E6nE1hDW+pZc84QLRDPXD9bewlQKWYkXxiVOwvdlqC66aAxHtfhDj/rDacxaOZyB2N0t9AP6C+7Om0hYmqKKJR3aAXlGORKWt9a7lSrSa3bx2HYyx4Yo0cMRmKDUPdVvxMErXaeqPEQ5Spm1O/Dvb0WI6oErj9R50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385795; c=relaxed/simple;
	bh=btCZZuKZwDHwegac4lZwAmmkykNullD5FLtTtCs4fM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXowqkSWJowkjp01VHY2kOwOoW0fB+EslQELRqpS1fv3S55ny75JIbdfJdN8KCoD1TfxcdMf4uYSLIAL4/mivkoeXcdC8MVmSpAhquR7+RhiNIUTEqIA5JtsVy2WOWRaafcUjjDMyRnjFnA+C7theQe2sVZDl886Bj+ukFJEp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KZBlPQ1s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KZBlPQ1s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7841C2B;
	Tue, 28 Apr 2026 07:16:22 -0700 (PDT)
Received: from [10.57.63.26] (unknown [10.57.63.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48BFF3F763;
	Tue, 28 Apr 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777385788; bh=btCZZuKZwDHwegac4lZwAmmkykNullD5FLtTtCs4fM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZBlPQ1sPDbrJhxD9GJVH5ERW4UKB3ReLaGE3w6Rs7y5sqoZtBJxYyDPoySmzUimS
	 O2W2ca7Bx0rNnlTgvtXYIkX9i8isJ3q6U5bEoSdMuy+joC8i+kcUX/Pz9lnXt+pwSX
	 DREPzwlNeterBeiJ8pRPWspZwsPTrQUst6s1cJdo=
Message-ID: <82091dd4-9d11-4054-89ec-99aadaeec7b2@arm.com>
Date: Tue, 28 Apr 2026 16:16:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] arm64: mm: Map the linear alias of text/rodata
 as tagged
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-18-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-18-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Before moving the empty_zero_page into the __ro_after_init section, make
> sure it has the memory-tagged type. This is needed to ensure that
> cpu_enable_mte() will be able to initialize the tags correctly.

mark_linear_text_alias_ro() is called after all features have been
detected and enabled, so do we actually need this?

AFAICT the lines that matter for cpu_enable_mte() are those, in map_mem():

    __map_memblock(pgdp, kernel_start, kernel_end,
               PAGE_KERNEL, NO_CONT_MAPPINGS);

It is probably this call that needs to be changed to use
pgprot_tagged(PAGE_KERNEL).

- Kevin

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dd85e093ffdb..f084993024ab 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1049,7 +1049,7 @@ void __init mark_linear_text_alias_ro(void)
>  	 */
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
> -			    PAGE_KERNEL_RO);
> +			    pgprot_tagged(PAGE_KERNEL_RO));
>  }
>  
>  #ifdef CONFIG_KFENCE
