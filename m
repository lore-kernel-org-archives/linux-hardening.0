Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF4229B21;
	Mon,  9 Dec 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749044; cv=none; b=X/Juz6fhZTyrBLsnegB2PVd1gwwdsl2y9DExJjo+RutqGSHtLU3tQ1wf+Krr273RK33p/0MPeHdZnsxShGpbb2z/IuLHBlCcIwqHIp0fW4HuESb4RQuaiooDFz/5Kv2jnbXEfW5U2qiVCThPk/TvPjuvFZk7VOO7h9cLNyOFnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749044; c=relaxed/simple;
	bh=VexgucUkKC3dW+9+1fSj/F49YE0/r3u0mmMQ3poEJac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsZsEm3fkFuh5TFw9HDMLth04exrDpMrFQj5LLgfFJx/PGdQSi6SxfR8HwGSa3kC7l3OM7UeFtW6iLasbRW/Vg8BzN8Jy9jsjxbr8KpKBiOvoPhXcYWClD6cX6RKb2i0wsrScWAby93jhoV+zlfC4pOB/GHYHWcsU4X+hW7ePC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6A21113E;
	Mon,  9 Dec 2024 04:57:47 -0800 (PST)
Received: from [10.57.68.240] (unknown [10.57.68.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3DF3F720;
	Mon,  9 Dec 2024 04:57:12 -0800 (PST)
Message-ID: <8fc285a3-92af-47e1-a405-0adf573c57aa@arm.com>
Date: Mon, 9 Dec 2024 13:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] pkeys-based page table hardening
To: Jann Horn <jannh@google.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, jeffxu@chromium.org, joey.gouly@arm.com,
 kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com,
 qperret@google.com, ryan.roberts@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <CAG48ez1b8BBquEB1BJEg+KsPdPyZLPuD7uToUH3ZdN8F0r+U9w@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CAG48ez1b8BBquEB1BJEg+KsPdPyZLPuD7uToUH3ZdN8F0r+U9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/12/2024 20:14, Jann Horn wrote:
> On Fri, Dec 6, 2024 at 11:13 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>> [...]
>>
>> Page tables were chosen as they are a popular (and critical) target for
>> attacks, but there are of course many others - this is only a starting
>> point (see section "Further use-cases"). It has become more and more
>> common for accesses to such target data to be mediated by a hypervisor
>> in vendor kernels; the hope is that kpkeys can provide much of that
>> protection in a simpler manner. No benchmarking has been performed at
>> this stage, but the runtime overhead should also be lower (though likely
>> not negligible).
> Yeah, it isn't great that vendor kernels contain such invasive changes...
>
> I guess one difference between this approach and a hypervisor-based
> approach is that a hypervisor that uses a second layer of page tables
> can also prevent access through aliasing mappings, while pkeys only
> prevent access through a specific mapping? (Like if an attacker
> managed to add a page that is mapped into userspace to a page
> allocator freelist, allocate this page as a page table, and use the
> userspace mapping to write into this page table. But I guess whether
> that is an issue depends on the threat model.)

Yes, that's correct. If an attacker is able to modify page tables then
kpkeys are easily defeated. (kpkeys_hardened_pgtables does mitigate
precisely that, though.) On the topic of aliases, it's worth noting that
this isn't an issue with page table pages (only the linear mapping is
used), but if we wanted to assigning a pkey to vmalloc areas we'd also
have to amend the linear mapping.

>> [...]
>>
>> # Threat model
>>
>> The proposed scheme aims at mitigating data-only attacks (e.g.
>> use-after-free/cross-cache attacks). In other words, it is assumed that
>> control flow is not corrupted, and that the attacker does not achieve
>> arbitrary code execution. Nothing prevents the pkey register from being
>> set to its most permissive state - the assumption is that the register
>> is only modified on legitimate code paths.
> Is the threat model that the attacker has already achieved full
> read/write access to unprotected kernel data and should be stopped
> from gaining write access to protected data? Or is the threat model
> that the attacker has achieved some limited corruption, and this
> series is intended to make it harder to either gain write access to
> protected data or achieve full read/write access to unprotected data?

The assumption is that the attacker has acquired a write primitive that
could potentially allow corrupting any kernel data. The objective is to
make it harder to exploit that primitive by making critical data immune
to it. Nothing stops the attacker to turn to another (unprotected)
target, but this is no different from hypervisor-based protection - the
hope is that removing the low-hanging fruits makes it too difficult to
build a complete exploit chain.

- Kevin
