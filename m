Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9E30C616;
	Tue, 27 Jan 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535464; cv=none; b=T0I4dRjPE/jdNCNKEs/u6KWJvb0aVApNZG7avTEEEhcIbv3TPlMwSlu9o5qc/NodKSLYBocKkN+1srp98AUdH/7GawP/ZiJo08JqX1QVpqTiYNKw8MhDtt6TjYxhqeUt5WHXWHp3QPNk3RqVaILTbkPqA65DeD8H5jTYwu+EmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535464; c=relaxed/simple;
	bh=Ox6Z4a6uZnVLgOafz5vTjhuSqMOQ+SJY2IaSbQhGswQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0DPiySxRVTdqreujeUgEFqsqxbII1ru5zsVo2RLrgeiSusdyW1kKOCMXnuvJFlmnn+T/8W/RV6VDwX1pM0CowVuREGagmk6uF0eAfhOUpL1MHd6RFAsBArjgS+vDPKGc0F9XVi6Ayzodxcc2US0/bi+ZADhMnNfsvbO8qMIYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB58E1515;
	Tue, 27 Jan 2026 09:37:34 -0800 (PST)
Received: from [10.1.37.210] (XHFQ2J9959.cambridge.arm.com [10.1.37.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9ECB3F632;
	Tue, 27 Jan 2026 09:37:39 -0800 (PST)
Message-ID: <6dbafb58-599f-448e-a17d-daaf4c9438f2@arm.com>
Date: Tue, 27 Jan 2026 17:37:38 +0000
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-15-ardb+git@google.com>
 <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
 <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
 <da0b8783-590e-42a0-8937-f786a2ebcafa@arm.com>
 <eff29cc6-29e6-4eda-8b44-aef30095252c@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <eff29cc6-29e6-4eda-8b44-aef30095252c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 17:02, Ard Biesheuvel wrote:
> 
> 
> On Tue, 27 Jan 2026, at 17:59, Ryan Roberts wrote:
>> On 27/01/2026 15:03, Ard Biesheuvel wrote:
>>> On Tue, 27 Jan 2026 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>> Currently, pgattr_change_is_safe() is overly pedantic when it comes to
>>>>> descriptors with the contiguous hint attribute set, as it rejects
>>>>> assignments even if the old and the new value are the same.
>>>>>
>>>>> So relax the check to allow that.
>>>>
>>>> But why do we require the relaxation? Why are we re-writing a PTE in the first
>>>> place? Either the caller already knows it's the same in which case it can be
>>>> avoided, or it doesn't know in which case it is accidentally the same and couple
>>>> probably just as easily been accidentally different? So it's better to warn
>>>> regardless I would think?
>>>>
>>>
>>> Based on rule RJQQTC in your reply to another patch in this series, my
>>> conclusion here is that we can drop this check entirely.
>>
>> Hmm, I don't think that would be quite right; The rule permits _some_ bits of
>> the PTE to change in a live mapping as long as the CONT bit remains unchanged.
>> If you change the CONT bit on a live mapping, you could end up with overlapping
>> TLB entries which would not go well on a system without bbml2.
> 
> I'm not suggesting we add it to 'mask', just to remove the check that forbids any manipulation of an entry that has PTE_CONT set. So toggling PTE_CONT itself would still be caught by the check.

Ahh, sorry, wasn't looking at the whole function. Yes,I agree that makes sense then.

Now that I'm looking at the function, I find it odd that PTE_UXN and PTE_USER
are not included in the mask. These bits are used (along with PTE_PXN and
PTE_WRITE, which are in the mask) to form the PI index, when PI is enabled.
Seems odd that we can change some bits of the index but not others... But that
is probably for another day.
