Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB0207DE2
	for <linux-hardening@vger.kernel.org>; Mon, 25 Aug 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128021; cv=none; b=p/A74JYD+qjWSA92btA9I2uYjHcbutlW7ivms5WX4zvqOFh9sJeA5RgzsgEje9lp2bdiH7fR4VmcG+EOZc+7Ez3ucHgRqnrNrclCdRCHmN0bNu0IwEFNL5aTyoSgIZnMPLuFRSkox0LRuDzyyAnHBSwZyDqFR7F+abEImEa8tLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128021; c=relaxed/simple;
	bh=m6jqKINFobNIZ/79Pbgva0NJNu9TvoUNn6dTFB0S+7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imd3KM6frsipowl7XL1hQYEwJtVmgVunh6zD4jlPERR5+cQZRJlUAtFTW/FxugIpMyqBL5dHI3/U7fNTABtQReMBj+f7k09CBbX8GcCHL+sv0gk0iPCJmFFuJDhLbChW5lpXMuOqwSzUtOZ2BKeG9SBl+YdzVYUOE6cozFok0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGlD45vg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGlD45vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756128018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xanPEdPEE3D5dOZlqK4VGPHY2abbjAoznKTXD9A7MGY=;
	b=DGlD45vgogFOnmNirGnK6pe2kjVEFm0sjvqpAQNxEbhNEWv3HAE5aRTg+FotMdfU3H9/53
	jtaoel+eL/RL08LvNLp0mZtYBVlQXWrRNjQuIT7jhmOZmSKrPvYwaWRlTWPT5IxFc4qMym
	Bq4i5Ec78h34ie72D8KB3VqR70gnviw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-v7hyZU_sPTiiiChmcdkL5A-1; Mon, 25 Aug 2025 09:20:17 -0400
X-MC-Unique: v7hyZU_sPTiiiChmcdkL5A-1
X-Mimecast-MFC-AGG-ID: v7hyZU_sPTiiiChmcdkL5A_1756128016
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b612dbc28so5821185e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 25 Aug 2025 06:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128016; x=1756732816;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xanPEdPEE3D5dOZlqK4VGPHY2abbjAoznKTXD9A7MGY=;
        b=Sx+ZlixYj/G6sPYAkBWHZr0nZBiHavTYT4kyGyJVI0i27PP6bLnW+zSE5+sGNU176K
         0afNznlz2vWtBGXNLLSz+7VrmFzDRwXsMiG4cXiOBXk254nswBR1rSsC3TXhLNXuujjS
         Fx+zdPnaigBgb/3eXWPzwjcxxgy6RgVdKROAol74wvk/1KWwKZc9g5GkssEze8NC+ihr
         2cWd1ffwmGHbNkkg2tgE+iYOuqVxfPlQKYKisik7i5sZPAZT78vB9FbjAHfEEsHuAo83
         krEZicaj6oNz1CbysR0Fb88M477PM9TtOqghNdSuL2CQtvaXsWTLtTVmgVVCPTWU6fxp
         S46w==
X-Forwarded-Encrypted: i=1; AJvYcCUnND3pC4qNilzvWBoe5x51qINTb60Ghe6LLzPP4f5LbKwA5NSe3GPzTLdRXB996fa9Htp06NylGadkTohUTdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiMFCjNuLWNSvJQ3+6EbTikjaxrmjP0B7L+KXxETgtmSNMYH2
	hmzY+tDfWBHTUxijaZktP5bObQ6ODMRHmNxUNgeZhhc0S6Xw3FJie8xNVeYlsihD14tnO4rFmKI
	Y6gKJUsJqcH/KS8jkpwyUolCD/fe5vg201jQCU8fgQ3H2bEU1dYZOhwyHp60NYIH74GTt1g==
X-Gm-Gg: ASbGnctuHLSRw0Cf5rRgEpH7YqjQqq0Vm51RcKiZsPgIFKIRYc5larvdNG6ehWyyvQi
	bCvpNiAH+ZZq2CEMYXn30ms2HqLuGRYGDdNPNeIz2HEXZkd6NTC5J+Lw7vLOxd1vbIq7751pxYl
	l/knGrwuEr8OJTfErQWT3W2vaaaqfVXX14y//+Bjl83jjSDm40rjZDSHztuWSZ4Xzjkiob1kVg6
	wsPKw5uq4Z0VEa2vM2roEKeaADoGcSBGyNEUlUCdr8nxXYnPA5MBWc9ARCDMdaQ6+A9hDK5dshm
	boLVap4MzV2zKkKGri0poybYJMmjb0xGVwezlmjOscPYvb6OYHW8Qjms8TMtG29LUyldSNHe+6d
	XxH/ZwG/Clgxp60GoPK14hsoQ1qETKp3qn5vhZNRMddAPurGyxo3K0Q+Wn40GbWwFOnc=
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b5ec68358mr40532035e9.11.1756128015737;
        Mon, 25 Aug 2025 06:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvrXUbP05G5QAqAXL/0e5bs4AE6awYxmrv92zt0i3Fp8EOJw//DKRQZAygSokTsHc8FeRx2w==
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b5ec68358mr40531705e9.11.1756128015277;
        Mon, 25 Aug 2025 06:20:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b506bdd9csm92855095e9.3.2025.08.25.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:20:14 -0700 (PDT)
Message-ID: <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
Date: Mon, 25 Aug 2025 15:20:13 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
 <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
 <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
 <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
 <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
 <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: heXBq2WE7ewFcUD5fPhOJ8qR2t76mO2rgaZTXJdWRe8_1756128016
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> IIRC, kernel/vmcore_info.c is never built as a module, as it also
>> accesses non-exported symbols.
> 
> Hello David,
> 
> I am looking again into this, and there are some things which in my
> opinion would be difficult to achieve.
> For example I looked into my patch #11 , which adds the `runqueues` into
> kmemdump.
> 
> The runqueues is a variable of `struct rq` which is defined in
> kernel/sched/sched.h , which is not supposed to be included outside of
> sched.
> Now moving all the struct definition outside of sched.h into another
> public header would be rather painful and I don't think it's a really
> good option (The struct would be needed to compute the sizeof inside
> vmcoreinfo). Secondly, it would also imply moving all the nested struct
> definitions outside as well. I doubt this is something that we want for
> the sched subsys. How the subsys is designed, out of my understanding,
> is to keep these internal structs opaque outside of it.

All the kmemdump module needs is a start and a length, correct? So the 
only tricky part is getting the length.

One could just add a const variable that holds this information, or even 
better, a simple helper function to calculate that.

Maybe someone else reading along has a better idea.

Interestingly, runqueues is a percpu variable, which makes me wonder if 
what you had would work as intended (maybe it does, not sure).

> 
>  From my perspective it's much simpler and cleaner to just add the
> kmemdump annotation macro inside the sched/core.c as it's done in my
> patch. This macro translates to a noop if kmemdump is not selected.

I really don't like how we are spreading kmemdump all over the kernel, 
and adding complexity with __section when really, all we need is a place 
to obtain a start and a length.

So we should explore if there is anything easier possible.

>>
>>>
>>> So I am unsure whether just removing the static and adding them into
>>> header files would be more acceptable.
>>>
>>> Added in CC Cristoph Hellwig and Sergey Senozhatsky maybe they could
>>> tell us directly whether they like or dislike this approach, as kmemdump
>>> would be builtin and would not require exports.
>>>
>>> One other thing to mention is the fact that the printk code dynamically
>>> allocates memory that would need to be registered. There is no mechanism
>>> for kmemdump to know when this process has been completed (or even if it
>>> was at all, because it happens on demand in certain conditions).
>>
>> If we are talking about memblock allocations, they sure are finished at
>> the time ... the buddy is up.
>>
>> So it's just a matter of placing yourself late in the init stage where
>> the buddy is already up and running.
>>
>> I assume dumping any dynamically allocated stuff through the buddy is
>> out of the picture for now.
>>
> 
> The dumping mechanism needs to work for dynamically allocated stuff, and
> right now, it works for e.g. printk, if the buffer is dynamically
> allocated later on in the boot process.

You are talking about the memblock_alloc() result, correct? Like

new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);

The current version is always stored in

static char *log_buf = __log_buf;


Once early boot is done and memblock gets torn down, you can just use 
log_buf and be sure that it will not change anymore.

> 
> To have this working outside of printk, it would be required to walk
> through all the printk structs/allocations and select the required info.
> Is this something that we want to do outside of printk ?

I don't follow, please elaborate.

How is e.g., log_buf_len_get() + log_buf_addr_get() not sufficient, 
given that you run your initialization after setup_log_buf() ?


-- 
Cheers

David / dhildenb

