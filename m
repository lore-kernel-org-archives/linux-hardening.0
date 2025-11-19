Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCC2DAFC3
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566541; cv=none; b=TJLMFwCtpXDOXC4bT/8Z9pjOrSCFxL+TjlGSq9L/glXxtgZv8DUEJyM0CGsbDTFDhBmf7ERs9mD1sX1PlRsqI2BmBB+rtNabi1cZ5CU5SbCZrN8SwIF0i2ssQkZtGsT8YRLls6o557SNAswjFNY9a/RSsDV+1gENEQ85ttMzKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566541; c=relaxed/simple;
	bh=98F9TF+1u4VU2oMhaGWcWPbcfiR3dB6OFSUMjyMa99g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ar4Q04EAvuKxTzO9a7HRLogELB+jFgX/EUrajtFH5XgBcy3gYV4XCoziIaQu7lZFuIzBxUJNOn+R1tCJTpDue+bSiHPNBFHYujfd0OLZ75mEXVIr/TlKjux6g0A2fTv+LOxmMGZZsgr6sWj7o10I9C8NlKzW470D2hToFB4tMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbP30ZjW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbP30ZjW"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c76d855ddbso637533a34.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763566539; x=1764171339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0MUIoclSDjMac0LLcg2Ee6Ju8UNy4Q705UmSp79dVY=;
        b=RbP30ZjWeT+D4LQPizjXWRMh/rhZAIeNc+OdXw7mFYg+SUicn+sy2EIXJTJshAjFEm
         fF6HEoZ500VExxvXd3el49yCGNog0wyEbfengFLbfhkXHs24yBvNhhuSMzVPYPeZ1n+J
         Iq/0rNENvkpZNPwvJX4BCIDYD9LdrXcWx76CkGR2bMn8tFY7mOieGtk6qFUHIcE/1/c3
         /j5o2XDt8xAWKdHVRLmthHx+A5V+G3GqfQgGMMWcR+5YBq4fIeMGn1RjQZfYwhcoXYW6
         WmDrTzFj+uw7FATAJnNjxDg2A6qhbisz2rGhaG16ijlz/PdqQrG4hW2Dn2m1Sp+nfVNB
         nPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566539; x=1764171339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0MUIoclSDjMac0LLcg2Ee6Ju8UNy4Q705UmSp79dVY=;
        b=v7CXV0No3jStnEerkkXIhZVGBJVLSEcnwHeHBQVAO/o9ZPxeYzf5hNNSLydceTUrH/
         sD1BtdDCr6D4gySiHNvTMtPG+pwIaxaCfr8duUYgs7QBsVScnWw6amXfaX0O2ydnXbnZ
         SOKQEuM/MQ00b0h38IWCvOurssWHD326LO7Z3pzIpaOY41yAvb8HdIjBHOJGnYol3KPP
         5nkMdI8Vql4t5G2CwChZNv0wrqY+DTu3zIHepA1Zpk4goCGLFdvuS3H3RhYs9WDExPJj
         6OoHEc0sxuqMSlZFNX8C3a/DxDyQ3EEQj3cC1om2rwLEpcFjao/cZoRSNW3ODz28HQvT
         KGtg==
X-Forwarded-Encrypted: i=1; AJvYcCXitJGTGOelCbo6skoL3+1WwbP0eRv+NapWDMhMhraRnvWm1uBzbnX3YArM6k15QOqiw9iI50YvNjBlJ05Nc1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOY/4rQboUAY8YBmvFFrYhj0mWmamCdJwm0xoh6aAuvX/7/zg
	It9y+figrC8CiQ7KecCT4xredxp7/Z7PVztTSjyYXqZbO1fInFPlbTJt
X-Gm-Gg: ASbGncu2SX1Ue6Ak0EpwC1BmJcyEBrdLv8qWQJwXDKuRqc7Fo/edrFvHb4x/uoRJG+w
	EsbXuEJgE36EMvAtB2LXBJqTArwNqVv37hDM5TUCLy+GEe1r9FIDYMAY/+zBEj8obTkvESGly2Y
	gYvVEXCeaowmyNSlhvYpci1xmbrBEd3iPWVWiU4wwPJ0mlhWgN975Eg961NBZVAA7A8Vva8qkj5
	2dM0TFp7jAgVos5J9xte/UP05bypTWMyj09BVmmsNDPxKi/Y7Q8D7RthrArwqzOPB+i9T2djFmj
	QcuMJ/L/+WSMJMoazuDWjAjzCiaJuONJPcTOD0HRnTqg1ASHKBm7e1Hh6zaqx72gCUIDJtLZkch
	U7x2GKYJkljQD6NQxtXgswUv8lPStOBd9mXScZu0VFXBWrMh6nWKcVdfzI626ZZpAq6OktGqqTg
	eheHLUMfc17siv/iIqsvC+BQYAqRIC0LkqW4bb
X-Google-Smtp-Source: AGHT+IHFdG0WqHXii1nxCkIeynYFthhZ7Bwnez8vGwdrxtwqnj4FI/th0be7fcReTD89cTP8bmNhdw==
X-Received: by 2002:a05:6830:6e9c:b0:7c7:5a07:303e with SMTP id 46e09a7af769-7c75a0731b3mr6539063a34.36.1763566538711;
        Wed, 19 Nov 2025 07:35:38 -0800 (PST)
Received: from [172.31.0.38] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bce15sm7824319a34.23.2025.11.19.07.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 07:35:38 -0800 (PST)
Message-ID: <c8b5038c-222f-4215-84c4-3f0698ccf10e@gmail.com>
Date: Wed, 19 Nov 2025 08:35:35 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
To: Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>,
 Richard Biener <rguenther@suse.de>, Andrew Pinski <pinskia@gmail.com>,
 Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Hubicka <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Marcus Shawcroft <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>,
 "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
 "Constable, Scott D" <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
References: <20251117201219.makes.617-kees@kernel.org>
 <20251117201231.2160039-7-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <20251117201231.2160039-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/25 1:12 PM, Kees Cook wrote:
> Implement RISC-V-specific KCFI backend. Nothing is conceptually rv64
> specific, but using an alternative set of instructions for rv32 would be
> needed, and at present the only user of KCFI on riscv is the rv64 build
> of the Linux kernel.
> 
> - Scratch register allocation using t1/t2 (x6/x7) following RISC-V
>    procedure call standard for temporary registers (already
>    caller-saved), and t3 (x8) when either t1 or t2 is already the call
>    target register.
> 
> - Incompatible with -ffixed-t1, -ffixed-t2, or -ffixed-t3.
> 
> - Integration with .kcfi_traps section for debugger/runtime metadata
>    (like x86_64).
> 
> Assembly Code Pattern for RISC-V:
>    lw      t1, -4(target_reg)         ; Load actual type ID from preamble
>    lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
>    addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
>    beq     t1, t2, .Lkcfi_call        ; Branch if types match
>    .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
>    .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer
> 
> Build and run tested with Linux kernel ARCH=riscv.
> 
> gcc/ChangeLog:
> 
> 	config/riscv/riscv-protos.h: Declare KCFI helpers.
> 	config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
> 	function, to wrap calls.
> 	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
> 	wrap calls with return values.
> 	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
> 	config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
> 	doc/invoke.texi: Document riscv nuances.
> 
> gcc/testsuite/ChangeLog:
> 
> 	* gcc.dg/kcfi/kcfi-adjacency.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-basics.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-call-sharing.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-move-preservation.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-offset-validation.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-large.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-tail-calls.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-trap-section.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t1.c: New test.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t2.c: New test.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t3.c: New test.
Note there's still review work to do on the RISC-V bits.  But it's worth 
noting your patch triggers ICEs in the RISC-V testsuite.  See:

https://github.com/ewlu/gcc-precommit-ci/issues/4115#issuecomment-3543758441

Jeff
