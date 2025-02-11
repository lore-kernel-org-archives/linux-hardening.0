Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259791E5721;
	Tue, 11 Feb 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264317; cv=none; b=rZdZfp0cWxqwSE0qwwpieya0bNoRZmyBVjGyFAGPmmTLUeSowBQjPbUN9UQVew8DOGaU3ySwLadUYY3zRLvCTGFCyYjbPeJE+Anu63KXIV+RKTcOyAEduiXWFtuy18zuftoE9Yt0NPs4CuWgw7u0XrlOKTlejPGgDve3ckDLFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264317; c=relaxed/simple;
	bh=x6W1HDLosyVn27dDhWnDbtDxbDJIhXRuKZqrrk9uB+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIshLFjM8kLBTeAbFOU5UClkxVeYxl2pg0uVtzKJfN0p2+ZqpepUx9nz/KymV1mfe+kZVWNe96eEnTNRUw77TWVY4VOZthrBRh2f2RZzvgwwvVHnudibqs+deMoaZeb9QjbcCh0Gu40ad2Zov67gqhPXmEetz6oO6LyvOJU7lEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C72091477;
	Tue, 11 Feb 2025 00:58:55 -0800 (PST)
Received: from [10.57.83.200] (unknown [10.57.83.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBD13F5A1;
	Tue, 11 Feb 2025 00:58:28 -0800 (PST)
Message-ID: <d009306c-eb1c-48ca-ab8e-d891b413d55f@arm.com>
Date: Tue, 11 Feb 2025 09:58:25 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] mm: Add basic tests for kpkeys_hardened_cred
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Howells <dhowells@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
 <20250203102809.1223255-9-kevin.brodsky@arm.com>
 <202502062024.BCB0DED1D5@keescook>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <202502062024.BCB0DED1D5@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 05:52, Kees Cook wrote:
> On Mon, Feb 03, 2025 at 10:28:09AM +0000, Kevin Brodsky wrote:
>> Add basic tests for the kpkeys_hardened_pgtables feature: try to
>> perform a direct write to current->{cred,real_cred} and ensure it
>> fails.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  mm/Makefile                    |  1 +
>>  mm/kpkeys_hardened_cred_test.c | 42 ++++++++++++++++++++++++++++++++++
> Current file naming convention[1] would be to name this as:
>
> 	mm/tests/kpkeys_hardened_cred_kunit.c

I wasn't aware of those guidelines, thanks for the pointer! I got
inspiration from various existing tests, it unfortunately looks like the
conventions in [1] have not been universally adopted. I'll try to follow
them in the next version (of both RFC series).

> [...]
>
> +static void write_cred(struct kunit *test)
> +{
> +	long zero = 0;
> +	int ret;
> +
> +	ret = copy_to_kernel_nofault((unsigned long *)current->cred, &zero, sizeof(zero));
> +	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
> +			    "Write to current->cred wasn't prevented");
> +
> +	ret = copy_to_kernel_nofault((unsigned long *)current->real_cred, &zero, sizeof(zero));
> +	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
> +			    "Write to current->real_cred wasn't prevented");
> This is a good negative test. I would include a positive test as well.
> i.e. make sure you can run copy_from_kernel_nofault() to read it
> successfully. Otherwise you don't know if you're just getting a bad
> address -- we want to distinguish between them. (This is more true for
> the next suggestion, since current->cred being broken would be much more
> obvious.)

That's a fair point, I've actually run into this sort of issues with the
page table tests (in the other RFC series). I can add positive tests
with a regular read (e.g. reading current->cred->uid directly) - no
fault is expected to occur in that case.

> While current->cred is good and easy, I would like to see prepare_creds()
> exercised too to get a new cred and validate that it is equally directly
> readable and directly not writable, and then use the correct accessors
> to perform a successful write to the cred, read back the change,
> etc. (i.e. validate the expected behavior too.)

prepare_creds() does not allocate protected memory, see the introduction
in the cover letter and patch 6. However I could certainly add such
tests for the new helpers protect_creds() and prepare_protected_creds(),
which are meant to be used with override_creds().

>> +}
>> +
>> +static int kpkeys_hardened_cred_suite_init(struct kunit_suite *suite)
>> +{
>> +	if (!arch_kpkeys_enabled()) {
>> +		pr_err("Cannot run kpkeys_hardened_cred tests: kpkeys are not supported\n");
>> +		return 1;
>> +	}
> Instead of failing ("return 1") I think this should be a "skip" (it is
> expected to not work if there is no support) in each test instead:

kasan_suite_init() uses this approach if KASAN is disabled, but skipping
does seem to be a better idea - this way it doesn't show up as an error.

> 	if (!arch_kpkeys_enabled())
> 		kunit_skip(test, "kpkeys are not supported\n");
>
> I'm very happy to see tests! :)

Thank you for the review and suggestions!

- Kevin
