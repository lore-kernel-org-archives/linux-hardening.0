Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4341A616E
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356234; cv=none; b=Gxvz4/5UyWo0QcWWM90b2gNhr1Oi6eYm0KG9o4XKkWa18klnb+8Gs0+OQ5nOM8cG+9AkWau/StG7iMCm96fF2LPMk1o+K/+ZJuyYJDUEG+igH5Va7WXWNxmJ2v9jUpgjlqvhdzIErAphZFMExqRoLIBhi1QD+2SsVllycAimjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356234; c=relaxed/simple;
	bh=iGVV+m4HJkFiwhpP4XIVIdXAvDtHdGH9xOpxRwhOAis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqUArs4peATplmeFIWmrrner03x1vsjjSLvXKV2M18tLwgs2DImvXQEuMqXxFxcawaVV4++2bJUyL8amjIXmoG+2JUDw9GfcLaVWvy9j9425Lrgv1hwP4WnpVY3XBiPxXNroDDT30DPNNGC1WZGuZQHJd+SwDYkngxskGc0m7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pShVwaZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pShVwaZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53884C4AF0C;
	Tue, 30 Jul 2024 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356234;
	bh=iGVV+m4HJkFiwhpP4XIVIdXAvDtHdGH9xOpxRwhOAis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pShVwaZ83JafSgO/NqCmmX1ZAiLrpHgLYHXKiqL204ar5fZ2a8LLouFbyzJtOejr4
	 hKiN3hsxy8B9IuwF5Y6ymbcrS+lRrmlIvtfCbmvlfywicEjAMcsCI1S9NgBBOSoRp3
	 uxddG3lyJk8x3n6dcioM3DiuyS4fo2rj3tS6NKb7Yk7z3+y9/lYKG7uByyvgUyYjaV
	 3TQQkh4IERUu1Drruh44f45cKgpPI8RPtSntAcbUjRxKmJoUhlT91Ulk+2F5SKUtKB
	 WDai26Chwv0IBNGmvwH3/UypEXeb1sV1C1z3VpOsb8wJPbLfr9ETG8E3jULXxbwKfb
	 WyN67Z6fvqUzQ==
Date: Tue, 30 Jul 2024 09:17:13 -0700
From: Kees Cook <kees@kernel.org>
To: "Prithivi Raj.S" <prithivi.s017@gmail.com>
Cc: linux-hardening@vger.kernel.org
Subject: Re: Unexpected Heap Randomization Behavior in Kernel Version 5.10.216
Message-ID: <202407300858.EC28E15@keescook>
References: <CACBLJD=y-4aWa-7r-xhfYoTVEkQAGi2EmG3nA97rH2cz-KXmcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACBLJD=y-4aWa-7r-xhfYoTVEkQAGi2EmG3nA97rH2cz-KXmcw@mail.gmail.com>

On Tue, Jul 30, 2024 at 04:45:29PM +0530, Prithivi Raj.S wrote:
> I have been testing Address Space Layout Randomization (ASLR)
> functionalities with the kernel.randomize_va_space sysctl parameter.
> According to the kernel documentation:
> 
> 0 disables randomization.
> 1 randomizes the address of mmap base, stack, and VDSO page.
> 2 randomizes the heap address.
> 
> However, I have observed that in kernel version 5.10.216, the heap
> base address is being randomized even when kernel.randomize_va_space
> is set to 1. This behavior is not the same as described for this
> parameter.
> 
> I tested this on an older kernel version (3.10.0) from the CentOS 7.9
> distribution, where the feature worked as documented.
> 
> Test Code:
> 
> int main() {
>     // Get the current end of the heap
>     void *heap_addr = sbrk(0);
> 
>     printf("Current end of heap (base address): %p\n", heap_addr);
> 
>     return 0;
> }
> 
> I would like to know if this behavior indicates a kernel bug or if the
> heap address randomization is being influenced by other factors. This
> is my first communication with the Linux community, so please let me
> know if there is anything inappropriate or missing in my report. I am
> happy to provide any additional information if needed.

Ignoring randomize_va_space=2 is not intended, but I suspect it may be
related to PIE randomization (text base randomization), as the brk area
is in a fixed position relative to the text address when not separately
randomized, but this has the appearance of a random brk address (which
is really showing the text address randomization).

What was your base OS for the v5.10 test? I know at least Ubuntu does
PIE builds (-pie -fPIE) by default in their compiler, and other distros
are finally starting to catch up to them.

Try this:

int main() {
	// Get the current end of the heap
	void *heap_addr = sbrk(0);
	void *main_addr = main;

	printf("main: %p\n", main_addr);
	printf("brk:  %p\n", heap_addr);
	printf("main/brk offset: %lu\n",
		(unsigned long)heap_addr -
		(unsigned long)main_addr);

	return 0;
}

Here's what I see:

# sysctl -w kernel/randomize_va_space=2
kernel.randomize_va_space = 2

# ./test
main: 0x5efc40341169
brk:  0x5efc41999000
main/brk offset: 23428759

# ./test
main: 0x5bd8d1283169
brk:  0x5bd8d2cd8000
main/brk offset: 27610775

# sysctl -w kernel/randomize_va_space=1
kernel.randomize_va_space = 1

# ./test
main: 0x64452def3169
brk:  0x64452def7000
main/brk offset: 16023

# ./test
main: 0x5dc1e726d169
brk:  0x5dc1e7271000
main/brk offset: 16023

With randomize_va_space=2, the first 2 runs of "test" show differing
"main" addresses, and differing main/brk offsets.

With randomize_va_space=1, the next 2 runs of "test" still show the
randomized "main" address, but unchanged main/brk offsets. (But the
literal brk address is different between the two runs.)

To turn off PIE builds, use "-no-pie":

# gcc test.c -no-pie -o test

# sysctl -w kernel/randomize_va_space=2
kernel.randomize_va_space = 2

# ./test
main: 0x401156
brk:  0x1cb6000
main/brk offset: 25906858

# ./test
main: 0x401156
brk:  0xe1f000
main/brk offset: 10608298

# sysctl -w kernel/randomize_va_space=1
kernel.randomize_va_space = 1

# ./test
main: 0x401156
brk:  0x405000
main/brk offset: 16042

# ./test
main: 0x401156
brk:  0x405000
main/brk offset: 16042

Without text randomization, under randomize_va_space=2, the brk
offset (and address) are randomized. And under randomize_va_space=1,
the brk offset (and the resulting address) are NOT randomized.

Perhaps the docs for randomize_va_space need some clarification... :)

-Kees

-- 
Kees Cook
