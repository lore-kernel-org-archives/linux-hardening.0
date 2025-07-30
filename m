Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C42D94BF
	for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883846; cv=none; b=qU4uO23r5q3760sBVuszPHuKeCJ+NE3Il0r3QEX3qDA8JP93D4Q0IKf38cT/iM/thhSpjHP5QIwu8I4YKlHhpgchHNzJRB6dqZNrO1G6ipZuuDp4/+UoHpUfwCMYF60Qv6KvuQ2Pq+8uJijBkDkdaQk4883ZwuMe9HibZb8r0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883846; c=relaxed/simple;
	bh=KAuIxAKCqcvJESNNAPuXzlToKx9gAeC5GQhRozqHAyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdGlkrNU7s0cI1bjgZ4XgXaVd9+VQU/69mXjsKsWwKKoQdaZjMVnYrsJ8jzH/OwZj1JcTgPCc0IPy0+jL0ngwbKo9imVoxLPMhvNqtklRmL0/jGbZCevHer4CxcoDTXY2YNvsi5nC+0UNXYeZ6+CVVC9TEUQvUVit88dGwetRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jx5ugZWt; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx5ugZWt"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1608248f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753883842; x=1754488642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9x/2NmBAyKmjbcpba0SHjkvYUhTVea6LU5Wnmf6NNM=;
        b=Jx5ugZWtSK8COB35T6ay+0YdwxeOCttweMLRxJBK2JXAXtlpQzAy35n4IE9WKajNUr
         9ThFYASiYaYYwE02g/ue708xDEexVjPx/cKG+H5eVlUWiRCeSbJiJ7Mynyok2+FGcydo
         DLzMGuHYnMPinmuVFAw3BFjz8y/hrUvMZKRw1PhES81AaTNPALDFzSjLgAZ5XBkNFB5B
         4UyxwmRK50urYQTzwJJk6nwenS/o9dL4EBdu8aaxiEBD4B5ovGL9GViRQMK9G/JfUGhE
         Nq02agYiqRCzuXuJw/7ODDisEkq2x6bb+i/S2oc7ZWaaEGjfbaGYEDb5W3zO9iXK4rqW
         xv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883842; x=1754488642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9x/2NmBAyKmjbcpba0SHjkvYUhTVea6LU5Wnmf6NNM=;
        b=sQvk1ILf+aFnhjMilCVbyXaqxHJEWUPtI+bkD6bRo6bOj/y5Vn3m5mVjPxUdv3n4Pk
         /+xMzPAK2nDVi0nMh/dPGrZS2x19gmqz0awKnO8gM8flcPKU8mLDq+fkbLPwtReY9BP0
         TvPaNtRD5nfZIwTTecWcL0USLEN2exKTwsSRF2zBjJ5ni9qOtWwDeaU9Y1UGP0WJUBS7
         +Lt2+a5sI9RWKxtCTu9jvnmjJeva7c2Pw5vsS5Yzwn3f9VhIBuZrPa1rbRVCvOiRSBNK
         XgJL3Yj4x6maFmXt77WRGP6OZGLlPo2TqqrQyVJAmaLMV53IEI6bJ9pvBl7v/gnVfH86
         t0WA==
X-Forwarded-Encrypted: i=1; AJvYcCW/sNqfjc/WrgxQCY05L/8i6LdhH2HR9qTjYHdIxKEZGTTSy9wiRv97sIM7h+Vc6jA0CtPmO4wQgMx26DDaVQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFScrIIzN1O5tm/Qo+3wPed0Die8mGG0Ifmjw2IQRKXPAwqUI
	6oLNIQUurV0+oHLmFjuCiz/HSsVxVcI1uFOciQVF/lz4EGdCgXEBp2A2dJbNEu//6vQ=
X-Gm-Gg: ASbGncvn1UpMY1umwnlcV9F+nPFeQ1Guoyga7i4Du8LqumRiDD1H7gW2OTpUMT/fdtb
	5uLbaiJHRD9QQIWtWSowuu0cb2Um9hhJc/Dat+7siJ5Q7X52pWVNsXXt/3gZ6iXG3gEMcxc0jfy
	TcZ4Sa18vWwMy5h1lRzDuWIdyjjAYWnpnCnJXUIe7o0SKWNSWPitpOx+BrWU4cEplB8OsRdDSdh
	QHrPKn316o6+CV5X87gHYO58ZLb+JqDBUq4ujEW3Ot9IeYV1qrP33Mg+AVgG8KhLBDa6oxjHY4a
	rQDbc5GDkdLfruut5R1t5CvEbzHR4bdDiz4Oc3wImjMPkGrSEIKX7e04fNpzfq9sRJec6+qcFVE
	9r4W24+19MMLldw3cZPrGaA30GaADNw==
X-Google-Smtp-Source: AGHT+IH3yb9aRgK/Q+bZ6pcZQPnb/X5dHJrsLz/8jaoiHMtgM6iMNWm/RCtsBVpSGygJWiFCkMusNg==
X-Received: by 2002:a05:6000:1886:b0:3b7:9a31:2a10 with SMTP id ffacd0b85a97d-3b79a312c5bmr433785f8f.41.1753883841744;
        Wed, 30 Jul 2025 06:57:21 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b795bf9719sm2807959f8f.63.2025.07.30.06.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:57:21 -0700 (PDT)
Message-ID: <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
Date: Wed, 30 Jul 2025 16:57:20 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 7/30/25 16:52, David Hildenbrand wrote:
> On 24.07.25 15:55, Eugen Hristev wrote:
>> Annotate vital static information into kmemdump:
>>   - node_data
>>
>> Information on these variables is stored into dedicated kmemdump section.
>>
>> Register dynamic information into kmemdump:
>>   - dynamic node data for each node
>>
>> This information is being allocated for each node, as physical address,
>> so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
>> uid, and register the virtual address.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   mm/numa.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/numa.c b/mm/numa.c
>> index 7d5e06fe5bd4..88cada571171 100644
>> --- a/mm/numa.c
>> +++ b/mm/numa.c
>> @@ -4,9 +4,11 @@
>>   #include <linux/printk.h>
>>   #include <linux/numa.h>
>>   #include <linux/numa_memblks.h>
>> +#include <linux/kmemdump.h>
>>   
>>   struct pglist_data *node_data[MAX_NUMNODES];
>>   EXPORT_SYMBOL(node_data);
>> +KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
>>   
>>   /* Allocate NODE_DATA for a node on the local memory */
>>   void __init alloc_node_data(int nid)
>> @@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
>>   	int tnid;
>>   
>>   	/* Allocate node data.  Try node-local memory and then any node. */
>> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>> +	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
>> +					 nd_size, SMP_CACHE_BYTES, nid);
> 
> Do we really want to wrap memblock allocations in such a way? :/
> 
> Gah, no, no no.
> 
> Can't we pass that as some magical flag, or just ... register *after* 
> allocating?
> 

Thanks for looking into my patch.

Yes, registering after is also an option. Initially this is how I
designed the kmemdump API, I also had in mind to add a flag, but, after
discussing with Thomas Gleixner, he came up with the macro wrapper idea
here:
https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
Do you think we can continue that discussion , or maybe start it here ?

Eugen
