Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90EC7EE2A
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 08:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjEWIRn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjEWIRG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 04:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30631185
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684829668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pK75x5ErRQbR7sZTyIQvs8c6Qw3cdzJ6+CtVUWa6Arg=;
        b=AQjk4+6vhrQGvGYf8L6tDhOWFfEqacUgqNgg8X7UYWepwuVIL2PKJ47js16/NaAgCMJCw/
        KmkV2oAvJ3ljevYSr2Reh5Miv47cDyFp4gGn9A9zJdM4fnPZ9f9RWvg2uDSJaKP1OdyMkw
        4pMhEHo0wGy8JJqQoXPLDlbx6+qfMB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-dSBAoavJM4-2KTz4XRfFbw-1; Tue, 23 May 2023 04:14:27 -0400
X-MC-Unique: dSBAoavJM4-2KTz4XRfFbw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30959544cbdso2049302f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829666; x=1687421666;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK75x5ErRQbR7sZTyIQvs8c6Qw3cdzJ6+CtVUWa6Arg=;
        b=CpIKR2/JOvecL5UkPrme25q9dGhe/wMgCQDUSBpBYgbQkw9iHV/bG3tsi4SRZJ/aUL
         ksG72AJrlfu/FYGDXDohv8BS/xhzA8fWWXBGb1q0UrXiiFjw34YzvE4HlpgudS3Ljq+h
         leA2ShrsFuDI3lfXN2FB9+3Vgdn1tq7b/iwkKCtrBXjVIbylpRQPb/Ijh1ruvV4yDh/0
         ALwoiWfTt5+ZO/L9UtWcB7S/J0Tpxuxu9WdDrwoaqA3vKmtEg7NPvuqQvo4Df5vLlvVz
         zhJDxXQ7DpYfdYv3ywQqBOID5nORlGpGUbsthpuLTHZGVXTVDgE7VpSAH76lXCAhgBec
         oUYw==
X-Gm-Message-State: AC+VfDw+6ktpE/2dC6tT+J6MuIiSqaq21erKIA0htqU0AcDSmHJY9T0v
        6+Y6Vlk2H4ELGyEe+ftOkRB8HNmZxBuFsoWNdcga5rU2GQ7xGpVHsx7Lp14a5SohyVYOKtSZ0Y3
        oVnQhonRfmJnsHddkPBrSvtMCvHSk
X-Received: by 2002:adf:ea82:0:b0:30a:8f9e:8ee6 with SMTP id s2-20020adfea82000000b0030a8f9e8ee6mr4507355wrm.22.1684829666192;
        Tue, 23 May 2023 01:14:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6H1MPKDPiSbV8c1ccyUYy2bHzIhCHQ2vPFAk/Ser7s8xXZJeKgLdg+5PD28Od7MlUSBAjG7A==
X-Received: by 2002:adf:ea82:0:b0:30a:8f9e:8ee6 with SMTP id s2-20020adfea82000000b0030a8f9e8ee6mr4507320wrm.22.1684829665772;
        Tue, 23 May 2023 01:14:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b00306281cfa59sm10367794wrn.47.2023.05.23.01.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 01:14:25 -0700 (PDT)
Message-ID: <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
Date:   Tue, 23 May 2023 10:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
 <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 23.05.23 09:56, Lorenzo Stoakes wrote:
> On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
>> On 5/23/23 09:42, Lorenzo Stoakes wrote:
>>> On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
>>>> With SLOB removed, both remaining allocators support hardened usercopy,
>>>> so remove the config and associated #ifdef.
>>>>
>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>> ---
>>>>   mm/Kconfig       | 2 --
>>>>   mm/slab.h        | 9 ---------
>>>>   security/Kconfig | 8 --------
>>>>   3 files changed, 19 deletions(-)
>>>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 7672a22647b4..041f0da42f2b 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -221,7 +221,6 @@ choice
>>>>   config SLAB
>>>>   	bool "SLAB"
>>>>   	depends on !PREEMPT_RT
>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   	help
>>>>   	  The regular slab allocator that is established and known to work
>>>>   	  well in all environments. It organizes cache hot objects in
>>>> @@ -229,7 +228,6 @@ config SLAB
>>>>
>>>>   config SLUB
>>>>   	bool "SLUB (Unqueued Allocator)"
>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   	help
>>>>   	   SLUB is a slab allocator that minimizes cache line usage
>>>>   	   instead of managing queues of cached objects (SLAB approach).
>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>> index f01ac256a8f5..695ef96b4b5b 100644
>>>> --- a/mm/slab.h
>>>> +++ b/mm/slab.h
>>>> @@ -832,17 +832,8 @@ struct kmem_obj_info {
>>>>   void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
>>>>   #endif
>>>>
>>>> -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   void __check_heap_object(const void *ptr, unsigned long n,
>>>>   			 const struct slab *slab, bool to_user);
>>>> -#else
>>>> -static inline
>>>> -void __check_heap_object(const void *ptr, unsigned long n,
>>>> -			 const struct slab *slab, bool to_user)
>>>> -{
>>>> -}
>>>> -#endif
>>>
>>> Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
>>> not want the prototype?
>>
>> Well I didn't delete the prototype, just the ifdef/else around, so now it's
>> there unconditionally.
>>
>>> Perhaps replacing with #ifdef
>>> CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
>>
>> Putting it under that #ifdef would work and match that the implementations
>> of that function are under that same ifdef, but maybe it's unnecessary noise
>> in the header?
>>
> 
> Yeah my brain inserted extra '-'s there, sorry!
> 
> Given we only define __check_heap_object() in sl[au]b.c if
> CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
> if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
> unconditionally?
> 

The file is only compiled with CONFIG_HARDENED_USERCOPY:

mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o



Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

