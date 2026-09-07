Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AA42E413
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796194; cv=none; b=eRB3Po94iyMajelb0e9YUghn11TzcOnBKxlHD5qP1H3V3apoE4fPgH2CfPkpEdo5ho3reIxkfLvq0lmkdNe0dJ4ofn5cYJWiQ7QLcyMBH8M/5gf5Eugusl+nlIlo1X4vj6owkd2jFjqZIyGhFfOF7utxPnmfyOWtbQF7Arj9Jwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796194; c=relaxed/simple;
	bh=NgsqfI4UMPdAKy09BfAtIYj/ju7Uvf0+W/vr1pDeSmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knGtOkExwEh/KvTyGtiCiNo0WS9/6C/JUafbsGFlnSzv9aNkBpGXylUhbTHLQku+vfN5Eif3FFXTgkxb9IjYbu56hYygIAtuU7rWRNzxGrzI4seGailJqqURdabDhC//0UZZCAa7m8vbgSpduyA30tyU2vCN3Ep073t3PeZDwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X8PrVsr7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X8PrVsr7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D891476;
	Mon,  7 Sep 2026 08:49:47 -0700 (PDT)
Received: from [10.57.6.26] (unknown [10.57.6.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634F93F7B4;
	Mon,  7 Sep 2026 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796191; bh=NgsqfI4UMPdAKy09BfAtIYj/ju7Uvf0+W/vr1pDeSmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X8PrVsr7qSGJqrvABBYQzM/DbPiLBfiIRsoRicV7kmHmDk4fvFg6Gl0y2kzAN0Etz
	 Ea7Gi8wO+37xss8GQ8X/AtXdULivI4RHRx1t2vIjhRBNjqhWUfYrjRpUJ+dijf2Dy4
	 Yv9O0nkLGvLbp7EhNWeac5e0DU5XWNx23239QUAw=
Message-ID: <3f6e7678-0784-4ac1-acb4-b128887803c5@arm.com>
Date: Mon, 7 Sep 2026 17:49:42 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 01/25] mm: Introduce kpkeys
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-1-743ad31b2c8f@arm.com>
 <178877845406.3691569.6930315020588094755.b4-review@b4>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <178877845406.3691569.6930315020588094755.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 12:54, Mike Rapoport wrote:
> Hi Kevin,
>
>> kpkeys is a simple framework to enable the use of protection keys
>> (pkeys) to harden the kernel itself. This patch introduces the basic
>> API in <linux/kpkeys.h>: a couple of functions to enter/leave a
>> kpkeys context and macros to define guard objects.
>>
>> kpkeys introduces a new concept on top of pkeys: the kpkeys context.
>> Each context is associated with a set of permissions for the pkeys
>> managed by the kpkeys framework. kpkeys_enter_context(ctx) sets
>> those permissions according to ctx, and returns the original kpkeys
>> state (typically the arch-specific pkeys register) that is later
>> restored by calling kpkeys_leave_context(). To start with, only
>> KPKEYS_CTX_DEFAULT is available, which is meant to grant RW access
>> to KPKEYS_PKEY_DEFAULT (i.e. all memory since this is the only
>> available pkey for now).
>>
>> The underlying representation of each kpkeys context is entirely
>> architecture-specific. Support for kpkeys must be explicitly
>> indicated by selecting ARCH_HAS_KPKEYS and defining the following
>> functions in <asm/kpkeys.h>:
>>
>> * arch_kpkeys_enter_context()
>> * arch_kpkeys_leave_context()
>> * arch_supports_kpkeys()
>>
>> Additionally, <asm/kpkeys_types.h> must define struct arch_kpkeys_state,
>> which typically provides storage for the pkeys register.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>
>> diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
>> new file mode 100644
>> index 0000000000000..eac522f552141
>> --- /dev/null
>> +++ b/include/linux/kpkeys.h
>> @@ -0,0 +1,104 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _LINUX_KPKEYS_H
>> +#define _LINUX_KPKEYS_H
>> +
>> +#include <linux/bug.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/kpkeys_types.h>
>> +
>> +/**
>> + * KPKEYS_GUARD_NOOP() - define a guard type that does nothing
> Nit: I'd suggest to drop "define" from all the descriptions, they would
> read better without it IMHO.

Fair enough, but if we say just "a guard type that does nothing" is it
clear that this is a macro defining a type, and not a type itself?

- Kevin
