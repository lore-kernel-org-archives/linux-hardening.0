Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C1132804
	for <linux-hardening@vger.kernel.org>; Mon,  3 Jun 2024 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445729; cv=none; b=skieKo6kExeB5RlNGSgmbOzkEM2H906LtNdIu6h4dfRHv9lT5/qpvrord5CtllsbFybRadfX7MxrkzBXHmJpBhu/UQASwYOKBUSNn1lBU8N3OnPya5umekHIGemjEGZUle+MMp6C52X/8DvPFAAomCCQLF/5MFae6wgI5E7l3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445729; c=relaxed/simple;
	bh=6dYnEieFW5pJy3yVLXofn6h+6BvWJDoHjAgo36u4P5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoSoyO5WrOqGlasZo/izs3tICr56iG2tiR/3r8DHnFRO/0gZodcmQrormWNMnnsPVoxhj4nVAIx5cRAEe2yeWPqKzLn//yZWEvheSNIyzppsKCgsP+qrrdr/q5Kma1+e9d2f7rqOVdJzNp1GqGKCbKWZE465ZumkQnsdzan1YEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgixPF1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgixPF1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717445726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J7Z4t2qMyLKYpVfFtfi2uoH8f5YIeqj2+6Ra9CTUtuo=;
	b=MgixPF1Yrqkye2DNx8g3L+rpKOrLqYFrGFJkzHNzbT03PVKAv8ruI2V5o1iUpK/sIf1Iye
	LWnYLzHMkE9AWhC0LtZIcirelwfRbCbpb4Ev62+Ux61j2YyU8TtS0gsvLWTB4FwNt4bth6
	ohQ7CrUpxIPhljY9+YH0upqQRDAeOms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-d77YOOLgMkW5vX-8dVKFQA-1; Mon, 03 Jun 2024 16:15:24 -0400
X-MC-Unique: d77YOOLgMkW5vX-8dVKFQA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dca355ffaso2754534f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 03 Jun 2024 13:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445723; x=1718050523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7Z4t2qMyLKYpVfFtfi2uoH8f5YIeqj2+6Ra9CTUtuo=;
        b=RHGGxBKdNuVH+THmj0qVuOKyboxjlYfMpp/eRWC1dalPbdzNRVJJZwVxIlDDzBGr5m
         fZQNsjcEYCoS1ba6k6u2ocqyVtDn//zeQvnGSb9zET6k2ocxKB73dWG4TGgXIQd39kEJ
         6oOg4I5U2JgV3tDxrzOUPhHCnIY0xypqA27aewCIwpNZRfMud23xiwh9r8Hc/xHyGQxy
         yBbHKBAtH4mNy2AIrWXr1PPXH69ybrNxA2Y8TTEPQMrsBfkq5/YLd8hTX9uAUkH2w4zD
         CDAaRaqrG93bc+ebtZUlz62+AYor0A6HJVlq7uzV8gdm928hIpMSCQz7BijIMAj1Uu10
         le7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6E5vrHVOHrfUPVD2YKAmHZDuJ6CWy+b8hXILnt07LkuB4JlvNv/xUQiL+i3AOfGF9RBVDZyBnk9J4SDXPN9ocZbvPaRgO0j14d2Gw1Jx
X-Gm-Message-State: AOJu0Yy62cYDhiNsKFw7sDgI+as6CrYcOHsuTJLYZPEO1dOw+Oh22fO/
	HO1kM+jd7Vbxrcb/CTd/N/yYSmtt+YnAGvxhEtkGyzrq6UfEVNYO3GIozEYouxfiVbwuNeHK96s
	I4R5S/UCvTgIiLXwgrOgVVIDXMVRzxaZYg6IPVl4NEYhsAQxXrCNAxbViW0P6xhWV7Q==
X-Received: by 2002:a05:6000:110d:b0:357:5051:2a58 with SMTP id ffacd0b85a97d-35e0f271dafmr7197115f8f.16.1717445723608;
        Mon, 03 Jun 2024 13:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKWxWINFf5bDDx2blbnNV0KtFPVfLhtRQ2ELigXS60SDnuxKQZYZYheWXLOAAzUKKryG7Btg==
X-Received: by 2002:a05:6000:110d:b0:357:5051:2a58 with SMTP id ffacd0b85a97d-35e0f271dafmr7197106f8f.16.1717445723194;
        Mon, 03 Jun 2024 13:15:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cb1e7sm9631143f8f.43.2024.06.03.13.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:15:22 -0700 (PDT)
Message-ID: <01d90f6c-64a1-4d25-a760-0d8865f6de95@redhat.com>
Date: Mon, 3 Jun 2024 22:15:21 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Anastasia Belova <abelova@astralinux.ru>, lvc-project@linuxtesting.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 linux-hardening@vger.kernel.org
References: <20240603112830.7432-1-abelova@astralinux.ru>
 <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>
 <20240603-4f7a5fd957aa1f9cbc8d5f14-pchelkin@ispras.ru>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240603-4f7a5fd957aa1f9cbc8d5f14-pchelkin@ispras.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 21:54, Fedor Pchelkin wrote:
> On Mon, 03. Jun 18:07, David Hildenbrand wrote:
>> On 03.06.24 13:28, Anastasia Belova wrote:
>>> nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
>>> array by invalid index with check for nid.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>>> ---
>>>    mm/memory_hotplug.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 431b1f6753c0..bb98ee8fe698 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -846,7 +846,7 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
>>>    	unsigned long kernel_early_pages, movable_pages;
>>>    	struct auto_movable_group_stats group_stats = {};
>>>    	struct auto_movable_stats stats = {};
>>> -	pg_data_t *pgdat = NODE_DATA(nid);
>>> +	pg_data_t *pgdat = (nid != NUMA_NO_NODE) ? NODE_DATA(nid) : NULL;
>>>    	struct zone *zone;
>>>    	int i;
>>
>>
>> pgdat is never dereferenced when "nid == NUMA_NO_NODE".
>>
>> NODE_DATA is defined as
>>
>> arch/arm64/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
>> arch/loongarch/include/asm/mmzone.h:#define NODE_DATA(nid)      (node_data[(nid)])
>> arch/mips/include/asm/mach-ip27/mmzone.h:#define NODE_DATA(n)           (&__node_data[(n)]->pglist)
>> arch/mips/include/asm/mach-loongson64/mmzone.h:#define NODE_DATA(n)             (__node_data[n])
>> arch/powerpc/include/asm/mmzone.h:#define NODE_DATA(nid)                (node_data[nid])
>> arch/riscv/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
>> arch/s390/include/asm/mmzone.h:#define NODE_DATA(nid) (node_data[nid])
>> arch/sh/include/asm/mmzone.h:#define NODE_DATA(nid)             (node_data[nid])
>> arch/sparc/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[nid])
>> arch/x86/include/asm/mmzone_32.h:#define NODE_DATA(nid) (node_data[nid])
>> arch/x86/include/asm/mmzone_64.h:#define NODE_DATA(nid)         (node_data[nid])
> 
> node_data array is declared as follows on most archs:
> 
>    struct pglist_data *node_data[MAX_NUMNODES];
> 
> It's an array of pointers to struct pglist_data. When doing node_data[-1],
> it is actually dereferencing something before the start of the array in
> order to obtain a pointer to struct pglist_data, isn't it?
> 
>     (C99, 6.5.2.1) The definition of the subscript operator [] is that
>     E1[E2] is identical to (*((E1)+(E2))).
> 

Yes, you are right, I shouldn't have reviewed that on the subway :) I 
thought we'd have a "&" in the front ...

What likely saves us here is the compiler doing the right thing, and not 
actually looking up that pointer when unused -- or even inlining 
auto_movable_can_online_movable() twice into auto_movable_zone_for_pfn().

[...]

> 
> This code looks to be executed with memory_hotplug.online_policy=auto-movable,
> I suppose it's not a real big problem due to the fact that node_data is a
> global variable as otherwise [-1] array access would lead to crashes..
> 
> I've triggered the code with node_data[-1] on kernel with UBSAN enabled,
> and no splats were observed. Is it due to that node_data is a global
> variable or I somehow managed to misuse UBSAN for catching oob access?
> Cc'ing linux-hardening.
> 
> Nonetheless, maybe it'd be better to define pgdat inside the else-block
> in auto_movable_can_online_movable() where it's only used?

Yes, that's cleanest. And that's likely what the compiler does by itself 
already.

Thanks!

-- 
Cheers,

David / dhildenb

