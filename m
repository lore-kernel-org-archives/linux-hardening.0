Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A821CA02;
	Thu, 20 Mar 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469897; cv=none; b=MBtwm3ExA6Mm1FMNSGeqznXyScDvC7eWZfMNLr/cZWOXyXJwWinEoAYIJn8xOpl02vlGAxPb4qa2pyyWdUZEYrVWbeSfu678sa6k7zoISZjzONWGsMgjincw9CxXPaQzmWnU9jfT7q8GtGPWxSoS9ZQjRZGWDkicElDhZryNWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469897; c=relaxed/simple;
	bh=EqOgyWceMyeTT109wBhCjqL5G3XOhHfXDEIxz9Mj4DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1LDXyVTq7vTZpccub8QbHxGtI5+w5f0VPuCmiX/c1AItFP4XHwrqjoyh7tjQon+U9kO9fHLFpd/wUgcjqNWNC2fL13Q66B3fLrQ+yqw1XS0bmGGaj5kEnYz4dnjT6XRv+nArr3ju2wSpdouIZUtmQCtfUdHkEk1v0CNowu9gTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68371424;
	Thu, 20 Mar 2025 04:25:02 -0700 (PDT)
Received: from [10.57.84.158] (unknown [10.57.84.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238CF3F694;
	Thu, 20 Mar 2025 04:24:53 -0700 (PDT)
Message-ID: <2cb92aaf-900e-4a30-beeb-50081afc85ec@arm.com>
Date: Thu, 20 Mar 2025 11:24:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64/mm: Remove randomization of the linear map
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <kees@kernel.org>
References: <20250318134949.3194334-2-ardb+git@google.com>
 <CAMj1kXHXAYt0xLnx4=+qiCbnuF5U+9dzwnds1yd+vhTtpP5v3Q@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHXAYt0xLnx4=+qiCbnuF5U+9dzwnds1yd+vhTtpP5v3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2025 07:57, Ard Biesheuvel wrote:
> On Tue, 18 Mar 2025 at 14:50, Ard Biesheuvel <ardb+git@google.com> wrote:
>>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> Since commit
>>
>>   97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
>>
>> the decision whether or not to randomize the placement of the system's
>> DRAM inside the linear map is based on the capabilities of the CPU
>> rather than how much memory is present at boot time. This change was
>> necessary because memory hotplug may result in DRAM appearing in places
>> that are not covered by the linear region at all (and therefore
>> unusable) if the decision is solely based on the memory map at boot.
>>
>> In the Android GKI kernel, which requires support for memory hotplug,
>> and is built with a reduced virtual address space of only 39 bits wide,
>> randomization of the linear map never happens in practice as a result.
>> And even on arm64 kernels built with support for 48 bit virtual
>> addressing, the wider PArange of recent CPUs means that linear map
>> randomization is slowly becoming a feature that only works on systems
>> that will soon be obsolete.
>>
>> So let's just remove this feature. We can always bring it back in an
>> improved form if there is a real need for it.

The argument certainly makes sense to me.

>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Additional note based on an off-list discussion with Kees and the KSPP team:
> 
> Initially, the randomization of the linear map was considered to be a
> layer of defense against the abuse of writable linear aliases of
> read-only mappings in the vmalloc range, such as module text and
> rodata. 

I would have assumed that there is already a level of randomization for this use
case because vmalloc will be allocating random pages from the buddy, so the
location of a given vmalloc alias in the linear map is already somewhat random?

Perhaps the regions of interest are allocated early in boot when the pages the
buddy gives you are still pretty predictable? In this case could there be any
argument for adding a capability to the buddy to give out somewhat randomised
pages, at least during boot?

> This has been addressed in the meantime, by mapping the linear
> region down to pages by default, and mapping linear aliases read-only
> if the vmalloc mapping is read-only.
> 
> So considering that, and the fact that randomization of the linear map
> occurs rarely if at all on recent CPUs, I think we should go ahead and
> remove this feature.

