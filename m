Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392192B2D7
	for <linux-hardening@vger.kernel.org>; Sun, 14 Sep 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879587; cv=none; b=EYjExxndnfDrbcQm7dao3zB/+asB+byzJe5I99lDhFxfzP0wJqQCHP/E4NBEa+qLpgYat2wrpV+3but5auuku3OwxaE0LlX8xQ0iDFMV3TaX9jDeT9hI5svWnMgg9pRK4pujeme2KI0lzwFlbp9th5e8qbliccwGCnspFVbb7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879587; c=relaxed/simple;
	bh=tjCj3EnbRdHma0YQmuUtm2LMwvB/7l5CWfCjTeWHLWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkTz+zn5wFoWoc2gfCde4ZdIeDeyAmT8RiWjsEHRuaj5ZGKgI5cwBT9I8O8KkTP1aP09XEq0kDAC0RZlEW/SkwboDGlwUxuKr4qRr9MCf9apO0dvRxeMNZQSUIfT8iukCB28NIZm6VK247m2LjuxX4rasG2NgkQmPKKnGAk95XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8ftvluB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8ftvluB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso3114311a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 14 Sep 2025 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757879585; x=1758484385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pje4D3CByGIXLuBhczETfA0Fp2g3PnfJQiaiRkQVus=;
        b=i8ftvluBd3zBTe0qhDdt7Zp92gUsTl3Rze+reeVZJIpXEJpM9rcct8zG4fJwmB1dVH
         DPiH4+5Jw4kKXVinTR8YKdESXNN1TWBVspcQV+x+csern4Qq55sFiPEP/jeYR6sgxrRA
         JdBS7KyXp7KmVKjL+icz0EzXBSjYtniy3piuz63M5FXE+I2mjsDP9QF39+no2YoAZpkB
         DiMZLi83DWeTX2IAN0SkcXbUjUIGoNon2dGurxmY5/1ZXB0qr6PFuIDH6KKegI1xmw5r
         pYOXasCdcPc6/8rFT8DdeQQ1nBh6hnlox2VInY9IEA8Y7VIuD7a3DbAHy99Gin5+XUI9
         Hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757879585; x=1758484385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Pje4D3CByGIXLuBhczETfA0Fp2g3PnfJQiaiRkQVus=;
        b=ucAIBRKeNPveIhvRk4IV8ggclAiA+eY3gyKCQJOAbxgTLrYaSY4zxrwg5w8UTxfxY/
         Khzp2NzBKU9aJov8wOzfliPxQ1riUe8zhGMRW4Cl8cRLh5uQa3pDI7p25gtr4YRa4fZM
         2XxrOHsTJ/GELtIc9YbNA0ebRH6xJU10VdAL+ZRTJcEM27be4il1sYNSsfTCQC5x9chW
         xEwn1MtnEV6xAQ5iosagcA39xwItKx/+hraQpscxwMXN3mqcnFmENd208CdF+19tcvRN
         Q8XUqvz3bLch1aidL68vijvJ1EITiH2EmcAP4sEqDDi0kbGfqNrCZvab7NZLPgQCGSLx
         FqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWjK7fRv782xEoNaR0+F/9DFKBvqBOM9zUHOTrIULc7TY9/+GxLdoWSHbzvrY6jkGbZZDlXoTpsBBwwaUGBncs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhBy6/VqNNeKGNMjMTu01vYOFAa6Y9cCsvDSkFkmDb/p44P0q
	KoKZ7keVegP8rraK6by5a344EPv6EY2/uNyJLuzu6KAZYGvGUXXOs76piismm+31ngpQXwcf5In
	Kbh53Jp2tRvaJNPLCc7Sga9IrztXpglc=
X-Gm-Gg: ASbGnct8bN74pZr2cJyyHmD4jPYVhWyiNKWTUt2Dy2N5syJJPMqZICQESSpvvoncJCW
	ExaLqac+pukGGjc/wZpwzG/5V1OqPxAt0+6NHFIzNF60leyNndAovXNr0XOcAKRpiM4lERVilZG
	UFlm8acZiGgux4pZUoI/YGwPsRTDNb0tdU6nfRTaXIFMNLb6bg1heUnbssEibpVAmYHPI1J15pp
	zaVuw==
X-Google-Smtp-Source: AGHT+IGnev8nKvE2s2675ib8Bbo/lnhrwpAVNb3f1+cVYyKUFlQkDPgDhV/K4NchiZgIrueWo5O0RXLGKE3JIx8qV5w=
X-Received: by 2002:a17:902:cecf:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-25d2713241dmr142954305ad.45.1757879585399; Sun, 14 Sep 2025
 12:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913231256.make.519-kees@kernel.org> <20250913232404.2690431-4-kees@kernel.org>
 <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com> <202509141233.33B8C6D4@keescook>
In-Reply-To: <202509141233.33B8C6D4@keescook>
From: Andrew Pinski <pinskia@gmail.com>
Date: Sun, 14 Sep 2025 12:52:52 -0700
X-Gm-Features: Ac12FXz5NF_8dkTBNQWhxDvWW6irq8X23zKi9Dlv_NFqrjCxg8MTU-X_iresXwY
Message-ID: <CA+=Sn1k=BFEPhWJFh075r+9dx0Fft6KHmnz64tKLRx0W=XsKew@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>, Qing Zhao <qing.zhao@oracle.com>, 
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>, 
	Joseph Myers <josmyers@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Dan Li <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Ramon de C Valle <rcvalle@google.com>, Joao Moreira <joao@overdrivepizza.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 12:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Sep 13, 2025 at 04:43:29PM -0700, Andrew Pinski wrote:
> > On Sat, Sep 13, 2025 at 4:28=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > Implement AArch64-specific KCFI backend.
> > >
> > > - Trap debugging through ESR (Exception Syndrome Register) encoding
> > >   in BRK instruction immediate values.
> > >
> > > - Scratch register allocation using w16/w17 (x16/x17) following
> > >   AArch64 procedure call standard for intra-procedure-call registers.
> >
> > How does this interact with BTI and sibcalls? Since for indirect
> > calls, x17 is already used for the address.
> > Why do you need/want to use a fixed register here for the load/compare
> > anyways? Why can't you use any free register?
>
> Ah, yeah, good point. I'm struggling with this on aarch32 too for Ard's
> suggestion about using an eor sequence. So, the problem I haven't been
> able to solve is that call instructions cannot have scratch register
> operands. Or rather, can't when there is register pressure like on
> aarch32, where a spill would be needed. This is in the LRA:
>
>   if (CALL_P (curr_insn))
>     no_output_reloads_p =3D true;
>
> And that does make perfect sense, there's no place (in the current
> design) to provide a place where the reload would happen. But I also
> can't let the kcfi check/call get split up arbitrarily.
>
> Is there some way I can convince LRA to let me do the restore manually?
>
> > > +const char *
> > > +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > > +{
> > > +  /* KCFI is only supported in LP64 mode.  */
> > > +  if (TARGET_ILP32)
> > > +    {
> > > +      sorry ("%<-fsanitize=3Dkcfi%> is not supported for %<-mabi=3Di=
lp32%>");
> >
> > You should reject -fsanitize=3Dkcfi during option processing instead of
> > this late in the compilation.
>
> Where is best to do this on a per-arch basis?

In the case of aarch64, aarch64_override_options_internal looks like a
good place. There are already errors produced here when it comes to
incompatible options. Other targets will have a similar place too; I
was only reviewing the aarch64 specific changes here.

Thanks,
Andrew Pinski

>
> > > +  /* Get KCFI type ID from operand[3].  */
> > > +  uint32_t type_id =3D (uint32_t) INTVAL (operands[3]);
> >
> > Maybe an assert that `(int32_t)type_id =3D=3D INTVAL (operands[3])`?
>
> Oh, hm, actually, I think I should be using UINTVAL instead?
>
> > > +  /* Load actual type into w16 from memory at offset using ldur.  */
> > > +  temp_operands[0] =3D gen_rtx_REG (SImode, R16_REGNUM);
> > > +  temp_operands[1] =3D target_reg;
> > > +  temp_operands[2] =3D GEN_INT (offset);
> > > +  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);
> >
> > Since you are using a fixed register, you don't need the temp_operands[=
0] here.
> > Also what happens if target_reg is x16? Shouldn't there be an assert
> > on that here?
>
> Yeah, I need to solve the scratch register issue more generally.
>
> > > +  /* Output conditional branch to call label.  */
> > > +  fputs ("\tb.eq\t", asm_out_file);
> > > +  assemble_name (asm_out_file, call_name);
> > > +  fputc ('\n', asm_out_file);
> >
> > There has to be a better way of implementing this.
>
> I couldn't find one that would let me keep the custom label name. I'd
> love to have something better! :)
>
>
> --
> Kees Cook
