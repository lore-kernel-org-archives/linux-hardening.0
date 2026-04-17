Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594062857CC;
	Fri, 17 Apr 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441577; cv=none; b=P8Nr+qFHzrJ7tI1eFBNR+KqiZ6HTMXmGhJhnj0bxzWYL73guCL2VxbtEKckkr/Gsqv53iBgnWbQzlQzA8FJy1VhwMbjG8+rARliuw/lFTmk+QgDgSFcFTeV2pBsMZ4t6DnSr8zOm4LSYUwgkw+Mt8KBc624lfxa4IpFr2OE66e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441577; c=relaxed/simple;
	bh=j8FO8PzF0PieyWhQwCeTDRN7VIBMniarhO6pmXOcNmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLHuypQ0WVH7M/yolfS8ymRfBJINH/fKdGQW59jMyBVot1MyF9zyTd1VI48bWuEG3cLHyhre0I3VunXFToDIuvEfqU9yz1WA0Y0mso2zpX0eIf3oHkNu8l+TuJp3fGk5xxg9rM535to0M07E1dlvOrc2Y0/6YITpVD0kcdR/CDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dKqzTM+j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dKqzTM+j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B11D1DB5;
	Fri, 17 Apr 2026 08:59:30 -0700 (PDT)
Received: from [10.57.63.31] (unknown [10.57.63.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338A23F7D8;
	Fri, 17 Apr 2026 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776441575; bh=j8FO8PzF0PieyWhQwCeTDRN7VIBMniarhO6pmXOcNmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKqzTM+j4F58kIlpCMfJfslXRAvTIV63Jvs8XKtFPmTHYNKP2Hv8L1yPWqACikmRb
	 b+TajA/SlxbTw4g2mMiYjf5eL8R/K3voQJzpqhOA7XvIo434idPxeQ4QAJe9tq+kr2
	 S45xgvtee1/IiZZgthWVd5FLYan71Tu1mwyJ2OjU=
Message-ID: <913002a5-e002-4001-ad19-037102d1f97d@arm.com>
Date: Fri, 17 Apr 2026 17:59:26 +0200
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
 <00b24db8-0063-48d6-8bc4-e8b670d8f0d5@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <00b24db8-0063-48d6-8bc4-e8b670d8f0d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2026 16:37, David Hildenbrand (Arm) wrote:
> On 2/27/26 18:54, Kevin Brodsky wrote:
>> kpkeys is a simple framework to enable the use of protection keys
>> (pkeys) to harden the kernel itself. This patch introduces the basic
>> API in <linux/kpkeys.h>: a couple of functions to set and restore
>> the pkey register and macros to define guard objects.
>>
>> kpkeys introduces a new concept on top of pkeys: the kpkeys level.
>> Each level is associated to a set of permissions for the pkeys
>> managed by the kpkeys framework. kpkeys_set_level(lvl) sets those
>> permissions according to lvl, and returns the original pkey
>> register, to be later restored by kpkeys_restore_pkey_reg(). To
>> start with, only KPKEYS_LVL_DEFAULT is available, which is meant
>> to grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since
>> this is the only available pkey for now).
>>
>> Because each architecture implementing pkeys uses a different
>> representation for the pkey register, and may reserve certain pkeys
>> for specific uses, support for kpkeys must be explicitly indicated
>> by selecting ARCH_HAS_KPKEYS and defining the following functions in
>> <asm/kpkeys.h>, in addition to the macros provided in
>> <asm-generic/kpkeys.h>:
>>
>> - arch_kpkeys_set_level()
>> - arch_kpkeys_restore_pkey_reg()
>> - arch_kpkeys_enabled()
> Another thing: why not simply drop the "arch_" stuff from these helpers?

The first two are not meant to be directly called, they're the
arch-specific implementation of kpkeys_set_level() and
kpkeys_restore_pkey_reg(), and those generic functions handle some
generic logic.

arch_kpkeys_enabled() is directly used in generic code, so I suppose it
could be renamed to kpkeys_enabled()? It's actually implemented in an
arch header so I wasn't too sure about it.

- Kevin
