Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8537266D;
	Fri, 17 Apr 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431468; cv=none; b=jfW1ySlFLOnJxSqDnPjuJgBuLGGcC3FRJKBvihtELzbY+guL4LrEe1/I/pfJhFBVI8L8Sem8D4eqpbbxQwO9YNf6LGK8Of2obpiEF6/OkV0RcPz/qvEiewYMW5bONcA+WEIbzT8wdEqm2Vt6NjF/Xl5Q/FDgBedNFfEp7KcNS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431468; c=relaxed/simple;
	bh=UZ+9QdPmSTx/ezgB1oRSxcs6WFStfM5GyAzSgULBfK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViGuuV+BjpGYwZydUt3KfRw+VijEEX/P0UwPqslu3c4RbB6RaMTA3CN5F3VtX5NJg2AIzuFIM+VztF5C3nbzQqu0+jmpKtUh3OpPbGJNN+sR+AMvmKPCO/WDvZnNaQ9vK4VdFP8NbcWCehnRGLZv3/lC0CfpXHs6Rp0XTLZXNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nLP9+NmO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nLP9+NmO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1216A1C2B;
	Fri, 17 Apr 2026 06:10:59 -0700 (PDT)
Received: from [10.57.63.31] (unknown [10.57.63.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312443F7D8;
	Fri, 17 Apr 2026 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776431464; bh=UZ+9QdPmSTx/ezgB1oRSxcs6WFStfM5GyAzSgULBfK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nLP9+NmOP4Js5PxqLmjA9erzChDc1WNxHz0qocmuG+AsyaZz8t5QVQ1Lo5Rct4eL2
	 KPNqAe7G2utJg38/pHsrTnSjhvBlhhVTbSoisuYuAhC7ve0hNuyJOThpP/YByANyjN
	 MdbXC7wVzrfGBlCo2N0+cUxzbDtoHJT7TGqJbU94=
Message-ID: <5adc64e5-d4e3-42f1-8cf2-6e824bad2bf6@arm.com>
Date: Fri, 17 Apr 2026 15:10:52 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/30] mm: Introduce kpkeys
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
 <20260227175518.3728055-2-kevin.brodsky@arm.com>
 <eaca640b-5006-489b-8b2d-148a3c4073da@kernel.org>
 <fea9c939-f955-4020-bed6-427e592f0024@arm.com>
 <cf9da9e0-310b-4dc0-81aa-3154077fff85@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <cf9da9e0-310b-4dc0-81aa-3154077fff85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2026 14:00, David Hildenbrand (Arm) wrote:
> On 4/15/26 17:50, Kevin Brodsky wrote:
>> On 15/04/2026 15:00, David Hildenbrand (Arm) wrote:
>>> On 2/27/26 18:54, Kevin Brodsky wrote:
>>>> kpkeys is a simple framework to enable the use of protection keys
>>>> (pkeys) to harden the kernel itself. This patch introduces the basic
>>>> API in <linux/kpkeys.h>: a couple of functions to set and restore
>>>> the pkey register and macros to define guard objects.
>>>>
>>>> kpkeys introduces a new concept on top of pkeys: the kpkeys level.
>>>> Each level is associated to a set of permissions for the pkeys
>>>> managed by the kpkeys framework. kpkeys_set_level(lvl) sets those
>>>> permissions according to lvl, and returns the original pkey
>>>> register, to be later restored by kpkeys_restore_pkey_reg(). To
>>>> start with, only KPKEYS_LVL_DEFAULT is available, which is meant
>>>> to grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since
>>>> this is the only available pkey for now).
>>>>
>>>> Because each architecture implementing pkeys uses a different
>>>> representation for the pkey register, and may reserve certain pkeys
>>>> for specific uses, support for kpkeys must be explicitly indicated
>>>> by selecting ARCH_HAS_KPKEYS and defining the following functions in
>>>> <asm/kpkeys.h>, in addition to the macros provided in
>>>> <asm-generic/kpkeys.h>:
>>> I don't quite understand the reason for using levels. Levels sounds like
>>> it would all be in some ordered fashion, where higher levels have access
>>> to lower levels.
>> That was originally the idea indeed, but in practice I don't expect
>> levels to have a strict ordering, as it's not practical for composing
>> features.
>>
>>> Think of that as a key that can unlock all "lower" locks, not just a
>>> single lock.
>>>
>>> Then, the question is about the ordering once we introduce new
>>> keys/locks. With two, it obviously doesn't matter :)
>>>
>>> So naturally I wonder whether levels is really the right abstraction
>>> here, and why we are not simply using "distinct" keys, like
>>>
>>> KPKEY_DEFAULT
>>> KPKEY_PGTABLE
>>> KPKEY_SUPER_SECRET1
>>> KPKEY_SUPER_SECRET2
>>>
>>> Is it because you want KPKEY_PGTABLE also be able to write to KPKEY_DEFAULT?
>> Right, and in general a given level may be able to write to any number
>> of pkeys. That's why I don't want to conflate pkeys and levels. Agreed
>> that "level" might not be the clearest term though, since there's no
>> strict ordering.
> As discussed offline, maybe the right terminology to use here would be
> something like a "context".
>
> You'd be activating/setting a context.
>
> KPKEY_CTX_DEFAULT
> KPKEY_CTX_PGTABLE
> KPKEY_CTX_SUPER_SECRET1

Sounds good to me, that's more accurate than "level" if it is possible
to give access to arbitrary pkeys to each context, which is the current
assumption.

> What is accessible (and how) is defined for each context. For example, I
> would assume that all context allow for read/write access to everything
> that KPKEY_CTX_DEFAULT has access to.

Most contexts would, although as I mentioned in the previous email,
unprivileged contexts such as eBPF programs may be further restricted.

- Kevin
