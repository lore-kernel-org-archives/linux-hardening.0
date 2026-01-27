Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAF2E6CC8;
	Tue, 27 Jan 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508391; cv=none; b=u4vOICZRYfdQwDhZOQzuK01/tzT9bAmxGYmCT/hKQqm/d2iWej6Vt2z2ysfeS8PeC/cVZAuVQmll6KyUyDYJMCRmCZPzW13+nZKotp+ioSx6j2/a5zZPb11wEMJZ9eV7CyweSrncA8SWlkK1Pa4crCsIWYmH3QQemGdHkjUmuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508391; c=relaxed/simple;
	bh=aCVAaVtir6jl31KehHmpucip5WC6Evmgt3IJ3QPaXZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2RSvWGBCIPk/JWBwUh7rnw1MtD/oUwPJYIFjhC7eYM4y7pjbiUqSS4cAxRsGt1rCBn4evtRWnZs6ltFwukONSvSkro0wAAK+J8LHjjYT0qFVIxcBdTYTD3zgcJNdYZ7SnmEXvs8sBorW6SOdk6ChI9woS0paYuVWbbGCkU3a/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF801595;
	Tue, 27 Jan 2026 02:06:22 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB193F73F;
	Tue, 27 Jan 2026 02:06:26 -0800 (PST)
Message-ID: <005012a8-bfcc-4049-9ff2-adecf3a89c53@arm.com>
Date: Tue, 27 Jan 2026 10:06:25 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] arm64: mm: Remove bogus stop condition from
 map_mem() loop
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-18-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-18-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The memblock API guarantees that start is not greater than or equal to
> end, so there is no need to test it. And if were, it is doubtful that
> breaking out of the loop would be a reasonable course of action here
> (rather than attempting to map the remaining regions)
> 
> So let's drop this check.

If start were greater than end, I think it's a pretty safe bet that
__map_memblock() would do something horrible.

But if memblock makes the guarantee you claim I agree it's preferable to
declutter the code:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d7faa98f427c..377bdc4d84a1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1158,8 +1158,6 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> -		if (start >= end)
> -			break;
>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as

