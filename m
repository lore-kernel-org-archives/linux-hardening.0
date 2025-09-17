Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B828B51E
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119174; cv=none; b=WVohei8hDiLGLl3/tlycs87GhT0zRkSDkZk1WeDvaHmu/8Fl5xYDWuiapupdYNQMtDi+eQtmpTYWjJPgVRZsTI/ayKDN4mCird4zbDEWLhk/f6pPBgHnRrGrA1BCVmApZW2BDqEtOWlei7G5ow3TdqtGHYuXyw33my8LL1hgJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119174; c=relaxed/simple;
	bh=JZxC59+l0K5DkGdV5aRYQYUWp1YC5ovZfqzD3FPsuz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9GD+ab1IPKjMFPTKTHl/77Y1Ekcoa2ZTJQ8Kwh1jEw8/NXpz2bJqNVGHRHB0/fIQtjX9UvDJ647KEOi13jbJL+sa2mtR8s9wCzV8dsl2ZITAp6fEP4C+k11KvpLZgzHs+lnlzJCr9LfH0BjSn635oXu3pRCjqKTlBjlz8Pov9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMacfxa6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMacfxa6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so553310266b.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119171; x=1758723971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10t2Z6sgnABIAwDZkTB26QdFfX0ldYEILJpBIALC4NU=;
        b=wMacfxa64V+hZqJdlMnXg2iSd8LdTVPmi5yXWNYYsPUQc/J8+hrz4DoD5nrQhJ42fn
         lqYPw4FMS30yNrWWuIwJIIfpA35RmuASBsHIvLBSzdg20DpRwJU7UuxQdqsfZZ/myoN2
         BgmpKgzbgIR9kuV8egT9fW7/uShJv18fYzfI5NdxS/JAzWA7HSLDoVYVOjt1/v+LZHOP
         73H2hVA/lfUhzCm3SsnPH1BFNGNc5ii4yvJvXJunecjrn419i291yAPce4q3nT6ClaCZ
         ZMWGweox/NDihX+XLcQlPvFDH8S2PZNE5jw3jJYdSH+c1b3qisNVF4MkZ9md+bo3CF72
         4TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119171; x=1758723971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10t2Z6sgnABIAwDZkTB26QdFfX0ldYEILJpBIALC4NU=;
        b=Z2XChr40bRiO3HbxEDuQY/Ygjs4Cf0+NGDdmLHatGhfHdbTnCTsQxycg+aGe9YO/Op
         0JJnYOdAfPNVmk8WC+AV8kbAfs+EdV96dEA6ZLLYIY7QUTiytBYMQqU31SVJk8txgd7h
         j5OVHrvms41yK5lK03nm+BfnxZXlP+WLPOdb51vRCWi5x/e99la+7pd9RDA+RKYlVVN4
         hBZ0x6a72/c+UwDJY1+rvpypfyE7bPeqPAIQAY57s98YYL2WpcLiT6BUL7KOhbWHwGk3
         3JC7G2ofojarirH4dxo54jUQ1TfdyKaR8tHE5yQcLInxQGiajk6bRTBOoirzeFxijROV
         HdqA==
X-Forwarded-Encrypted: i=1; AJvYcCXl56EzXWwDlcX7ZU4NOxuF+oNbS0DOX9Scl/fU1bRU8ATtn+U1PgAceJHdeMHVskAfVWwxWkFH8F9F4n3uAIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPv4OR1KsMLdTAdV3yzzuioPx05jEsI9eG6ZPZNcyMAaCX69iF
	U/GodoQspmx81pCghbmnX9AOIaQQxBa5cvlcKEYJ6z5sfBgKD0+ZfvaO3zpzxp3IV50=
X-Gm-Gg: ASbGncvP9I0tQdyw1gOlmgMFbfC1D//c5UQ8+ih9HWJj10Gx2oyaX5LeGOvtzflp/yI
	psa+exPjT4pRStgHizrWX+uEDan7X5U8xaif+R4IQnKh/zJX22b25HSHILXleN+6gLAQChndVij
	ZsZhJnKbdixipaPhDTuo5x66WY+EK0hNgw/ZU9wD418RXVymScT1lTixj3gLw2jKcvL1R2I/PW9
	eoGExerFha0YT9FnJQKusf7M0gh8zGpnQPIJ8AvdVbb+DVbGLJ7YXE8Te1daWu0XUjLHyvLEVIM
	CmyBJgIUq2mVzZvvbA7MaS/wzUdaA3mv8V6/jEwCuQ4p0jCT6vu0E+vIh2goH0l1VfNfYbeL/Hl
	/+TuFGyUDfsfJdXO6x8iiQCCe5jVpl7QdVBpbgcWOphA=
X-Google-Smtp-Source: AGHT+IEaxm2Ezs6X9pAGeZTfGiDeZKKFcv9jYxAWmPiRXScidoOV/iqJhV2uKVKOhqCyY8zfonbwMA==
X-Received: by 2002:a17:907:970e:b0:afe:c2e7:3705 with SMTP id a640c23a62f3a-b1bb2d0f4fdmr263147466b.22.1758119170855;
        Wed, 17 Sep 2025 07:26:10 -0700 (PDT)
Received: from [172.20.10.3] ([109.166.135.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b90sm1356906866b.109.2025.09.17.07.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:26:10 -0700 (PDT)
Message-ID: <b8a0586e-a79a-4e14-87d8-ee156436d1b0@linaro.org>
Date: Wed, 17 Sep 2025 17:26:08 +0300
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
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87v7lh891c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 17:10, Thomas Gleixner wrote:
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
> 
>> Some other subsystem wants to have access to this information. I agree 
>> that exposing these variables as r/w globally is not ideal.
> 
> It's a nono in this case. We had bugs (long ago) where people fiddled
> with this stuff (I assume accidentally for my mental sanity sake) and
> caused really nasty to debug issues. C is a horrible language to
> encapsulate stuff properly as we all know.
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

+1 from my side.

> 
> Sure, you can achieve the same thing with an accessor function. In case
> of nr_irqs there is already one: irq_get_nr_irqs(), but for places which

Not really. I cannot use this accessory function because it returns the
<value> of nr_irqs. To have this working with a debug tool, I need to
dump the actual memory where nr_irqs reside. This is because any debug
tool will not call any function or code, rather look in the dump where
is the variable to find its value. And nr_irqs is not in the coredump
image if it's not registered itself into kmemdump.
So to make it work, the accessory would have to return a pointer to
nr_irqs. Which is wrong. Returning a pointer to a static, outside of the
subsystem, is not right from my point of view.

> do not expose the information already for real functional reasons adding
> such helpers just for this coredump muck is really worse than having a
> clearly descriptive and obvious annotation which results in the section
> build.
> 
> The charm of sections is that they don't neither extra code nor stubs or
> ifdeffery when a certain subsystem is disabled and therefore no
> information available.
> 
> I'm not insisting on sections, but having a table of 2k instead of
> hundred functions, stubs and whatever is definitely a win to me.
> 
> Thanks,
> 
>         tglx

