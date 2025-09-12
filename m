Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582427F006
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670193; cv=none; b=H9u6LAAmq6SYaW0BlR5b9LdzoXGqN1x4jV9yle9FX7lc6I/cUiu4j0gDML17nmRNJl4FT81fv8UdIs/VBz1hgLq5bl/tagqDsQq7CItLjbNchOKfwJTIpBfrQxd9IkMI+ejrbs6aFaR9T/BCPEcb6YU0FllyLoZUzTt/JSQRuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670193; c=relaxed/simple;
	bh=Tm/gr3fAX2mucVzxZ3vj5YCQWrBZQm7DSz03T/+PLm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV366J3cxLvb4OAUqlTtUDf2vL+ChMIEAtKrkkgeuyRKLdEVlyUwLKOGRyCCsOnazNpCJy7gg08UZY1l4bjHdUd7xyid2hoUdXcScfpvUZux4WvAq9v85bi/e94v21UkP0qeuwBPrfBfD9fGsY/IHvK91Ya6zxXe6Erctj2izHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIJH9bqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIJH9bqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45871C4CEF1
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757670193;
	bh=Tm/gr3fAX2mucVzxZ3vj5YCQWrBZQm7DSz03T/+PLm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UIJH9bqs+o7JvQRB/HzsFTfW34SRXiD3TsgEwZfPfWIvegiPp094sq3HjeZHUNORR
	 aN8W3j5hcbM4HTLUu3hGdTnqiD+V20EwZRptIVw8TEMKcjV65hG/mctZK4pUZ7NN7J
	 fWxNQuSex2SORd/mHFzqlsuvxxr7yx+wvcKExJ6fPC32pCamONHmd7bNA7UEwGUHKW
	 LS55Z4+/yM7UsFXN6EvrF2G/YIlrgF0F0cqpXhn8Lk4dGVgeDvRX/aX3Vk/gsnvtAz
	 zbZkG7sWnu9xVq4ri8LYiI5V4pdAb638ZLr2z9Af83TSA50FVsytlOFnMw8xGRlwrv
	 r5SxlBKoqn+jw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-352e19bd72fso557451fa.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 02:43:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxNMlok4NE9hEUgeISYHUl4C7eYJ7jil1/v2qC+lljTGTJN47W3Oh7469knGLIi/DRjtSEgkdAZ65boupdFUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3P8T9bB+OYK5AnQynjZAZfAIm8p13wN8XMHxSxPM2XBffdTru
	YyjBw+yJwpVrYAoKUWwX3TpLc+P01vUOnIS7HwK92vaLmun4G6uHAKeJESmnfQaF0JlrFAto54W
	fzycAUlPvNXpyJIUOB9NYLxecf4+yIEs=
X-Google-Smtp-Source: AGHT+IG0zAg+CWmwTQNf0T7eQr0H8MrlAj0ok49vYOO0NTsSzSJA1V/Mfe9do0Vj4ptveNssaQxcrFh9cZYqY69qKpQ=
X-Received: by 2002:a05:651c:3245:20b0:336:e176:cd3c with SMTP id
 38308e7fff4ca-351403ed5aamr4876141fa.38.1757670191462; Fri, 12 Sep 2025
 02:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905001157.it.269-kees@kernel.org> <20250905002418.464643-5-kees@kernel.org>
 <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
 <202509120157.9681B7FC6D@keescook> <202509120205.69A1B0CB@keescook>
In-Reply-To: <202509120205.69A1B0CB@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Sep 2025 11:43:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFAaO2=B5jFBKcpf6rUbhKNG-BEqZoFBv0UJ2gb-Eym5Q@mail.gmail.com>
X-Gm-Features: Ac12FXwJ8k68qmVZ9hLIggEJHMS6xRMB37YN1YzfMTOCJqvVfKhzJeCmQ8Dmeko
Message-ID: <CAMj1kXFAaO2=B5jFBKcpf6rUbhKNG-BEqZoFBv0UJ2gb-Eym5Q@mail.gmail.com>
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

On Fri, 12 Sept 2025 at 11:08, Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 02:03:08AM -0700, Kees Cook wrote:
> > On Thu, Sep 11, 2025 at 09:49:56AM +0200, Ard Biesheuvel wrote:
> > > On Fri, 5 Sept 2025 at 02:24, Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > Implement ARM 32-bit KCFI backend supporting ARMv7+:
> > > >
> > > > - Function preamble generation using .word directives for type ID storage
> > > >   at -4 byte offset from function entry point (no prefix NOPs needed due to
> > > >   4-byte instruction alignment).
> > > >
> > > > - Use movw/movt instructions for 32-bit immediate loading.
> > > >
> > > > - Trap debugging through UDF instruction immediate encoding following
> > > >   AArch64 BRK pattern for encoding registers with useful contents.
> > > >
> > > > - Scratch register allocation using r0/r1 following ARM procedure call
> > > >   standard for caller-saved temporary registers, though they get
> > > >   stack spilled due to register pressure.
> > > >
> > > > Assembly Code Pattern for ARM 32-bit:
> > > >   push {r0, r1}                ; Spill r0, r1
> > > >   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
> > > >   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
> > > >   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
> > > >   cmp  r0, r1                  ; Compare type IDs directly
> > > >   pop [r0, r1]                 ; Reload r0, r1
> > >
> > > We could avoid the MOVW/MOVT pair and the spilling by doing something
> > > along the lines of
> > >
> > > ldr   ip, [target, #-4]
> > > eor   ip, ip, #type_id[0]
> > > eor   ip, ip, #type_id[1] << 8
> > > eor   ip, ip, #type_id[2] << 16
> > > eors  ip, ip, #type_id[3] << 24
> > > ldrne ip, =type_id[3:0]
> >
> > Ah-ha, nice. And it could re-load the type_id on the slow path instead
> > of unconditionally, I guess? (So no "ne" suffix needed there.)
> >
> >   ...
> >   eors  ip, ip, #type_id[3] << 24
> >   beq .Lkcfi_call
> > .Lkcfi_trap:
> >   ldr ip, =type_id[3:0]

Yeah better. If you use the right compiler abstraction to emit this
load, it will be turned into MOVW/MOVT if the target supports it.

> >   udf #nnn
> > .Lkcfi_call:
> >   blx target
> >
> >
> > >
> > > Note that IP (R12) should be dead before a function call. Here it is
> > > conditionally loaded with the expected target typeid, removing the
> > > need to decode the instructions to recover it when the trap occurs.
> > >
> > > This should compile to Thumb2 as well as ARM encodings.
> >
> > Won't IP get used as the target register if r0-r3 are used for passing
> > arguments? AAPCS implies this is how it'll go (4 arguments in registers,
> > the rest on stack), but when I tried to force this to happen, it looked
> > like it'd only pass 3 via registers, and would make the call with r3.
>
> Wait, I misread, my test is using r4 as the target! Still, is IP guaranteed
> to never be used for the target?
>

The target register can be any GPR. IP is guaranteed by AAPCS not to
play a role in parameter passing, because it is the Inter Procedural
scratch register, and may be clobbered by PLT trampolines that get
inserted between a direct call and its target. These are not direct
calls, of course, but the callee does not know that, and so it cannot
make any assumptions about the value of IP.

That said, I'm not sure I understand why this type register has to be
a fixed register. It /can/ be a fixed register, but you'd have to tell
the compiler that. In that case, it can still use the link register
for the target, unless it is emitting a tail call and LR needs to be
preserved. The upshot of that would be that some tail calls will be
converted into ordinary calls, due to the need to preserve some
registers on the stack. But I'd still assume letting the compiler do
this when needed is better than always pushing/popping two registers
in the CFI call sequence.
