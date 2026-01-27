Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46735EDDC;
	Tue, 27 Jan 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533171; cv=none; b=XMiGK97rYvE0jLE2FyMXt9n+MeKSk69H7QBrgCf4Yvu4etsLKsgBZCvKMFwsiO35JTRnseHb58GMlxYj4h6ffnxOuWLctGCmeJZSGDAzZ1cSZ9uEFPAoHdiKUtkypsH9m4y8B9eU7levuxjeZ0qbBw0vFvqPcx9xvirpTBPr+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533171; c=relaxed/simple;
	bh=j1tpzP4iXPz3dLxh/px30K7zYW7ZUU/yExkD9jkju/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdOF0r7a4KomCeFFR3weknbzvqZQU128m4cFpiJaUKefhwc+7QA3fHox8JC0JH4w0GdkJoxA1f7GT4kgKw8R+VVa91aikyAZKuombSD/24LumkUQwNdD31bh3wV5cMB6Ti2I3L1xxuArS+J9z5W0WfjMEb87LWbLFAVBc9QWD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F4F1596;
	Tue, 27 Jan 2026 08:59:22 -0800 (PST)
Received: from [10.1.37.210] (XHFQ2J9959.cambridge.arm.com [10.1.37.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00FCA3F632;
	Tue, 27 Jan 2026 08:59:26 -0800 (PST)
Message-ID: <da0b8783-590e-42a0-8937-f786a2ebcafa@arm.com>
Date: Tue, 27 Jan 2026 16:59:25 +0000
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
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-15-ardb+git@google.com>
 <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
 <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 15:03, Ard Biesheuvel wrote:
> On Tue, 27 Jan 2026 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Currently, pgattr_change_is_safe() is overly pedantic when it comes to
>>> descriptors with the contiguous hint attribute set, as it rejects
>>> assignments even if the old and the new value are the same.
>>>
>>> So relax the check to allow that.
>>
>> But why do we require the relaxation? Why are we re-writing a PTE in the first
>> place? Either the caller already knows it's the same in which case it can be
>> avoided, or it doesn't know in which case it is accidentally the same and couple
>> probably just as easily been accidentally different? So it's better to warn
>> regardless I would think?
>>
> 
> Based on rule RJQQTC in your reply to another patch in this series, my
> conclusion here is that we can drop this check entirely.

Hmm, I don't think that would be quite right; The rule permits _some_ bits of
the PTE to change in a live mapping as long as the CONT bit remains unchanged.
If you change the CONT bit on a live mapping, you could end up with overlapping
TLB entries which would not go well on a system without bbml2.

