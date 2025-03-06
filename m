Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037541A8F79;
	Thu,  6 Mar 2025 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245187; cv=none; b=ahpL5zSJZUYZCU3BcwuBBZW8tdEfQuEoN69P2T6ZMYPvqmSZ5qayB2mDOrZGsuyMI02m27u9/xxlXCA9Bk+rr8dazZwnDQeNnBibTu1j9pO5mRw7Q/jpKx8A9k0Pr5Hq0LCE5bs1KSJzNTmUEadjiCJI1lKm8IYDndyQT3b99/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245187; c=relaxed/simple;
	bh=3IAZxUPLr9Ucc24crqAABK/8tnWE32ICxSrbEhhWwww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvExTPIn9je6Fvj5M8sq3BFzFO8RF/aZxlnikpf1dRSXBpFhfDEWStACAILHf2wEJ+RZfgOaWTyCEFm0lfNb7WX1dWY3eiOftVypOkRmwtDRzd6cUwRfItnCVc8V01X3zKfpNzT0g3k7jycp0AT04kLeuTG9biPOBwUhD0niSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5ggZ6ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5ggZ6ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B5C4CEE4;
	Thu,  6 Mar 2025 07:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741245185;
	bh=3IAZxUPLr9Ucc24crqAABK/8tnWE32ICxSrbEhhWwww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5ggZ6ouBgiHmyn7ZuhL7t+eeGW/7EMWSRaFC4Q13IBQmnnJx4sGq3yI2IDLYThI5
	 z67v0HIsWbltqk9gxDejVS+EH9ucGSaOftNJvRtpzGrgo6LV1W6u7w2QyixhzQ7phJ
	 AEAzmSXQwrTPX67MgjLrkXoq8uPwS031sPJw481lbWVZr/OlyQ4kVLhRJPueYCs4Jk
	 6r/9oS1hVYgFRgouP49uVI4WtM8rv4LSC9ibYeSv51g2mPq9ZZz13C4nz9vQRrQheb
	 LsQPdWMVvodzWoJnKrkQp3J0bmggWRq5GjH8UiaDJMJIS1Rpnfdbim6vpEZs95CfTD
	 KoFlxOTYf2fJA==
Date: Wed, 5 Mar 2025 23:13:00 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH] overflow: Twiddle with struct_size()
Message-ID: <202503052213.D38DC337@keescook>
References: <20250305134315.GB16878@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305134315.GB16878@noisy.programming.kicks-ass.net>

On Wed, Mar 05, 2025 at 02:43:15PM +0100, Peter Zijlstra wrote:
> Hi Kees,
> 
> I keep getting hit by the struct_size() brigade, and I keep having
> trouble reading that macro.
> 
> I had a wee poke and ended up with the below, WDYT?

Ah, and to clarify, this is just for readability? (There have been
some tweaks to reduce the macro depths and other things in other areas,
so I just wanted to check that wasn't, or was, part of the rationale.)

> (I also tried to create a __must_be_flex_array(), but utterly failed :/)

I spent a lot of time trying to find something for that too. :( If you
do ever find it, please share! :)

> ---
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 0c7e3dcfe867..2123d0e238bb 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -352,9 +352,10 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
>  #define flex_array_size(p, member, count)				\
> -	__builtin_choose_expr(__is_constexpr(count),			\
> -		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
> -		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
> +	(__must_be_array((p)->member) +					\
> +	 __builtin_choose_expr(__is_constexpr(count),			\
> +			       sizeof(*(p)->member) * (count),		\
> +			       size_mul(sizeof(*(p)->member), (count))))

For both, I need to double check that __must_be_array() is
always a constant expression. If not, we can't move it out of the
__builtin_choose_expr(). But if so, then yeah, this is nice.

>  
>  /**
>   * struct_size() - Calculate size of structure with trailing flexible array.
> @@ -367,10 +368,12 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   *
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
> -#define struct_size(p, member, count)					\
> -	__builtin_choose_expr(__is_constexpr(count),			\
> -		sizeof(*(p)) + flex_array_size(p, member, count),	\
> -		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
> +#define struct_size(p, member, count)					       \
> +	(__must_be_array((p)->member) +					       \
> +	 __builtin_choose_expr(__is_constexpr(count),			       \
> +			       sizeof(*(p)) + (sizeof((p)->member) * (count)), \

typo: above should be                        (sizeof(*(p)->member))

(hint, to test this code use "./tools/testing/kunit/kunit.py run overflow")

But yeah, this passes the overflow tests which include the constant
expression tests, so __must_be_array() is a constant expression. Whee :)

> +			       size_add(sizeof(*(p)),			       \
> +					size_mul(sizeof(*(p)->member), count))))

This one I'm not such a fan of. It feels wrong to not use
flex_array_size() here -- we're performing exactly the same
calculation. But it's possible this has cpp complexity reduction
benefits from avoiding the stacking of __builtin_choose_expr() and
__must_be_array() macros...

So, yeah, I think I could live with this. :) Especially if it means we can
start using struct_size() in code you look at. :P

But please include this selftest update too. Since your patch splits the
dependency between struct_size() and flex_array_size(), I'd like to test
them separately now:


diff --git a/lib/tests/overflow_kunit.c b/lib/tests/overflow_kunit.c
index 894691b4411a..ee29f1f8f528 100644
--- a/lib/tests/overflow_kunit.c
+++ b/lib/tests/overflow_kunit.c
@@ -705,18 +705,28 @@ struct __test_flex_array {
 
 static void overflow_size_helpers_test(struct kunit *test)
 {
-	/* Make sure struct_size() can be used in a constant expression. */
-	u8 ce_array[struct_size_t(struct __test_flex_array, data, 55)];
+	/* Verify struct_size() family can be used as constant expressions. */
 	struct __test_flex_array *obj;
+	u8 ce_flex[flex_array_size(obj, data, 22)];
+	u8 ce_array[struct_size(obj, data, 55)];
+	u8 ce_array_t[struct_size_t(typeof(*obj), data, 99)];
 	int count = 0;
 	int var;
 	volatile int unconst = 0;
 
-	/* Verify constant expression against runtime version. */
+	/* Verify constant expression versions against runtime versions. */
+	var = 22;
+	OPTIMIZER_HIDE_VAR(var);
+	KUNIT_EXPECT_EQ(test, sizeof(ce_flex), flex_array_size(obj, data, var));
+
 	var = 55;
 	OPTIMIZER_HIDE_VAR(var);
 	KUNIT_EXPECT_EQ(test, sizeof(ce_array), struct_size(obj, data, var));
 
+	var = 99;
+	OPTIMIZER_HIDE_VAR(var);
+	KUNIT_EXPECT_EQ(test, sizeof(ce_array_t), struct_size_t(typeof(*obj), data, var));
+
 #define check_one_size_helper(expected, func, args...)	do {	\
 	size_t _r = func(args);					\
 	KUNIT_EXPECT_EQ_MSG(test, _r, expected,			\



(And note that the above patch is against -next, where the lib/ kunit
tests have moved into the lib/tests/ subdirectory now.)

-Kees

-- 
Kees Cook
