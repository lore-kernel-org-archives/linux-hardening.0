Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04C32ED5C;
	Thu, 14 May 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775552; cv=none; b=VPsTW8wwMY68Yjc51YgkGkcXK4GVGJ254i1a4t8lVR1MKJdZ0ijkAVkuuZ946YD/HQb0yoGQoZtnNe8EwvLNMZAEX5+I95CQgiCLk9gZgX9s1/nMTBUHx2jT+Hj5CrUdqL5qfL5qwkAUotTHkyeTWJeYYWsU84XWl1yPF8EsQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775552; c=relaxed/simple;
	bh=F5wvXsrQ072xrenn6NhqUcsSK80NMgYOdkf79Wcyit0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvXLNGe7kLgTPEfB11ZeIuSfaeOI3+LMEVOvMpVDomDPi41oN+fkiDTrDQioyFhe2CBNjyyuHnCDoy9UkLA43A7W5VCCEI6hA9WJmiGKx24/Ob3eRCiX7akV4SQFa7DGJ0SjvqXAphfYy83AusCp0/+UUK08Vf1fybH/xTZth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyI7aUt5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyI7aUt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D67DC2BCB3;
	Thu, 14 May 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775552;
	bh=F5wvXsrQ072xrenn6NhqUcsSK80NMgYOdkf79Wcyit0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyI7aUt5Odd7cxM308rIqtrnCHzkcvK8kpOQGBf2iNBUalcyubX6bYqabIhQxwMzB
	 QclfOAr+oIg93PZSuYlXikSzrYk1FfydLDzroPOpFSeKdvE1jnfHQKyNbzpIXLkhdl
	 ZHCT628QYWZmbRHmUdpUrTxQ3hbRFj2JL7o5SYrBcsXNA6bN6EcG+TB5cPZehfRdvd
	 VxJ9KytgCshu+2ddvSQLEW5epkaooiLDyxTylDhU4UodHc1jAwawOyzxKSeobMbiGx
	 mSKo1MF9zTmmrtBUXPzpMHzIcPlDdTadQDA6KTs8hADWt5bLnetDS9Y+Y7auYiBNGl
	 PoDqL6LpF1Eag==
Date: Thu, 14 May 2026 09:19:11 -0700
From: Kees Cook <kees@kernel.org>
To: Milan Tripkovic <milant2002@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Shevchenko <andy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] lib/string_kunit: extend benchmarks and unit test
 to memcmp()
Message-ID: <202605140916.09FBB1A4@keescook>
References: <20260514121359.931999-1-milant2002@gmail.com>
 <20260514121359.931999-3-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514121359.931999-3-milant2002@gmail.com>

On Thu, May 14, 2026 at 02:13:58PM +0200, Milan Tripkovic wrote:
> From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> 
> Extend the string benchmarking suite to include memcmp().
> Extend the string unit test to include memcmp().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605140827.Qg1DZpcB-lkp@intel.com/
> Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> ---
>  lib/tests/string_kunit.c | 106 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b027..d0bad40a719a 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
> @@ -881,6 +881,110 @@ static void string_bench_strrchr(struct kunit *test)
>  	STRING_BENCH_BUF(test, buf, len, strrchr, buf, '\0');
>  }
>  
> +static void string_test_memcmp(struct kunit *test)
> +{
> +	const int max_offset = 16;
> +	const int max_len = 32;
> +	const int buf_size = max_offset + max_len + 32;
> +	u8 *buf1, *buf2;
> +	int i, j, len, k;
> +
> +	buf1 = kunit_kzalloc(test, buf_size, GFP_KERNEL);
> +	buf2 = kunit_kzalloc(test, buf_size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf1);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf2);
> +
> +	for (i = 0; i < max_offset; i++) {
> +		for (j = 0; j < max_offset; j++) {
> +			for (len = 0; len <= max_len; len++) {
> +				memset(buf1, 'A', buf_size);
> +				memset(buf2, 'A', buf_size);
> +				KUNIT_EXPECT_EQ_MSG(test, memcmp(buf1 + i, buf2 + j, len), 0,
> +						    "Should be equal: i:%d j:%d len:%d", i, j, len);
> +				for (k = 0; k < len; k++) {
> +					memset(buf1, 'A', buf_size);
> +					memset(buf2, 'A', buf_size);
> +					buf2[j + k] = 'B';
> +					int res = memcmp(buf1 + i, buf2 + j, len);
> +
> +					KUNIT_EXPECT_NE_MSG(test, res, 0,
> +							    "Should detect difference at k:%d (i:%d j:%d len:%d)",
> +						k, i, j, len);
> +
> +					if (buf1[i + k] < buf2[j + k])
> +						KUNIT_EXPECT_LT(test, res, 0);
> +					else
> +						KUNIT_EXPECT_GT(test, res, 0);
> +				}
> +			}
> +		}
> +	}
> +}

This looks good, thanks!

> +#if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
> +static void string_bench_memcmp(struct kunit *test)
> +{
> +	char *buf1, *buf2;
> +	size_t lengths[] = { 1, 7, 8, 16, 32, 64, 128, 512, 1024, 4096};
> +	int offsets[] = {0, 1, 3, 7};
> +	const size_t max_len = 4096 + 64;

I think I'd prefer, instead of a ifdef stub, to do:

        if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))
	        kunit_skip(test, "CONFIG_STRING_KUNIT_BENCH not enabled")

here.

> +
> +	buf1 = vmalloc(max_len);
> +	buf2 = vmalloc(max_len);
> +
> +	if (!buf1 || !buf2) {
> +		vfree(buf1);
> +		vfree(buf2);
> +		kunit_err(test, "vmalloc failed\n");
> +		return;
> +	}
> +
> +	memset(buf1, 'A', max_len);
> +	memset(buf2, 'A', max_len);
> +
> +	for (int i = 0; i < 100000; i++)
> +		(void)memcmp(buf1, buf2, 4096);
> +
> +	for (int o = 0; o < ARRAY_SIZE(offsets); o++) {
> +		int off = offsets[o];
> +
> +		for (int i = 0; i < ARRAY_SIZE(lengths); i++) {
> +			size_t len = lengths[i];
> +			char *p1 = buf1;
> +			char *p2 = buf2 + off;
> +
> +			u32 iterations = (len < 512) ? 100000 : 10000;
> +
> +			for (u32 j = 0; j < iterations; j++) {
> +				(void)memcmp(p1, p2, len);
> +				barrier();
> +			}
> +
> +			u64 elapsed = STRING_BENCH(iterations, memcmp, p1, p2, len);
> +			u64 ns_per_call = div_u64(elapsed, iterations);
> +			u64 mbps = len ? div_u64((u64)len * iterations * 1000,
> +									 elapsed) : 0;
> +
> +			if (off == 0) {
> +				kunit_info(test, "bench_memcmp_aligned: len=%-4zu: %llu MB/s (%llu ns/call)\n",
> +					   len, mbps, ns_per_call);
> +			} else {
> +				kunit_info(test, "bench_memcmp_unaligned(off=%d): len=%-4zu: %llu MB/s (%llu ns/call)\n",
> +					   off, len, mbps, ns_per_call);
> +			}
> +		}
> +	}
> +
> +	vfree(buf1);
> +	vfree(buf2);
> +}
> +#else
> +static void string_bench_memcmp(struct kunit *test)
> +{
> +	kunit_skip(test, "not enabled");
> +}
> +#endif
> +
>  static struct kunit_case string_test_cases[] = {
>  	KUNIT_CASE(string_test_memset16),
>  	KUNIT_CASE(string_test_memset32),
> @@ -910,6 +1014,8 @@ static struct kunit_case string_test_cases[] = {
>  	KUNIT_CASE(string_bench_strnlen),
>  	KUNIT_CASE(string_bench_strchr),
>  	KUNIT_CASE(string_bench_strrchr),
> +	KUNIT_CASE(string_test_memcmp),
> +	KUNIT_CASE_SLOW(string_bench_memcmp),
>  	{}
>  };
>  
> -- 
> 2.43.0
> 

-- 
Kees Cook
