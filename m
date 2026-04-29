Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567D325707
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474569; cv=none; b=W7wgeWViWorszUlohvlj2T9Uwagic4lvGJuK0YkBwNphAgPkPlrcC/7W4BT3bAIKNlTKARnY0Ie7BtIfucCqUHjUwf+vPUTA6Rc9NATMcTodKm28CTvpsrwt1rEiflmGn2YG2Fecc7Bj0IOABGdENgIw7HxdBoY4KuiJ6z05+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474569; c=relaxed/simple;
	bh=CSOdFd7szD0Ao2hLSpmBMSj30LDJUzA9HwyCrM7mFHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZlsOaH47U0IV5cJJ2IkOvVPCeds1D7ewj+gsbN/9FedwIVnqzORy554nuM6ME6JgR7oYMUatyNKM2LR6+3kilHPGkx/KG/QwekZginuAyFmJ9sqpfiGyiIncqQXVX4PiWhYStILeKl+iKPiS14KzMRfq8iE++yvrsXyFbz5qj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmhLNwPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmhLNwPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A35C19425;
	Wed, 29 Apr 2026 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474569;
	bh=CSOdFd7szD0Ao2hLSpmBMSj30LDJUzA9HwyCrM7mFHE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZmhLNwPCzDGJ+arpjX/REC5icJ2Ri121oKkTKnsEizrLsLOE0N9ruH0+blxCJ0LB9
	 Y02Um7/DMSfFqkuKD/x3CFV9Ev7cXtjw1UKSfxRJMOa0gXelaJcysFoSIOuY0mjek2
	 exllRRmPlOrTFrPEPwxevy99PBRROS4q+P8l+Dzff+ivsGhJ0G8GY8r0ObGkhg5FzL
	 LyX8ECyspMDfX51u3V7tk1Baw0PjirR51qlJtPJW8SqInAFa9z/46rU31e1lMgE5lK
	 seiZfHePVXeLK1ofRDMLLO1JeV1BO+tls7GmQZ9RfNzX42+Y9qgFKX0mzsw+g4hT7i
	 f41/6U4FINpSg==
Message-ID: <87c448ad-4ee0-4605-8a5f-7c7661a156a2@kernel.org>
Date: Wed, 29 Apr 2026 16:56:05 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
To: Erhard Furtner <erhard_f@mailbox.org>, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Content-Language: fr-FR
In-Reply-To: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/04/2026 à 13:45, Erhard Furtner a écrit :
> Greetings!
> 
> Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 via 'modprobe -v 
> kunit_iov_iter':
> 
> [...]
> KTAP version 1
>   1..1
>       KTAP version 1
>       # Subtest: iov_iter
>       # module: kunit_iov_iter
>       1..12
>       # iov_kunit_copy_to_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 1 iov_kunit_copy_to_kvec

This happens in alloc_pages_bulk_noprof(), due to

	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
	if (!pcp)
		goto failed;

Because:

#ifdef CONFIG_SMP
[...]
/*
  * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails 
and thus
  * is not compatible with our locking scheme. However we do not need 
pcp for
  * scalability in the first place, so just make all the trylocks fail 
and take
  * the slow path unconditionally.
  */
#else
#define pcp_spin_trylock(ptr)		\
		NULL


So apparently it is expected that alloc_pages_bulk() returns 1 on non-SMP.

Christophe

>       # iov_kunit_copy_from_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 2 iov_kunit_copy_from_kvec
>       # iov_kunit_copy_to_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 3 iov_kunit_copy_to_bvec
>       # iov_kunit_copy_from_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 4 iov_kunit_copy_from_bvec
>       # iov_kunit_copy_to_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 5 iov_kunit_copy_to_folioq
>       # iov_kunit_copy_from_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 6 iov_kunit_copy_from_folioq
>       # iov_kunit_copy_to_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 7 iov_kunit_copy_to_xarray
>       # iov_kunit_copy_from_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 8 iov_kunit_copy_from_xarray
>       # iov_kunit_extract_pages_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 9 iov_kunit_extract_pages_kvec
>       # iov_kunit_extract_pages_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 10 iov_kunit_extract_pages_bvec
>       # iov_kunit_extract_pages_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 11 iov_kunit_extract_pages_folioq
>       # iov_kunit_extract_pages_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 12 iov_kunit_extract_pages_xarray
>   # iov_iter: pass:0 fail:12 skip:0 total:12
>   # Totals: pass:0 fail:12 skip:0 total:12
>   not ok 1 iov_iter
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

