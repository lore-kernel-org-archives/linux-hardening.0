Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F8F60FC1
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 18:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhIUS2S (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:28:18 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.147]:22396 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232644AbhIUS2S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 14:28:18 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E4FC3400D5E51
        for <linux-hardening@vger.kernel.org>; Tue, 21 Sep 2021 13:26:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id SkTgmY5AYBvjySkTgmFErG; Tue, 21 Sep 2021 13:26:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/dj7s67eUkkTGvtArxjq5kIQaqJk5zQlj2EZsb9EvXo=; b=CtuNvfEow+zACbdw8ZfOWssMzl
        0bHsT+p1GmSL1VqJrs09WJhuaZJFffasqXANF3MxH/Y4vLRVAEfim4Hda6s3LFYYoqhJQasLwSEHH
        DnHqRTKkEsAZXT1YIspdXGmROyBPTsmUpORTmA+AIUXgBk9/nA5NNMTbh6P4bTqI0hcsQwjAakWzD
        0VVGEufBvFHAp1mO+BleA1MK2ovX3ZymnIAiXDa8UhPO3m9ttBqHSOfjVRRcNb3AH43DNysaEvG9N
        Jivx1sdQ3ViLwRtEhZnR21ANBPuHuoBsGqUA4ZRMzDhb+YlB0Qdvz7n1EKXXVNYvHvTBDOnHlxAzw
        BkPouv8w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:36388 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mSkTg-000c67-5M; Tue, 21 Sep 2021 13:26:48 -0500
Subject: Re: [PATCH] assoc_array: Avoid open coded arithmetic in allocator
 arguments
To:     Len Baker <len.baker@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210919110913.39386-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c7bc0092-96e5-9be8-1987-00689ef9cab8@embeddedor.com>
Date:   Tue, 21 Sep 2021 13:30:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919110913.39386-1-len.baker@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1mSkTg-000c67-5M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:36388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/19/21 06:09, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kmalloc() and kzalloc() functions.
> 
> Also, take the opportunity to refactor the memcpy() calls to use the
> struct_size() and flex_array_size() helpers.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'll add this to my -next tree.

Thanks
--
Gustavo

> ---
>  lib/assoc_array.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index 04c98799c3ba..079c72e26493 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -741,8 +741,7 @@ static bool assoc_array_insert_into_terminal_node(struct assoc_array_edit *edit,
>  	keylen = round_up(diff, ASSOC_ARRAY_KEY_CHUNK_SIZE);
>  	keylen >>= ASSOC_ARRAY_KEY_CHUNK_SHIFT;
> 
> -	new_s0 = kzalloc(sizeof(struct assoc_array_shortcut) +
> -			 keylen * sizeof(unsigned long), GFP_KERNEL);
> +	new_s0 = kzalloc(struct_size(new_s0, index_key, keylen), GFP_KERNEL);
>  	if (!new_s0)
>  		return false;
>  	edit->new_meta[2] = assoc_array_shortcut_to_ptr(new_s0);
> @@ -849,8 +848,8 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
>  		keylen = round_up(diff, ASSOC_ARRAY_KEY_CHUNK_SIZE);
>  		keylen >>= ASSOC_ARRAY_KEY_CHUNK_SHIFT;
> 
> -		new_s0 = kzalloc(sizeof(struct assoc_array_shortcut) +
> -				 keylen * sizeof(unsigned long), GFP_KERNEL);
> +		new_s0 = kzalloc(struct_size(new_s0, index_key, keylen),
> +				 GFP_KERNEL);
>  		if (!new_s0)
>  			return false;
>  		edit->new_meta[1] = assoc_array_shortcut_to_ptr(new_s0);
> @@ -864,7 +863,7 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
>  		new_n0->parent_slot = 0;
> 
>  		memcpy(new_s0->index_key, shortcut->index_key,
> -		       keylen * sizeof(unsigned long));
> +		       flex_array_size(new_s0, index_key, keylen));
> 
>  		blank = ULONG_MAX << (diff & ASSOC_ARRAY_KEY_CHUNK_MASK);
>  		pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, diff, blank);
> @@ -899,8 +898,8 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
>  		keylen = round_up(shortcut->skip_to_level, ASSOC_ARRAY_KEY_CHUNK_SIZE);
>  		keylen >>= ASSOC_ARRAY_KEY_CHUNK_SHIFT;
> 
> -		new_s1 = kzalloc(sizeof(struct assoc_array_shortcut) +
> -				 keylen * sizeof(unsigned long), GFP_KERNEL);
> +		new_s1 = kzalloc(struct_size(new_s1, index_key, keylen),
> +				 GFP_KERNEL);
>  		if (!new_s1)
>  			return false;
>  		edit->new_meta[2] = assoc_array_shortcut_to_ptr(new_s1);
> @@ -913,7 +912,7 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
>  		new_n0->slots[sc_slot] = assoc_array_shortcut_to_ptr(new_s1);
> 
>  		memcpy(new_s1->index_key, shortcut->index_key,
> -		       keylen * sizeof(unsigned long));
> +		       flex_array_size(new_s1, index_key, keylen));
> 
>  		edit->set[1].ptr = &side->back_pointer;
>  		edit->set[1].to = assoc_array_shortcut_to_ptr(new_s1);
> @@ -1490,13 +1489,12 @@ int assoc_array_gc(struct assoc_array *array,
>  		shortcut = assoc_array_ptr_to_shortcut(cursor);
>  		keylen = round_up(shortcut->skip_to_level, ASSOC_ARRAY_KEY_CHUNK_SIZE);
>  		keylen >>= ASSOC_ARRAY_KEY_CHUNK_SHIFT;
> -		new_s = kmalloc(sizeof(struct assoc_array_shortcut) +
> -				keylen * sizeof(unsigned long), GFP_KERNEL);
> +		new_s = kmalloc(struct_size(new_s, index_key, keylen),
> +				GFP_KERNEL);
>  		if (!new_s)
>  			goto enomem;
>  		pr_devel("dup shortcut %p -> %p\n", shortcut, new_s);
> -		memcpy(new_s, shortcut, (sizeof(struct assoc_array_shortcut) +
> -					 keylen * sizeof(unsigned long)));
> +		memcpy(new_s, shortcut, struct_size(new_s, index_key, keylen));
>  		new_s->back_pointer = new_parent;
>  		new_s->parent_slot = shortcut->parent_slot;
>  		*new_ptr_pp = new_parent = assoc_array_shortcut_to_ptr(new_s);
> --
> 2.25.1
> 
