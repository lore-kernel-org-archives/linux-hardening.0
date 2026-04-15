Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0922D0603;
	Wed, 15 Apr 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268241; cv=none; b=gTCUIGsPEnjCwE7klndQjoit1GwwLoZZt7t/5F5tPxeFYBzmmaiCMIWFKYiVarxhhIVitziZ/vRfUmPLxGhn2uY2zjVj6m1iflGaNUAkSIMlM6PpvCfPSD5XIVN4Ckdpsr0GD0GipqBsqYmmmYyK7moXzSn7c6RDZ6qDOOK/mEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268241; c=relaxed/simple;
	bh=KOMJEclslTGko0CKo3zJ9nnmBRPTykeI0IPan0usj1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncbFtwDwCcYSjTitQtq9unBTAGSQVBh59Qexi2c7x3trCXU1/XTj9FJaitZCfMdj7wIBY3kVw2e56K75kVjNmZnzmjJD5YY0KY60fcGduE5/orWmuBLHAV54L3pwsFUXwA5Nv3axia9JN0xBBytw2RW96SgGz7EJFKqhu6VLD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hR3+dovg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hR3+dovg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E3F3543;
	Wed, 15 Apr 2026 08:50:33 -0700 (PDT)
Received: from [10.57.61.135] (unknown [10.57.61.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC703F7B4;
	Wed, 15 Apr 2026 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776268239; bh=KOMJEclslTGko0CKo3zJ9nnmBRPTykeI0IPan0usj1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hR3+dovgqaAoCeD7Tj26ImE/aKDrkOG7n2ey9QHxI3X9difSYSy69sYtkr08iAEHk
	 fyQlQqCCEJG3ZsAktdUrlv/o6tLioBkfsevEDHaXxc5Hh//9nV+0z8WKgSU1JBm0v0
	 6SAa+zLxImrdvyYlNd1yAhbhoIUq82FWMkSjwMhM=
Message-ID: <fea9c939-f955-4020-bed6-427e592f0024@arm.com>
Date: Wed, 15 Apr 2026 17:50:29 +0200
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
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <eaca640b-5006-489b-8b2d-148a3c4073da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2026 15:00, David Hildenbrand (Arm) wrote:
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
> I don't quite understand the reason for using levels. Levels sounds like
> it would all be in some ordered fashion, where higher levels have access
> to lower levels.

That was originally the idea indeed, but in practice I don't expect
levels to have a strict ordering, as it's not practical for composing
features.

> Think of that as a key that can unlock all "lower" locks, not just a
> single lock.
>
> Then, the question is about the ordering once we introduce new
> keys/locks. With two, it obviously doesn't matter :)
>
> So naturally I wonder whether levels is really the right abstraction
> here, and why we are not simply using "distinct" keys, like
>
> KPKEY_DEFAULT
> KPKEY_PGTABLE
> KPKEY_SUPER_SECRET1
> KPKEY_SUPER_SECRET2
>
> Is it because you want KPKEY_PGTABLE also be able to write to KPKEY_DEFAULT?

Right, and in general a given level may be able to write to any number
of pkeys. That's why I don't want to conflate pkeys and levels. Agreed
that "level" might not be the clearest term though, since there's no
strict ordering.

> But how would you handle KPKEY_SUPER_SECRET1 and KPKEY_SUPER_SECRET2 then?

Presumably those would also have access to KPKEY_DEFAULT. However, if
you consider the reverse situation where the level is less privileged
than the default (say an eBPF program), then write access to
KPKEY_DEFAULT would not be granted.

Also worth noting on the notion of level that POE2 will bring further
per-level restrictions, besides which pkeys can be accessed. For
instance, we could prevent an unprivileged level from executing certain
instructions. This isn't in scope for this series, but this is a
consideration in the design of the kpkeys abstractions.

- Kevin
