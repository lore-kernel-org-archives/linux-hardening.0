Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F58E233696;
	Wed, 11 Dec 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924139; cv=none; b=eq88g8JmsYV5YfpN0Y33fK2ze7QvxEP3mnhnYIPE8bT05efXR3dNDHLuqWbqvPZRdsaWzFvfIPVXIer3xJzcP2AL8uL5iEJu9m6uZd7xxrNo0H6gcbS2/PPV+8++AJo89IvB5gb1nf+rEfdoJTflyaEdCm4z7UC4VBg7Yb/Uc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924139; c=relaxed/simple;
	bh=iFHlJce+tj0dKx9Nr0h2tu85fnxZTCB9b2AakTaYe38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB4BuL5xljoO+u/uEPEm7JVf2M2ym/fuDgeuihevSZi2Pc05zi3GRbq1TQXL/3NfiKgZ5eaSbO+HpBEDG54NHWphbG4pPaDHdyk2UO4emjZCffmU3NL9RnrhIyvz329eoUVqwdTFfQZ0F5GsUv5xv3qTXVpWhamz4cTiVXOoEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557CC1063;
	Wed, 11 Dec 2024 05:36:04 -0800 (PST)
Received: from [10.57.70.51] (unknown [10.57.70.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0238C3F720;
	Wed, 11 Dec 2024 05:35:31 -0800 (PST)
Message-ID: <8aedf3db-d1a5-4cc6-974b-a3d9fffe4f52@arm.com>
Date: Wed, 11 Dec 2024 14:35:28 +0100
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
 <75a345d4-78ea-4434-a4cd-3f2095ce2b31@arm.com>
 <20241210122355.GN8562@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241210122355.GN8562@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2024 13:23, Peter Zijlstra wrote:
> On Tue, Dec 10, 2024 at 10:27:56AM +0100, Kevin Brodsky wrote:
>> On 09/12/2024 11:24, Peter Zijlstra wrote:
>>> On Fri, Dec 06, 2024 at 10:11:06AM +0000, Kevin Brodsky wrote:
>>>> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map p4d/pgd pages
>>>> using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that they can
>>>> only be written under guard(kpkeys_hardened_pgtables).
>>>>
>>>> The case where pgd is not page-sized is not currently handled -
>>>> this is pending support for pkeys in kmem_cache.
>>>>
>>>> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
>>>> (default).
>>> Should not this live in pagetable_*_[cd]tor() in generic code?
>> This would certainly be preferable but it doesn't look like such helpers
>> exist for p4d/pgd. For p4d, we could potentially handle this in the
>> generic __p4d_alloc(), but I'm not sure we can assume that
>> p4d_alloc_one() won't be called from somewhere else. pgd_alloc() is
>> entirely arch-specific so not much we can do there.
> Can't we add the missing pagetable_{p4d,pgd}_[cd]tor() functions. Yes,
> it will mean touching a bunch of arch code, but it shouldn't be hard.

It does look doable. The p4d level shouldn't be an issue, it's unclear
why it doesn't follow the same pattern as pud already. pgd will be more
involved (no generic layer at all) but as you say it should just be
about some churn in arch code.

An extra complication is that the pgd level may be smaller than a page,
at least on arm64 (see pgd_alloc() in arch/arm64/mm/pgd.c). I suppose
affected architectures will have to define their own pgd_alloc_one().

I'll give it a try and post something separately if it looks sensible.

- Kevin
