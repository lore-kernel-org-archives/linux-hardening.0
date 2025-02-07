Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E323ED5A;
	Fri,  7 Feb 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938814; cv=none; b=gsnceiMewDCysmedEA7tQnzZv6CItZTsfCcNZyi2PYof61l1QyPQjb5oQNM8hvQOfo6N8fAcxtBayr7didb/Kz/8oTZ6yMpMr0rnSUpPQJ+KPGElf2uTOPUqGBOWba48SFgCP0m1tteyzkrjw2mNhd9Aw+mxdNtlqZd6u1OVtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938814; c=relaxed/simple;
	bh=snMwSaLP8lnNXVIs56gsvdEex7XhNiEE64iH6ynGayQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6J3Dfo/QYWPZ0B/DiXbD1BbnT3muBN4Qn7WiQebrSKlkEmfaXSupOvY9vZAUsXYT1bkcPdZhYOsIfZXEYh+9LeFu6Gesa+BkjChIPaYmv57Vk7+3UCkZTHEE4MxkoL/JmfgdhVSYuAhBqg7sfV7Kf/HLeJWtb8i4H6pKsC/t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBAEA113E;
	Fri,  7 Feb 2025 06:33:53 -0800 (PST)
Received: from [10.57.80.179] (unknown [10.57.80.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEA383F58B;
	Fri,  7 Feb 2025 06:33:26 -0800 (PST)
Message-ID: <69b78d77-0dbd-4257-8076-260a3c64a81d@arm.com>
Date: Fri, 7 Feb 2025 15:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/15] mm: Introduce kernel_pgtables_set_pkey()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
 <20250203101839.1223008-9-kevin.brodsky@arm.com>
 <CACRpkdZ_eGsfZh2vkG8dtSyZDbStMfDUuj7s7TQ4FcDwThJVkg@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CACRpkdZ_eGsfZh2vkG8dtSyZDbStMfDUuj7s7TQ4FcDwThJVkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2025 20:01, Linus Walleij wrote:
>> +static int set_page_pkey(void *p, int pkey)
>> +static int set_pkey_pte(pmd_t *pmd, int pkey)
>> +static int set_pkey_pmd(pud_t *pud, int pkey)
>> +static int set_pkey_pud(p4d_t *p4d, int pkey)
>> +static int set_pkey_p4d(pgd_t *pgd, int pkey)
>> +int kernel_pgtables_set_pkey(int pkey)
> Aren't these all discardable after boot, so the whole set should
> be tagged with __init?

Good point, I was thinking of this function as a relatively generic one
but in reality there's probably no use for it after boot. In any case
it's only called from a function marked __init at the moment, so it's
safe to mark all those as __init too.

> Other than that it LGTM.

Thank you for the review!

- Kevin
