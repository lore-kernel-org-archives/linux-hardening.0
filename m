Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04321C84AC
	for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574415; cv=none; b=uY8osLmOuTHKwIXg/dmjc5kcLjd+g+jdlBtpH8YEqJ4qUL8Dnr2UrRUKm6O/mtLulkj7u/g4ooDUR1oRCPnTnEFzZR+ggYanZgElGmDa3ac2zA98zY+Wqhkni8ywswb9AfTF31NITIud+FSKWSTwjCkeC4i+71iWRj8w47E3skU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574415; c=relaxed/simple;
	bh=KyQL3L0qpc6BP+Wc2cClrEFXi5QBtwDn66b2cUtQHGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLf+4JAeq9jreWM0bx5XLZO1HJAjs4N98dZBK2aRxTDKHTSjXdFVaew8eZJvksc29Dote5i+tCSldOgoWBYSpJV1LxvrmfE1S32vLGzEXkPyZaOQU6RnXzpp9ytNx5zq9Yuq6q7j0qrpek2YKvj4l/AjcsQkkZ7XIaaSmC9l7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=GOuUc9rR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GOuUc9rR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38de1a5f039so2372211f8f.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739574412; x=1740179212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PB+r6JvVzie2JvMnY5R6Nkb8yUTw2Iu5MRXRiO5OIrs=;
        b=GOuUc9rRT02Q4U23i5kui/A2Bmjf6IcdJ+UIJc98pgRgVeEGOQuoURAvkxdF9Yx6rD
         mwUaZOwVs0G1SeoV+7u9i7i3ymmr670xx/ilYbq/2h28jcsknLpm07iy605tk3I9VO1p
         4n0ilTUgiP+38IcixEmuuHlhW+bcnCD0+MEZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574412; x=1740179212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB+r6JvVzie2JvMnY5R6Nkb8yUTw2Iu5MRXRiO5OIrs=;
        b=urfAxoGcawxJXz7FIt+APe6jBJMryIAoFvSL/RSu7MRLkB44TADcRxcSngtZI/ROa/
         6/Eb3NKCxNTr4UVXTMvBOxsTBNQyyK5dP4KvbI8lR0ji5+/PCDZ+CR886pjcdWJNM5dV
         T2aHawYbYALVbiLEc2ZSbQwyVfLhG0ygY1a2mMA3brcqbO69qn2ldyo23IMtzTzfRIZb
         UsgVMRg4HyHWR9cPKIjv+MqtIQErkw9wljyHj/HBolmdluhoNEzP/CXZZn6ATvsstTHM
         y1Ybk0xMk9E+kpBrcy7bSww6knfMgEKCxHLhPBwwvSUkNOtSf2W8lEuh338aqj5foqj3
         mRqw==
X-Forwarded-Encrypted: i=1; AJvYcCUz41m4ZSL7SJPJc3zmZcM2CH1s3E36F3pov0e33qEX7N36S4I3RYo2n7SNCMk+S0sRfsSTtderk9g1pYncBoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcvcnQcoUE2TbbV/hC0zc/nUrvEO9RagkM54vd8Iwa6qI23JI
	vpEExDu98EutMfGJdNLhMM8tIGaLBTPuaVTc5Ry7cLQjahr4pFOsuB49lIfv+RQ=
X-Gm-Gg: ASbGncuUoFCbRBtHVb7bvvJvNX3OuTCtDaK1Wm7Aaja5poQFig2/G1+nevXOllcsbTC
	oGGprjTQqIYDMXhZOze0M9BxeOfQasejVxcvmCtjWwBj2YBiYk0apR9hfxtQ6lAii0uYpIGVAEz
	7hjgRcyMln7DHK/aEX/5ancM962gUxlAB9rIyU/O8riLp7cttcyAL6UYdifpDzuYylnerRP++Di
	43rM/m6Dkreg7s/drQJZ5Dg+stD8Ed+9RV0o38rw59ZaSXRYTqodPONrcxLWw/F3YMYKn454Txe
	CB34k4Z1QP3LWb4MmVJRjz2Ql6ugNO5iN6vVrAseOqMHHL8Hwa88AAM=
X-Google-Smtp-Source: AGHT+IFLQd2UoaUoR8vSrVkmfa1fsW1c99PulW/ZI1I/6rPcmxTRozmB9oTxgdVe8prRiiraCjwMUg==
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f33f57459mr1030799f8f.53.1739574412141;
        Fri, 14 Feb 2025 15:06:52 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5923sm5795765f8f.74.2025.02.14.15.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 15:06:51 -0800 (PST)
Message-ID: <c2af5771-1c16-4ac8-bc09-c33d07956358@citrix.com>
Date: Fri, 14 Feb 2025 23:06:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>, Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, linux-hardening@vger.kernel.org,
 kees@kernel.org, joao@overdrivepizza.com, samitolvanen@google.com,
 kernel list <linux-kernel@vger.kernel.org>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com> <Z65/Fpd9cnUk8TjE@ubun>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z65/Fpd9cnUk8TjE@ubun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 11:24 pm, Jennifer Miller wrote:
> On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
>>>> ; swap stacks as normal
>>>>     mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+20>
>>>>     mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24>
>> ... these are memory accesses using the user %gs.  As you note a few
>> lines lower, %gs isn't safe at this point.
>>
>> A cunning attacker can make gs:[rip+0x7f02c56d] be a read-only mapping,
>> at point we'll have loaded an attacker controlled %rsp, then take #PF
>> trying to spill %rsp into pcpu_hot, and now we're running the pagefault
>> handler on an attacker controlled stack and gsbase.
>>
> I don't follow, the spill of %rsp into pcpu_hot occurs first, before we
> would move to the attacker controlled stack. This is Intel asm syntax,
> sorry if that was unclear.

No, sorry.  It's clearly written; I simply wasn't paying enough attention.

> Still, I hadn't considered misusing readonly/unmapped pages on the GPR
> register spill that follows. Could we enforce that the stack pointer we get
> be page aligned to prevent this vector? So that if one were to attempt to
> point the stack to readonly or unmapped memory they should be guaranteed to
> double fault?

Hmm.

Espfix64 does involve #DF recovering from a write to a read-only stack. 
(This broken corner of x86 is also fixed in FRED.   We fixed a *lot* of
thing.)

As long the #DF handler can be updated to safely distinguish espfix64
from this entrypoint attack, this seems like it might mitigate the
read-only case.
> I think we can do the overwrite at any point before actually calling into 
> the individual syscall handlers, really anywhere before potentially 
> hijacked indirect control flow can occur and then restore it just after 
> those return e.g., for the 64-bit path I am currently overwriting it at the
> start of do_syscall_64 and then restoring it just before 
> syscall_exit_to_user_mode. I'm not sure if there is any reason to do it
> sooner while we'd still be register constrained.

I don't follow.  If any "bad" execution is found in an entrypoint, Linux
needs to panic().  Detecting the malice involves clobbering an in-use
stack, and there's no ability to safely recover.

~Andrew
