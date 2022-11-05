Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1DC4332F
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Nov 2022 19:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKET2p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Nov 2022 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKET2o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Nov 2022 15:28:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C3DE93
        for <linux-hardening@vger.kernel.org>; Sat,  5 Nov 2022 12:28:42 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4N4SGD6gXnz9sfH;
        Sat,  5 Nov 2022 20:28:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K5Xaurpgzo3o; Sat,  5 Nov 2022 20:28:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4N4SGD5czrz9sfD;
        Sat,  5 Nov 2022 20:28:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC16C8B76C;
        Sat,  5 Nov 2022 20:28:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0QtASGCCfdWc; Sat,  5 Nov 2022 20:28:36 +0100 (CET)
Received: from [192.168.235.6] (unknown [192.168.235.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63C3C8B763;
        Sat,  5 Nov 2022 20:28:36 +0100 (CET)
Message-ID: <d224142a-cdbf-9eca-b357-1f9862b22cae@csgroup.eu>
Date:   Sat, 5 Nov 2022 20:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 2/6] powerpc/64s: Helpers to switch between linear and
 vmapped stack pointers
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "cmr@bluescreens.de" <cmr@bluescreens.de>,
        Nick Piggin <npiggin@gmail.com>
References: <20221104172737.391978-1-ajd@linux.ibm.com>
 <20221104172737.391978-3-ajd@linux.ibm.com>
 <20c79a09-0b95-bb52-2495-999d2365308d@csgroup.eu>
In-Reply-To: <20c79a09-0b95-bb52-2495-999d2365308d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



Le 05/11/2022 à 09:00, Christophe Leroy a écrit :
> 
> 
> Le 04/11/2022 à 18:27, Andrew Donnellan a écrit :
>> powerpc unfortunately has too many places where we run stuff in real mode.
>>
>> With CONFIG_VMAP_STACK enabled, this means we need to be able to swap the
>> stack pointer to use the linear mapping when we enter a real mode section,
>> and back afterwards.
>>
>> Store the top bits of the stack pointer in both the linear map and the
>> vmalloc space in the PACA, and add some helper macros/functions to swap
>> between them.
> 
> That may work when pagesize is 64k because stack is on a single page,
> but I doubt is works with 4k pages, because vmalloc may allocate non
> contiguous pages.
> 

[snip]

> 
>> +
>> +#else // __ASSEMBLY__
>> +
>> +#include <asm/paca.h>
>> +#include <asm/reg.h>
>> +#include <linux/mm.h>
>> +
>> +#define stack_pa(ptr) (is_vmalloc_addr((ptr)) ? (void *)vmalloc_to_phys((void *)(ptr)) : (void *)ptr)
>> +
>> +static __always_inline void swap_stack_linear(void)
>> +{
>> +	current_stack_pointer = get_paca()->kstack_linear_base |	\
>> +		(current_stack_pointer & (THREAD_SIZE - 1));
> 
> That looks hacky. I think you can't just change current_stack_pointer on
> the fly. You have to provide something similar to call_do_softirq() or
> call_do_irq()
> 

Maybe you can have a look at Nic's RFC for calling functions in real 
mode : 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210212012041.392566-1-npiggin@gmail.com/

Christophe
