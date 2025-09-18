Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7621DF74F
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203631; cv=none; b=eGcdbUIxu16tnZy7Hh6ybSphDij34XoErRjOyc4/FEJ2JAZ2+yd4flugPYeR9PHTLTSE0xVkter3vhaFPcqbO0Fat7ivRdFdy83F6uLDlMNn34k4H7BV/Kofa2uUq02anc5KJkuSZd+bM3WVxobDj7AwI+vH0jrv8bRVTrF92zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203631; c=relaxed/simple;
	bh=W8d+rtW76hd2LNkPX2+QJLDJy6PBL5cszIE1g/3/9FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFSb2zv7N5Wh3zACHtpTfqUtdHysOVb09ieGQWkzCxJ2abKUxg+8oHkylrGufJjvGm2POJhlBlO/NTdkaEs49+nEHUftLu5bUbCxj7YLNRcurIOr5O5TbpD6IxZpCtMhCQ66UdJdt9IeYGHx8DP6uNVXMbA8A/bsVfH0cjvUzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfQMeVPw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfQMeVPw"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso177007566b.2
        for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758203628; x=1758808428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7efdXg49cd0dO4HNsPgED93u6J0FRsteNdyMBWuRc0=;
        b=cfQMeVPwhlYmpXtRfT5BYz/T64TCrvFJH32cIptJYbfQCQtwjQsSKaALeXPvk33VpH
         arNXDWeQtAB702/agV1Yb32LnvTiUtMqTik2TaYQiQXOKm/pXZfcgDMDgXTbX3k+8A0y
         OaRPcDv3acaWTtrxzqWfSR7KIQ/pWUhzTwypH+zeKkK5pzI7Zjt4xFlqjNNLgyFIMmRT
         40MWju1htAXyxrvY9WduasEk6HQQXXrUbFxklSW+ghU45OQefJky7Yl77X2GMM7RIDRD
         b6hxehcLvwJwR1QDj0FxPKio+SUWdBrDk8SxtjjdvS9IxiLeQCsa5koecQdC1qlQah4D
         ywig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203628; x=1758808428;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7efdXg49cd0dO4HNsPgED93u6J0FRsteNdyMBWuRc0=;
        b=KBq2r0O82eUnUPi16z1k26OURvNGAQSTd6hnd3TZUu1lAHLvMEctTXciYQpsa/zqwk
         +eZ+MnP9cQ+h5mfbicAxmtIRuexxTv3+Edr0FudKSWXg2cZq6uQysDq7cuSf3Q6zDRze
         gdMRgxdPr13G8dwEOXJUrcdOIdR+Ef+wb4W8QgNDs6aiaTZka9a6t47HLvYvQ4NCmkJK
         ZvU0OR8gUnmBfEOEF5wAXin36dBjjAid0Eh27rbq0AMmF30z08ANZj/8y07kLNXbDK0W
         ZGnNSiuvEMSNBWscqOi0coPlkZkBwzFr23zsE15PmWMYG4VWMEnbRipQcyigPzpUoTVF
         Z9ew==
X-Forwarded-Encrypted: i=1; AJvYcCXIy2qphlo8NS1xNMErsEvgljMYrNcUJ+5N8eK22wKDJ4iYf3QeETbn3dwe+PbZ74fgFmw+rgmpMB8lYZCsqWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqvn3kOquUt/Kb3tNfUfc/LTb3k99nEXUEDzSUfBEkt9X5p1LZ
	LVhlqgFyj48afsglWNVlJ9fJogQD7Sl+SKYcq0n0477f7seASKJ7Xq3c+jEQfbqhGLg=
X-Gm-Gg: ASbGnctuBjPWVepcwXfQViO3MftjASGAlV+RacH4uqLZwnPYMRNzdV0PmNguFjM6pJU
	skyfdi76Fm6Zv2Ydh+sxT9ZqoFPt52dSskmcAUnP05pdOGLi3RkGNGDhoplSmIp+XUXtmCnH0Ay
	vhVHa9DMEe+kD9ICT2u8/xq7OdsmYt4UYYkILqhL/GBct2kppOXg8kCyV7VZvj3LyncVP+6T5SJ
	pbGEbe6v+Te8k94eFV2PjGAGZULjCh8y1nldck6BJ86HxkcLO/1aRzuhKCAoNYM0zXIDFkcZaMI
	VS4ImeofIXxLSRq/YKXMKy2hQK2vNcF5FD2TdEjouzn0AuPRHAt2OBLae4bygOCu4P8Wolf9U6Q
	2S7Oorrt2XKKxDd2NSGzUVXq60IILWG0Uad9P1P/gvScb5l4zytQ=
X-Google-Smtp-Source: AGHT+IHnDWpjM1umgSyHsR6OREF3QxVVNfm6x8W+jII5XcXDsJKZeNe+EM7x++buErDbKkF9QmRQfw==
X-Received: by 2002:a17:907:7e93:b0:b02:a093:eac9 with SMTP id a640c23a62f3a-b1bc1169518mr637192866b.53.1758203628349;
        Thu, 18 Sep 2025 06:53:48 -0700 (PDT)
Received: from [172.20.10.3] ([109.166.131.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44bbcsm203026466b.5.2025.09.18.06.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:53:47 -0700 (PDT)
Message-ID: <c3ab4a21-183f-495a-b3b5-cc74b392eebc@linaro.org>
Date: Thu, 18 Sep 2025 16:53:45 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
To: Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand
 <david@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-10-eugen.hristev@linaro.org> <87cy7q9k8y.ffs@tglx>
 <87a52u9jyl.ffs@tglx> <8df2cf28-c15e-4692-a127-6a5c966a965e@linaro.org>
 <2bd45749-e483-45ea-9c55-74c5ba15b012@redhat.com> <87v7lh891c.ffs@tglx>
 <95ff36c2-284a-46ba-984b-a3286402ebf8@redhat.com>
 <24d6a51d-f5f8-44d7-94cb-58b71ebf473a@linaro.org>
 <7f4aa4c6-7b77-422b-9f7a-d01530c54bff@redhat.com> <87segk9az5.ffs@tglx>
 <f8d3c2d4-8399-4169-8527-3c87922f2ef1@redhat.com> <87jz1w88zq.ffs@tglx>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87jz1w88zq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 11:23, Thomas Gleixner wrote:
> On Wed, Sep 17 2025 at 21:03, David Hildenbrand wrote:
>>> As this is specific for the compiled kernel version you can define an
>>> extensible struct format for the table.
>>>
>>> struct inspect_entry {
>>> 	unsigned long	properties;
>>>          unsigned int	type;
>>>          unsigned int	id;
>>>          const char	name[$MAX_NAME_LEN];
>>> 	unsigned long	address;
>>>          unsigned long	length;
>>>          ....
>>> };
>>>
>>> @type
>>>         refers either to a table with type information, which describes
>>>         the struct in some way or just generate a detached compile time
>>>         description.
>>>
>>> @id
>>>         a unique id created at compile time or via registration at
>>>         runtime. Might not be required
>>
>> We discussed that maybe one would want some kind of a "class" 
>> description. For example we might have to register one pgdat area per 
>> node. Giving each one a unique name might be impractical / unreasonable.
>>
>> Still, someone would want to select / filter out all entries of the same 
>> "class".
>>
>> Just a thought.
> 
> Right. As I said this was mostly a insta brain dump to start a
> discussion. Seems it worked :)
> 
>>> @properties:
>>>
>>>          A "bitfield", which allows to mark this entry as (in)valid for a
>>>          particular consumer.
>>>
>>>          That obviously requires to modify these properties when the
>>>          requirements of a consumer change, new consumers arrive or new
>>>          producers are added, but I think it's easier to do that at the
>>>          producer side than maintaining filters on all consumer ends
>>>          forever.
>>
>> Question would be if that is not up to a consumer to decide ("allowlist" 
>> / filter) by class or id, stored elsewhere.
> 
> Yes, I looked at it the wrong way round. We should leave the filtering
> to the consumers. If you use allow lists, then a newly introduced class
> won't be automatically exposed everywhere.
> 
> Thanks,
> 
>         tglx


So, one direction to follow from this discussion is to have the
inspection entry and inspection table for all these entries.
Now, one burning question open for debate, is, should this reside into mm ?
mm/inspect.h would have to define the inspection entry struct, and some
macros to help everyone add an inspection entry.
E.g. INSPECTION_ENTRY(my ptr, my size);
and this would be used all over the kernel wherever folks want to
register something.
Now the second part is, where to keep all the inspection drivers ?
Would it make sense to have mm/inspection/inspection_helpers.h which
would keep the table start/end, some macros to traverse the tables, and
this would be included by the inspection drivers.
inspection drivers would then probe via any mechanism, and tap into the
inspection table.
I am thinking that my model with a single backend can be enhanced by
allowing any inspection driver to access it. And further on, each
inspection driver would register a notifier to be called when an entry
is being created or not. This would mean N possible drivers connected to
the table at the same time. ( if that would make sense...)
Would it make sense for pstore to have an inspection driver that would
be connected here to get different kinds of stuff ?
Would it make sense to have some debugfs driver that would just expose
to user space different regions ? Perhaps something similar with
/proc/kcore but not the whole kernel memory rather only the exposed
inspection entries.
Now, for the dynamic memory, e.g. memblock_alloc and friends ,
would it be interesting to have a flag e.g. MEMBLOCK_INSPECT, that would
be used when calling it, and in the background, this would request an
inspection_entry being created ? Or it makes more sense to call some
function like inspect_register as a different call directly at the
allocation point ?

Feel free to throw your opinion at each of the above.
Thanks for helping out !
