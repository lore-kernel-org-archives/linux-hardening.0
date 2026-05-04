Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B6D34A3B1;
	Mon,  4 May 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884633; cv=none; b=kowkeFb93ST7IIPON3t/PLBJ2SXfCwcp9buujxdEqpFXq1MYeNXY+5bwpxCPWrlF6atcEbtamUlzM+T1L+VSZKpWFub7aTq+HVHd2vEU0E4wkseu0fkm0U00kca+bjzBG3FuB+3UMjrR6UrlVFj8vs2xlYV11CY7tLa+0PdhAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884633; c=relaxed/simple;
	bh=FCMkZ9hkweao0c59LeiVz688RdDZQ8lSc3hEZVLOErk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5ipeMDvsU+d8zWkEktEeC5pFqRkJ1SwSLwRTfYDeyYkpvEmS6KFfKMRLW6oU7974LNppV/bVJmFTvAF9cQO4PuwZAG/6gzI3MPbzc9J6PYhn/tgJGEuUAuNRV5poHYTlxTVeATVgY/XxhNSpxkyup+paqvsmCiZhYKsB4vbE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vugjd43c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vugjd43c"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A83531713;
	Mon,  4 May 2026 01:50:18 -0700 (PDT)
Received: from [10.57.34.72] (unknown [10.57.34.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6D133F763;
	Mon,  4 May 2026 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777884624; bh=FCMkZ9hkweao0c59LeiVz688RdDZQ8lSc3hEZVLOErk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vugjd43cPy1s2or/IKdw/90It0UtXRePbtH549/6cttjMFAgm9Gdw5rlF0k8TrWC0
	 6z8xwVelspAzl3e+lQ+ekhrPmZ5vMU0D9K2Wl9nCbaJCCexBDwY0/8LBrXBEpFJPOf
	 gEIFSygQ8vdYubxqMBnzuD3iSgcy8OysDOF8lTgQ=
Message-ID: <49eb450b-0045-4add-b993-a8b518514c34@arm.com>
Date: Mon, 4 May 2026 10:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] arm64: mm: Map the kernel data/bss read-only in
 the linear map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-29-ardb+git@google.com>
 <a8740f95-e167-48ae-ae65-97c6701d9c94@arm.com>
 <9ff1d19d-f3f8-4106-aeeb-66c4c21742b9@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <9ff1d19d-f3f8-4106-aeeb-66c4c21742b9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2026 16:46, Ard Biesheuvel wrote:
>>> @@ -1155,7 +1157,11 @@ static void __init map_mem(void)
>>>  	 * of the region accessible to subsystems such as hibernate,
>>>  	 * but protects it from inadvertent modification or execution.
>>>  	 */
>>> -	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
>>> +	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
>>> +		       flags);
>>> +
>>> +	/* Map the kernel data/bss so it can be remapped later */
>>> +	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
>> Maybe I'm missing something obvious, but considering patch 3/4 couldn't
>> we directly map the range RO here?
>>
> After 3/4, __map_memblock() will no longer combine new mappings with existing
> ones into block mappings or contiguous ranges. However, it will still set the
> requested type and permission attributes on the entire range, and so the second
> invocation is needed to restore the read-only bit.
>
> IOW, we could also map it read-only twice, the result would be the same, but the
> second call is still needed.

Got it, thanks.

- Kevin
