Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4430FC23;
	Wed,  6 May 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106263; cv=none; b=O7lpkOeJoGeSHqZB6gDeApF/IrVkGVAkcMukr0JE03bQsn4lyvFGe0MJxpPts/Rr1yTkHdzZ2I+mgLMPtjiTS+KI/9WFpO5z61FhZJX6eBRSPjxJCYEQAgf1+cl1nQbmcbhs8xbxULIZz8v+YkEXdpJMa2yUJxHvhHQA/rLFd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106263; c=relaxed/simple;
	bh=C3mebG4xQF/8bmrtHQtaU2n+DtqkjaRZNTf90X58E2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlBJinaQXz6+RP0KHG1pu+H67BcV/wE5hAra0TptlMkOrLa1MPgXWZm0RO2EA3p/tNk42UJKWa/dX2SZPBwWtE+Sm5eqGUkaQvvKpJSVDB+r+xGu5loG5yCgN/VL4sX0MEAp74r3SoEAs4YEvZ2mKo5TuFtZwfSrnNGqUVq5G80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NfArlEGd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NfArlEGd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vi0t2C7a2R6SnUYU4KKYj9AxGRg+DnRXadjNE3N8EBA=; b=NfArlEGdAWPcCoH/FJoIcjd/Xx
	v0VGf6G9ZMr/C3p0KzULi7+62TDDz7ebLBBgAmDOAZQNtgc9Rd3hxGYM8n1/c7WRjxMH5TdUYHS1Y
	xYuKQj1ejx357aaKz0hG9dse8x1UPxgU3dN29LjnqHee5FqusRcl0K0JAu/xagKnH3iYfRLTSM26w
	4eE0aukax1J5xQV1gRZfrsGnhPrhv9J0Iw2g8DJbW+jVwOLNsChttgsUyfQ0TL1GW5NgAISwcvxYn
	Hm/a6fJOepDWp7SOi88ubhonH1e3+02KScPOHGIr3nWDSfjs808TNY4p0Fu5a9XRhhEVxpn1eg6JL
	NdTQZrXw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKkfF-00000002BjH-2T1G;
	Wed, 06 May 2026 22:24:21 +0000
Message-ID: <927e9642-f5b5-41e7-aaaf-0a263dfb82a3@infradead.org>
Date: Wed, 6 May 2026 15:24:20 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kernel-doc: python: strip __counted_by_ptr macro
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 krzk@kernel.org, kernel-team@android.com
References: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 4:04 AM, Tudor Ambarus wrote:
> The `__counted_by_ptr` macro was recently introduced [1] to extend
> bounds checking semantics to standard dynamically allocated pointers.
> 
> However, the new Python implementation of kernel-doc does not currently
> recognize it as a compiler attribute. When kernel-doc encounters a
> struct member annotated with this macro, it fails to parse the variable
> name correctly, resulting in false-positive warnings like:
> 
>   Warning: ... struct member '__counted_by_ptr(cmdcnt' not described
> 
> Add `__counted_by_ptr` to the `struct_xforms` regex list so it gets
> safely stripped out during the parsing phase, mirroring the existing
> behavior for `__counted_by`. Update the corresponding unit tests.
> 
> Link: https://git.kernel.org/torvalds/c/150a04d817d8 [1]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  tools/unittests/test_cmatch.py        | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index f6ea9efb11ae..118156ea8cd2 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -29,6 +29,7 @@ class CTransforms:
>          (CMatch("__aligned"), ""),
>          (CMatch("__counted_by"), ""),
>          (CMatch("__counted_by_(le|be)"), ""),
> +        (CMatch("__counted_by_ptr"), ""),
>          (CMatch("__guarded_by"), ""),
>          (CMatch("__pt_guarded_by"), ""),
>          (CMatch("__packed"), ""),
> diff --git a/tools/unittests/test_cmatch.py b/tools/unittests/test_cmatch.py
> index 7b996f83784d..109141cd2ab8 100755
> --- a/tools/unittests/test_cmatch.py
> +++ b/tools/unittests/test_cmatch.py
> @@ -320,6 +320,7 @@ class TestSubWithLocalXforms(TestCaseDiff):
>          (CMatch('__aligned'), ' '),
>          (CMatch('__counted_by'), ' '),
>          (CMatch('__counted_by_(le|be)'), ' '),
> +        (CMatch('__counted_by_ptr'), ' '),
>          (CMatch('__guarded_by'), ' '),
>          (CMatch('__pt_guarded_by'), ' '),
>  
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260506-kdoc-__counted_by_ptr-1e206f3f1dc1
> 
> Best regards,

-- 
~Randy
