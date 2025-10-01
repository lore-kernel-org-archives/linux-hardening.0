Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D922D9F7
	for <linux-hardening@vger.kernel.org>; Wed,  1 Oct 2025 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280178; cv=none; b=N3ZfHSYVaKotJT/PPXXmz69KDdk/cKgA7TNZTRlEONSgM8ACVRcBwX2tA3AYwHodwmBqEGJBCHFKP+406UODQZ6ZKgy7hqU0s3O362LsRGq8XAP/FvlkpIWjq6qMW/fsgoosgogfXXDJ6BE8ty8FRO69+l+SgKBTFnAbf/ggmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280178; c=relaxed/simple;
	bh=c8vxULP8C85NcBTAnU7CsTkLwR7T7M/afRi/S1DBivs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLz1cFAvf0Ujw0uW/xMYo3OaMpsPCN444XL4br1odMsipwF7Bdods+VNiIt1lI/aGbjN7kSFhvpa/6Vh0UPMYkKQ08bd4bembxsKuldc+DORjwFvqu95Y7QxSVBGfSKeHjeylLx+U05n0888S+K7fzK498YTGX1oa5kRvmumYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWxscEt5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWxscEt5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-73b4e3d0756so82196557b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Sep 2025 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759280176; x=1759884976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hn0ImS2MfIERveTGFy7N5JukE0cIyxiDOhsijBPMQI4=;
        b=QWxscEt52AIQ4DqQ3BLkPXNDOlnwWp77UJ2i9CPbm9nnbed18bxgN0JX+nG1Y7Wtym
         ZgobBz9PxyNzUzFSipTMnUk93aufqmbbVzyet6fDprBBmDK+LS/6tFGZYjbjARurxez/
         cjU+NgqJVCtJfgWwyNPcEohDr7xGYRsgWniKoYURQkJgozW2O8PiK6SbzI6T3Z22eRXw
         QotsYjacTJiWvanT/ySY7zkRNKlrYiWwnu9dXO1JdGVZbLbVl5UmfFLQ8bOnIu72tcX7
         ZwOyuayTZ7JN8BBxuZ0CvoZXwG/tPNo1Q9SwRwqrH5BsfXx7jDbAzJUlst2Z95wCBOy3
         F0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759280176; x=1759884976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0ImS2MfIERveTGFy7N5JukE0cIyxiDOhsijBPMQI4=;
        b=BYfmB+m2j53GT+FnM/9Ls1EiBx10HQHLlPgYVnIiBU2GSz7FegO7iyEuL6OwTIsWsd
         wjd3XirZL4HeffcmYW20Vl/bQ3uz6iIIUUF+BHmQ7f0AjA8bUtqBKGyuoFFpTGkSPp1Y
         qUTQD0DtG+PMZDpuzUMpg5egcZQBqmamFZZHQQgdHshiklz+mbQYDcfHog1DgkccPRFB
         qAphhkIZOFP22uYpxGmvDi3LO9Mkkhno3lsDczEKXHm9cFsGehoYGDPqaC51GePuXF6M
         jAD490qTV0lA7bMMvLXDf9ih/wHlFGxwKHOamXTBoHCrs9kcN/0fgGwUsjmv24SNhXSG
         J08g==
X-Forwarded-Encrypted: i=1; AJvYcCVqzOz6CeUY8MeZbm8/+aMQ/SyEHytubD804DLAwXt7LCbw1v/JYeLKXWSQ8RmXpudRCJ6Qd2XphpzRNPD9zF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoyizxP/3/JT8hY3TAx7GdTANvET4aMsnrtT44c+2bL99gVIf
	bcTAmTqkpJjW5GgT/RUMZwWvrBatq3FK79G1/wfF635V+FOTx/aKcpRu
X-Gm-Gg: ASbGncvaoJQ562TuVEA5b7cCizSOglqjo86+kHpRwQAlCB1cfz9dRxUQCv2VHOeH4rQ
	KHrN2/TTCZeenc2B17XiwzFMcJ+M0pa1Q3HepahxXT1Ey4GnxRtJSUYbynbM7yApbd3zfzsxQGy
	SVoN3OYXND+FqYFe5hquSbYsm7D8/pG8uOcNedMT/eokTRMPaRXqDZzaV4x2rJ1yqgZ7TkYOH23
	q1JVwJWWyZkdF33I//pfEXm+SCYe7vgUmRPob4W4JjI/U6Fq79LeeUOefzNil8uqqIeip0VfyMB
	0Nr86m0cws2IKyCAP05BxcdVBp4rl1/tEtSJ7R7qJFw+3iEwIZpKCVnwgu5L3blvka1uPbzn8kt
	T4l8ekZHl+XbjtC0X/bXhLYZOL2UeYHmXnIGKAC1+GWt/1LKzkyM=
X-Google-Smtp-Source: AGHT+IGxgxqD6XLgYawRZQgWSfkru70DrKeOCvbU7jbtULA91hvFUmpgS3sA8Pni9Iu76i6cb+VyjA==
X-Received: by 2002:a05:690c:931b:10b0:760:aed8:a03 with SMTP id 00721157ae682-77f6f1358b2mr22214257b3.11.1759280175578;
        Tue, 30 Sep 2025 17:56:15 -0700 (PDT)
Received: from [172.31.0.38] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bb916a90sm41937627b3.4.2025.09.30.17.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 17:56:15 -0700 (PDT)
Message-ID: <965b7366-2474-4712-9f3c-4cd71f63d17d@gmail.com>
Date: Tue, 30 Sep 2025 18:56:12 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
 Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
 Jan Hubicka <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Marcus Shawcroft <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Dan Li <ashimida.1990@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-6-kees@kernel.org>
 <dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com>
 <202509152254.8A38F96D91@keescook>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <202509152254.8A38F96D91@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/25 12:04 AM, Kees Cook wrote:

>>> +/* Apply KCFI wrapping to call pattern if needed.  */
>>> +rtx
>>> +riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
>> So our coding standards require a bit more for that function comment. What
>> are PAT and ADDR and how are they used?
> 
> Sure, I can document those more fully in the next version.
Thanks.


> 
>>> +riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
>>> +{
>>> +  /* Target register.  */
>>> +  rtx target_reg = operands[0];
>>> +  gcc_assert (REG_P (target_reg));
>>> +
>>> +  /* Get KCFI type ID.  */
>>> +  uint32_t expected_type = (uint32_t) INTVAL (operands[3]);
>> Do we know operands[3] is a CONST_INT?
> 
> Yes, these all come from their respective RTL's:
> 
>           (match_operand 3 "const_int_operand"))
Perfect.  Just wanted to make sure.  It's a fairly common goof to try to 
extract an integer value from a non-integer node.


>> ISTM that this will need some kidn of adjustment if someone were to compile
>> with -ffixed-reg.  Maybe all we really need is a sorry() so that if someone
>> were to try to fix the temporary registers they'd get a loud complaint from
>> teh compiler.
> 
> Yeah, this needs more careful management of the scratch registers. I
> have not been able to find a sane way to provide working constraints to
> the RTL patterns, but I'd _much_ rather let the register allocator do
> all this work.
Usually you end up having to define a register class with the single 
register you want.  Of course once you do that you also need to start 
defining union classes and you also have to audit all kinds of code to 
make sure it's doing something sensible.  Yea, it's painful.


> 
>>> +
>>> +  /* Load actual type from memory at offset.  */
>>> +  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
>>> +  temp_operands[1] = gen_rtx_MEM (SImode,
>>> +                      gen_rtx_PLUS (DImode, target_reg,
>>> +                                   GEN_INT (offset)));
>>> +  output_asm_insn ("lw\t%0, %1", temp_operands);
>> Rather than using DImode for the PLUS, shouldn't it instead use Pmode so
>> that it at least tries to work on rv32?  Or is this stuff somehow defined as
>> only working for rv64?
> 
> It was designed entirely for rv64. I'm not against making it work with
> rv32, but I just haven't tried or tested it there.
ACK.  This may never end up being used on rv32.  But we should at least 
fix the obvious stuff since it's just the right thing to do.

Conceptually any pointer should be using Pmode.  If you keep that in 
mind, that covers one big blob of issues.  It also means that if someone 
where to try to light up 32 bit pointers on rv64 that your code is ready 
for that (and yes, we've had those kinds of requests, though to date 
none of that code has been ready to integrate).


>>
>> We generally prefer to not generate assembly code like you've done, but
>> instead prefer to generate actual RTL.  Is there some reason why you decided
>> to use output_asm_insn rather than generating RTL and letting usual
>> mechanisms for generating assembly code kick in?
> 
> Yeah, I covered this a bit in patch #2 in the series which describe the
> design requirements. The main issue is that the typeid validation check
> cannot be separated from the call, and the instruction pattern needs to
> have very close control over the register usage so we don't introduce
> any new indirect call gadgets (pop %target, call %target).
> 
> So, this is a replacement of the regular CALL rtl pattern. I am totally
> open to any other way to do this. I have been bumbling around in here
> (and on the other architectures) trying to find ways to make it all
> work, but it still feels like a bit of a hack. :)
I didn't really see anything in patch#2 which would indicate we want to 
generate blobs of assembly code.  It feels like there's something 
missing in both our understandings.





> 
> Okay, noted. Are there any restrictions on function pointer alignment?
> Regardless, I should probably rewrite this language a bit to try to
> better say "we don't care about alignment padding since the preamble
> typeid contents are a multiple of instruction size" (which would still
> be true for 2 byte alignemnt).
Nope.  The architecture will require them to be 2 byte aligned if "C" is 
enabled or 4 byte aligned if "C" is not enabled.  In both cases those 
alignments correspond to the minimum instruction size.

Jeff
