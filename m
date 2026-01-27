Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69127F736;
	Tue, 27 Jan 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507158; cv=none; b=Jq/of2t6+fn3JVKJPwIqdzYCXBwyUkLE9z56m8q2hROZCOwocnCpovpV6UN1sq9OQSH0zOXCL2EPIikXD/iudVxEf8YbOXrZfXlyrWgqRGD8vmnqoH4XjV1ASYadQV9PghqRsDxfzquQHz5byAqQpjP8lSrIguFmGP97jPAM7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507158; c=relaxed/simple;
	bh=//lhyNZ5BDjB9XBSK+GrUucTMgfunQ4RqrVjA14x0o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwAW23uticYQeXDpKxpiDQ6YXaTWClmCX/vYGAai4k9iMqz8GA5lyFmkcQWemFD7eC1MJesg9Kp89UAfOk7in0Nym1nvkSiGrQb4AUDzrPdsewAPUHRWLXC/N5ZU+hmZzffJXV95h/tZAsenrA5TMV0Ww8FkNla1wiz76aQON1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71EA51595;
	Tue, 27 Jan 2026 01:45:49 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 283343F632;
	Tue, 27 Jan 2026 01:45:54 -0800 (PST)
Message-ID: <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
Date: Tue, 27 Jan 2026 09:45:52 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] arm64: mm: Permit contiguous descriptors to be
 rewritten
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-15-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-15-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Currently, pgattr_change_is_safe() is overly pedantic when it comes to
> descriptors with the contiguous hint attribute set, as it rejects
> assignments even if the old and the new value are the same.
> 
> So relax the check to allow that.

But why do we require the relaxation? Why are we re-writing a PTE in the first
place? Either the caller already knows it's the same in which case it can be
avoided, or it doesn't know in which case it is accidentally the same and couple
probably just as easily been accidentally different? So it's better to warn
regardless I would think?

I'm sure I'll get to the patch where this matters and change my mind :)

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c36422a3fae2..9d39de3cfe67 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -141,7 +141,7 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
>  		return false;
>  
>  	/* live contiguous mappings may not be manipulated at all */
> -	if ((old | new) & PTE_CONT)
> +	if ((old | new) & PTE_CONT && old != new)
>  		return false;
>  
>  	/* Transitioning from Non-Global to Global is unsafe */

