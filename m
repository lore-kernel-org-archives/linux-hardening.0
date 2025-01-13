Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3A186A;
	Mon, 13 Jan 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763045; cv=none; b=p7PUekJfwxc7OWp03Y6C4OiepVi7CuTBqzqiUIkvH6hGMk50uO2kiODTGGf8T1Rq1loOOzr/FgTU8c5VEf7iOp9E20kqGg2TNx/glrcvXevW5kylHdvLJEkjuX+oF7sDboSKLHL2UIN5WqAwxtagb2/7wNKX6F7Hh62Isn4Hsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763045; c=relaxed/simple;
	bh=jqo4SwSptk7hKi0M8gQXHVZfAad1gALA0Zh70B3XpQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sr1f6Ao19FgmDd55kgEeAMisLDQfPFCNzofB8bFtHHTo2PCSYU09/ciQakBekySt+INsw84nDMqM7Y0tlh+l8qm3lcWbywDMyhQz5DiDAe2caBugx9Agxlp8cN/lT3pBkEe4PaE+Ui7gSCqbSvTOHvAMnPA9c/Nd9P47TVgxZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF80D1424;
	Mon, 13 Jan 2025 02:11:10 -0800 (PST)
Received: from [10.57.94.36] (unknown [10.57.94.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2183F66E;
	Mon, 13 Jan 2025 02:10:36 -0800 (PST)
Message-ID: <83b57cc5-fe6f-483b-b7e3-8d6e356c914f@arm.com>
Date: Mon, 13 Jan 2025 11:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/15] pkeys-based page table hardening
To: Dave Hansen <dave.hansen@intel.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20250108103250.3188419-1-kevin.brodsky@arm.com>
 <dcc1800c-cf0a-4d88-bc88-982f0709b382@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <dcc1800c-cf0a-4d88-bc88-982f0709b382@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2025 17:30, Dave Hansen wrote:
> One of the sticker things in the x86 attempt to do the same thing was
> context switching, both between normal tasks and in/out of exceptions
> and interrupts.
>
> The easiest place this manifested for us was code chunk like this:
>
> 	kpkeys_set_level(KPKEYS_LVL_PGTABLES);
> 	// modify page tables here
> 	kpkeys_restore_pkey_reg();
>
> We had to make sure that we didn't get preempted and context switch over
> to some other task that _wasn't_ doing page table manipulation while
> page table writes were allowed.
>
> On x86, we had to basically start context-switching the kernel pkey
> register the same way we do GPRs.
>
> How is SYS_POR_EL0 being context switched?

I think this is pretty much the same situation with POR_EL1 on arm64. I
mentioned on the cover letter that resetting POR_EL1 on exception entry
is required (and not done yet), but in fact as you say it also needs to
be context-switched per-thread. This does sound pretty similar to GPRs
(unlike POR_EL0, which is switched in __switch_to() like the user TLS
register for instance).

Is there a particular concern about that extra switching? I don't expect
it to be a significant cost on arm64. In the vast majority of cases,
POR_EL1 will remain set to its default value, meaning that the overhead
is limited to reading POR_EL1, a load and a branch. The only situation
where an expensive write to POR_EL1 is needed is an interrupt firing
right in the middle of a page table setter - possible but pretty
unlikely. Writing to POR_EL1 on exception return isn't really a concern
either, as no additional barrier (ISB) is required in that case.

By the way thank your for mentioning the x86 attempt, I wasn't aware of
it. I'll have a better look and make sure to Cc anyone involved in that
work in future versions.

- Kevin
