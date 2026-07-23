Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5323BCD04;
	Thu, 23 Jul 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789092; cv=none; b=P/mVmydBLIoLj4ttuCHuUN/w7TwRXe8Mi+Yo4OZ7JOuW7TJhGBf+dySnwecFuUNGHMZb0BKvmfeTVOOvycO/Bhebl/og0I6sOatjoiyvd7u4k2VJp+4S/g0x95HrcH+pKoJexKAdG1EcfssZemoByiGQkYV54F4sHcVX2VYhlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789092; c=relaxed/simple;
	bh=dN+lG9a/eWWNVbUWn3qyRWEddvwqXYRCJp9w+fT+QyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4TX10iykrShhtYSe5QZI82uxODGE5mH03X0a73mekSmHJpDIsWeCOpZR+2fjXjaO0LlJIMJrtK0qIalG1YGkoipItnkUHu81VxNayAmL8IcD+xaLpRo82LXMCHpUHpQqSOT+MQehFSyZOfwdHUqKzMBcYVFggqq59Obvot1Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: faaebaf2866111f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e242e081-c494-4aa3-a82d-733feacf8b5a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c4a2b4a85359be396a6d2c449ef42505,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: faaebaf2866111f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 839911132; Thu, 23 Jul 2026 14:44:40 +0800
Message-ID: <3355f1cc-4059-475e-9e52-4bca9b10ed98@kylinos.cn>
Date: Thu, 23 Jul 2026 14:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: string: add strnlen SIZE_MAX test coverage
To: Gao Rui <gao.rui@zte.com.cn>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org
References: <20260722064037.1111467-1-gao.rui@zte.com.cn>
 <20260722064037.1111467-3-gao.rui@zte.com.cn>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260722064037.1111467-3-gao.rui@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/7/22 14:40, Gao Rui wrote:
> Extend string_test_strnlen to validate strnlen behavior with
> SIZE_MAX input:
> 
> - Add explicit test case for strnlen(s, SIZE_MAX).
> - Ensure fallback to generic path returns correct length when
>   string has no NUL terminator.
> - Complements existing tests for non-terminated strings and
>   boundary conditions.
> 
> This improves KUnit coverage for extreme inputs and verifies
> the correctness of the new fallback logic in strnlen.S.
> 
> Signed-off-by: Gao Rui <gao.rui@zte.com.cn>
> ---
>  lib/tests/string_kunit.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b027..8e2e8980aa75 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
> @@ -155,6 +155,16 @@ static void string_test_strnlen(struct kunit *test)
>  
>  	for (size_t offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
>  		for (size_t len = 0; len <= STRING_TEST_MAX_LEN; len++) {
> +			/* Test strings without NUL terminator */
> +			s = buf + buf_size - offset - len;
> +			if (len > 0)
> +				KUNIT_EXPECT_EQ(test, strnlen(s, len - 1), len - 1);
> +			if (len > 1)
> +				KUNIT_EXPECT_EQ(test, strnlen(s, len - 2), len - 2);
> +
> +			KUNIT_EXPECT_EQ(test, strnlen(s, len), len);
> +
> +			/* Test strings with NUL terminator */
>  			s = buf + buf_size - 1 - offset - len;
>  			s[len] = '\0';
>  
> @@ -169,6 +179,9 @@ static void string_test_strnlen(struct kunit *test)
>  			KUNIT_EXPECT_EQ(test, strnlen(s, len + 2), len);
>  			KUNIT_EXPECT_EQ(test, strnlen(s, len + 10), len);
>  
> +			/* Test Count overflow fallback */
> +			KUNIT_EXPECT_EQ(test, strnlen(s, SSIZE_MAX), len);
> +
>  			s[len] = 'A';
>  		}
>  	}

A similar patch has already been submitted:

https://lore.kernel.org/all/20260526085913.429049-1-min_halo@163.com/

-- 
With Best Regards,
Feng Jiang

