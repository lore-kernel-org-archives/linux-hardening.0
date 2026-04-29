Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B79149C7B
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472875; cv=none; b=eXRA81COngVR/pxuCmI/QhO0baNCH3cr9XWir8f7gL+VYSSe1BuZSyJnm/oVPggYGybTSvpXe/tnjmC/sYibhjoRjQBv6tfQvcpjQbj0viOYEFYzAxV0dRlbfhyz1/pqu8DSH1FY3k/ljoNx96h0Ps2ztXOcbFrAvHFH9T4yVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472875; c=relaxed/simple;
	bh=F3PVZBZmNefwkqlKIjOUbFnAYv8PA6YsXVkn7/L/i0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6haK/UShOQVHjIxzGRQkbz/IJMuWEb4An7qNKrmCqmkviGh/swn64zp9YJnLqbLoY7XTPQTAyN+bsuwrbXTHoGon0nRY6ipn2jyY5JZM+u+Kxf45W3+aPLc2qPxh7CJObpSTiH4EH8SwyqoDfQoIWrNGQ+Y297SExTxSX0LHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1CtxZVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1CtxZVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF5CC19425;
	Wed, 29 Apr 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472875;
	bh=F3PVZBZmNefwkqlKIjOUbFnAYv8PA6YsXVkn7/L/i0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H1CtxZVHfBOutby2kB0KcUf8Gk/UWp5/ZLYbImHPIbrS7Co6CWhf58bieD2lEbI5G
	 97Yk1/kPcX3+93H4Fwsk1xoKu5gbMxgjTvUd9C8eVrYKmfXmSYrxp9sucqtk6btXoj
	 gY/x2IxDF8YgbWXJ+78qMLS4NRG1C7FgHBznAnC9F3raesvvg84H8Ge9H1ne4b/Eku
	 1UdnhHAOkzawYUlTpBntxG7hedJTEOBfeyy6Y1jWzOOSZtHSqVVVw2URXCTmKNyh21
	 Lpqar+d97OoG+86S5v0owdL0YMSY+UyedcHv0RTeaQmXeQlYaXVrQvKajadocsN7IB
	 kIqgU4u3CFRag==
Message-ID: <bdfe4f8b-02f1-4331-a07a-eca2b7de1063@kernel.org>
Date: Wed, 29 Apr 2026 16:27:52 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fortify_test_known_sizes: EXPECTATION FAILED at
 lib/tests/fortify_kunit.c:90 (v7.0.2, ppc)
To: Erhard Furtner <erhard_f@mailbox.org>, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
References: <f45fd960-335c-4761-9590-ff8eccb62e9a@mailbox.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <f45fd960-335c-4761-9590-ff8eccb62e9a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/04/2026 à 12:17, Erhard Furtner a écrit :
> Greetings!
> 
> Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 at running 
> fortify_kunit test:
> 
> [...]
> KTAP version 1
> 1..1
>      KTAP version 1
>      # Subtest: fortify
>      # module: fortify_kunit
>      1..26
>      # fortify_test_known_sizes: EXPECTATION FAILED at lib/tests/ 
> fortify_kunit.c:90
>      Expected ({ char *__p = (char *)(stack); size_t __ret = 
> (~(size_t)0); const size_t __p_size = 
> __builtin_dynamic_object_size(stack, 1); if (__p_size != (~(size_t)0) && 
> __builtin_constant_p(*__p)) { size_t __p_len = __p_size - 1; if 
> (__builtin_constant_p(__p[__p_len]) && __p[__p_len] == '\0') __ret = 
> __builtin_strlen(__p); } __ret; }) == 5, but
>          ({ char *__p = (char *)(stack); size_t __ret = (~(size_t)0); 
> const size_t __p_size = __builtin_dynamic_object_size(stack, 1); if 
> (__p_size != (~(size_t)0) && __builtin_constant_p(*__p)) { size_t 
> __p_len = __p_size - 1; if (__builtin_constant_p(__p[__p_len]) && 
> __p[__p_len] == '\0') __ret = __builtin_strlen(__p); } __ret; }) == 
> 4294967295 (0xffffffff)
>      not ok 1 fortify_test_known_sizes

I have the same on QEMU with pmac32_defconfig + FORTITY + KUNIT ...

Apparently it is due to __builtin_constant_p(*__p) returning FALSE, if I 
understand correctly it is expected that it returns TRUE.

This is with GCC 15.2

Christophe


>      ok 2 fortify_test_control_flow_split
>      ok 3 fortify_test_alloc_size_kmalloc_const
>      ok 4 fortify_test_alloc_size_kmalloc_dynamic
>      ok 5 fortify_test_alloc_size_vmalloc_const
>      ok 6 fortify_test_alloc_size_vmalloc_dynamic
>      ok 7 fortify_test_alloc_size_kvmalloc_const
>      ok 8 fortify_test_alloc_size_kvmalloc_dynamic
>      ok 9 fortify_test_alloc_size_devm_kmalloc_const
>      ok 10 fortify_test_alloc_size_devm_kmalloc_dynamic
>      ok 11 fortify_test_realloc_size
>      ok 12 fortify_test_strlen
>      ok 13 fortify_test_strnlen
>      ok 14 fortify_test_strcpy
>      ok 15 fortify_test_strncpy
>      ok 16 fortify_test_strscpy
>      ok 17 fortify_test_strcat
>      ok 18 fortify_test_strncat
>      ok 19 fortify_test_strlcat
>      ok 20 fortify_test_memcpy
>      ok 21 fortify_test_memmove
>      ok 22 fortify_test_memscan
>      ok 23 fortify_test_memchr
>      ok 24 fortify_test_memchr_inv
>      ok 25 fortify_test_memcmp
>      ok 26 fortify_test_kmemdup
> # fortify: pass:25 fail:1 skip:0 total:26
> # Totals: pass:25 fail:1 skip:0 total:26
> 
> 
> Suppose this may be a ppc/BE specific test failure as I don't get it on 
> my Thinkpad T60 (x86).
> 
> Full dmesg and kernel .config available on request.
> 
> Greetings,
> Erhard
> 

