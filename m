Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569037A4B9;
	Wed, 29 Apr 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471059; cv=none; b=ZMbIDc6zkMpacPnzvtNAi2MZM1dc9kNO68Fe82RW707ZpZj9lKSempl9nWSMNXdJdHkJ9NQqGkyR6UnRHW9xRPSu1a/BFv2apUEzl78sj+58SdP4nSEAZPmpbwcd/h/rIwxcs6HFtw/o8ko9e4GjTq3Qk7jpGmVLPGonO2Us4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471059; c=relaxed/simple;
	bh=51AOjeUHqGDov+TlvZ961wTG4/ToLBw1MVjjZ/EnINw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAV6KFD9nl2KOZGXWJgI5kHihymi/2bR7anZtM1USWkjulGm+qZR041q2rN3JtyLemSB3LkLXMQrdwM9Wx5vWP5/U3qOeLKJAA7y0vqv4E7sMr+0Ve54Fh6uFbDpFoMYRgtmcDAQb1WSdA9Qw0wtAjYia3KChqRZo99OI6bmJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VZYMMPru; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VZYMMPru"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB45337B;
	Wed, 29 Apr 2026 06:57:30 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54813F62B;
	Wed, 29 Apr 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777471056; bh=51AOjeUHqGDov+TlvZ961wTG4/ToLBw1MVjjZ/EnINw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VZYMMPruwp21m0Xl4JeKfECbeTob5+cc9VVBwFqewef4YFQpd9Inm1HT5mWQ5/6XG
	 ItElSh4Ig+yLgjTKWv4g3SNaz5OOVx2Ve3sKphhXFiZ/dF5OXmmvFug+NBjU9oGbIA
	 5KSpb9He9n9hVC8WDP9z/KmEA1lJ8qPdpTJ9HzCk=
Message-ID: <21a547ae-7121-4cd1-b203-4d8182eb7cc9@arm.com>
Date: Wed, 29 Apr 2026 15:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] arm64: mm: Remap linear aliases of the fixmap
 page tables read-only
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
 <20260427153416.2103979-32-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-32-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> [...]
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 84d81bae07a7..e76fe5b0c5fe 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1076,6 +1076,11 @@ void __init mark_linear_text_alias_ro(void)
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    pgprot_tagged(PAGE_KERNEL_RO));
>  
> +	/* Map the fixmap PTE table at __fixmap_pgdir_start R/O in linear map too */
> +	update_mapping_prot(__pa_symbol(__fixmap_pgdir_start),
> +			    (unsigned long)lm_alias(__fixmap_pgdir_start),
> +			    PAGE_SIZE, pgprot_tagged(PAGE_KERNEL_RO));

Is that definitely just one page?

> +
>  	remap_linear_data_alias(true);
>  
>  	if (IS_ENABLED(CONFIG_HIBERNATION)) {
