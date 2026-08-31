Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ECA46D572
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189928; cv=none; b=m6dFgk9CrVc00CkH5pqt2VUqq00TCSTl8twASXq+ZqF+HxLGScRwaEVV5MAZ3/+AMXa31OHljmwmMYeaPcDr2F9dkXpBhjokoxza9juSy1Gjazxi0C5D3FqlGMzbh++NwXeEGaD2JUCaaRknFsjcPiv1jUdpzKSmrWaTanxjK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189928; c=relaxed/simple;
	bh=eK4lq3SDbX0dW+5hYaKysf1ohyjSSfRIS1hTL0ZfAV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvfZGgTH1W9leTjpO6FqtV9j84hN1VMM4guZXcMfGDwLRF4UtiNy9KW1vi2Gqtx6VASQh3b/V0fGRsv6hx/eVp7S8/QvjdN+DOZUhyp7fYQejwbBv4g8wDlpDb5cCiIUiWnFhAEn2dO6C3YQb+sj7j3bYvTDrfiw60hAc6L/JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ERM+z1j/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ERM+z1j/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B0814BF;
	Mon, 31 Aug 2026 08:25:14 -0700 (PDT)
Received: from [10.57.6.141] (unknown [10.57.6.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09D9D3FAA1;
	Mon, 31 Aug 2026 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788189917; bh=eK4lq3SDbX0dW+5hYaKysf1ohyjSSfRIS1hTL0ZfAV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ERM+z1j/JBwlg2fAxsfL8eZW4gRaVWX/j5qdnj1kgq3pJy6J4eZ8K21f5sScC6ngd
	 66BaVsUlLVYQU2k0g7DZbCjiISMySQ9GE19fNRsy0Eu1baoXaH+Cp05TisgpJMke/3
	 R/0L4fm8uy9+eRa96GTQNDL+1cNFc3qZl+uTNaHs=
Message-ID: <25ca0804-f864-4836-a3ed-58e997f265c8@arm.com>
Date: Mon, 31 Aug 2026 17:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 01/25] mm: Introduce kpkeys
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linu Cherian <linu.cherian@arm.com>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
 <f082aff3-ec63-48fa-94c5-159ca0c5a33e@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <f082aff3-ec63-48fa-94c5-159ca0c5a33e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2026 20:00, David Hildenbrand (Arm) wrote:
>> [...]
>>
>> +/**
>> + * kpkeys_enter_context() - enter a kpkeys context
>> + * @ctx: the context to switch to
>> + *
>> + * Enters the specified kpkeys context. @ctx must be a compile-time constant.
>> + *
>> + * Return: state to be passed to kpkeys_leave_context().
>> + */
>> +static __always_inline
>> +struct kpkeys_state kpkeys_enter_context(enum kpkeys_ctx ctx)
>> +{
>> +	BUILD_BUG_ON_MSG(!__builtin_constant_p(ctx),
>> +			 "kpkeys_enter_context() only takes constant values");
>> +	BUILD_BUG_ON_MSG(ctx < 0 || ctx >= KPKEYS_CTX_COUNT,
>> +			 "Invalid value passed to kpkeys_enter_context()");
>> +
>> +	return arch_kpkeys_enter_context(ctx);
>> +}
>> +
>> +/**
>> + * kpkeys_leave_context() - leave a kpkeys context
>> + * @state: state returned by kpkeys_enter_context()
>> + *
>> + * Restores the state saved when entering a kpkeys context. If no context was
>> + * entered, this function does nothing.
>> + */
>> +static __always_inline
>> +void kpkeys_leave_context(const struct kpkeys_state *state)
>> +{
>> +	if (state->entered_context)
>> +		arch_kpkeys_leave_context(state);
> state->entered_context is a common code variable, but it's not set by
> commoncode. Is there a reason?

Not a good one, agreed the asymmetry isn't great.

> IOW, should arch_kpkeys_enter_context() only return the arch parts, and
> entered_context would be set in common code?
>
> Also, should entering bail out if the context was already entered.
>
> Last but not least, when would we expect to call kpkeys_leave_context() but the
> context was not entered?

It may be worth clarifying that this is not the same situation as lazy
MMU mode, where the state is thread-global. Here the state is supposed
to be on the stack and you should never have nesting or unmatched
enter/leave calls for a given kpkeys_state. (I could certainly add some
VM_WARN_ON_ONCE() to check these invariants, like in the lazy MMU API.)

The other difference is that only arch code can decide whether we need
to enter that state, as this is based on the value of the
(arch-specific) pkeys register. 

> If this is really arch-specific stuff, probably it should go entirely into arch
> doe. If this is common code stuff, likely it should be maintained entirely in
> common code.

The decision is made by the arch, but I think all architectures would
want this behaviour. So we could have:

    bool arch_kpkeys_enter_context(enum kpkeys_ctx ctx, struct
arch_kpkeys_state *arch_state);
    void arch_kpkeys_leave_context(const struct arch_kpkeys_state
*arch_state);

It's a little less elegant because the state to be set now needs to be
passed as an extra argument, but maybe that's better encapsulation. It
also has the advantage of removing the dependency on struct kpkeys_state
in <asm/kpkeys.h>, so we could get potentially get rid of the separate
<linux/kpkeys_types.h>.

The alternative is to make the entire struct kpkeys_state arch-specific
and move all the handling to the arch helpers. Currently the difference
is academic, but when other architectures implement the interface this
could lead to undesirable discrepancies.

> Overall this looks much cleaner to me compared to what I reviewed the last time
> (was that v8? I don't remember :D )

It was indeed RFC v8, and thanks :D

- Kevin
