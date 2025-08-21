Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66632E62B1;
	Thu, 21 Aug 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761041; cv=none; b=cQotXTw/2ZAyUabQYHxlHf1eMEJk6lTVYHAzEqNWQrxWskAYBbxpjUONhVJKmPj7OE7op6fXDujofUWNTWlPbaYCqHMCHmzhxmpKQ1v7jxIdJiDKstv6s6mYX518JfwXSmq0+KYlX/RiIQI5su/KBjfy25/7v8bTMvVbQ/jDESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761041; c=relaxed/simple;
	bh=X64IdBmjHXhS6gvtudLgoG6tBJL+bVjtjgEiJHPyTrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olKV0Ym64TjyDOVKkYZgwVq6nM4fR1A1CnPS9xdlrOfTlt7YSJEJ1vLc/gYPQ+0bsUv2Zl3SmQOK+5wNFc8WwUijufMvM1ZwYf6w3BvIsFHUVk6+b5UWU6bv6OmXbumXCKuQ9qJmw165d1bYOXaZy2XT+sFN7NQYnBcc1HKGlsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A871168F;
	Thu, 21 Aug 2025 00:23:43 -0700 (PDT)
Received: from [10.57.91.165] (unknown [10.57.91.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C45A3F58B;
	Thu, 21 Aug 2025 00:23:45 -0700 (PDT)
Message-ID: <09873338-574e-43e4-a6ff-590a3c9a9e87@arm.com>
Date: Thu, 21 Aug 2025 09:23:42 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "maz@kernel.org" <maz@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "mbland@motorola.com" <mbland@motorola.com>,
 "david@redhat.com" <david@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "joey.gouly@arm.com"
 <joey.gouly@arm.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "pierre.langlois@arm.com" <pierre.langlois@arm.com>,
 "jeffxu@chromium.org" <jeffxu@chromium.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "jannh@google.com" <jannh@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
 "qperret@google.com" <qperret@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <4a828975-d412-4a4b-975e-4702572315da@arm.com>
 <5b5455eb-e649-4b20-8aad-6d7f5576a84a@arm.com>
 <3c18d1f1e94d3491410168e37cdf67e9e471649e.camel@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <3c18d1f1e94d3491410168e37cdf67e9e471649e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/08/2025 18:18, Edgecombe, Rick P wrote:
> On Wed, 2025-08-20 at 18:01 +0200, Kevin Brodsky wrote:
>> Apologies, Thunderbird helpfully decided to wrap around that table...
>> Here's the unmangled table:
>>
>> +-------------------+----------------------------------+------------------+---------------+
>>> Benchmark         | Result Class                     | Without batching | With batching |
>> +===================+==================================+==================+===============+
>>> mmtests/kernbench | real time                        |            0.32% |         0.35% |
>>>                    | system time                      |        (R) 4.18% |     (R) 3.18% |
>>>                    | user time                        |            0.08% |         0.20% |
>> +-------------------+----------------------------------+------------------+---------------+
>>> micromm/fork      | fork: h:0                        |      (R) 221.39% |     (R) 3.35% |
>>>                    | fork: h:1                        |      (R) 282.89% |     (R) 6.99% |
>> +-------------------+----------------------------------+------------------+---------------+
>>> micromm/munmap    | munmap: h:0                      |       (R) 17.37% |        -0.28% |
>>>                    | munmap: h:1                      |      (R) 172.61% |     (R) 8.08% |
>> +-------------------+----------------------------------+------------------+---------------+
>>> micromm/vmalloc   | fix_size_alloc_test: p:1, h:0    |       (R) 15.54% |    (R) 12.57% |
> Both this and the previous one have the 95% confidence interval. So it saw a 16%
> speed up with direct map modification. Possible?

Positive numbers mean performance degradation ("(R)" actually stands for
regression), so in that case the protection is adding a 16%/13%
overhead. Here this is mainly due to the added pkey register switching
(+ barrier) happening on every call to vmalloc() and vfree(), which has
a large relative impact since only one page is being allocated/freed.

>>>                    | fix_size_alloc_test: p:4, h:0    |       (R) 39.18% |     (R) 9.13% |
>>>                    | fix_size_alloc_test: p:16, h:0   |       (R) 65.81% |         2.97% |
>>>                    | fix_size_alloc_test: p:64, h:0   |       (R) 83.39% |        -0.49% |
>>>                    | fix_size_alloc_test: p:256, h:0  |       (R) 87.85% |    (I) -2.04% |
>>>                    | fix_size_alloc_test: p:16, h:1   |       (R) 51.21% |         3.77% |
>>>                    | fix_size_alloc_test: p:64, h:1   |       (R) 60.02% |         0.99% |
>>>                    | fix_size_alloc_test: p:256, h:1  |       (R) 63.82% |         1.16% |
>>>                    | random_size_alloc_test: p:1, h:0 |       (R) 77.79% |        -0.51% |
>>>                    | vm_map_ram_test: p:1, h:0        |       (R) 30.67% |    (R) 27.09% |
>> +-------------------+----------------------------------+------------------+---------------+
> Hmm, still surprisingly low to me, but ok. It would be good have x86 and arm
> work the same, but I don't think we have line of sight to x86 currently. And I
> actually never did real benchmarks.

It would certainly be good to get numbers on x86 as well - I'm hoping
that someone with a better understanding of x86 than myself could
implement kpkeys on x86 at some point, so that we can run the same
benchmarks there.

- Kevin
