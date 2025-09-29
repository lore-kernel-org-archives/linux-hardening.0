Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44E2D0600
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139969; cv=none; b=CmvZBpq7FbVT22W4pg51IjYKXCPL2wn9eRukpE9oQXPhDS/a9BI5pj7gXtQ5IM2/njZaRp9NB42pLURsg/iMJvv7pzp2zO9meevlSGciZiFvg4JAJ81iU9jTxbVVe90KZ5ndImfl2x/Li/6KWs/8FvuEYRjy6xz3p21ub8f1kCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139969; c=relaxed/simple;
	bh=DYBJPIBbMHafgcAN44nzOJoGRrFBL/WVkCVLx71eGis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir9Hqdq+bxs9kMdpWGgtX4qsmU765+dBNbMEGp7mTTeMqSw0TDrOEy7jCVaf8HtQymzQBEFDKoTQ0klIfGGBVkLA73Dl0V+/ezetqNp+xLAF+QRkkYvneRhtk7X/g8/XAyC6VC649O/X+chuL8YBsYmMl+2rn9F5suEv++TbIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzoa9paf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzoa9paf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2A2C2BCB0
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139968;
	bh=DYBJPIBbMHafgcAN44nzOJoGRrFBL/WVkCVLx71eGis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nzoa9pafJSDzrhiJVc3GOIWx5Y3QKMjHeQHP0KNgv6XZAk6YfGWCLxpUsbevoMlPn
	 5S2YuXVXDDDtUFTGA2Didr1OsAe2AiGb1ezNRYQQT9CgiPkURbMjxUE+PmyH2fIkTu
	 sQwdKtu2f1LKP/ohbU5lKVMkudjXnf5Pyg5avwEbDriL59eZXWzXd/ikanRHDEqGOQ
	 xhU7jR5b9qugYOZGgcN4aezRLbF8VDBHax+I9DsErwUVH5O0UlaUU1GsVshEYpV0qp
	 q0QrdE/Mthte+TODczIE670YxAIqXXYZ7KL8ELBs1NzkZlWgDI4KsjVTyFeWnAVpqL
	 2NZeuqJmvtoCA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36a53fe7ebdso40922321fa.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 02:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSXl7WsfQSa1eYqTVWBtTErByaoup9CWRFZL3eG1P1cudbnLy9ZciGm0GMacS2o1HtNE4o5CkFXCr/AAHi0Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRidBKHOy+8QDQFZHWQ96oQAnfuFN92NpxUPyR55AUtKxtGXID
	30WmRIo1EIk3NIfnAObHvjnqYZE09kVZL5Y1wu57BL1YtzIFD9ogu/lZ7maqa7/tjCy9BAF2ThC
	Iphgs0f8RqG+EcpTTYnnLUbrEplm8gug=
X-Google-Smtp-Source: AGHT+IH5PibK2BEglV95OeRjODJbfR64f3760++WT4suP3RRQZaHMmgALypPu7Nm1nRiO8F1GDIp61CbGgPxhEIiEos=
X-Received: by 2002:a2e:be8d:0:b0:35f:246:a751 with SMTP id
 38308e7fff4ca-36f7e29b533mr50398521fa.5.1759139966508; Mon, 29 Sep 2025
 02:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926023737.it.616-kees@kernel.org> <20250926030252.2387681-6-kees@kernel.org>
In-Reply-To: <20250926030252.2387681-6-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Sep 2025 11:59:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQn0YEvpnwRigL_Mu61SGtGfmKVUJJgotGmm8S_BT8dA@mail.gmail.com>
X-Gm-Features: AS18NWBz0QeU3nJjTbDl289pZA1oNXXRnd7AYbXix4O9zvUwW_ML-KHDXqd1kQc
Message-ID: <CAMj1kXHQn0YEvpnwRigL_Mu61SGtGfmKVUJJgotGmm8S_BT8dA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>, 
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>, 
	Joseph Myers <josmyers@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jeff Law <jeffreyalaw@gmail.com>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Dan Li <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Ramon de C Valle <rcvalle@google.com>, Joao Moreira <joao@overdrivepizza.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 05:02, Kees Cook <kees@kernel.org> wrote:
>
> diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> index 422ae549b65b..c3b9f16ea872 100644
> --- a/gcc/config/arm/arm.md
> +++ b/gcc/config/arm/arm.md
...
> +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> +   RTL instruction being processed.  OPERANDS is the array of RTL operands
> +   where operands[0] is the call target register, operands[2] is the KCFI
> +   type ID constant.  Returns an empty string as all output is handled by
> +   direct assembly generation.  */
> +
> +const char *
> +arm_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> +{
> +  /* KCFI type id.  */
> +  uint32_t type_id = INTVAL (operands[2]);
> +
> +  /* Calculate typeid offset from call target.  */
> +  HOST_WIDE_INT offset = -kcfi_typeid_offset;
> +
> +  /* Generate custom label names.  */
> +  char trap_name[32];
> +  char call_name[32];
> +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", kcfi_labelno);
> +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", kcfi_labelno);
> +
> +  /* Create memory operand for the type load.  */
> +  rtx mem_op = gen_rtx_MEM (SImode,
> +                           gen_rtx_PLUS (SImode, operands[0],
> +                                         GEN_INT (offset)));
> +  rtx temp_operands[6];
> +
> +  /* Normally we can use r12 as our scratch register.  */
> +  unsigned scratch_reg_num = IP_REGNUM;
> +  /* If register pressure has made r12 our target register, we need to pick
> +     a different register.  We don't want to spill our target register
> +     because on reload at the end of the KCFI check, we'd be producing
> +     the very kind of call gadget we were trying to protect against:
> +     "pop %target; call %target".  In this case, use r3 as our scratch
> +     register.  But since r3 may be used for function arguments, we need
> +     to check if it is being used for that and only spill/reload if that
> +     happens.  Any spill/reload of r3 due to making a call will already
> +     have been managed by the register allocator, so we only have to care
> +     about not clobbering the argument value it may be carrying into the
> +     call here.  Also use r3 when r12 is a fixed register.  */
> +  if (REGNO (operands[0]) == scratch_reg_num
> +      || fixed_regs[scratch_reg_num])
> +    scratch_reg_num = LAST_ARG_REGNUM;
> +  rtx scratch_reg = gen_rtx_REG (SImode, scratch_reg_num);
> +
> +  /* We only need to spill r3 if it's actually used by the call.  */
> +  bool need_spill = (scratch_reg_num == LAST_ARG_REGNUM)
> +                   && reg_overlap_mentioned_p (scratch_reg, insn);
> +
> +  /* Calculate trap immediate.  */
> +  unsigned addr_reg_num = REGNO (operands[0]);
> +  /* The scratch register is always clobbered by eor seq: use 0x1F.  */
> +  unsigned udf_immediate = 0x8000 | (0x1F << 5) | (addr_reg_num & 31);
> +

I take it this means you still need to decode the instructions in the
kernel to obtain the expected type id?

Can't you insert the actual register index here, and defer the reload
until after the UDF? That way, the scratch register will always
contain the XOR of the actual vs expected typeids when taking the
trap.
