Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634AC4338F
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Aug 2021 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27266104F
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Aug 2021 09:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhHEJSY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Aug 2021 05:18:24 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:56653 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239918AbhHEJSW (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Aug 2021 05:18:22 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GgNLl4K04z9sWJ;
        Thu,  5 Aug 2021 11:18:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u8DIUV7I5wGA; Thu,  5 Aug 2021 11:18:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GgNLl3KK1z9sWH;
        Thu,  5 Aug 2021 11:18:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 525F78B7BF;
        Thu,  5 Aug 2021 11:18:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0W9Kg7YB8_OZ; Thu,  5 Aug 2021 11:18:07 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C02128B7BE;
        Thu,  5 Aug 2021 11:18:06 +0200 (CEST)
Subject: Re: [PATCH v5 8/8] lkdtm/powerpc: Fix code patching hijack test
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     keescook@chromium.org, peterz@infradead.org, x86@kernel.org,
        npiggin@gmail.com, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, dja@axtens.net
References: <20210713053113.4632-1-cmr@linux.ibm.com>
 <20210713053113.4632-9-cmr@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7a6c97ed-815b-49fc-5568-ab4420f53122@csgroup.eu>
Date:   Thu, 5 Aug 2021 11:18:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713053113.4632-9-cmr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



Le 13/07/2021 à 07:31, Christopher M. Riedl a écrit :
> Code patching on powerpc with a STRICT_KERNEL_RWX uses a userspace
> address in a temporary mm on Radix now. Use __put_user() to avoid write
> failures due to KUAP when attempting a "hijack" on the patching address.
> __put_user() also works with the non-userspace, vmalloc-based patching
> address on non-Radix MMUs.

It is not really clean to use __put_user() on non user address, allthought it works by change.

I think it would be better to do something like

	if (is_kernel_addr(addr))
		copy_to_kernel_nofault(...);
	else
		copy_to_user_nofault(...);



> 
> Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
> ---
>   drivers/misc/lkdtm/perms.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 41e87e5f9cc86..da6a34a0a49fb 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -262,16 +262,7 @@ static inline u32 lkdtm_read_patch_site(void)
>   /* Returns True if the write succeeds */
>   static inline bool lkdtm_try_write(u32 data, u32 *addr)
>   {
> -#ifdef CONFIG_PPC
> -	__put_kernel_nofault(addr, &data, u32, err);
> -	return true;
> -
> -err:
> -	return false;
> -#endif
> -#ifdef CONFIG_X86_64
>   	return !__put_user(data, addr);
> -#endif
>   }
>   
>   static int lkdtm_patching_cpu(void *data)
> 
