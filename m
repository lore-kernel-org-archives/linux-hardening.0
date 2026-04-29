Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07232720C
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457891; cv=none; b=TdKT4u+2kn2HnE4+QVB2tpVCtSwfIVY0Y5yQhmYg5D02doE7csherYv920osRKQ3GqaD1+mXoMyvcVVxzUaXoDLomeHuNmD+r0WJfeqjtIIothwD0skO4pJpxy33hVnx9/4TAPJ+Y57Rq6turBkbIpjytaK5QTOr3ZQN7Dw/04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457891; c=relaxed/simple;
	bh=OlaILIy2hW4ldwTuO8Z2wJqU3H81rh3D/91/KT7PRQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M8FZOeTBaM5PXrjC+DwPppGmXOS/04TyE7wZJinGSuJBGzzoeSffiVytVJqHEc9GoutOObAhQEKxtWKtHlduQoXyeq4V9dN1p6OK1EatNgY1UWq8XHrxL7GGT8FVX70cIctPS4E4xjiwdKBT9Hk4p+yzsWHvr5O4UcJEIc9CP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WJaaztFx; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WJaaztFx"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g5CtK269zz9vGr;
	Wed, 29 Apr 2026 12:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777457881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yl3S+f3STSDCEgzzf0rBEyoOYrRNmCDGnCoCO5wEQJA=;
	b=WJaaztFxIUZAAFLmCLpiwhxAqJKwPGlCERdO044yhI5FkFH031ra0/55nbrAGhYlW0uH6W
	LZCNEhlSyPUXDZT/YHXpxzGL0vpRBc97cJu96rlSjE9gawgP3vE/33c5Lgz9cLDZWc4/10
	VIT3KFQ7o+5ZyDmUGr7q20Ytw2/60FYPp29llzIFtX+rIbqPpW+4usgKnUIzlUGguoeoWx
	IFEMU/Vk13LcywyRLPl/Znm6pT5IVeqnJVgdkCtHhhu9czkkGGZwjfDOfuM87UJk9Sju6h
	R6RAxhAAdVSX/aWKAdIhZqykpy52wkDHEDnxQKXcnUEJOe39hBWhbmnEVrfTNg==
Message-ID: <f45fd960-335c-4761-9590-ff8eccb62e9a@mailbox.org>
Date: Wed, 29 Apr 2026 12:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: linux-hardening@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
From: Erhard Furtner <erhard_f@mailbox.org>
Subject: fortify_test_known_sizes: EXPECTATION FAILED at
 lib/tests/fortify_kunit.c:90 (v7.0.2, ppc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f665d335b0d2e075d32
X-MBO-RS-META: h7xis46hfirjohtwbznkzn46x93kcntz

Greetings!

Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 at running 
fortify_kunit test:

[...]
KTAP version 1
1..1
     KTAP version 1
     # Subtest: fortify
     # module: fortify_kunit
     1..26
     # fortify_test_known_sizes: EXPECTATION FAILED at 
lib/tests/fortify_kunit.c:90
     Expected ({ char *__p = (char *)(stack); size_t __ret = 
(~(size_t)0); const size_t __p_size = 
__builtin_dynamic_object_size(stack, 1); if (__p_size != (~(size_t)0) && 
__builtin_constant_p(*__p)) { size_t __p_len = __p_size - 1; if 
(__builtin_constant_p(__p[__p_len]) && __p[__p_len] == '\0') __ret = 
__builtin_strlen(__p); } __ret; }) == 5, but
         ({ char *__p = (char *)(stack); size_t __ret = (~(size_t)0); 
const size_t __p_size = __builtin_dynamic_object_size(stack, 1); if 
(__p_size != (~(size_t)0) && __builtin_constant_p(*__p)) { size_t 
__p_len = __p_size - 1; if (__builtin_constant_p(__p[__p_len]) && 
__p[__p_len] == '\0') __ret = __builtin_strlen(__p); } __ret; }) == 
4294967295 (0xffffffff)
     not ok 1 fortify_test_known_sizes
     ok 2 fortify_test_control_flow_split
     ok 3 fortify_test_alloc_size_kmalloc_const
     ok 4 fortify_test_alloc_size_kmalloc_dynamic
     ok 5 fortify_test_alloc_size_vmalloc_const
     ok 6 fortify_test_alloc_size_vmalloc_dynamic
     ok 7 fortify_test_alloc_size_kvmalloc_const
     ok 8 fortify_test_alloc_size_kvmalloc_dynamic
     ok 9 fortify_test_alloc_size_devm_kmalloc_const
     ok 10 fortify_test_alloc_size_devm_kmalloc_dynamic
     ok 11 fortify_test_realloc_size
     ok 12 fortify_test_strlen
     ok 13 fortify_test_strnlen
     ok 14 fortify_test_strcpy
     ok 15 fortify_test_strncpy
     ok 16 fortify_test_strscpy
     ok 17 fortify_test_strcat
     ok 18 fortify_test_strncat
     ok 19 fortify_test_strlcat
     ok 20 fortify_test_memcpy
     ok 21 fortify_test_memmove
     ok 22 fortify_test_memscan
     ok 23 fortify_test_memchr
     ok 24 fortify_test_memchr_inv
     ok 25 fortify_test_memcmp
     ok 26 fortify_test_kmemdup
# fortify: pass:25 fail:1 skip:0 total:26
# Totals: pass:25 fail:1 skip:0 total:26


Suppose this may be a ppc/BE specific test failure as I don't get it on 
my Thinkpad T60 (x86).

Full dmesg and kernel .config available on request.

Greetings,
Erhard
