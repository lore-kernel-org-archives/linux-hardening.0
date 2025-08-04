Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9725F7B5
	for <linux-hardening@vger.kernel.org>; Mon,  4 Aug 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312597; cv=none; b=OJwd1K3btrTYZXG4lxjOTRF40LFTtYL4/zWfRp503wm7+SdgQkZ+iDJzBf6R0YFHVPljp6lJJh6chSJ7cJKer6HtDZ/AHt76dbcCz7EbU7pfT3WYYsn0sHo2lTp8DN7soPMsGYHmywNtGe4wayaKdD80DctlYj8Pw/SrN1kPkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312597; c=relaxed/simple;
	bh=AsROPsVEl1oTjmpB6nCLhCvRE0hr89auEqbCmM9WAyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+RLkv0rhZ7M6LLQIIIBOpH06O98ineXozV9yblT2Kd0hkJMbxz63/0W16INp4P2W656pPkROlhgbHbaYHM2OfNKm3NI8mPYXTPjI3bKIfXoj0z9v+Ov/45knmLZ7swBXECGkSGABpmirh2pB7HjOwq2cWQZ5XikXbIFYKHhzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnDB6aCW; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnDB6aCW"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so9651444a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Aug 2025 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754312594; x=1754917394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q47hRQ8aof0UlFDXgmcMzO/kJRO5vpkzZCiWS2hBN/U=;
        b=RnDB6aCW1UjoSRMWGFE7N9JFBPSIznZeCv+jxcKhGjHmS/GP/+gbpqhnlwWwv0J3sd
         5t+sGNahuwexVNIhVhcbqQgZBh00DLOvSUf8HqOsafXZOdVQS0+2yaooe94FVdcyZk9g
         v+E6gAVC15CMK44ik9/vtjEwOfJxN1ZIqt4K87WNI+TfgZPbUi33fBVuSKE9yonTzSs+
         ATbggjLfxmoP1eQUFUIXJf0b6G1eifgvwmhYImKuoHmKTticmgli8XSwtKbCb+p2TjZx
         nrq4EnbcSe8tn/fhv+JwGc3ptxzjPtuwEfTvK2L+URggJBTFilY87ZYEc4GFtapsnEgR
         4m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312594; x=1754917394;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q47hRQ8aof0UlFDXgmcMzO/kJRO5vpkzZCiWS2hBN/U=;
        b=dwkLHCuoU4pGzyaN9Dahg7QJiX9EcRyb8k3ZFsRrP1druYsXogXKJ8jbxsRBi6S+08
         YA7DJlUeD+DFlBfYOj3ZifFGGIB6C9auSs2ls5OGTKPYyVmtF+01Yvv8dEhBdGUbY0CE
         Rds6Hf53viCzFNrUGbY8BfPp7XGHxkpC2HxRuceyte8F+rIh7IVFxqVGUPr7D6z3+Ak9
         TOyOpj/CCbuT020wKJaoNGdTxeq6RMBlye23gzO7KdFLcNpZOadMFg5fe58B/6EChSzF
         ASNqMpfK5YHsKthTQf+4Gi/8aS/urdqfRjjsqfSjjenAIJX2JK3lCq8MFOcRq63O89x1
         tn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdBBoG9lBBsCbeCaMVdUH42qPhcVKfi7tUXiiOtbexLvT3ZZ+sVZUo7BvxdS7JqiJzK5FZoLo2Ljxns2DDHrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0lylmZqU4GxhemOXuOYYZkL90mWk7laxThTr00U2jQl+tpRLX
	w9XY3/Rzqsn7MkCUFEmiGmy6ZUWDLO+yhTkqdcn6Nff3FFwyyHuel6IoCP8piquZ4qs=
X-Gm-Gg: ASbGncvOgjaybq4qMuRTHKuAUIS/7+xv6Skxh3X3mpi5vQyQ0Fizgat23Y0QAoHWPrK
	nHHNfYzsSluzTSQnEajGomZqzDDivjfoEv93GFCzWL3QhWBFzXwTGl5ZevcO9C1+aI/nTUtgqVl
	8BXRaHLRrOjYocgK4QCQyGL6gAOuAb+D1VdrGUzlPhePUHHOz8XeJyaLHPe6lheIfkufPWFbVht
	rpevH6KeDk1RVxjfRENjhbj2nsN1iluKoPJLgWKMpgWSzF2Squg0XbQpeqV37lxEpapEk1uj9od
	dZj2Wmbnm53ki03gr5hvCfd0jBQYVA3bd2L/DOH+K0wQXRuRq1zAC5A/KJP0OYzTzMgBTHWrLAP
	Xi3ybrWdX6jWh1hIjLaoobM2pqnvBAA==
X-Google-Smtp-Source: AGHT+IGvSWWoom5PCcQotC2cJOEy0b1eBZ0+mNZIcNqIApwylioSaULTySuV/h+PeeW7g5S3kYnbAQ==
X-Received: by 2002:a05:6402:27cc:b0:607:35d:9fb4 with SMTP id 4fb4d7f45d1cf-615e5e52361mr8637535a12.15.1754312593561;
        Mon, 04 Aug 2025 06:03:13 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8effda1sm6755395a12.1.2025.08.04.06.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:03:13 -0700 (PDT)
Message-ID: <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
Date: Mon, 4 Aug 2025 16:03:10 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
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
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 15:49, David Hildenbrand wrote:
> On 04.08.25 14:29, Eugen Hristev wrote:
>>
>>
>> On 8/4/25 15:18, David Hildenbrand wrote:
>>> On 04.08.25 13:06, Eugen Hristev wrote:
>>>>
>>>>
>>>> On 8/4/25 13:54, Michal Hocko wrote:
>>>>> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>>>>>> On 30.07.25 15:57, Eugen Hristev wrote:
>>>>> [...]
>>>>>>> Yes, registering after is also an option. Initially this is how I
>>>>>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>>>>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>>>>>> here:
>>>>>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>>>>>> Do you think we can continue that discussion , or maybe start it here ?
>>>>>>
>>>>>> Yeah, I don't like that, but I can see how we ended up here.
>>>>>>
>>>>>> I also don't quite like the idea that we must encode here what to include in
>>>>>> a dump and what not ...
>>>>>>
>>>>>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>>>>>> where we e.g., have
>>>>>>
>>>>>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>>>>>
>>>>>> Could we similar have some place where we construct what to dump similarly,
>>>>>> just not using the current values, but the memory ranges?
>>>>>
>>>>> All those symbols are part of kallsyms, right? Can we just use kallsyms
>>>>> infrastructure and a list of symbols to get what we need from there?
>>>>>
>>>>> In other words the list of symbols to be completely external to the code
>>>>> that is defining them?
>>>>
>>>> Some static symbols are indeed part of kallsyms. But some symbols are
>>>> not exported, for example patch 20/29, where printk related symbols are
>>>> not to be exported. Another example is with static variables, like in
>>>> patch 17/29 , not exported as symbols, but required for the dump.
>>>> Dynamic memory regions are not have to also be considered, have a look
>>>> for example at patch 23/29 , where dynamically allocated memory needs to
>>>> be registered.
>>>>
>>>> Do you think that I should move all kallsyms related symbols annotation
>>>> into a separate place and keep it for the static/dynamic regions in place ?
>>>
>>> If you want to use a symbol from kmemdump, then make that symbol
>>> available to kmemdump.
>>
>> That's what I am doing, registering symbols with kmemdump.
>> Maybe I do not understand what you mean, do you have any suggestion for
>> the static variables case (symbols not exported) ?
> 
> Let's use patch #20 as example:
> 
> What I am thinking is that you would not include "linux/kmemdump.h" and 
> not leak all of that KMEMDUMP_ stuff in all these files/subsystems that 
> couldn't less about kmemdump.
> 
> Instead of doing
> 
> static struct printk_ringbuffer printk_rb_dynamic;
> 
> You'd do
> 
> struct printk_ringbuffer printk_rb_dynamic;
> 
> and have it in some header file, from where kmemdump could lookup the 
> address.
> 
> So you move the logic of what goes into a dump from the subsystems to
> the kmemdump core.
> 

That works if the people maintaining these systems agree with it.
Attempts to export symbols from printk e.g. have been nacked :

 https://lore.kernel.org/all/20250218-175733-neomutt-senozhatsky@chromium.org/

So I am unsure whether just removing the static and adding them into
header files would be more acceptable.

Added in CC Cristoph Hellwig and Sergey Senozhatsky maybe they could
tell us directly whether they like or dislike this approach, as kmemdump
would be builtin and would not require exports.

One other thing to mention is the fact that the printk code dynamically
allocates memory that would need to be registered. There is no mechanism
for kmemdump to know when this process has been completed (or even if it
was at all, because it happens on demand in certain conditions).

Thanks !

