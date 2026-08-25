Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7411E0DE8;
	Tue, 25 Aug 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787634466; cv=none; b=uOXeywxVew7Qgoj2NHYoQ95znxc5OT0Up/rPZjJo2z16j34S2OKGo/N89bQG38P/QVUBaP9/9ZnjplsT4a133NgMKtMfWKMDeqF88tghp83V+HipCcUJ6+wpIt+q5FsZmatDDoJ34S21RhtNG+I4Z+x6AIVYIMAX7u5eR0sqtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787634466; c=relaxed/simple;
	bh=SQHNn/ts9/ycErKCaZ5tVLTT6zkguL0GgEFvITPmDqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChO83n/PrIDkq/0RoN5hvg1FBpCeSCtE/+5Y0XtV4jKzYZAAqMPQ8MdOUBafBXGaAFfkVuIfUm9Z+QCyooHqmmVfyjeZfrAhpUajnGVrsbvpqpfARSZp0ppDvrfaQNOlySb7enKcxkOUN9UY/0nu5qbuVlWzDqZ7kH9ZCn3oeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 2F1811EAAA9; Tue, 25 Aug 2026 13:07:34 +0800 (AWST)
X-Spam-Level: 
Received: from [IPV6:2001:8003:8802:7000::41b] (unknown [IPv6:2001:8003:8802:7000::41b])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id BA6E21EA7C4;
	Tue, 25 Aug 2026 13:07:28 +0800 (AWST)
Message-ID: <f165dbd7-d275-4f9c-969c-408399e85830@davidgow.net>
Date: Tue, 25 Aug 2026 13:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
To: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Ryota Sakamoto <sakamo.ryota@gmail.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, Petr Mladek <pmladek@suse.com>,
 Kir Chou <note351@hotmail.com>, codemender-patching+linux@google.com,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
References: <20260823123549.1120133-1-morbo@google.com>
 <20260823123549.1120133-3-morbo@google.com>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20260823123549.1120133-3-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2026 à 20:35, Bill Wendling a écrit :
> Add a custom KUnit test suite 'stacktrace_counted_by' to verify that the
> __counted_by_ptr annotation on the 'entries' field of 'struct stack_trace'
> behaves correctly.
> 
> The test verifies that 'max_entries' correctly limits and validates access
> to 'entries' when CONFIG_ARCH_STACKWALK is not defined. If it is defined,
> the test is cleanly skipped at runtime to prevent compile-time or runtime
> failures due to 'struct stack_trace' being undefined on modern
> architectures.
> 
> Assisted-by: Gemini Next
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <david@davidgow.net>
> Cc: Rae Moar <raemoar63@gmail.com>
> Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Kir Chou <note351@hotmail.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---

I'm a bit confused: what is this actually testing? You're creating an 
array of size 4 and writing 4 entries to it, after setting max_entries 
correctly? Removing the __counted_by_ptr attribute doesn't change 
anything here. Is there any circumstance where this should fail? The 
only case I can think of is if __counted_by_ptr is either totally 
broken, or someone randomly points it to a different value. Neither of 
which seem likely.

Even if this did something more exciting (like try to access elements 
beyond the end of the array), I'm not sure a KUnit test is the optimal 
place for it: ultimately we're looking for a compiler warning / error, 
not a runtime one, and even then, one which probably isn't of much value 
given it's unlikely __counted_by_ptr will spontaneously break.

Added to that, there are a bunch of stylistic issues with the test below 
anyway. These mostly seem like LLM-isms, but probably should've been 
caught before this went to the list.

Unless there's something I'm missing (and, if so, it's probably worth 
writing a description which better explains the "why" here), I think we 
can probably drop this test entirely and stick to just patch 1.

-- David

>   lib/Kconfig.debug            | 10 +++++++
>   lib/kunit/.kunitconfig       |  1 +
>   lib/tests/Makefile           |  1 +
>   lib/tests/stacktrace_kunit.c | 51 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 63 insertions(+)
>   create mode 100644 lib/tests/stacktrace_kunit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e97bdf3a42a8..51a6ac1a2461 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2716,6 +2716,16 @@ config BITOPS_KUNIT
>   
>   	  If unsure, say N.
>   
> +config STACKTRACE_KUNIT_TEST
> +	tristate "KUnit test for stacktrace counted_by attribute" if !KUNIT_ALL_TESTS
> +	depends on KUNIT

This should also just depend on CONFIG_ARCH_STACKWALK, rather than doing 
the whole skip test thing.

> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables the KUnit test for verifying the __counted_by_ptr
> +	  attribute on struct stack_trace.
> +
> +	  If unsure, say N.
> +
>   config BITFIELD_KUNIT
>   	tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL_TESTS
>   	depends on KUNIT
> diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
> index 9235b7d42d38..b3761b41459e 100644
> --- a/lib/kunit/.kunitconfig
> +++ b/lib/kunit/.kunitconfig
> @@ -1,3 +1,4 @@
>   CONFIG_KUNIT=y
>   CONFIG_KUNIT_TEST=y
>   CONFIG_KUNIT_EXAMPLE_TEST=y
> +CONFIG_STACKTRACE_KUNIT_TEST=y

Please don't add this here. This is not a test of KUnit itself, which is 
what the lib/kunit/.kunitconfig file is meant to configure.

For general KUnit test build, CONFIG_KUNIT_ALL_TESTS will enable it.

> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 4ead57602eac..40875e729fc8 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -6,6 +6,7 @@
>   CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
>   obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
>   obj-$(CONFIG_BITOPS_KUNIT) += bitops_kunit.o
> +obj-$(CONFIG_STACKTRACE_KUNIT_TEST) += stacktrace_kunit.o
>   obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
>   obj-$(CONFIG_BITS_TEST) += test_bits.o
>   obj-$(CONFIG_SHDI3_KUNIT_TEST) += shdi3_kunit.o
> diff --git a/lib/tests/stacktrace_kunit.c b/lib/tests/stacktrace_kunit.c
> new file mode 100644
> index 000000000000..7ec48edf84fe
> --- /dev/null
> +++ b/lib/tests/stacktrace_kunit.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for struct stack_trace counted_by attribute.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/stacktrace.h>
> +
> +#ifndef CONFIG_ARCH_STACKWALK
> +static void test_stack_trace_counted_by(struct kunit *test)
> +{
> +	unsigned long entries_buf[4];
> +	struct stack_trace trace = {
> +		.entries = entries_buf,
> +		.max_entries = 4,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, trace.max_entries, 4U);
> +	KUNIT_EXPECT_PTR_EQ(test, trace.entries, (unsigned long *)entries_buf);
> +
> +	/* Write to the allocated elements to verify access */
> +	trace.entries[0] = 0xdeadbeef;
> +	trace.entries[1] = 0xbeefcafe;
> +	trace.entries[2] = 0xcafebabe;
> +	trace.entries[3] = 0x12345678;
> +
> +	KUNIT_EXPECT_EQ(test, trace.entries[0], 0xdeadbeefUL);
> +	KUNIT_EXPECT_EQ(test, trace.entries[1], 0xbeefcafeUL);
> +	KUNIT_EXPECT_EQ(test, trace.entries[2], 0xcafebabeUL);
> +	KUNIT_EXPECT_EQ(test, trace.entries[3], 0x12345678UL);
> +}
> +#else
> +static void test_stack_trace_counted_by(struct kunit *test)
> +{
> +	kunit_skip(test, "CONFIG_ARCH_STACKWALK is enabled, struct stack_trace is not defined");
> +}
> +#endif
> +
> +static struct kunit_case stacktrace_test_cases[] = {
> +	KUNIT_CASE(test_stack_trace_counted_by),
> +	{}
> +};
> +
> +static struct kunit_suite stacktrace_test_suite = {
> +	.name = "stacktrace_counted_by",
> +	.test_cases = stacktrace_test_cases,
> +};

Is this suite intended to cover more stacktrace tests than just the 
counted_by one at some point? If so, it'd be better to name it 
"stacktrace". If not, these structs should be named 
"stacktrace_counted_by_test_suite", etc.

> +
> +kunit_test_suite(stacktrace_test_suite);
> +
> +MODULE_LICENSE("GPL");

