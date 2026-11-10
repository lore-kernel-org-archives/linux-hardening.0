Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301308;
	b=2eUh7V6NmiYDWTSQKJKt54zPeeKoexbq+y0L1HNYkc95sxfKXYc44Qp0MEmeYU4DE7Q9
	 o6FwloQxuPqlUyTyqRMVcQKHqeX+cFJY4emOmIE+wT3EZh9bNoMoNUwq4Qbif7gJU3ge6
	 A5x2ulMfFHN600faBhn9R6nWyn5bE4ag0Eh/eRDuEJsw+QT72Z1t1a2kMBUDCtiiGZ7b+
	 F59OFkfcIa6GssWZe9QDsTdodD26noASvJH+7DOum5au3JlbldhIEHqFABzfiryu7RjF5
	 DzYWBJu6tr34bWEVEp4LhxXz8cU+pcmATt/e1gIShX1DfUtI8LiCfrplnVsFzRFPjNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301308;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=N5RMWLcP7isxBVM2qsk29DjsEb+SK3rhdns3s69Yvq8=;
	b=C1OoMwhIh7odZY2nA4DUkbUxw8mkz9AwH9zaoEEsD+WyX4UnbllBLNRY+xDQ2dOoWCl1
	 ITePw5E6PVNvurqm9TgM1idtL9O68wqjg0TaHLDZ5K5ikyklZI5dXWrpg/I60Tr44GJnv
	 wlK9Yl5uPNB7b5m1VS9V01f+8NORuFjoXOrU04w1cL/smFZP+VTEFVFddUY+CqZF4GOdM
	 OPP/KV3zyHtZdWF2W4WbLbnx4yLqrhJTNY2k+kOr0Gn4qEuBpKymUGdUfYN3fshxVMUEm
	 /pomWJOV5+fRxAPpid5hkgCFVXskuZUAYG9PVjC+ndnW4bcr71K9YsS/ygoAl3E6bMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mlXxr88Y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598C606A31C;
	Tue, 10 Nov 2026 09:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3598C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mlXxr88Y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665221516;
	Tue, 10 Nov 2026 01:01:43 -0800 (PST)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60013F85F;
	Tue, 10 Nov 2026 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794301306; bh=9CU41Se9la/KtdDwMQULrIKfytvMpdfr7XLUHb+OkJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mlXxr88YJEAGdd0L2wAgQsnosP8cErHqpjtUnIFgrZRlpeDVMedSkCWzs5XJQabcP
	 AYoasvJ/eG3DdRL64rFmaMFN2uhjRLcP6I3ZkVQpszUmeizzIzpLY6LqjYw9gK2PiX
	 Tw4LA2EMpYvVCFN3nkVI0GLFrsqAWZf0DZ7bW+m8=
Message-ID: <9e59fd71-97e7-422c-a7dd-bc23c6e6a852@arm.com>
Date: Tue, 10 Nov 2026 10:01:36 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v10 22/22] mm: Add basic tests for
 kpkeys_hardened_pgtables
To: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org,
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
 <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2026 20:28, Mark Brown wrote:
> On Mon, Nov 09, 2026 at 03:58:47PM +0000, Kevin Brodsky wrote:
>
>> ---
>>  mm/Makefile                               |   1 +
>>  mm/tests/kpkeys_hardened_pgtables_kunit.c | 200 ++++++++++++++++++++++++++++++
>>  security/Kconfig.hardening                |  12 ++
>>  3 files changed, 213 insertions(+)
>> +config KPKEYS_HARDENED_PGTABLES_KUNIT_TEST
>> +	bool "KUnit tests for kpkeys_hardened_pgtables" if !KUNIT_ALL_TESTS
>> +	depends on KPKEYS_HARDENED_PGTABLES
>> +	depends on KUNIT=y
>> +	default KUNIT_ALL_TESTS
> I'd also expect to see this added to one of the KUnit config fragments
> somewhere so it gets run as standard, though that's a little awkward
> given that KPKEYS_HARDENED_PGTABLES isn't universally available.

Do you mean adding the dependency KPKEYS_HARDENED_PGTABLES=y to
tools/testing/kunit/configs/all_tests.config? Indeed that would only be
meaningful on arm64 (for now). That said it wouldn't hurt other
architectures, so happy to add it there if you think that's worth it.

- Kevin
