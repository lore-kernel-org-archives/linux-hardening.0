Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179B3191C9;
	Wed, 28 Jan 2026 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639955; cv=none; b=L/U3G1mVita+hFY/dn4jJrCiIpV6CuOmMGW+FhtTUNJH78xE19+JXcWlZNCovwzqIJGXwYdfE7Nz0/hdlSvGtsvEOu1YYBGoYEl+nmE5i0ahMx9UxqmJAEG+A1SFyYLhEoDuI6TViTUkZTBoneKEF5AzfYzCFnEHCZ3DT1U1ioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639955; c=relaxed/simple;
	bh=+Qo0hUtbp6GPRhlGZrjzGk3yEHHY8vN3Rk5lovqMKeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV0M8BNPoZPKVUQ1xZhBdLAy4B45knqFQnQ4eVoNP7TWItpaOA9mJROgICXpZGLcmpQJwwneGiLAMmmwtaPxBoAjRtPL558kER67bu2AihqRV1KND5mmr5ropT8AR9cayhniOzykOk9lD+Enwxm0BSqUGBNp/ASQBM21lO+7dUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoe5guXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoe5guXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B7BC4CEF1;
	Wed, 28 Jan 2026 22:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639954;
	bh=+Qo0hUtbp6GPRhlGZrjzGk3yEHHY8vN3Rk5lovqMKeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoe5guXZgqiwHfkzvcyGwChsttEGzY8XkQAQGbi+GVyMpTmaL9A50P2fKJkq1Ud/p
	 W1LNZoTZbltT2WEw70+ZaFoJrjI/FmyZ8fHktzXwjQUFEtxQJmOizUBhrFp8Mb5yHj
	 NYCENS6FTRdjzLmG5B3zAo3o7urcoqQErGRaCO1Npy5N5maFNmJaaTHbNWKdXumg0w
	 iKnU6v2CUeiFR3lVO8ZSadcj2RfCJJmdyB8NbH+m9eDDJef8qiOZkMfFrCTShZDcgL
	 qWypr76X7QxjjtRPuQA9tEzQS083eLdv3ipGuRDv2zU6QSOgreU+SzC35YqbLvadk3
	 19la0D8Df3KAQ==
Date: Wed, 28 Jan 2026 14:39:14 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, andy@kernel.org,
	ebiggers@kernel.org, martin.petersen@oracle.com,
	sohil.mehta@intel.com, charlie@rivosinc.com,
	conor.dooley@microchip.com, samuel.holland@sifive.com,
	linus.walleij@linaro.org, nathan@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 1/8] lib/string_kunit: add correctness test for
 strlen()
Message-ID: <202601281437.F327FC61@keescook>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
 <20260127012558.40025-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127012558.40025-2-jiangfeng@kylinos.cn>

On Tue, Jan 27, 2026 at 09:25:51AM +0800, Feng Jiang wrote:
> Add a KUnit test for strlen() to verify correctness across
> different string lengths and memory alignments.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> Acked-by: Andy Shevchenko <andy@kernel.org>
> Tested-by: Joel Stanley <joel@jms.id.au>
> ---
>  lib/tests/string_kunit.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index f9a8e557ba77..bc5130c6e5e9 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
> @@ -17,6 +17,9 @@
>  #define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
>  #define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
>  
> +#define STRING_TEST_MAX_LEN	128
> +#define STRING_TEST_MAX_OFFSET	16
> +
>  static void string_test_memset16(struct kunit *test)
>  {
>  	unsigned i, j, k;
> @@ -104,6 +107,28 @@ static void string_test_memset64(struct kunit *test)
>  	}
>  }
>  
> +static void string_test_strlen(struct kunit *test)
> +{
> +	const size_t buf_size = STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1;
> +	size_t len, offset;
> +	char *s;
> +
> +	s = kunit_kzalloc(test, buf_size, GFP_KERNEL);

One aspect of "correctness" that we might want to include here is making
sure we don't have any implementations that over-read. To that end,
perhaps this test can put the string at the end of a vmalloc allocation
(so that the end of the string is right up against an unallocated memory
space).

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
> +
> +	memset(s, 'A', buf_size);
> +	s[buf_size - 1] = '\0';
> +
> +	for (offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
> +		for (len = 0; len <= STRING_TEST_MAX_LEN; len++) {
> +			s[offset + len] = '\0';
> +			KUNIT_EXPECT_EQ_MSG(test, strlen(s + offset), len,
> +				"offset:%zu len:%zu", offset, len);
> +			s[offset + len] = 'A';
> +		}
> +	}
> +}

It would require building the string backwards here. Or maybe we just
need a separate test for the over-read concerns?

Thoughts?

-Kees

-- 
Kees Cook
