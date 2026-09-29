Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7058353A81;
	Tue, 29 Sep 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662987; cv=none; b=mFNi+c4uzFOkih6276ED+QlSOyFj2t80RlT4tD2QytVMu8XM4nDL/ENljZ0CXflr124r1VVDVHeFCPTH0Swm1kb8YiQ0TC5guWUhfJAza9i32TruBGq6bjNqWuJpJl8neo/Ha/PbKu/DRVoAKQ9bVy2YBIfZylXRbS/4FqLe9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662987; c=relaxed/simple;
	bh=xU1e3+DxEqKhMCr8ylodRzXGFmv8z9Q3jNQYSBiVi9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkq7MKHf92OzzlOXGrM+75Fn8vLeJh7TEvb1ea5IZ67bGRfXukRxKR7J4MmYvMf4qxHStQtSbaP1DQ48DRVaLeivXw/e0qL1bWZsw5iZBRuJt7DsjSOW2GuibqhwXQj2XCErykcxOGN0Orxq2zkYt3efuoHq/GEd0V/tjH2TdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW/UjGUp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0n50FDTI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW/UjGUp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0n50FDTI"
Date: Tue, 29 Sep 2026 08:23:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790662983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNEg87cU5+xb7cXOD++DHDpoblLKSzYbAs+d70mx6I=;
	b=oW/UjGUpOjgWJ91A2k3l5hJ28xjAqb+bgDSVKLkwXH6v+HoDpWc8AFWheJmmnT+54/7yW8
	nzHQDZtlw7buRVlLI4Mgi4YRmhIk/uJNxOiJTUKwIkQlc8dmpN1UHkTZK+vAg2eJ4wDgMy
	XuMS7PKh9Cc8cLFC9QegobY//v4cn8xRunBRzLg2Co2jFwcuFp6x9C0aze/i+JgDKuN8l0
	ye4JT81945lm8w0uW2u2KWxw0IDX9gUcVv9L0i3RZI+rozNzrTCYGQ9jclxcrGVwZZEuhq
	lp6OArdxbJsJL/0ZUrR758EgNSdr886B4xs/ipV8BYYPXoKM4OJ20Q/2a7ACrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790662983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNEg87cU5+xb7cXOD++DHDpoblLKSzYbAs+d70mx6I=;
	b=0n50FDTIC6PS0lvXTfWCuXcRCS1DLyNzKvVH27YlIV+E1TVqPmmkbVl9PvUZx7uf8zP2Gg
	oNXeI4YWHJBudrAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fortify: add KUnit tests for __counted_by and
 __counted_by_ptr
Message-ID: <20260929074930-f1e4add2-f8ca-43db-85fd-83be0e40c676@linutronix.de>
References: <20260928231737.2092716-1-morbo@google.com>
 <20260929010031.2186255-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929010031.2186255-1-morbo@google.com>

Hi Bill,

this looks much better. Thanks for the rework.

On Tue, Sep 29, 2026 at 01:00:31AM +0000, Bill Wendling wrote:
> The '__counted_by' and '__counted_by_ptr' attributes associate a
> flexible array member or pointer member with a struct field that holds
> its element count. Supporting compilers use these annotations to
> compute dynamic object sizes via '__builtin_dynamic_object_size()' for
> runtime bounds checking with CONFIG_FORTIFY_SOURCE.
> 
> Add KUnit tests ('fortify_test_counted_by_flex' and
> 'fortify_test_counted_by_ptr', guarded by CONFIG_CC_HAS_COUNTED_BY and
> CONFIG_CC_HAS_COUNTED_BY_PTR respectively) to verify that:
> 
>  - '__builtin_dynamic_object_size()' (both types 0 and 1) returns the
>    expected logical byte size for annotated flexible array and pointer
>    members.
>  - Fortified operations ('memset()' and 'memchr()') succeed within the
>    logical bounds and detect out-of-bounds read and write accesses
>    beyond the annotated count.
> 
> Allocate the test buffers with extra physical capacity (2 * size) in
> 'noinline' helpers and hide the returned pointers with
> OPTIMIZER_HIDE_VAR() so allocation-size attributes, physical slab
> bounds, and compiler optimizations do not mask the '__counted_by' and
> '__counted_by_ptr' checks.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2: Move tests to the 'fortify' KUnit tests. It uses UBSAN, which is
>     what gets triggered by 'counted_by'.

v2 is missing in subject.

> ---
>  lib/tests/fortify_kunit.c | 119 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> index 413cdbf3dc0d..2335171f84d8 100644
> --- a/lib/tests/fortify_kunit.c
> +++ b/lib/tests/fortify_kunit.c
> @@ -1011,6 +1011,119 @@ static void fortify_test_kmemdup(struct kunit *test)
>  	kfree(copy);
>  }
>  
> +#ifdef CONFIG_CC_HAS_COUNTED_BY

The ugly ifdeffery can be replaced by IS_ENABLED():

if (!IS_ENABLED(CONFIG_FOO))
	kunit_skip(test, "Not built with CONFIG_FOO=y");

It makes the code cleaner and gives some useful feedback at runtime.

> +struct counted_by_flex_struct {
> +	size_t size;
> +	int array[] __counted_by(size);
> +};
> +
> +/*
> + * Allocate the struct out-of-line with extra physical capacity so that
> + * __alloc_size() and physical slab bounds do not mask the __counted_by()
> + * logical bounds check.
> + */
> +static noinline struct counted_by_flex_struct *
> +alloc_counted_by_flex_struct(struct kunit *test, size_t size)
> +{
> +	struct counted_by_flex_struct *s;
> +
> +	s = kzalloc(sizeof(*s) + 2 * size * sizeof(s->array[0]), GFP_KERNEL);

kunit_kzalloc() to automatically free the allocation again.
struct_size() for the size calculation.

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
> +
> +	s->size = size;
> +	return s;
> +}
> +
> +static void fortify_test_counted_by_flex(struct kunit *test)
> +{
> +	size_t size = 128;
> +	struct counted_by_flex_struct *s;
> +	size_t elem_bytes = size * sizeof(s->array[0]);
> +
> +	s = alloc_counted_by_flex_struct(test, size);
> +
> +	OPTIMIZER_HIDE_VAR(s);
> +	OPTIMIZER_HIDE_VAR(elem_bytes);
> +
> +	/* __builtin_dynamic_object_size() should return the logical length. */
> +	KUNIT_EXPECT_EQ(test, elem_bytes,
> +			__builtin_dynamic_object_size(s->array, 0));
> +	KUNIT_EXPECT_EQ(test, elem_bytes,
> +			__builtin_dynamic_object_size(s->array, 1));
> +
> +	/* Within-bounds write and read succeed. */
> +	memset(s->array, 0x42, elem_bytes);
> +	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
> +	KUNIT_EXPECT_NOT_NULL(test, memchr(s->array, 0x42, elem_bytes));
> +	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
> +
> +	/* Out-of-bounds write and read past logical size are caught. */
> +	memset(s->array, 0x42, elem_bytes + 1);
> +	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
> +	KUNIT_EXPECT_NULL(test, memchr(s->array, 0x42, elem_bytes + 1));
> +	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
> +
> +	kfree(s);
> +}
> +
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +struct counted_by_ptr_struct {
> +	char *ptr __counted_by_ptr(size);
> +	size_t size;
> +};

In the other structure the arguments where swapped, intentional?

> +
> +/*
> + * Allocate the struct out-of-line with extra physical capacity so that
> + * __alloc_size() and physical slab bounds do not mask the __counted_by_ptr()
> + * logical bounds check.
> + */
> +static noinline struct counted_by_ptr_struct *
> +alloc_counted_by_ptr_struct(struct kunit *test, size_t size)
> +{
> +	struct counted_by_ptr_struct *s;
> +
> +	s = kmalloc_obj(struct counted_by_ptr_struct);

We should probably also get kunit_kmalloc_obj() at some point.

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
> +
> +	s->size = size;
> +	s->ptr = kzalloc(2 * size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s->ptr);
> +
> +	return s;
> +}
> +
> +static void fortify_test_counted_by_ptr(struct kunit *test)
> +{
> +	size_t size = 128;
> +	struct counted_by_ptr_struct *s;
> +
> +	s = alloc_counted_by_ptr_struct(test, size);
> +
> +	OPTIMIZER_HIDE_VAR(s);
> +	OPTIMIZER_HIDE_VAR(size);
> +
> +	/* __builtin_dynamic_object_size() should return the logical length. */
> +	KUNIT_EXPECT_EQ(test, size, __builtin_dynamic_object_size(s->ptr, 0));
> +	KUNIT_EXPECT_EQ(test, size, __builtin_dynamic_object_size(s->ptr, 1));

Is this builtin guaranteed to be available?
We have a wrapper KUNIT_EXPECT_BDOS() above.

> +
> +	/* Within-bounds write and read succeed. */
> +	memset(s->ptr, 0x42, size);
> +	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
> +	KUNIT_EXPECT_NOT_NULL(test, memchr(s->ptr, 0x42, size));
> +	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
> +
> +	/* Out-of-bounds write and read past logical size are caught. */
> +	memset(s->ptr, 0x42, size + 1);
> +	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
> +	KUNIT_EXPECT_NULL(test, memchr(s->ptr, 0x42, size + 1));
> +	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
> +
> +	kfree(s->ptr);
> +	kfree(s);
> +}
> +#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
> +#endif /* CONFIG_CC_HAS_COUNTED_BY */
> +
>  static int fortify_test_init(struct kunit *test)
>  {
>  	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
> @@ -1054,6 +1167,12 @@ static struct kunit_case fortify_test_cases[] = {
>  	KUNIT_CASE(fortify_test_memchr_inv),
>  	KUNIT_CASE(fortify_test_memcmp),
>  	KUNIT_CASE(fortify_test_kmemdup),
> +#ifdef CONFIG_CC_HAS_COUNTED_BY
> +	KUNIT_CASE(fortify_test_counted_by_flex),
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR

The nesting of these conditionals looks unnecessary.

> +	KUNIT_CASE(fortify_test_counted_by_ptr),
> +#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
> +#endif /* CONFIG_CC_HAS_COUNTED_BY */
>  	{}
>  };
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
