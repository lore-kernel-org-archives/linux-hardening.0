Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C337F8BD
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810700; cv=none; b=MMZ2kzC0myCAhIeaPqufn6S7Yc80YK4B860zMAn5hrdMN43JwlzERVe1xhp06yELj8nSWuU1Nx4KQeVhJUSkgLVje6vApwu6DLzu7D6jvKMMcw52/3z9vEM+uuSrAh8eaU/vhaaf3jjB/tocvqov+gtrbAUfbh2NtbJr12CgQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810700; c=relaxed/simple;
	bh=Fp0iKtIQ8WSu99tEd8oJ9ZJXm1jtTIlwqw7RjhGDc+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czFKm1juulJjjQjaJVtaab4H3vtJJjniDBzpKx1Cm4qoyWpiipwb467H0S/IsCa0ZwrPqkKJjWiDII5/bGznm5uf1g1X2+TyxoY8jqr6vHjqZNrORfTLHUdZ68NEZVQEg7GGh/znt4yTx9rZxchx3cAQkitNjJ7zeu9zQ0ucteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hAZ/XGAW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hAZ/XGAW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF6F2C1C;
	Tue, 30 Jun 2026 02:11:33 -0700 (PDT)
Received: from [10.57.81.132] (unknown [10.57.81.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07BD3FAFB;
	Tue, 30 Jun 2026 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782810698; bh=Fp0iKtIQ8WSu99tEd8oJ9ZJXm1jtTIlwqw7RjhGDc+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hAZ/XGAW6u+JKDyTjbV6aaMnWKHnBmN3C6nhJhtMaxQUv8mY4WutOy1CIUH1h5PaP
	 P/y6MGDQDKu+Z19IQ0YpQlt8bdC9TQbsdY9hXxRS0fUKaQ9OtMPJ/oObIJO74x36xf
	 UBWKMVwAmj18UEiY9Kpxmydd0hlAYSLfzTocchLg=
Message-ID: <94cadab5-41c9-4127-aef3-14cb25415363@arm.com>
Date: Tue, 30 Jun 2026 11:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v8 01/24] mm: Introduce kpkeys
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Linus Walleij <linusw@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
 <20260526-kpkeys-v8-1-eaaacdacc67c@arm.com>
 <70f4dcdf-c45f-47d3-91df-a7897bd86ff4@kernel.org>
 <CAD++jL=km9hqTuTMFUhyx_QPuMEwWqmnUVQtPtMXnp8paHH1_A@mail.gmail.com>
 <9b11b0c0-dfc7-45ba-934e-19cd053e5635@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <9b11b0c0-dfc7-45ba-934e-19cd053e5635@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/06/2026 20:38, David Hildenbrand (Arm) wrote:
> On 6/18/26 15:22, Linus Walleij wrote:
>> On Tue, Jun 16, 2026 at 5:19 PM David Hildenbrand (Arm)
>> <david@kernel.org> wrote:
>>
>>> Looking at this, and wondering about "why do we get registers involved in this
>>> API" I would probably have an interface like:
>>>
>>>         arch_kpkeys_enter_context()
>>>         arch_kpkeys_leave_context()
>>>
>>> Whereby you return a "struct kpkeys_state" or sth like that.
>> This is close to what I was looking for as well.
> Cool :)

That's probably what I was looking for too, without knowing it!

>> enter/leave makes the code look more like generic entry.
>>
>> Passing some kind of state cookie around is inevitable in
>> this design and IIUC Kevin argued that it would be inefficient
>> (another level of abstraction) as opposed to just hammering
>> in the context we want, where we want it.

I must have misunderstood what you meant in your previous comments, I
don't have a concern with performance here.

>>
>> But I think the compiler will optimize that out by constant
>> propagation if the backing architecture implementation is
>> simple.
> Yes, it should be wrapped somehow. I don't think this will be a problem
> performance-wise that cannot be solved differently.
>
> Returning an u64 ("register") here is really arm64-sepcific and should be
> abstracted.

Agreed. All this looks very much like the new lazy MMU API, and doing
something along the same lines seems perfectly reasonable.

- Kevin
