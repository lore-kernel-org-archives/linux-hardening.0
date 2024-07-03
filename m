Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72227137911
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jul 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993455; cv=none; b=b4Gt/dcEgb57+lKggSLylutefi9q8M5uWlWUtv6TL19c7CPxGsftObbW7ImTW7+MuuVWyCyi1QKEp2YzEfBA2tlZuu+JbjfAOicLfB+xr1rFV/sG040YuHBtOgYyisE9avlsWnamC5ml1PoFOtpUSAL/LC2+9Gm5+s0E3YwDM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993455; c=relaxed/simple;
	bh=U+tuZf+gHrZIew88Zq0HhyZ0+J7x2Mhz/9FZdbvH6Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9vyurBE0roQgx74wnWsx0OYrpNc+491UzfohxoCTH3Qr6HrK3fEbfpuMkgNRHf96mnSyl695lWjiTOHLCVz9K/D9j/5YhHiDDBbqy2RQ2usoKO8H73gxr14tjIybcZUSIRPYegbCE6vCr4fYa/W5PjllFXdNKNmTHobITM/rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTyE90hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTyE90hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719993451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
	b=hTyE90hrZpPA7rCvoJMFBttsO84hdETHQoiOo1/6jzwCukxY6T2bJqoE6G7z6J9+icfcYG
	AV8QBOcXUB6QoJI9IMwhAm8nFAhK13lqnAX9/y5aAnaatKQBzWTyqkW3hob8jBfxMtWMoI
	asOHuqBjUXLAYd31D9SeL1stxR9nv4g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-VkqjYb40NfuOWkaHpYipQw-1; Wed, 03 Jul 2024 03:57:30 -0400
X-MC-Unique: VkqjYb40NfuOWkaHpYipQw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3630a676a07so3194511f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jul 2024 00:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993449; x=1720598249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
        b=cTDNG5iVMRZJ/j1Zhfs/z246vIhDIcg2mHf9DMlwuOlz0YSCtthT6Vxg4QCPtlFwMw
         kDDb8xn/HPEXzz6v7NFerNh8zQzf5JlVGz37x9h9d0fWmiFbiLTjTaFCicFUENXD209k
         lnCf0MiBL0Kg6FyiC7UgW7NtBBszj7ow1su+99McxZH8adznhWeP6qpxgZLZlj00KQmM
         Dox5HD/r5+8u85Ht3D7SgErGPEyogQ+aUebClPrUn4ROKjg/2OJUPzZhGfiwgaCww4r0
         AAPlM0POOvHUiFR8rq2IZFfYwmabDaazJFiXaASd5k524eQUyi2Qzb4f6N6CIg3hSsXU
         y9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFZZHxvIn54mYnsCJmnlEgFbGSuOzb6Iw2YTkc0+zZq2SpZWIrKY8xwh2kCGq4l2xpL+amserf4+989o453POD8k1w51leyAfog2R41XAv
X-Gm-Message-State: AOJu0YyXVC7EbNCQ3DtaLgXdsfLOVvX5Hx8kzAHG/NndcUgUyNEOskyn
	u8dz0RyHfqWhhLdRoOQedhmmwDtyJzkgRqWAkQwjAG19MXNr+Re+Oo+ZVVqZ8U1aVA6To9wrB++
	weJIhrDFPQ0vnRZCOK0aULgEegExB01rccU42urhJmFtakkUcLmapRBBdY/kprLj0sg==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597282f8f.6.1719993448997;
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgd9U2eqDjR78JXH16dEWMefFhv6oCfwMwNT/hPSpZD56c2ut2zLCAdpneI7XMTfA346aUUg==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597268f8f.6.1719993448595;
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm15223623f8f.16.2024.07.03.00.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Message-ID: <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
Date: Wed, 3 Jul 2024 09:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <202407021326.E75B8EA@keescook>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <202407021326.E75B8EA@keescook>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2024 22:29, Kees Cook wrote:
> On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new struct kmsg_dump_detail, that will hold the
>> reason and description, and pass it to the dump() callback.
> 
> Thanks! I like this much better. :)
> 
>>
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>>
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>>
>> v2:
>>   * Use a struct kmsg_dump_detail to hold the reason and description
>>     pointer, for more flexibility if we want to add other parameters.
>>     (Kees Cook)
>>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>>     declaration of oops_to_nvram()
> 
> The versioning history commonly goes after the "---".

ok, I was not aware of this.
> 
>> [...]
>> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
>> index 906521c2329c..65f5a47727bc 100644
>> --- a/include/linux/kmsg_dump.h
>> +++ b/include/linux/kmsg_dump.h
>> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>>   	u64	next_seq;
>>   };
>>   
>> +/**
>> + *struct kmsg_dump_detail - kernel crash detail
> 
> Is kern-doc happy with this? I think there is supposed to be a space
> between the "*" and the first word:
> 
>   /**
>    * struct kmsg...
> 
> 
Good catch, yes there is a space missing.

I just checked with "make htmldocs", and in fact 
include/linux/kmsg_dump.h is not indexed for kernel documentation.
And you can't find the definition of struct kmsg_dumper in the online doc.
https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper

> Otherwise looks good to me!
> 

Thanks.

As this patch touches different subsystems, do you know on which tree it 
should land ?

-- 

Jocelyn

