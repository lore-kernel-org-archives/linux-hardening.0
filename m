Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917D267B7F
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577010; cv=none; b=GYbQ8vmNYU3Fkmo0EuXgHCoZGqyXYGHkqXiD/mklZCdxvp9aacHTIknxff6G0fh0dDx9Wqu8ZG27RGLK1UNY97VOj0TiKLEJ6w61Rqj1UtLPNMN92mejuYHV6UdcQ6M/LvGYJu5hhPIODUTZ80170wJfI6ArNKgiOCmIp4WlUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577010; c=relaxed/simple;
	bh=IpjMEeOicXD1vokeMuiFBcT1efgJJH75myvJXPDIAFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFGR+cy5UDZ4E7tEmsnpkxKyezv46dtfm57DqW/vNC/r1BpdPAadIhe94/R3g7apcGfcD3GSljCu0n12K35UYixla5PTgVO2w4KEWTsK1q2asCpji6KAChbyTbFPigL2wbsG0amQ2/uaQZp5L94V82KoGV3jiFMS5gXmSGhswD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9udmL7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9udmL7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F69C4CEFF
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757577009;
	bh=IpjMEeOicXD1vokeMuiFBcT1efgJJH75myvJXPDIAFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E9udmL7wG1Pj+O0gE3PKBTzXQtZHl9shxjaa5nTAzbjU+ksM5axbIo+RYIz0XpMxv
	 1C8ogLatmyTaSDE+xkrwMDL/71V2HjTzvDZmRqeulQwGL91Pmmvigbcj2f4UKUS9TE
	 LE4xLOcXw8MY4BZnYJ1FkMiMQ+NJFzNI5eQs2fNxOTlvOJXafOJQCltE+Pi4CEC2kg
	 dhPIxJvrbq5rxoSIe6C/f4NjEwvMwcVs8trVaoBSwj/BZ67ha2JlOOZKfG2mySRl33
	 gU/D5k4K1bR5hWnvOgWC/oQrmHN3BDWvb0fLYnKlnpPjXcZqwN/gXH64YOgkwGWSkQ
	 uhF9rjrAgu09w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso3233981fa.2
        for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 00:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/6pzhq3Gs/SLfHXKtI5TjjtP+XCkMSxD6xuphEMS1X40LR7vZIswnjhZ04I7JDedmUxKcbXlk+VBPkUzmoTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKkmjc8AmL30JYH14uOk7MOYpOMAnaDm3Vmy9nfNBYjJouIZ8
	543TsDM3pzUyj4+y1YvXTygBBoNKBfSTUAg+P7RfcweaoIVWGtKDxJdmTAQHdDpsHcmUKGThyfX
	Adymqge+CaIfGUruoOBnxtqMisTHolAw=
X-Google-Smtp-Source: AGHT+IHFDwUeB357yOplEkYnGxYgkcZ7818jbfLu17DrZVUhMgvaTcpAsKrW/JsFP+hRuRZfIQ5v1KUvU7zHQVro+lk=
X-Received: by 2002:a05:651c:19ab:b0:336:e32f:79ed with SMTP id
 38308e7fff4ca-33b55f3292amr62325751fa.29.1757577007577; Thu, 11 Sep 2025
 00:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905001157.it.269-kees@kernel.org> <20250905002418.464643-5-kees@kernel.org>
In-Reply-To: <20250905002418.464643-5-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 09:49:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
X-Gm-Features: Ac12FXx4UpEZ-6GHZevGFAVEALdEtX7dFx5vYaaH3YbDpSQblo8SKul85yW7WjU
Message-ID: <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>, 
	Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dan Li <ashimida.1990@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ramon de C Valle <rcvalle@google.com>, 
	Joao Moreira <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 02:24, Kees Cook <kees@kernel.org> wrote:
>
> Implement ARM 32-bit KCFI backend supporting ARMv7+:
>
> - Function preamble generation using .word directives for type ID storage
>   at -4 byte offset from function entry point (no prefix NOPs needed due to
>   4-byte instruction alignment).
>
> - Use movw/movt instructions for 32-bit immediate loading.
>
> - Trap debugging through UDF instruction immediate encoding following
>   AArch64 BRK pattern for encoding registers with useful contents.
>
> - Scratch register allocation using r0/r1 following ARM procedure call
>   standard for caller-saved temporary registers, though they get
>   stack spilled due to register pressure.
>
> Assembly Code Pattern for ARM 32-bit:
>   push {r0, r1}                ; Spill r0, r1
>   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
>   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
>   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
>   cmp  r0, r1                  ; Compare type IDs directly
>   pop [r0, r1]                 ; Reload r0, r1

We could avoid the MOVW/MOVT pair and the spilling by doing something
along the lines of

ldr   ip, [target, #-4]
eor   ip, ip, #type_id[0]
eor   ip, ip, #type_id[1] << 8
eor   ip, ip, #type_id[2] << 16
eors  ip, ip, #type_id[3] << 24
ldrne ip, =type_id[3:0]

Note that IP (R12) should be dead before a function call. Here it is
conditionally loaded with the expected target typeid, removing the
need to decode the instructions to recover it when the trap occurs.

This should compile to Thumb2 as well as ARM encodings.


>   beq  .Lkcfi_call             ; Branch if typeids match
>   .Lkcfi_trap: udf #udf_value  ; Undefined instruction trap with encoding
>   .Lkcfi_call: blx/bx target   ; Execute validated indirect transfer
>
> UDF Immediate Encoding (following AArch64 ESR pattern):
> - UDF instruction immediate encoding format:
>   0x8000 | ((ExpectedTypeReg & 31) << 5) | (TargetAddrReg & 31)
>   - ExpectedTypeReg indicates which register contains expected type (R12 = 12)
>   - TargetAddrReg indicates which register contains target address (0-15)
>   - Example: udf #33154 (0x817A) = expected type in R12, target address in R2
>
> Build and run tested with Linux kernel ARCH=arm.
>
> gcc/ChangeLog:
>
>         config/arm/arm-protos.h: Declare KCFI helpers.
>         config/arm/arm.cc (arm_maybe_wrap_call_with_kcfi): New function.
>         (arm_maybe_wrap_call_value_with_kcfi): New function.
>         (arm_output_kcfi_insn): Emit KCFI assembly.
>         config/arm/arm.md: Add KCFI RTL patterns and hook expansion.
>         doc/invoke.texi: Document arm32 nuances.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/arm/arm-protos.h |   4 +
>  gcc/config/arm/arm.cc       | 144 ++++++++++++++++++++++++++++++++++++
>  gcc/config/arm/arm.md       |  62 ++++++++++++++++
>  gcc/doc/invoke.texi         |  17 +++++
>  4 files changed, 227 insertions(+)
>
