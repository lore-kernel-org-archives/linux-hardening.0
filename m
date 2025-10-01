Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC3277CB3;
	Wed,  1 Oct 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321344; cv=none; b=RaAnGCu2WPaislGFuTbctrjUFqQTixW1jZsBTf8bT4EjpWOrnPSViOxV/OoJ4/LM2aLDMjkRod+2e4H9xuJLznpEarb9CWMbZznhuWyasPMa20bYZWChkUSnUXYocoMfpMu8aAL3ikc3TW+X8fyPBwmDvuz9iRFuUKIsM76i6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321344; c=relaxed/simple;
	bh=aeXq1FtEKMEGcd1X6F5pimnL4GuLi9B4eChqnBDj3p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pM/b1ukIzBrUNaxHklX3/yWeQ6aopitDWNxodW7sIgiiDnsH3rs8Aan9WlxFI5iqxOj82z5O83KJTD/3DkhhNLSiaWnXgtT/BtBpg0guXnBO71SwJHsiRfzZQUs6HV1ltkVREYpOFmgNq6RSG5O1TqfYBUd5Yo3zhI2XqfgjaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67DA16F2;
	Wed,  1 Oct 2025 05:22:12 -0700 (PDT)
Received: from [10.57.66.40] (unknown [10.57.66.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC5B3F66E;
	Wed,  1 Oct 2025 05:22:14 -0700 (PDT)
Message-ID: <9e1b474e-b822-469a-990f-b27389a7f0e0@arm.com>
Date: Wed, 1 Oct 2025 14:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, linux-hardening@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
 <8f7b3f4e-bf56-4030-952f-962291e53ccc@arm.com>
 <aMwd7IJVECEy8mzf@willie-the-truck>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <aMwd7IJVECEy8mzf@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 16:57, Will Deacon wrote:
> On Thu, Sep 18, 2025 at 04:15:52PM +0200, Kevin Brodsky wrote:
>> [...]
>>
>> For now, my plan is to stick to solution 3 from [2], i.e. force the
>> linear map to be PTE-mapped. This is easily done on arm64 as it is the
>> default, and is required for rodata=full, unless [1] is applied and the
>> system supports BBML2_NOABORT. See [1] for the potential performance
>> improvements we'd be missing out on (~5% ballpark). I'm not quite sure
>> what the picture looks like on x86 - it may well be more significant as
>> Rick suggested.
> Just as a data point, but forcing the linear map down to 4k would likely
> prevent us from being able to enable this on Android. We've measured a
> considerable (double digit %) increase in CPU power consumption for some
> real-life camera workloads when mapping the linear map at 4k granularity
> thanks to the additional memory traffic from the PTW.

Good to know!

> At some point, KFENCE required 4k granularity for the linear map, but we
> fixed it. rodata=full requires 4k granularity, but there are patches to
> fix that too. So I think we should avoid making the same mistake from
> the start for this series.

Understood, makes sense. I'll be looking into implementing the custom
PTP allocator I suggested above then.

- Kevin
