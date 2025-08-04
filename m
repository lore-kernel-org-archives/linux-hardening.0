Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CD253931
	for <linux-hardening@vger.kernel.org>; Mon,  4 Aug 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309809; cv=none; b=eOLNFs3h+EtlnafXa576nyLEhloYC1xrXbICf9f4Nu55sXKABZlZvv08SZAySsQVUrHudJnHJKxfAVi3O/1l4ReDg+Kl9lTlq390uP5RPIe7vic7v1jdGzuGDPZ8M7Jhgd8smghMeVB5+vqZybx+Fv2rlnZTuElepVrEFtUy4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309809; c=relaxed/simple;
	bh=awU+T6Ftp2Kkneag8TpAZKgxjvoOPHpg4vGF0gRImD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/cL6JjGs6+Q/tfPH5eQP2JitzZIem4ptEuwhtFM61qQXS4RZoRw81hKb7BJKTH2WHiOmo+2tM+GHfR0OHyl4kE4Qy+Gpt+nlQgeQ0C6cvPlq9UhUM94XFVJ1LTxs5/ITpVwdJpcsX9ya1M8N+CW2Piah+YvkXi/AqXa2mZxiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWAIUrNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWAIUrNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754309806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=smTivLN7vGpmKkbSDiw2L8Umpu8NAfTaDV1GiCt7zpg=;
	b=WWAIUrNwW08ncQ7SUc98EZz7/MHmdsn8hcBdZhU4HfZ8bWn05DG4T7BRCMxvOpjtedKshk
	DD7l3nJV1qUP2g7o77MQTbaY+RHGphCw/KwgxAWyuUzrEzaNgxboG9Z4i7dAU5rmmiYM1w
	0yY+qCd/X18TUNTp2bkYMGg02XBJLnw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216--JU827uUOAuRTOM4XEDduw-1; Mon, 04 Aug 2025 08:16:45 -0400
X-MC-Unique: -JU827uUOAuRTOM4XEDduw-1
X-Mimecast-MFC-AGG-ID: -JU827uUOAuRTOM4XEDduw_1754309804
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b780da0ab6so1871297f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Aug 2025 05:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754309804; x=1754914604;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=smTivLN7vGpmKkbSDiw2L8Umpu8NAfTaDV1GiCt7zpg=;
        b=S3b9iBreVqY6NZu7LMo6awRFoiWnlNYGOCrAtlwioFH8d0WmNHoS4wzdoL1tvTAqOd
         kmF8gzlJoODw6FfHX5cUJlwctecY+jgnxU1P+TQ4n+rByJHgkVTKxQeaZaZ2qCWfRBC3
         1bkAbSaX8aDMeOchuDzFEmL1nop/wqGatQb1dUQq2BRa/ybEqXg5JOUOYc/CtxUE3k6q
         xyIGlrVEjAlgV7xX3/4HMQQs+4c+V4oe5Npb8wnb9Lr+p9GBUPdKdePy5t+9ZrRNSSGI
         55nvyB6arV4UaM8X30NCHDGyAUKy9In854ybmhx+O8Rnc+DeeVJjeFS5+G6myW3iYCaB
         tUOg==
X-Forwarded-Encrypted: i=1; AJvYcCUj8m1EKd0tFGTamAY330JdZf73l24SPL398aoYijcXslTJar05BpLJw3CmCoJ1mL9gnmB+9y8/xwdzy3+bU04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDcfvPAYXdqU9QdqX4fyxxJxO3+DFd1IeWEnAVTbolkLyJvD9
	1VTUd0gZr81g0ijSIFCTKTd3sGuxosX9D4KjQegOqz2GG8B4BYHYRGPdc0MhRMGB5GUfsJel07E
	AHR0/cDyyY7hXtUgN8MtIsgp58ZhcsM8zhxv5l36h6LouSoxCsSwf+Fi8SGhSPVePKlr1AA==
X-Gm-Gg: ASbGncvI5akCTinEEJH5XHNMRx3ihW+ujNVFHDu8jwn0cawEH5HDGHZwtbIWMjhmlge
	lDRzjPSDA+Ozh6/+M3IMR3TkjyCRhxj/b0fCxkxmpKoGnB2GrC89Oyo9mSwD3I5g5ntlqHVg7AZ
	CfZaLEOlILcXfjWVHmcT/51hg0jN/4gaeJv13EPQIfbinzHo34jlxmCPK2DGHTvvPEOAv0IHRST
	U/oua40uLEHUukysE+JXdcc4XKs5IoTek+NS91jST+Pns+bxe3l7/XqgGkcBEiawbYcYZqDnfGv
	NAV8U9KcHKaTFLV7aYxDm6uJlHmWkTs6+RkiUUT+2qqoiZATERelDY0xLj37L9G+5uudnDM/0tv
	6yJc1r+jPEBAfdHVlQuhoi5HrEUH161L03WEBbTHswPrjvGACHnD9Xb5PoNhZUdLq18A=
X-Received: by 2002:a05:6000:4312:b0:3b8:d081:3240 with SMTP id ffacd0b85a97d-3b8d9469b94mr7277490f8f.1.1754309804031;
        Mon, 04 Aug 2025 05:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF62zIj5iO+0NeyVqAEhpgd+//vlpeQVUkWLMm00GOI4VdqPyH3d/dI3sWmYI2aRdRjphW97w==
X-Received: by 2002:a05:6000:4312:b0:3b8:d081:3240 with SMTP id ffacd0b85a97d-3b8d9469b94mr7277455f8f.1.1754309803502;
        Mon, 04 Aug 2025 05:16:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfd983sm166628015e9.13.2025.08.04.05.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:16:42 -0700 (PDT)
Message-ID: <dd27cf00-b9b8-4231-a6d1-9ad6562d0074@redhat.com>
Date: Mon, 4 Aug 2025 14:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Michal Hocko <mhocko@suse.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, corbet@lwn.net, mojha@qti.qualcomm.com,
 rostedt@goodmis.org, jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJCRgXYIjbJ01RsK@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -szQvgaNZtyvnlNGbVjjqeltdpiGExwiEnI6E1HjNos_1754309804
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 12:54, Michal Hocko wrote:
> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>> On 30.07.25 15:57, Eugen Hristev wrote:
> [...]
>>> Yes, registering after is also an option. Initially this is how I
>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>> here:
>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>> Do you think we can continue that discussion , or maybe start it here ?
>>
>> Yeah, I don't like that, but I can see how we ended up here.
>>
>> I also don't quite like the idea that we must encode here what to include in
>> a dump and what not ...
>>
>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>> where we e.g., have
>>
>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>
>> Could we similar have some place where we construct what to dump similarly,
>> just not using the current values, but the memory ranges?
> 
> All those symbols are part of kallsyms, right? Can we just use kallsyms
> infrastructure and a list of symbols to get what we need from there?
> 
> In other words the list of symbols to be completely external to the code
> that is defining them?

That was the idea. All we should need is the start+size of the ranges. 
No need to have these kmemdump specifics all over the kernel.

-- 
Cheers,

David / dhildenb

