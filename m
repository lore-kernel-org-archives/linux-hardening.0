Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C222F1FF4
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834079; cv=none; b=GIAeUW7PNMr7TYCNF2QaaG8lUAJFGbUsVUZj/2+HCNKcauKtET1KEdJ7eMTHjjgfjC9IMS6l6SECXD2dhpRYP85B+iHwwuR2+Qxqq+dhoQkIJ8ehJPygUoE8LkcrPY28mb6P4GPFZ+oYDdeqAgfLIZBdkDqurauB2F6URohCafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834079; c=relaxed/simple;
	bh=aceFjlRhhVLZ90elGDabHBPqZJUEfYBPbWijqEROSyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnWPmx8GfEUzqz8kEFI745NjwFUCrRbttWKZTX7qKyLTSzWVVkm/I6fwOIsjbJy1eabHAv//MIuQ9BeCulS0nOAccGwv6KJQPQYccUvZZkuC+YRDCAsYxvVmCsR/GXE0NE20svcsIyEuWWUeoVmtRtP2el94VO8NqyLFCS2QMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dbZVvGlP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dbZVvGlP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42311169E;
	Thu, 27 Aug 2026 05:34:33 -0700 (PDT)
Received: from [10.43.16.29] (e126510-lin.lund.arm.com [10.43.16.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A1A3F85F;
	Thu, 27 Aug 2026 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787834077; bh=aceFjlRhhVLZ90elGDabHBPqZJUEfYBPbWijqEROSyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dbZVvGlPRVGbMOS9gpMYjRRCIrdm/QR6t04nNlV0cgrjLxA3CJUJiRs58GGu8Mq8c
	 0YtvNrcJKGCOaIxn+JC43gVTyluTOGINgGl4oSHWKXmwNzKvd8GUBnu95X8PRRAOBp
	 v3EndSvhaD48jivJgnVBYGGyqnGbxVAStJx05gUA=
Message-ID: <e4e7b0d3-e982-4c42-8907-fcb04c7ac83c@arm.com>
Date: Thu, 27 Aug 2026 14:34:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: mm: Map fixmap PTE tables r/o in the linear
 map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 linux-hardening@vger.kernel.org
References: <20260805104042.1107678-2-ardb+git@google.com>
 <5a3b89a6-bc42-42c3-82e8-25d6f1a2c5d2@arm.com>
 <a277a83a-cc01-443d-be42-775ce0bc96dd@app.fastmail.com>
 <c33d081b-7886-4db2-b1d9-61dc195844e5@arm.com>
 <1c0299ab-9f5f-4c7b-826e-a0547f7863dd@app.fastmail.com>
 <aacacc48-4e20-423f-b1cd-d8593485bf9d@arm.com>
 <00b4326d-af1c-429d-9495-c65ed5ce184f@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <00b4326d-af1c-429d-9495-c65ed5ce184f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 12:16, Ard Biesheuvel wrote:
>>> I'm currently experimenting with using __put_kernel_nofault() to update
>>> the descriptors at all levels (including PTE) and handling the fault
>>> using the fixmap approach. That way, all statically allocated page
>>> tables could move to .rodata (except bm_pte[]) and there should be no
>>> substantial performance impact.
>> Doesn't that still mean modifying a fixmap PTE every time we update
>> kernel page tables? That doesn't exactly sound cheap.
>>
> Only the ones that were allocated statically, which cover the region
> around the kernel image, and the special cases (fixmap, kasan). Everything
> else is allocated dynamically, using memblock_alloc() if very early
> during the boot.

Ah yes I see! Then it does sound very reasonable, those page tables
should rarely be written if at all. For kpkeys that would mean we would
just need to map bm_pte with the special pkey to complete the
protection, the rest being already RO or pkey-protected.

- Kevin
