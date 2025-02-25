Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23A19E7E2
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507049; cv=none; b=U25fx4Ouj2sLYgYc1AqMjoFoyY7CQLzP8twAWxdzb9vTQldg9QPa6xzStJF5tZxX0oi4Q/D4R9N6olMwP0kOsAoFUe9j8Sb//uN9RTa9J9iXx/CjTh9I+cNEQ5wl2V7RBPFh4lhbMOBY56NIZUo+xP/xs148uuW2JYU9GX/O+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507049; c=relaxed/simple;
	bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+gB9Bhz+nr0igMLgKMzLNSGwccjFhvpwrGLTD1YUd6zFVX9R/pbilXe/3kKpcmZQXqbK4TSTxkfDw0dOxD50j4bgt9jIw824X5WPt0oBdI5gFFAh/8f+arbiXlPv0bQNf+tE5HTatd/R8jCOy8C1KkDhG38LR+zM0Xs0i7eh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vM2nQPXw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vM2nQPXw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so15434415e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740507045; x=1741111845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
        b=vM2nQPXw/WzSO+wmw1KTx7KrFS9ZLnE0auUpjWV8g17xs+s0tI3yH0HZKh+xAgwBHW
         NY82M/DMzXjs3OPc6booetmBlhUG7k5W3kWxNYiUfl3yuLaiAvvKznLAHqFAqUgz3wFN
         R1HWshOpTCyJuv2kvC+PUVZJawQrNiq/ZrTRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507045; x=1741111845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
        b=Wq510D7+0eUzyxXjswt7GRwGqlpDvNbQEQeKWXBYwP4PPK4xXoHBqxy9cRJvOck6ff
         XHblv4hx654y20zkj8Gm/X2uxTaaieMMFJsEeNYC3OO7hvUJakqx5hkhImrDNR4JwH1y
         k1iX46zps0FPlVyEEqm0SUE0g5IUPe47VXrBNoyy08AFRQBLlpjpzmYJ/DV2FjjHIFcB
         Xc1+RFhLRlEQkXPD5Pp8A7oC3SjzZc7u4Ike6gU1jB734qTAbaSztAMJHOQ8q3javev2
         XF4XiWaytdCM8Dy9w9v1lDi2sSrkVjf1EtOwBOpulLLigdGQJGnZ3SA4/43gQFPpvGGx
         d/1w==
X-Forwarded-Encrypted: i=1; AJvYcCXnF8pqf2fO8r/YMpseAjPaiWkD/EqilGoaWjRhvkapYlgvEeaYr9O1WqiY9Z/KdiND+BCJC4Wv2uy6MVF6frA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JQpmbYRgqD8aC2rd3g46jSmHFDkqWToC1G4mXwhnpBO09/JN
	rxDfXsfQX+UzI1Vxs0aox4Y+eLuveSA+GR0tcDYIG/8I15p03wC22lGxaxEU79g=
X-Gm-Gg: ASbGncvi/l2/zsq4v3wsgOkIqeJHXPkZJNK9qI93oLcJpUT+tGuPn2FQ7Ybi8zSmJOe
	tO7nno4/szXy47VxI2O/msiG4n5F/wAa7wJqBPr0KDpJNCHuY4sEwlB57oLoY/uQx5NejTYuEux
	j98DU9VJx94UZlsTdexTyoxlPlFQZUfdi2/ulsCXux88BF3/nFX0LtNRDs4pWsOrJdPaFGNP+pT
	vWFyZc/quyQRQCdaN9N8plrOs/PWo63J4JWRJvmBj8w8qOKTitv4I8i6uq6Am1L74wWJs9phHfK
	P/rWOGBTgsX2sj+n4gdABz2sWuWoPJz0Z67XRGDyGdiGbUieWwSHQwRW/tob45w/iQ==
X-Google-Smtp-Source: AGHT+IG9zEYrz279GnRlIYQx2hGfJtQTkJ0pTYmtHboiyYfH27LPFowEQjM9SOPBl/uYZJVX95Hruw==
X-Received: by 2002:a05:600c:1e23:b0:439:987c:2309 with SMTP id 5b1f17b1804b1-439ae221d7dmr149222535e9.27.1740507045584;
        Tue, 25 Feb 2025 10:10:45 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c40fd2sm24904785e9.0.2025.02.25.10.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:10:45 -0800 (PST)
Message-ID: <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
Date: Tue, 25 Feb 2025 18:10:44 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Rudolf Marek <r.marek@assembler.cz>, Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
 <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
 <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2025 8:43 pm, Rudolf Marek wrote:
> Hi,
>
> Dne 13. 02. 25 v 3:42 Andrew Cooper napsal(a):
>> The SYSCALL behaviour TLDR is:
>>
>>      %rcx = %rip
>>      %r11 = %eflags
>>      %cs = fixed attr
>>      %ss = fixed attr
>>      %rip = MSR_LSTAR
>>
>> which means that %rcx (old rip) is the only piece of state which
>> userspace can't feasibly forge (and therefore could distinguish a
>> SYSCALL from user vs kernel mode), yet if we're talking about a JOP
>> chain to get here, then %rcx is under attacker control too.
>
> The SYSCALL instruction also provides means to create "incoherent"
> state of the processor selectors
> where the value of selector do not match pre-loaded values in the
> descriptor caches.

Very cunning.  Yes it does, but the state needs to be safe to IRET back
to, and ...

> Would it work to have KERNEL_CS as last entry in the GDT table?
> Therefore executing SYSCALL would set the CS as usual,
> but the numeric value of SS selector would be larger than GDT limit?

... this isn't safe.  Any exception/interrupt will yield #SS when trying
to load an out-of-limit %ss.

i.e. a wrongly-timed NMI will take out the system with a very bizarre
looking oops.


You can do this in a less fatal way by e.g. having in-GDT form have a
segment limit, but any exception/interrupt will resync the out-of-sync
state, and break detection.  Also it would make the segment unusable for
compatibility userspace, where the limit would take effect.

Finally, while this potentially gives us an option for SYSCALL and maybe
SYSENTER, it doesn't help with any of the main IDT entrypoints which can
also be attacked.

~Andrew
