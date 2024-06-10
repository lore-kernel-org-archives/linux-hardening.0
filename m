Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2A1C6A4
	for <linux-hardening@vger.kernel.org>; Mon, 10 Jun 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003303; cv=none; b=ELgEpASkaFqqeiV6GpgEo7FURxmgeE/oiLoA4Qsf8VxAED/3SK/wekRDkHLbvEeX7bMRjIc8qRK1lDouG+ZunwlmQsB75ubr+jH34lsfpbORNvAsmsOsQ/GZ886fLLnPZH9TZ4j6ED2bAEWqiEnZyk9roVvy/wRePGrkr51UvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003303; c=relaxed/simple;
	bh=QEP/zaNAd6rVQEJ7AQSX8sXbT4ui22VLn/jbIusAu0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=InUMVuoxpdwqQmktll4bRtvenYu81Am9xZi9rjYz2s8alRUPtcu3YgG9yhiY7ZeMluvkYKyRbDtDgrPzjgPGMEfE8sOFiSgNPRgyntYXJ0pTXnelEYhg/bMcWIVQWXfc8MxxT9XXTpMHKTuesdF5Vcio/bTqstKdNxnQxn/Qp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HRJTc3ud; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HRJTc3ud"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so2960389a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jun 2024 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718003300; x=1718608100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iVrI5GsrQNLTME723VL0GXEMwV6fiHKNH1QpwFztIZA=;
        b=HRJTc3udHCGHshWdZL93VbqnKKjErnegxjtkRgw1Wo0PKCawTN9ohGQLP9h0TA17Zf
         fbF+1/U3GipxYUNwSu6y3aMwrASCy4uAZ9ygrvproX7lftE41KqagrEYPt0CFTxv6O9M
         X2XQLMzeJ27Z4HiQrwbrjiKKKGgxdpIheSgpVfdmiNEreRIUVKFmz2TBdtq5r2iwggQq
         B6FiXo4l2RHrmgBQanBksYLraQ6VvUJWkzmNBIAM7cL8BLCjvIGhc4Wtz2YZsKIfoNpB
         DfUv/JM0h+T/98IkMU7unGJESIDudKYyVKxA2iprezwTMdF/gyKVV6xlEiFgkTIwZMlN
         1CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003300; x=1718608100;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVrI5GsrQNLTME723VL0GXEMwV6fiHKNH1QpwFztIZA=;
        b=gPpv4UHOOEGqO2+mRIG+5uYeBAlvY4Dh3dhGVgnDS7+uzK1rF4xjPq2Xgw273hTu7b
         u2LyleWQLXYZ5FTkJWaI+dEsITJwXgCGvzOaQbpWaC/KU67hgxjm9gqQKZ2u8O8Ro+aV
         F9YMvFCLAuaQuAR6GpsVP25OG849Dv12YWjBOrBHAA5y+RdvrFmOkZ9p6crWM34Zpkuj
         utKVsTVsG6vcvWhihYmF9+5DTLmkI6QKU/yhbifK0TMvQzrHiMScpPqAD6SJYis69OtF
         5HcguBVU7H/5Fp4sbEigzUWvJYZOTWswHi0N7fgC4hrjCdv52OR4spL9CLWhsiS8bNK8
         gmKA==
X-Forwarded-Encrypted: i=1; AJvYcCUD8kaE0qDH7LFfuDL15NcO7EpdYFgHXGCwLOYpzOOdCQzUt1il4LQgxEfAPY4Li58eLyjOVcEaIDLW7qu6V3epfxS6AVHKqaCfH+p3xeV1
X-Gm-Message-State: AOJu0Yzw5RCM2MCP8YqC3iBsb3p/oN2H7XJ1/SJPo4q0iBwS8Rc2J98u
	BXIfOHBI/dn5TOdJ6nGa9TvDZ50XMb2BlQJO9R90a0QnKtNXpc1EjkYcUN6fFz8=
X-Google-Smtp-Source: AGHT+IHrLJutCqFB6QyRHYps/IiSSbjoC3LCsYCwOb37kfga8SmQTAXj6uBl+DbsZS27mM1A/ddGQg==
X-Received: by 2002:a50:ab1a:0:b0:57c:6c98:b61f with SMTP id 4fb4d7f45d1cf-57c6c98b88emr3430720a12.42.1718003300041;
        Mon, 10 Jun 2024 00:08:20 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e? ([2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7681d659sm2427026a12.54.2024.06.10.00.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:08:19 -0700 (PDT)
Message-ID: <d827e5ab-6204-4a47-a8af-a1eedd76b070@suse.com>
Date: Mon, 10 Jun 2024 10:08:18 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
From: Nikolay Borisov <nik.borisov@suse.com>
To: Kees Cook <kees@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <202405310923.78257B2B3@keescook>
 <a54db95c-e22a-4e13-ae4b-6a5a67d1c49b@suse.com>
Content-Language: en-US
In-Reply-To: <a54db95c-e22a-4e13-ae4b-6a5a67d1c49b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1.06.24 г. 10:27 ч., Nikolay Borisov wrote:
> 
> 
> On 31.05.24 г. 19:28 ч., Kees Cook wrote:
>> On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
>>> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
>>>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>>>>> 'make W=1 C=1' warning:
>>>>>
>>>>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol 
>>>>> '__fortify_panic' was not declared. Should it be static?
>>>>
>>>> Actually doesn't it make sense to have this defined under ../string.h ?
>>>> Actually given that we don't have any string fortification under the
>>>> boot/  why have the fortify _* functions at all ?
>>>
>>> I'll let Kees answer these questions since I just took guidance from 
>>> him :)
>>
>> Ah-ha, I see what's happening. When not built with
>> CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
>> has the function definition, we get a warning that the function
>> declaration was never seen. This is likely the better solution:
> 
> fortify-strings.h is used in include/linux/string.h. However all the 
> files in the decompressor are using a local copy of string.h and not the 
> kernel-wide. When pre-processing misc.c with FORTIFY_SOURCE enabled 
> here's the status:
> 
> $ grep -i fortify  arch/x86/boot/compressed/misc.i
> void __fortify_panic(const u8 reason, size_t avail, size_t size)
> 
> It seems the decompressor is not using fortify-string at all because 
> it's not using the global string.h ?

Kees, care to comment about my observation? Have I missed anything? 
Reading the following articles : 
https://www.redhat.com/en/blog/enhance-application-security-fortifysource

it seems that fortification comes from using the system header string.h 
(in our case that'd be include/linux/string.h) which is not being used 
by the decompressor at all so simply removing the function definition 
should be the correct fix, no ?



<snip>
