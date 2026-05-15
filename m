Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7643A961B;
	Fri, 15 May 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854519; cv=none; b=Zz8JRPIYt8jXb8uQZC/+0T0iDf43Tpx0yenChD1HnlQ4d+KHxkxtf7Vhy/7Bxjv9EW34S3tB3J0/D3k9JV3dvaRS218KbcvcsKcxXQUeXdUJTuDbMM9dkp/PAuGobswl0XNH+5rjCQFIHilSOWQhG/SqzCsMs90rWjfOMx5C/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854519; c=relaxed/simple;
	bh=q3ddQQ7Y/h8yP7ksmWTHC7sGDBsS3439/VlNrRezglo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHgZpXDepViX7b8Pa/L+FNiipFFbvuHlAejhMeq5vrN23YJimwGesD1n6Le4pj6pL5QpU/ZX2kocxWV0bEeqlFU0bOs2GGzVOTNoJFupcOPAzELpZ1yIO2wrcq0hCevgiCrpivigXkB+Up7X2LfDda6fmfHkjek7KiFTd/u2R2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Qmz6vOf3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Qmz6vOf3"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6EB48410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778854517; bh=hhlVW1p0W18gTXBj78aOHGg/y0iUqQRc1l2EOM9d6wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qmz6vOf3ByCXNMOoWjskT0XVJP09PKMACMQBlVgMRlCqvYt+BeNbWmF8bE0P4OmSe
	 dzHj0L+xwXoiy25Es7a196GrHl1pgW19//mJwYoKNKuwUupBKbdf5WF2qpi3eqqdxs
	 4SKqC6uwPe9dpsTpbI15OoYkVc6r9zMWFTouK2I1rh1TPkqLDmG3rxEWeGmT/NYG0F
	 Q3Jxu5wp1bsknWKaZjSpapUgD+9ezcT6uBr9Hd2+55PYyqJ5ulcZod2JFg7V6I/Wuy
	 MZm9MfD9vcxggYJB00+uBt1cc7QIHkgUdB1p/+lnHlfd1i7MQ8s0ywRkfXSouRRusP
	 KOluXT3GVIhZQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6EB48410B5;
	Fri, 15 May 2026 14:15:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 krzk@kernel.org, kernel-team@android.com, Tudor Ambarus
 <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] docs: kernel-doc: python: strip __counted_by_ptr macro
In-Reply-To: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>
References: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>
Date: Fri, 15 May 2026 08:15:16 -0600
Message-ID: <87qzncrc7f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

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
> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  tools/unittests/test_cmatch.py        | 1 +
>  2 files changed, 2 insertions(+)

Applied, thanks.

jon
