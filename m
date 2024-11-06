Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72E1D2784;
	Wed,  6 Nov 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885987; cv=none; b=su8ioCIgVRhqpHMufn5Sv/stFy/U7Knd3hlLoLJRpoabelYw8BoLDg3hNSBM8FPI4ktvEDLOycvm+wdg3oP1igcgdFh6UR3usTd5ehz39TrOzQUqe5uBZePXa6yRGM8AkMlZWTcbD4uWNNMQkFkckL6fhw9UDj7JOyMVsPD5D2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885987; c=relaxed/simple;
	bh=HqkSHPNzNxfWq47hs/mKT9Od0KoWzw5n3XoycMQEAb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwU0pDGsPEMQPwMWheBIneI/XZTuA0rb3LwVSEUs+4J/tVp39Oj5LXpYvK3PGc6Qtb9dU4ICQCgr9xLkypLTw/qSkC4VMzXgTNwBgTxuR4Dw9U+UJCJFk+e2VXfOP7yXEfaA84+3Tjq7oLTZNhuymBlKgUyutZpW0s9RVf3BNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xk0Xv5Scnz9sRr;
	Wed,  6 Nov 2024 10:39:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlDylVDbi0Jl; Wed,  6 Nov 2024 10:39:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xk0Xv48Vfz9sRk;
	Wed,  6 Nov 2024 10:39:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7965A8B77B;
	Wed,  6 Nov 2024 10:39:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FLvIR2VzFJTV; Wed,  6 Nov 2024 10:39:43 +0100 (CET)
Received: from [192.168.232.102] (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 436038B77A;
	Wed,  6 Nov 2024 10:39:43 +0100 (CET)
Message-ID: <8dcc739a-3fd4-434c-995c-1dce33cefe6f@csgroup.eu>
Date: Wed, 6 Nov 2024 10:39:43 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Add __must_check to set_memory_...()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

Le 07/09/2024 à 17:40, Christophe Leroy a écrit :
> After the following powerpc commits, all calls to set_memory_...()
> functions check returned value.
> - Commit 8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and
> mark_initmem_nx()")
> - Commit f7f18e30b468 ("powerpc/kprobes: Handle error returned by
> set_memory_rox()")
> - Commit 009cf11d4aab ("powerpc: Don't ignore errors from
> set_memory_{n}p() in __kernel_map_pages()")
> - Commit 9cbacb834b4a ("powerpc: Don't ignore errors from
> set_memory_{n}p() in __kernel_map_pages()")
> - Commit 78cb0945f714 ("powerpc: Handle error in mark_rodata_ro() and
> mark_initmem_nx()")
> 
> All calls in core parts of the kernel also always check returned value,
> can be looked at with following query:
> 
>    $ git grep -w -e set_memory_ro -e set_memory_rw -e set_memory_x -e set_memory_nx -e set_memory_rox `find . -maxdepth 1 -type d | grep -v arch | grep /`
> 
> It is now possible to flag those functions with __must_check to make
> sure no new unchecked call it added.
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Do you plan to take this patch anytime soon ?

The generic part of the same was already applied in previous cycle, see 
https://github.com/torvalds/linux/commit/82ce8e2f31a1eb05b1527c3d807bea40031df913

Discussion at 
https://lore.kernel.org/all/b0fe75b4-c1bb-47f7-a7c3-2534b31c1780@csgroup.eu/T/ 
suggests that it would be beneficial to enforce return checking.

Christophe


> ---
>   arch/powerpc/include/asm/set_memory.h | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
> index 9a025b776a4b..9c8d5747755d 100644
> --- a/arch/powerpc/include/asm/set_memory.h
> +++ b/arch/powerpc/include/asm/set_memory.h
> @@ -12,37 +12,37 @@
>   
>   int change_memory_attr(unsigned long addr, int numpages, long action);
>   
> -static inline int set_memory_ro(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_ro(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_RO);
>   }
>   
> -static inline int set_memory_rw(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_rw(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_RW);
>   }
>   
> -static inline int set_memory_nx(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_nx(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_NX);
>   }
>   
> -static inline int set_memory_x(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_x(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_X);
>   }
>   
> -static inline int set_memory_np(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_np(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_NP);
>   }
>   
> -static inline int set_memory_p(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_p(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_P);
>   }
>   
> -static inline int set_memory_rox(unsigned long addr, int numpages)
> +static inline int __must_check set_memory_rox(unsigned long addr, int numpages)
>   {
>   	return change_memory_attr(addr, numpages, SET_MEMORY_ROX);
>   }
