Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7818E25
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702160; cv=none; b=mo1nsvC+9ZLarnygVbWgwXGaSF8wqA89VJu/oyKw8DxXppfqOKbaehS+cE6NatE2l49r4/ssQ7vJXgamCgUpbk+DYRiPMwhCBMqYsXS9GF/1UJBC4kBFMx/Jjoig1hv5NYoTQpHm7n5KENnOh5mTCilbanUfyIGBR2W+W+cVc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702160; c=relaxed/simple;
	bh=y4gWWqmz84oG206JRwdNKi7A9nqe8+bM/0jPZWiNXtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kweEjAJUjoX2t55MpQAdkGGIreWGFC/DRVPYZAZhcLFUdoC63g8H1h249NFmntdgZ6FtGtAtCh9ZlcMGUgsyNJcP/Xoq8ki0HesvKk5XdFbp9BScICdXviPT3DlDhtD35J60JoJp99vLEbnkFff3M7OSCsg+niZw0QB80JrUtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeOxtFpt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeOxtFpt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d19699240dso1893314f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757702157; x=1758306957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTwLCqYrxP4A65CpeLdDZfX/1/5VrrEeFcGj8O2B7PY=;
        b=TeOxtFptWOd1RU9pHqHLwx2CyO2LBGwUxnU+jShsmNmONkCQB/x2UZkLqoIKZlziZh
         /oumduplmrNAWzJ85JCY9ON3Y7PVG2dcE+tOcK/wbSo5wqspnWaObSgEvOkcazk25P41
         OH8Po3w0R0ixOXE6nP+fhUDpHYaiHKcihJRB9k5xqGdZpYxnL3Ty1Nslx+KcvABgzd+z
         VZMG6kYSdLmivO6XWXfZDD8VQSwJ5JNLBu+JdnKZFfJ9a501LJFKaEWknwKUS/ygzUOy
         6U82LPqwAZ2zRvO95NRQzOrUUeBj7DVRvPXm+kjR76ZYzfFfMnc2JoP7wPDtcoBA4eQs
         SJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702157; x=1758306957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTwLCqYrxP4A65CpeLdDZfX/1/5VrrEeFcGj8O2B7PY=;
        b=jXww/aU/nrxjIPj4jobdjj4Na9Z6A3byGJAqpkwJrRefE60DarKrabFPpQ74L+KV/N
         M5iQ4+O7vaXlVEwtRiYo5tvG37Uf2QU0L9LUdKjIgHU45/AWGU6sOApj7QwS7a8iihco
         f0F+9874S+GC2wZxMNDjHIAjmRp9w33VdwjdcckwwMNpkoujpOkbJ3lM4Iq4NSaIkuG5
         hf5DmyCML8suIKPdCHbp6MWsZsbJn088OdsRw5xdA7GcAa0H8Q6zc2K4jISH3Zj3UbET
         tqaUiEFgIWmwNCM/y42p3k+wJBtCpBRG0ufUVvHXtxsz3Y6HOUpEE3HujQtwuBakR6WG
         cwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkRebDOlNr5QLOJzFpVA90p1U9m3Ymh9VSpt1Gj+qwebt7A3i/abUKltdlHuiqW5Q0/OdNv7rgtHYYXUCkSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon5wuJoqBRA1fUW2qi86XT2nkBrhWb0vCc8WO4lyfkHgUOCy+
	uqfKfxC7CHyUw8NCwuikLlFBYu9HhGoN8zaRyeqIjH5hRenHNK4DLVWPINH+heZ9+9s=
X-Gm-Gg: ASbGncsuM9uWjteELlES+3mvhYrvnyAXKwmeKC8lCfSEUaFiZBCVmWRVU7MneHIFnXZ
	MOnzeBGl3Wz8v/TIHLP1OVhre5HV6TxBj9BWCoSPu/7/OzgwUdfdjVH+/qS4EwHUvg0gsuY1XZJ
	mu8wPOaBXSzWcSHPin3fsP28Yv9WPTeMHzfTSRi7nja4hxvToZ4igwvEsk7dfokDciVlbtot6/R
	kuzKo3ej+PIieKjgGGuZz/21rdOu9Yba+uRS7vPeR+GtGjnXstmjBU2IGEBg27Xd5prfcmPgXB4
	G+U2xlpTVacN5UeCxp5fJRGPspSKVfBXV7dL2DZnhuFvF/AT9070ys6gqDV7Ns7Qhoemahusbjj
	8iAl+gXhKJi6zfnn2WVjz2ixuqs7D+4fu7uZiplP4Dot7bg==
X-Google-Smtp-Source: AGHT+IEFXfAwL8n5C3J9dCog5MqYjz/0z+tjRYy8VBux8QIcdwHNBxHHgPhwuMllRtUOig1ksCGmnw==
X-Received: by 2002:a05:6000:26c6:b0:3cf:3f1:acd8 with SMTP id ffacd0b85a97d-3e765a2367emr4237912f8f.28.1757702157424;
        Fri, 12 Sep 2025 11:35:57 -0700 (PDT)
Received: from [192.168.68.105] ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm7293297f8f.39.2025.09.12.11.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 11:35:57 -0700 (PDT)
Message-ID: <0bc838d3-26ad-4f2f-8bb5-1c34748e1fbb@linaro.org>
Date: Fri, 12 Sep 2025 21:35:54 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 00/16] Introduce kmemdump
To: David Hildenbrand <david@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <9c2e289c-0258-4e25-aaeb-a97be89ebd84@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <9c2e289c-0258-4e25-aaeb-a97be89ebd84@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 18:56, David Hildenbrand wrote:
>>
>> Changelog since the v2 of the RFC:
>> - V2 available here : https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
>> - Removed the .section as requested by David Hildenbrand.
>> - Moved all kmemdump registration(when possible) to vmcoreinfo.
>> - Because of this, some of the variables that I was registering had to be non-static
>> so I had to modify this as per David Hildenbrand suggestion.
>> - Fixed minor things in the Kinfo driver: one field was broken, fixed some
>> compiler warnings, fixed the copyright and remove some useless includes.
>> - Moved the whole kmemdump from drivers/debug into mm/ and Kconfigs into mm/Kconfig.debug
>> and it's now available in kernel hacking, as per Randy Dunlap review
>> - Reworked some of the Documentation as per review from Jon Corbet
> 
> IIUC, it's now only printk.c where we do kmemdump-related magic, right?
> 

Yes. The other places just have some changes such that I am able to
gather the data inside vmcoreinfo. (remove static, add some function to
get sizes)

