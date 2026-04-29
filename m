Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B9351C20;
	Wed, 29 Apr 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471030; cv=none; b=UeWVWHoqvi6E+5qcjUMuQ3OwGgHSXCOMmegC7T0Tyr8IfzPcf6/GWmrPKkT5wAzwdscz6eTf+SHHYann4KrkTDnDWFlY1yCQCG5zz/YEVJsQ1qu3tXjcM0L11ziwRu5chvU9e1e4ggr+Q68GC4WOKVjg7oXPJpiYLV3EOgVLj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471030; c=relaxed/simple;
	bh=uCnIw3CR1viWizfBhTu1oz/vcz1koGemFdz8oEqehX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG+Jj6IO2knSTflBbVpM/lp1xBohBAVMtoeiycKH0dmb86m8TTBe+0G3RmTdySSp2Ou8V+KrRBN7RW221toEA9MkrvUIt+LPl1XhGyiX1U5rdgctsKzz/rTGl8RIlIvvxlIUR1wO/5KlPtyMzeJ8+SBjIcl0OZdaEdkAiZ/m9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tKo7qpcU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tKo7qpcU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E251650;
	Wed, 29 Apr 2026 06:57:01 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D89E3F62B;
	Wed, 29 Apr 2026 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777471027; bh=uCnIw3CR1viWizfBhTu1oz/vcz1koGemFdz8oEqehX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tKo7qpcUs76IDv6e5R8HeijntK+tVAsQf3L1gGheC7KBuQnvLjzEHiTDybDxbZD8Z
	 PtAB4aUFl6moEHsC3wTckysjYxLPrEqXAKhGTICBGzpyQ8QAG/d2fCSGec37wtX7SN
	 2lIFCIl0BQq9yN+RECGiSkBoDunVzSNSdbxs6Lhk=
Message-ID: <961e9d06-1520-4176-ad76-3f0d8d5ab146@arm.com>
Date: Wed, 29 Apr 2026 15:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] arm64: mm: Generalize manipulation code of
 read-only descriptors
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
 <20260427153416.2103979-31-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-31-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> [...]
>
> -void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> +void noinstr set_rodata_pte(pte_t *ptep, pte_t pte)
>  {
> -	pgd_t *fixmap_pgdp;
> +	pte_t *fixmap_ptep;
>  
>  	/*
> -	 * Don't bother with the fixmap if swapper_pg_dir is still mapped
> -	 * writable in the kernel mapping.
> +	 * Don't bother with the fixmap if rodata is still mapped
> +	 * writable in the kernel and linear mappings.
>  	 */
>  	if (rodata_is_rw) {
> -		WRITE_ONCE(*pgdp, pgd);
> +		WRITE_ONCE(*ptep, pte);
>  		dsb(ishst);
>  		isb();
>  		return;
>  	}
>  
> -	spin_lock(&swapper_pgdir_lock);
> -	fixmap_pgdp = pgd_set_fixmap(__pa_symbol(pgdp));
> -	WRITE_ONCE(*fixmap_pgdp, pgd);
> +	spin_lock(&rodata_pgdir_lock);
> +	fixmap_ptep = pte_set_fixmap(__pa_nodebug(ptep));

I don't know much about the fixmap but it strikes me as odd that we
would now use pte_set_fixmap() at all levels. I suppose the question is
whether swapper_pg_dir could be written concurrently with fixmap page
tables at PMD level or above? I'm also wondering if those fixmap page
tables are ever written to.

- Kevin

> +	WRITE_ONCE(*fixmap_ptep, pte);
>  	/*
>  	 * We need dsb(ishst) here to ensure the page-table-walker sees
>  	 * our new entry before set_p?d() returns. The fixmap's
>  	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
>  	 */
> -	pgd_clear_fixmap();
> -	spin_unlock(&swapper_pgdir_lock);
> +	pte_clear_fixmap();
> +	spin_unlock(&rodata_pgdir_lock);
>  }
>
> [...]
