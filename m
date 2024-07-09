Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFCE1B86EE;
	Tue,  9 Jul 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549223; cv=none; b=Dy8oI2ABEcBPX/FUoc9DJ+Q3DwsV7cLZS5E1w2NrFJJrz0w3T5CxP0eqTshK2o6nvEBzHXZWw07+7bFf4byf6rQkxR5SfHr8vltmMi3IQ/YMKIOace9ylH19csDoaAeg2rJvWdtssmt5/E0bRlPwRr1o9Gw5DK5uTnFSPfrr210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549223; c=relaxed/simple;
	bh=o4LNldRqOadxzGj9lb5Q/GaxWylVRINLa1zAJHw5J70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMfcyTB0I2Z/DIdSzAuip4l8nqDbSZQwjiuZb2VyXrN7HvV7eMLhYzwSjGgFge3gR/vbdpx9ldmp+IBr1IfOiIeGloxx3God7eTDH4/kZ2or8PkxkROCam6rkMEtdLPLeOOcb3vunl3lD09GMQuiyyj+WLU/2GxnAZ640ABI5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H04Q9Xoz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H04Q9Xoz"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e9a920e73so6731273e87.2;
        Tue, 09 Jul 2024 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720549220; x=1721154020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7U7wbEzgseQiB4DffxQ9bUbCIeXp8Vk1Qs2pu9ffAEQ=;
        b=H04Q9XozJbSu78+WOt0362NP8Ghf2voPwourTtTk54xUoiGnxV5IvW8v3rFnnK3dQZ
         gAHAgF0J5wWj3zPgAanu9K7OaSLq9f1I+KpWFyJSKzfDiP5qA0AMhaYOzgYcxoTRZ5eV
         evJVJMXSA1VP/rkTzogCRZi8u1g89xuLjFvBvXyqSCF51CSVQJSsrdsIlMM/c2owllDO
         pgC4lFblB5x3Pnic5XvGw30bYgKo/iPgnmw7J4U8A9eBti4pbSbWQlMqKKD42WgaFPd6
         tLSm7b1MmBZhhucF8mD866M+0onOHLinM8eIrPwvxz5m0ZVllCgjmDU8CU1mAO6t6Lcp
         KMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549220; x=1721154020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7U7wbEzgseQiB4DffxQ9bUbCIeXp8Vk1Qs2pu9ffAEQ=;
        b=nwmaSc08yQPARexenTjFiFXFOka0wXeLs8OeQPEnwQMXfMu+dKZdTqJF3cTA0yk06Q
         IYk3x6rPMlLH3TdLc32f27bDT0tpjNeZrbtZtwx65fo6WIkuAEEmSTgRsM+/xYbZs0hx
         NsKnaRZW3B1dDTPrieqdmWcV+Ser2hc11PC3k0KuhJWdkQQKF0rGLaBwfEoAbWgb/t7k
         rxhjTJFq/OQGlneZOWuaMf/2b5VdmMpxh6HfL+JQZ7z+/Yu2pHdtsMWKCsvHiSYfHscT
         m/oYqMaLmDL5pGd5j5lCiH2OB1VCZ0wkZFWEEHirg4BanqmdpCXefDlywCf3aVzzbb/p
         d5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5kNshm7ZTCX+Nr/kG13ODmotlOZbhIKg5JRxDEt8tHDC238C2ynC1DrTrlMgkgoS60xaVRfQqXybW9nxttoRZY1LR165LHAjVxwxFGt24m2RtLG3nktd5usGg/9JUv+KSBa5tfP6loZ0rGYc
X-Gm-Message-State: AOJu0Yyxyx8XQ/Ciy390Ia73bB4x7i9RlQ/2kLYVaZbTcSnWFcFZB45V
	77oye+/axDRgAqcdh/w4JcsE5EsMkKci/l20gy+p/j4eu0KlYY2M
X-Google-Smtp-Source: AGHT+IFkJsyPymw36Z4REpEQEftT6X7papcc3C18b7N02t/y6iijhgj9yMw5M2VMr4ra8l687l5dWQ==
X-Received: by 2002:a05:6512:3c85:b0:52c:dfa7:53a2 with SMTP id 2adb3069b0e04-52eb99cc6a0mr2070774e87.50.1720549219770;
        Tue, 09 Jul 2024 11:20:19 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459e13sm1319189a12.67.2024.07.09.11.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 11:20:19 -0700 (PDT)
Message-ID: <39b94091-d452-4dac-9012-ae43024462cd@gmail.com>
Date: Tue, 9 Jul 2024 20:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240708202202.work.477-kees@kernel.org>
 <e95852cf-231a-4525-9075-fad42930d328@embeddedor.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <e95852cf-231a-4525-9075-fad42930d328@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/9/24 01:44, Gustavo A. R. Silva wrote:
> 
> 
> On 7/8/24 14:22, Kees Cook wrote:
>> Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
>> the end of the addressed destination (or source) struct member:
>>
>> In function ‘fortify_memcpy_chk’,
>>      inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
>>      inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
>>      inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
>> ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>    580 |                         __read_overflow2_field(q_size_field, size);
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> As already done for x86_64 and compat mode, do not use memcpy() to
>> extract syscall arguments from struct pt_regs but rather just perform
>> direct assignments. Binary output differences are negligible, and actually
>> ends up using less stack space:
>>
>> -       sub    $0x84,%esp
>> +       sub    $0x6c,%esp
>>
>> and less text size:
>>
>>     text    data     bss     dec     hex filename
>>    10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
>>    10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after
>>
>> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>> Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Brian Gerst <brgerst@gmail.com>
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: Peter Collingbourne <pcc@google.com>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks

I can confirm that the error was fixed after applying the patch, in the same build environment.

Tested-by: Mirsad Todorovac <mtodorovac69@gmail.com>

However, why memcpy() directly from struct pt_regs doesn't work is beyond my understanding :-/

FWIW, bulk memcpy() might be replaced by a single assembler instruction? Or am I thinking still
in 6502 mode? :-)

Best regards,
Mirsad Todorovac

> -- 
> Gustavo
> 
>> ---
>>   arch/x86/include/asm/syscall.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
>> index 2fc7bc3863ff..7c488ff0c764 100644
>> --- a/arch/x86/include/asm/syscall.h
>> +++ b/arch/x86/include/asm/syscall.h
>> @@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
>>                        struct pt_regs *regs,
>>                        unsigned long *args)
>>   {
>> -    memcpy(args, &regs->bx, 6 * sizeof(args[0]));
>> +    args[0] = regs->bx;
>> +    args[1] = regs->cx;
>> +    args[2] = regs->dx;
>> +    args[3] = regs->si;
>> +    args[4] = regs->di;
>> +    args[5] = regs->bp;
>>   }
>>     static inline int syscall_get_arch(struct task_struct *task)
