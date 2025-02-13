Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4CE2661B7
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479281; cv=none; b=WIZMr+K3EE53MwYb30nnUE5JcFPTWFndxZ7GiNztewo3i8IQwy3mMK4JrFc+e7k89VekClUqa5Wh41v2Ola2ZePvj8+r1kDHXjJVpwjp7iHHKZoMeAs0tDIuZa2x/33FWXdOYriaM38vcYoERgSsHqLoMIZjmkdYca8V5wv2ORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479281; c=relaxed/simple;
	bh=GEO8HaWi4QPWZEPqnXMKXjc1uQwgaeT7yXmjm39pIZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxL02q+S0n3sIR7c6chLyY3bbb+kujo+nJr1KOCZhk1yxN+riKsjByNwmz2iTVZejgYI4dAqZRMKMgrizOcH/80XbJAqdxdOKMkgte2qyQlUi7p9Sl1FkYV3n2cDUPcnxC9aI+zcjaXPXSEzD6Q3zqzue/kBIv9+IBHKdVFHLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=YWDJxxgC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YWDJxxgC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43957634473so14277455e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739479278; x=1740084078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JdzpiFraoMmeLhGJnT7doQj/1oDPuw5cX4OAzG+mUlw=;
        b=YWDJxxgCiOL2QkxEnIwn+LpWLo1+mRT6mPecCMmR5yYvVSjQJT/e3sxgmXw337lgig
         sEQg9E6vDpBH/QRz1MbhBmIwHbIJirMHAgUG56vr1qSgQf/ZqRFPCVISFh4InEilEr/T
         1mTlpAhTu8oI//sPKPbb05qvaCZ8fHoNGc/Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479278; x=1740084078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdzpiFraoMmeLhGJnT7doQj/1oDPuw5cX4OAzG+mUlw=;
        b=TIjueLTHpG6DIrSFZWw5ivymxbyHa5Jt/fv+qlt5vJlQjVNbObjpz8xB6rHst/Fy2g
         vUwqREc9cHxWZ/Uol8nms6Woegut6e0LRAYNdVj/ya9Z19DTDiJSW07fLRfWpTgSUHX5
         i3LZNC2n6aYQ+Z7/bKEfwt3bdGQcXPZ7frX/QnkK4A2axYb7vryv1DjV1LYbvS5l+wcF
         +D9p0n4/t9gsj6RMQkv/xTn/eO7nF8Tu60NXnmTu2BjWVuXa4LsOFu/oAcwZVOr6Vp21
         EDS31CpEnV9DbZi9BwUtuIemMTnO7dCttG8EL7pY/A8L8jr/yafyBMV4azZ/bhpGmrEH
         y14g==
X-Forwarded-Encrypted: i=1; AJvYcCXyIHUdPVBm2JgFAcZopC+ZmdighlxEXASZ0WrrURtC4vjT57oIuU4RHiC8hwpOUzdgcSO6D35jR3bBf3LE/qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJoPHUr3ejQSAEZ1J2wxpgdjxuXikbXeQe5T3LF0xY3od0Ukh
	JedTBhws5nX/lkeOTfkN5pPSVuHMj6UxPYxp/EZUrlBeXQdgtQKKQE9jfrz8wEU=
X-Gm-Gg: ASbGncs9/g1ApHzNADB2wsQX/WeG8N+P/8b5VXs4ta6ZczSL8TbC61zucoM+KpYnTNJ
	bskK0CUONLDzpk071Xb42Z4aqHRttbshjaVDeag+d+YrIOIMoJQb174iC9bwmVDad1BpcGh7V7X
	+Ita46bRjnJJKD7VfzMYx5Met1uiPYJk0tseRejXpZ6ZZ/smL2The4jbpERarWAsWnRDoGO6t53
	jv5Rwx3gQ4CyDri5ELY+7cpfAjYeuKz4UmdpSSFub7WHPHUCZOlF/XitI+RzMUlAwgPnsguy7Ph
	rywjhMaHPe1vW5cEO4PYHO+ycbVaS7oQTzuZTRdILjSgUIKoFRPtvJc=
X-Google-Smtp-Source: AGHT+IE8o+O6Rj99pbvAV2YEC3zJPBi0iF2O3SooUAH+pSf73d5GOrt4ZeIVdUyA8MCewiQRBRCRJw==
X-Received: by 2002:a05:600c:444d:b0:439:5529:33eb with SMTP id 5b1f17b1804b1-439581bf064mr113281535e9.30.1739479277707;
        Thu, 13 Feb 2025 12:41:17 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884f93sm26834485e9.27.2025.02.13.12.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:41:17 -0800 (PST)
Message-ID: <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
Date: Thu, 13 Feb 2025 20:41:16 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Kees Cook <kees@kernel.org>
Cc: jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 luto@kernel.org, samitolvanen@google.com,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <202502131224.D6F5A235@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 8:28 pm, Kees Cook wrote:
> On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:
>>>> Assuming this is an issue you all feel is worth addressing, I will
>>>> continue working on providing a patch. I'm concerned though that the
>>>> overhead from adding a wrmsr on both syscall entry and exit to
>>>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
>>>> any feedback in regards to the approach or suggestions of alternate
>>>> approaches to patching are welcome :) 
>>> Since the kernel, as far as I understand, uses FineIBT without
>>> backwards control flow protection (in other words, I think we assume
>>> that the kernel stack is trusted?),
>> This is fun indeed.  Linux cannot use supervisor shadow stacks because
>> the mess around NMI re-entrancy (and IST more generally) requires ROP
>> gadgets in order to function safely.  Implementing this with shadow
>> stacks active, while not impossible, is deemed to be prohibitively
>> complicated.
> And just validate my understanding here, this attack is fundamentally
> about FineIBT, not regular CFI (IBT or not), as the validation of target
> addresses is done at indirect call time, yes?

I'm not sure I'd classify it like that.  As a pivot primitive, it works
very widely.

FineIBT (more specifically any hybrid CFI scheme which includes CET-IBT)
relies on hardware to do the course grain violation detection, and some
software hash for fine grain violation detection.

In this case, the requirement for the SYSCALL entrypoint to have an
ENDBR64 instruction means it passes the CET-IBT check (does not yield
#CP), and then lacks the software hash check as well.

i.e. this renders FineIBT (and other hybrid CFI schemes) rather moot,
because one hole is all the attacker needs to win, if they can control a
function pointer / return address.  At which point it's a large overhead
for no security benefit over simple CET-IBT.

The problem is that SYSCALL entry/exit is a toxic operating mode,
because you only have to think about sneezing and another user->kernel
priv-esc appears.

~Andrew
