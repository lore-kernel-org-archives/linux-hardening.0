Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEAC2EC0A4;
	Tue, 28 Apr 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385814; cv=none; b=mj5fKL3KJu+1tVP7kHK0n3X0r2O11SiTfxEfM5TFfAE78xrDBdqs1VJbsfYHH44Fiw0i6HBzbbzTU/Zs8ruwO8FJO2tS3v1DG/aHd8rXykE+AiH0ipIejh8LSAyw6BA1CxNNe0hPp5otHXaRqeZ9GcdY5KWY7OEKiqvX6SlsIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385814; c=relaxed/simple;
	bh=oVrjIdlZ5Ebhd/IWkU1FIsmJ7nMiw5cvbtJC65flWy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emSc+QP06RtvREhVsAd4sZjR6k3c4vyJ5F+5LDfaySbNqxtrOM4leHOftdzRjc0u+penEpJ3IaAGvMrBVjABZjq4MI9MvkbUFyvB0mWnHzK3zJer8hDsXeDf6KhStz9cR4zyPNGaS0I83SOrdLW0bHFBrxC0/EwbnTNUwTALEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N9PsyVWZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N9PsyVWZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B03D15A1;
	Tue, 28 Apr 2026 07:16:47 -0700 (PDT)
Received: from [10.57.63.26] (unknown [10.57.63.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3763F763;
	Tue, 28 Apr 2026 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777385812; bh=oVrjIdlZ5Ebhd/IWkU1FIsmJ7nMiw5cvbtJC65flWy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9PsyVWZb9ZJ4M1SqH3xQYLnoSiZIX8Z3lJsZWaSwJBJW9JuJqRJAqdYLmCJDIOoE
	 +6rp3bcWLVPNuxuJnN1AV3qfoMKZVRHdgluQweWZSdfqaUSNbDYhKI/zxfpTj6tJ8j
	 FWC1eGlcCi1Fw2SoBRVyxLOvdlknS60k/xbkGuLA=
Message-ID: <802ca264-a849-4c66-a27c-db6fa9915711@arm.com>
Date: Tue, 28 Apr 2026 16:16:46 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
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
 <20260427153416.2103979-19-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-19-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The empty zero page is used to back any kernel or user space mapping
> that is supposed to remain cleared, and so the page itself is never
> supposed to be modified.
>
> So make it __ro_after_init rather than __page_aligned_bss: on most
> architectures, this ensures that both the kernel's mapping of it and any
> aliases that are accessible via the kernel direct (linear) map are
> mapped read-only, and cannot be used (inadvertently or maliciously) to
> corrupt the contents of the zero page.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..6ca01ed2a5a4 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
>  EXPORT_SYMBOL(zero_page_pfn);
>  
>  #ifndef __HAVE_COLOR_ZERO_PAGE
> -uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
> +uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  struct page *__zero_page __ro_after_init;
