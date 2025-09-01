Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B6272E41;
	Mon,  1 Sep 2025 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712416; cv=none; b=ujWLgsyYhHgXEQ1p7xRI7hBF5jSaA8bhtGBDtxaVn5Td/u8Jg3C7izDJHBbayWdQNERLLNYO2ZeG4zX9/Do6xOKEH6DUq2hbPnP7C5jg6Q5hkHiZMjnzO3OIUgqVmRxp29R8TuLX/reIKaSRQE5DTIGYmRBjMXUwxaq6md583f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712416; c=relaxed/simple;
	bh=YIjKxzEPWY2SYGWXUttLCwx6grvtC94JIZYrLh5T5H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE9J/LAXOi2SgNXRWYb9IK5vzXUN1TkYGqoKxikHzyWn7RkIMcAfqPyQmf/6RNz8VH+mnisLBtj+PcAWXQZaKmmj5zNSHdNceXMKR6DA7DTD/UG0gIR5xIYGHTg8IfUX5M1NHd6ZruCChPai+KZv3nEGiSQ/kKEBlzuUTN2xw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC7B1A25;
	Mon,  1 Sep 2025 00:40:06 -0700 (PDT)
Received: from [10.57.57.17] (unknown [10.57.57.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195E83F63F;
	Mon,  1 Sep 2025 00:40:08 -0700 (PDT)
Message-ID: <3f6e36f1-c942-40d6-8a46-63f3ba0d0d84@arm.com>
Date: Mon, 1 Sep 2025 09:40:06 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
 function signature
To: David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Yue Haibing <yuehaibing@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, James Morse <james.morse@arm.com>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250829190721.it.373-kees@kernel.org>
 <c13af2e9-a0ac-4e1d-be8e-4612ae8d9c0f@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <c13af2e9-a0ac-4e1d-be8e-4612ae8d9c0f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/08/2025 21:13, David Hildenbrand wrote:
>> [...]
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 6e8aa8e72601..49f1a810df16 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -17,6 +17,13 @@
>>   #include <linux/refcount.h>
>>   #include <asm/cpufeature.h>
>>   +enum pgtable_type {
>> +    TABLE_PTE, m68k_table_types
>> +    TABLE_PMD,
>> +    TABLE_PUD,
>> +    TABLE_P4D,
>> +};
>
> Just noting that we now have "enum pgtable_level" in
> include/linux/pgtable.h that could at some point possibly be used here
> instead (not in this fix). 

Thanks for the heads-up! I'll look into using the new generic enum
instead, there's really no need for every architecture to invent its
own. m68k could also use it instead of m68k_table_types.

- Kevin
