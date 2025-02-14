Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962E1FCCE5
	for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572834; cv=none; b=Kp9UaHq2L4AMsZeEa736Sg1Xt9ti2zqpoIZ4U/QcAu1f1KUXNLLTNcREOY55stFHLrBKoFUIkrHghhjv/jsNFhzNWxDWgtQpiNc3WdXed3JtTf3XYI1xsdUbq5khqjZtbMw7U0TW0/9mZDskYmnmUrJlfnR41cdDj3y5gEWovwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572834; c=relaxed/simple;
	bh=FkhQen3jMCWKwg3SUUeVcC847PjdOBFyLDHwxk87puw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guox1ogR/h7as/lh2Vv0J9N9n1e2dgcOpTw0N2y/Og0woQqq4Dw2VJUfPoP0k0rSoDsGAkg3bVeLgusR7yffntzHIWlO9TNMILb/VmfvMYwHYqnFNGLNUHolKG0vkrU0rdHFYHwyBXED0r92SRyqrTchkbFTGCJw4UKAAe443o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=qllAR9dY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="qllAR9dY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso15828355e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739572831; x=1740177631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d2Es7W7rIA+SDUtfarzDyFqNiRUQrkoPh/TZ5m+aaOw=;
        b=qllAR9dYU8hMk6l/ezrKB87OeELFeIVFPtt23l48p5S8XQtlH9vySkvJYu69VVO9Ib
         5fsOjh4JOI3OgdtpHdpe8lnLwMNhIOpZC6C59uBi6FOJZ0ziZP7KJTcnJn3V0/bKr/J/
         xOfLxoh2zHMiUqA8ujquQQRslDjohT9+y85kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572831; x=1740177631;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2Es7W7rIA+SDUtfarzDyFqNiRUQrkoPh/TZ5m+aaOw=;
        b=m5YExPvuBsbmNo8/Z7VaH7J7i1tAdohB+NuA5vmqr9Krsj5p/n8SfIUtVAch8Mu3h8
         OF1kleLPSp04irwL73RbqiaCycKv9AVy7VPYVDaXndrIenhZ34stuEzpiZHQtl6YpJha
         QAVYxSVanOD4X9csA/bqbH9/cmB88YenSIsFveSHaRDN/Vr6LT5JP1hhEsyMD6qgj0Ly
         Q8P3yJ9fJo3Q0dbFgoCnhF4Nnw13KRbjlMvHKVi61lN6BERWdeXY1cWwlgVi3t41jG5a
         IL2Tx+lma/ulN8AGcuchhaki8FdlhlDrlKqh6wvT5XZemVqITbzUNyem5amYmcCMTu6B
         MBzg==
X-Forwarded-Encrypted: i=1; AJvYcCVYQ8ypRBT57DnYWLk4qpxRf/0K96neNHQOFGO4GvbVzLJynIM4UGf8wgrmpYC83RiQpwU6vrNeqcJ/6SE1PNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/UiS/kFnj9bPxmrXhPEXYM+UKo77A5t7rBzF4WxuHgp+/psq
	jZrXUI3VMUd9YrDERKCgjw6fifKjezJ9lIlfpnRkGbT6KGecNnk5vSsez+35PO8=
X-Gm-Gg: ASbGnctZX5LxFkYQQ343MXDgZCrlcXZ/tdYG+NzG/YNnbET3y3pyzMpil/aq0cU9pvP
	Dina12K0sc8uzR6yZ8mFJV3YFsgSAJIL8sIq7qjtEI/9ZLZjdS3y0aMywHlvwaPX5MJ2DhdLtJ4
	DubPXMwhA3guKtQOkZkh1krvLaG+pq6O21aOO6pDnexDVZPgJMo1aSeqlhjlTYcLMOFygI2wzRN
	W6VHQtm/6lLrV8Tn5MmyJKIR6qB7t5HadTOn1GjSDWAUXuL+Xf+DfuwjAaSQKLMsqiWVA50kZXL
	7+7S8CKg2muwn2eHTcduXSBukNIo0VbOKo0XGAfsMGnWw9X0grKssmk=
X-Google-Smtp-Source: AGHT+IE71hgfi9vKmHrPeDtRHLEyfmLXJ+z/aDf94JYukLeP3uNQb4g+Gi67XQkP3nROa1beIZLSUA==
X-Received: by 2002:a05:600c:214:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-43960c068d9mr111724805e9.10.1739572831004;
        Fri, 14 Feb 2025 14:40:31 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961811315sm54926895e9.20.2025.02.14.14.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 14:40:30 -0800 (PST)
Message-ID: <7ae6ee84-b5ae-479b-b963-9e9aefcd3bfa@citrix.com>
Date: Fri, 14 Feb 2025 22:40:28 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kcfi: Require FRED for FineIBT
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jennifer Miller <jmill@asu.edu>,
 Sami Tolvanen <samitolvanen@google.com>, Jann Horn <jannh@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250214192210.work.253-kees@kernel.org>
 <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>
 <202502141345.C78A253D@keescook>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <202502141345.C78A253D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2025 9:54 pm, Kees Cook wrote:
> On Fri, Feb 14, 2025 at 07:39:20PM +0000, Andrew Cooper wrote:
>> On 14/02/2025 7:22 pm, Kees Cook wrote:
>>> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
>>> index ef5e0a698253..dfa2ba4cceca 100644
>>> --- a/arch/x86/include/asm/cfi.h
>>> +++ b/arch/x86/include/asm/cfi.h
>>> @@ -93,7 +93,7 @@
>>>   *
>>>   */
>>>  enum cfi_mode {
>>> -	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
>>> +	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */
>> You discuss XOM in the commit message, but there's no check ...
>>
>>>  	CFI_OFF,	/* Taditional / IBT depending on .config */
>>>  	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
>>>  	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
>>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>>> index 97422292b609..acc12a6efc18 100644
>>> --- a/arch/x86/kernel/alternative.c
>>> +++ b/arch/x86/kernel/alternative.c
>>> @@ -1323,7 +1323,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
>>>  
>>>  	if (cfi_mode == CFI_AUTO) {
>>>  		cfi_mode = CFI_KCFI;
>>> -		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
>>> +		/* FineIBT requires IBT and will only be safe with FRED */
>>> +		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
>>> +		    cpu_feature_enabled(X86_FEATURE_FRED))
>> ... here.
>>
>> Is this meant to be "/* TODO: wire up XOM */" or is that accounted for
>> somewhere else?
> Yeah, I wasn't sure how to best capture that in here. XOM doesn't exist
> yet for x86... I could add a TODO like that?

I get the feeling that the PKS series would have an easier time starting
with XOM (even if it hard-codes pkey1=xom and avoids the allocator in
the short term, seeing as Linux does have a good grasp of where it's
executable pages are, and how they're accessed) rather than trying to do
general page hiding.  The capability is in 3 generations of Intel CPU now.

>
>> Also, while I hate to come back and contradict myself from earlier...
>>
>> Architecturally, FineIBT without FRED seems to be no improvement over
>> simple IBT.  (I'd love to find some way of hardening the entrypoints,
>> but I can't see a robust way of doing so.)
> If you're just looking at IBT, yes. But kCFI (with or without IBT,
> but without FineIBT) will do hash checking at the call site, which
> should make it impossible to reach the entrypoints from an indirect call
> in the first place, as they have no hash preceding them.
>
>> However, micro-architecturally, FineIBT is still far better than simple
>> IBT for speculation issue, seeing as Intel keep on staunchly refusing to
>> turn off the indirect predictors by default like AMD do.
>>
>> A security conscious user ought to be using FineIBT for this, given a
>> choice, even if it's not perfect in other regards.
> A security conscious user should use kCFI without FineIBT. :) But I
> think we might be thinking about different elements of security. I am
> focusing on control flow, and I think you're considering speculation?

True.  The security realist knows they're dammed either way, and gets a
stiff drink instead.

~Andrew
