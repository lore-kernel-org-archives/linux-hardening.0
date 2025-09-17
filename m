Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159421CA00
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120413; cv=none; b=EUAWxvg5UULdkRpERCWRMSOdYvZLEks7sppyKdhsK/tXFikPQhiED7gU4mgAvHgYwbhsRazACNr1zcbJuKDTaksXa2mLwE64ziLF0KYZh1WNrnXIbn61P7EAgUKmMQiA0pV61CE0eNQvCq6nozZYP0QFyFlZWqSQLVFi2l6HRy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120413; c=relaxed/simple;
	bh=2lwqeabpS4Qb/h6rApISah5NsygIIWv9QS8376+S61s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRC3PXLmeeQNrr0PeqZIC3S4/Ga85snbGbHDKAMFu5NrjdUpwChqEDhvHPLhoNAzIc/F019GBKod/c7Hm+h4VtlysT8AkZK2jXZbu/bAMgbKYAyrhm8zYuBBYpAGI0MWGPtbyIqqphD2rJVuG9pDPJfGO11vYwDJ25/noyXV7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO7Jg0E0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO7Jg0E0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758120410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ovZ8mJqkmoqvvz8O8MVpBxVpu4t3oTHY8vOE+XFxYc0=;
	b=CO7Jg0E0g+ELqKPb/HmxlX+MOpi0yMcPSmhH7nuKfCutS9uk/9ZNhPdnR7gs4cqJ+dhrsS
	WwOIyg/rZEgAvx6iBJ8RphsO45WVKlNAfkJvUysxQbaWKEeolT7kOxszy8HySLmUb7aTej
	ax1Uwcl+QdWyx9036PYTAXSUvczi+eM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-6M1rFb4aNcq1XaUus0A8fw-1; Wed, 17 Sep 2025 10:46:47 -0400
X-MC-Unique: 6M1rFb4aNcq1XaUus0A8fw-1
X-Mimecast-MFC-AGG-ID: 6M1rFb4aNcq1XaUus0A8fw_1758120406
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so6998085e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 07:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120406; x=1758725206;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovZ8mJqkmoqvvz8O8MVpBxVpu4t3oTHY8vOE+XFxYc0=;
        b=j4GOxFFRzH65O6b7rhv+3O4738XD+er0N/+u1rqyVkmd1qkIv2WRREcb7xYUFB9N5Z
         AvqFvMLw+MZijVoveBu+ebUZnzpbwtzFOXvrSZr+CiUD1MxKrmpowd/iUFQjtAZTSeFn
         78s5v+a08o+/C7OquUVl3gSVT32D2HdjtIiYJ4KccxJrcARz2xjtTDDVugrlkoQXxMnU
         tLvsU9sVa8P5UR/gKCrwV5el/Encj+bNhZt9jWxKfnU4HcQa0l2IA7K5ByyDMPGiy66a
         DT4gmpnLD3BupMHe8FrelDiextcvcDYuhi5lWTPD7Btt2elePmaiy8oAx2lupD+Cnkpg
         ot/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWodSyFwe1IdH+VSdyBZssUfH/hIdci4V2QIIKl/lSZ8uPVahFu4Y36ZsC/23gmt71YDqdSJDyBzEYjmbDgTlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdsfJX8EuM9Ec5uk08JSVnR8NXp0I903OuPfSBlICCRGqaKnK
	SDHymd3T4YODHKTenPzfd+h5PsHR6IWKH6D6bPedsUAEz4ACYd26Ky8jiOOXGEP3DIP6rmXGjlX
	IBI5Ql3niUJ6bz+VORvEEgk9Eqz80tQIWs1YtFU+gvrt6v3TIpNh4PdDOKQ7pXsaLT8ugvQ==
X-Gm-Gg: ASbGncsaJnagUGA5gbi6m64n8eRbKRQaWNMD5IC0hqXyrdiEzUo6lJWcnVDdBJgKZ+P
	80EFyO3kZdF1x8zBP3yKnllkoCXapyAy8dfz/MZp0qFyTLceHdusfxtd0RxaQMa6q53uew7qaan
	sAkO4kIgvrABJqsIMKHYxMj6QzkulhwFATcakAEEynx/eUYeWXndifBQSWJyG3juMURu+wW7UKi
	dS7saHkmc9nzskQcgnmYqgirB+9jk7mzVDZoE/B0uQp57L2NhUg3Pu4Z8CY6tAxoCtDjvrjpwzn
	eslCQaRLXoN7HtFdM530uwnnuMh75fVottNzXBREhuv7XS1ILixvgRUyCJSEmnmz4uLFtKcSdEM
	8Su5fzVSKnChr1b4xdpWrmRErQ6uXIDyYexrPSepZUw1YN6MC0HhMgTsF00cusOyr
X-Received: by 2002:a05:600c:4888:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-45f32d0869fmr46709615e9.7.1758120405800;
        Wed, 17 Sep 2025 07:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Ufl1M6AshTZE+vFOVXEwIa1YoUqQ1InS/YuHHadh0wrsGDimF+1HMnmk4PGp9MwHqliWqQ==
X-Received: by 2002:a05:600c:4888:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-45f32d0869fmr46709295e9.7.1758120405326;
        Wed, 17 Sep 2025 07:46:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325a32f6sm40132415e9.2.2025.09.17.07.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:46:44 -0700 (PDT)
Message-ID: <95ff36c2-284a-46ba-984b-a3286402ebf8@redhat.com>
Date: Wed, 17 Sep 2025 16:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
To: Thomas Gleixner <tglx@linutronix.de>,
 Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87v7lh891c.ffs@tglx>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e_QuE0xqH62fhqJOGD0fSM5cZZSw1-a7UF6sBlxke5I_1758120406
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 16:10, Thomas Gleixner wrote:
> On Wed, Sep 17 2025 at 09:16, David Hildenbrand wrote:
>> On 17.09.25 07:43, Eugen Hristev wrote:
>>> On 9/17/25 00:16, Thomas Gleixner wrote:
>>>> I pointed you to a solution for that and just because David does not
>>>> like it means that it's acceptable to fiddle in subsystems and expose
>>>> their carefully localized variables.
>>
>> It would have been great if we could have had that discussion in the
>> previous thread.
> 
> Sorry. I was busy with other stuff and did not pay attention to that
> discussion.

I understand, I'm busy with too much stuff such that sometimes it might 
be good to interrupt me earlier: "David, nooo, you're all wrong"

> 
>> Some other subsystem wants to have access to this information. I agree
>> that exposing these variables as r/w globally is not ideal.
> 
> It's a nono in this case. We had bugs (long ago) where people fiddled
> with this stuff (I assume accidentally for my mental sanity sake) and
> caused really nasty to debug issues. C is a horrible language to
> encapsulate stuff properly as we all know.

Yeah, there is this ACCESS_PRIVATE stuff but it only works with structs 
and relies on sparse IIRC.

> 
>> I raised the alternative of exposing areas or other information through
>> simple helper functions that kmemdump can just use to compose whatever
>> it needs to compose.
>>
>> Do we really need that .section thingy?
> 
> The section thing is simple and straight forward as it just puts the
> annotated stuff into the section along with size and id and I definitely
> find that more palatable, than sprinkling random functions all over the
> place to register stuff.
> 
> Sure, you can achieve the same thing with an accessor function. In case
> of nr_irqs there is already one: irq_get_nr_irqs(), but for places which

Right, the challenge really is that we want the memory range covered by 
that address, otherwise it would be easy.

> do not expose the information already for real functional reasons adding
> such helpers just for this coredump muck is really worse than having a
> clearly descriptive and obvious annotation which results in the section
> build.

Yeah, I'm mostly unhappy about the "#include <linux/kmemdump.h>" stuff.

Guess it would all feel less "kmemdump" specific if we would just have a 
generic way to tag/describe certain physical memory areas and kmemdump 
would simply make use of that.

For example, wondering if it could come in handy to have an ordinary 
vmcoreinfo header contain this information as well?

Case in point, right now we do in crash_save_vmcoreinfo_init()

	VMCOREINFO_SYMBOL_ARRAY(mem_section);
	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
	VMCOREINFO_STRUCT_SIZE(mem_section);

And in kmemdump code we do

	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_mem_section,
			     (void *)&mem_section, sizeof(mem_section));

I guess both cases actually describe roughly the same information: An 
area with a given name.

Note 1: Wondering if sizeof(mem_section) is actually correct in the 
kmemdump case

Note 2: Wondering if kmemdump would also want the struct size, not just 
the area length.

(memblock alloc wrappers are a separate discussion)

> 
> The charm of sections is that they don't neither extra code nor stubs or
> ifdeffery when a certain subsystem is disabled and therefore no
> information available.

Extra code is a very good point.

> 
> I'm not insisting on sections, but having a table of 2k instead of
> hundred functions, stubs and whatever is definitely a win to me.

So far it looks like it's not that many, but of course, the question 
would be how it evolves.

-- 
Cheers

David / dhildenb

