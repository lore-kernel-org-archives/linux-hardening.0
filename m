Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909661A9FB7;
	Tue, 28 Apr 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386803; cv=none; b=DOlO23byEul0/qsuaRFxiCEcOQextMg8JTd4WhX72N00OHjXhBZD3ng9HD68YKUz5ocup3Ty6yQEsQlzxEgZPpvmfpyIdtNjDGcvtQP63I6omKCi5Xfkuy5EyOEQN5pDhQRevgj5sHca4DQMs8HF/AH0eIQnM46suWhBtq5yFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386803; c=relaxed/simple;
	bh=JDB0ysfCc3O+HZNjVWKQweokOG4BHmdvpSRYZ50uqik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMRBs0W7rUeRrQMX1lJ3Ln43lnYF2vwAkTXCdeDpj7yMjExg61qDSOmVsmre4V5BGYKVUr7Gg8nvjB46+a39+e0/5P0Wuf3CNXRih9u9viYfyafMm7uF2DEpwc8YQ15loWsBzbUKT6EnBQ6mlMN/Fjmij/uZaEC/ryA0Dz2Su9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FbU42jRe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FbU42jRe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5107D1C2B;
	Tue, 28 Apr 2026 07:33:15 -0700 (PDT)
Received: from [10.57.63.26] (unknown [10.57.63.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F283F763;
	Tue, 28 Apr 2026 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777386800; bh=JDB0ysfCc3O+HZNjVWKQweokOG4BHmdvpSRYZ50uqik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FbU42jReibYsWd6NKeLPLPky/aF1mB/E/5caW6uLbtydQSXInHIvalDj+UTrucmln
	 IVac9HVMny8XP6YKuQG1qxX4EIUfT4ejmLXHbaPXPbN+XCqX2KeCsSs/4yxZDqGWlA
	 F3yTplVvLLv/4Zfv7lahY9A4k269KL0yro8NgtDo=
Message-ID: <e6bf70de-5d3e-412c-8585-677706a6dce9@arm.com>
Date: Tue, 28 Apr 2026 16:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
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
 <20260427153416.2103979-22-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-22-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The memblock API guarantees that start is not greater than or equal to
> end, so there is no need to test it. And if it were, it is doubtful that
> breaking out of the loop would be a reasonable course of action here
> (rather than attempting to map the remaining regions)
>
> So let's drop this check.
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 005844e521bd..bfbf3fe0d1be 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1177,8 +1177,6 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> -		if (start >= end)
> -			break;
>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as
