Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED122CBE5;
	Tue, 10 Dec 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822888; cv=none; b=tLiJehCgv2L5yy/utwpHd1a8e0Uvl9YBJniSTPJsjzeLLsnfznQlUkpCXFk70oq6iMfWzC8hXWN0t8K+PzlJyPU8bxJf8VBDmPUQ/AnjuuaszPOsKcWuhb+l5tmugFBQj0mDFlIsEZAZ+z64nHLaSVS3rNw38E+I58bkpOJiFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822888; c=relaxed/simple;
	bh=Nz9k9rGo2D0/lXq/+ouFIhcZyVjeXWbcNdo9F1ICcB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zh42458XKQHb2o/GzF7Bp98lPoN/Gf/IjUIv6thwPiry77AINAAl/zkWkL5pXvHvDu5JmmzhRaTXbJQtEkC1WU2F2tfoGRO89Dm5X3BcdcNfUx7J4KlTcco3n7wLjon+HKMDg31cCv+2GIO6g727QlVO3Yq6EU1NiaOU3JhG248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7082A113E;
	Tue, 10 Dec 2024 01:28:33 -0800 (PST)
Received: from [10.57.69.139] (unknown [10.57.69.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C5B73F58B;
	Tue, 10 Dec 2024 01:28:00 -0800 (PST)
Message-ID: <75a345d4-78ea-4434-a4cd-3f2095ce2b31@arm.com>
Date: Tue, 10 Dec 2024 10:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/16] arm64: mm: Map p4d/pgd with privileged pkey
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, jannh@google.com, jeffxu@chromium.org,
 joey.gouly@arm.com, kees@kernel.org, maz@kernel.org,
 pierre.langlois@arm.com, qperret@google.com, ryan.roberts@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-13-kevin.brodsky@arm.com>
 <20241209102440.GI21636@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241209102440.GI21636@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 11:24, Peter Zijlstra wrote:
> On Fri, Dec 06, 2024 at 10:11:06AM +0000, Kevin Brodsky wrote:
>> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map p4d/pgd pages
>> using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that they can
>> only be written under guard(kpkeys_hardened_pgtables).
>>
>> The case where pgd is not page-sized is not currently handled -
>> this is pending support for pkeys in kmem_cache.
>>
>> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
>> (default).
> Should not this live in pagetable_*_[cd]tor() in generic code?

This would certainly be preferable but it doesn't look like such helpers
exist for p4d/pgd. For p4d, we could potentially handle this in the
generic __p4d_alloc(), but I'm not sure we can assume that
p4d_alloc_one() won't be called from somewhere else. pgd_alloc() is
entirely arch-specific so not much we can do there.

- Kevin
