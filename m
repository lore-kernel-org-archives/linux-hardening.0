Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D73BB672
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734683; cv=pass; b=DjzlmEPlZxChrGGB28NnYCY1KcubwA8LF3ChEZNtanppOiiEcQfDr2OVJlf1Sz5yuNhh6kr6v5eh+1MLf/T6iNn8Y0b4WlauX1Yxhm4HUyh88LpZL+jPopHDUFBiBmLImG1jSH9llZm3uVAZaKJo6Ugn7iSE9pGOLDg4Oeb22oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734683; c=relaxed/simple;
	bh=4hDmZR+0g9sg25xWn/EISS7mDraJaaS1AiK68Bo3XbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qje99yHbW9E7jn9SHxXIVfZN0PKYxhwqZw0KqCMIj58W1+hujQt0JQ1KM1Ue0fZC1VcQ3Ynfjd7oiOCPLoUMXg5IoX8dBphfBBo9vugSrWgaZ1x1Xt1tmF+t0LgMd/cfmE0GgdrU2WxYJ+LhxKDurguaZqtftw4+yGOwePvicJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo7I2C+q; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo7I2C+q"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c953950dfso4089811fa.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 01:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787734678; cv=none;
        d=google.com; s=arc-20260327;
        b=AhlQ9W9GmsTaXZ97e4cXhujRamK81omBcqiMhc2igoSzWsWDw+EmOAcmUBXbdLQ1C5
         0inhaPttssKq7UXo50jigeQ+LiMRHXXJOr2Of+jed6twq4wSAohsbfDiHV6WxyKiUtT3
         ++pBN2lOuWi9u5GLMiGHGDT3uWgX9bmjOGa6o+16gV8WAZD8mOaPfTTpyB6quDmxqAmq
         G1+GJovD+ADrF/bl9KwniElSSr9xr4YCl44GHA25jLNwXDLgNfa8ziEsck6SLHj6s7YB
         Hvwgzyvpr7sVBPURM4KnYfFntp6FCgQicj6Fb13v2t+h25JnQhA4U67E0Ke6iWDoxkW/
         gmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ueubB+TsLcNnlGdpPDJNO18clBrrJ7dLZ+ZET7/yfzA=;
        fh=fwZ+P4OJeOmdsYbBIi6vZgxjuydsi8Qpnt0UibWUBaw=;
        b=Y28Hk3dn5wnWhdJp2Zpr6AAcPhBf13xa/LwL+S5PJ7rKtkYS4iosjxZC9ENAmEYMN2
         NDubbVWxhBLEgZoLzrVIARQ2Fy3z0NZQv8eL5o+TkH8fC6fCfW2DfSsiHJ3fqVWQEb+l
         hdVDlkW0CxofvEIeeh0Lrsq/AyMRH/l4p6st4kyso5QzL8f71sVPvC0wtk3jb/Ub/HfB
         fnJuuw/QPF5YPLe4y8LH3rlEoSC47TNliT+86+uH+7+4Yf2lbcqosEW10qJVf0xRQ7Ll
         tTchl6/vP/x0f2D39wIXswRKUGzUel4XDR1rt5FUFWtfDEYwvigIHVmTfxLUKa7VWwZo
         DJ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787734678; x=1788339478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ueubB+TsLcNnlGdpPDJNO18clBrrJ7dLZ+ZET7/yfzA=;
        b=Wo7I2C+qfNmwvOFGpoEHNkTFveOjV3FzIE+qMts8hgngx5w8qAxJYRhe/OtmbABrXc
         G/IGHScI0ZxvXCeosy3THw+Wty9FhgzIHMuPSkrDV1fHOxooJBaD+1bIdUlh6g6Gpi0k
         IgHzTcs/oV6ChF8pc7zEbc4Nt1oIpRuSOhnGEI4Qi7hPpwx9BTpJ5GkEDteMcSWTdTRA
         UPlSzPKA0JbQspa0RXdZfCXqOD48M81JEERcADydC6SKzPoMz3ydd9wy6aZLYHXEk9gJ
         c0QBfHJob8HO/Foe7HM27dAUmARSPKvBRU0pyS0e70otnTWC65pA2AhaFmlKN9HFbO8p
         JXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734678; x=1788339478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ueubB+TsLcNnlGdpPDJNO18clBrrJ7dLZ+ZET7/yfzA=;
        b=oMw9EughkUwApkaY8ojj6NFl5D0tKgB1iJvpcKZvnURyS1OdLvvpnGsjQohj3SzQLx
         GJPEiwasqRkkTMVaC5UqT5mUDWYf4vPa1snaSj//PKno0HgD9c0Px6I3jfiigujy1Wfc
         145sRXSW24KEK5PnaqLwW99IOm0/k29fv7K/9FD9A/WdmK3MLLtd2OBwqpVvosLBbWPM
         2g6OKAWyUQO18X9EXLG+Jd0LbGidim28z/tOrjbDWf+a3x/yrKOv/lCN/mURo7nj/kyO
         TRY8aPIEO78/38u8E9MDU1F7CNXIlPs96cRCjzYQnqWVDmuPwLfBAfe4Hb8K7tFS2qRF
         pKHA==
X-Forwarded-Encrypted: i=1; AHgh+RopD4Y9+2llE9Dwnwj+A05YKjAKsdynjhdeyPtB/9vCQ6X9h6R8t9JTMI92xbtw22BUElHszKEdBsxZs8I3dO0=@vger.kernel.org
X-Gm-Message-State: AFuF++lOYua6UbUzxckJKie+bxjhBUz5+KpcYFQc9yTtDJRDvRdKh1LA
	vGYDhgGLqcIltOyLdCV2u3OaSnxUI2Q49ywaCXOhd1lhvCrDl67dHDrRbrDWH6DWiv+HI8Ecl0K
	6a0K7v//h1iDcG09FTPyY6zGZjR4BPhM=
X-Gm-Gg: AR+sD137SmhRABajCNnA1f90aqCkSqNd0kdVAaCUYFHNZZEDooDGebw6fpVqyvXrJzM
	yJXNeNM+/kXe5yOAq8UsT9FAEXOQDtiRWtr15OOVWsr6coMd03Q4AeplCKDRrA2p+fuLN6EQS7R
	qdIiLvDAwPMx6FJog8ctY6XgD9yaY+aO+RuAh5HiR4ETT08wB135DiQe+ZNDBzqmPIATpnDLBtX
	dsFBKcQ8ngXrkVcL/Z9G9Z0znh0bASFXM/OBIdwoWBeS7+Pi+cxfjNDcG1MXhd/NRVXLDPYfeMM
	VMwEaBX46UD7pAZBfhnaItK6+OzOFjVvrM7NO22mBVVDxARxbyW7WVDYsYmFOfpxa8xS541AJd4
	fIW/07LgwBNIKTC25SQIf2z+TRZQjE1iG++Brlo1a7xSAdT5J+dXoEi2ad2WwLw==
X-Received: by 2002:a2e:a58f:0:b0:394:5c9a:f315 with SMTP id
 38308e7fff4ca-3a1fd699d57mr10651161fa.14.1787734678124; Wed, 26 Aug 2026
 01:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825235748.i.456-kees@kernel.org> <20260825235759.3379064-4-kees@kernel.org>
In-Reply-To: <20260825235759.3379064-4-kees@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Aug 2026 10:57:44 +0200
X-Gm-Features: AcwNN1UAXjs7pIdFuzdaL-GOorRFajU5NWrqahY1_47ikBjSnxtGeV5IRbZDD70
Message-ID: <CAFULd4ZKxXdw0gk5RHfihOBHJmcs15Y-uLFHcQUp_JMg58RyrA@mail.gmail.com>
Subject: Re: [PATCH v15 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>, Jeffrey Law <jefflaw@qti.qualcomm.com>, 
	Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>, 
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Dan Li <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Ramon de C Valle <rcvalle@google.com>, Joao Moreira <joao@overdrivepizza.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Osterlund Sebastian <sebastian.osterlund@intel.com>, 
	Constable Scott D <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:59=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Implement x86_64-specific KCFI backend:
>
> - Implies -mindirect-branch-register since KCFI needs call target in
>   a register for typeid hash loading.
>
> - Function preamble generation with type IDs positioned at -(4+prefix_nop=
s)
>   offset from function entry point.
>
> - Function-aligned KCFI preambles using calculated alignment padding NOPs=
:
>   aligned(prefix_nops + 5, $func_align) to maintain ability to call the
>   __cfi_ preamble directly in the case of Linux's FineIBT alternative
>   CFI sequences (live patched into place).
>
> - Type-id hash avoids generating ENDBR instruction in type IDs
>   (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).
>
> - On-demand scratch register allocation strategy (r11 as needed), with
>   the clobbers added when KCFI is used.
>
> - Incompatible with -ffixed-r10 or -ffixed-r11.
>
> - Uses the .kcfi_traps section for debugger/runtime metadata.
>
> - Introduces -fsanitize-kcfi-arity to enable function arg count to be
>   represented in the kcfi hash preamble for FineIBT.
>
> Assembly Code Pattern layout required by Linux kernel:
>   movl $inverse_type_id, %r10d   ; Load expected type (0 - hash)
>   addl offset(%target), %r10d    ; Add stored type ID from preamble
>   je .Lkcfi_call                 ; Branch if types match (sum =3D=3D 0)
>   .Lkcfi_trap: ud2               ; Undefined instruction trap on mismatch
>   .Lkcfi_call: call/jmp *%target ; Execute validated indirect transfer
>
> Build and run tested on x86_64 Linux kernel with various CPU errata
> handling alternatives, with and without FineIBT patching.
>
> gcc/ChangeLog:
>
>         * common.opt (fsanitize-kcfi-arity): New option.
>         * config/i386/i386.h: KCFI enables TARGET_INDIRECT_BRANCH_REGISTE=
R.
>         * config/i386/i386-protos.h: Update ix86_output_call_insn.
>         * config/i386/i386-expand.cc (ix86_expand_call): Expand indirect
>         calls into KCFI RTL.
>         * config/i386/i386.cc (ix86_kcfi_mask_type_id): New function.
>         (ix86_output_call_insn): Emit KCFI assembly.
>         * config/i386/i386.md: Add KCFI RTL substitution patterns.
>         * doc/invoke.texi: Document x86 nuances.
>         * opts.cc (common_handle_option): Reset flag_sanitize_kcfi_arity.
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/kcfi/kcfi-adjacency.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-basics.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-call-sharing.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-move-preservation.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-offset-validation.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-large.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-tail-calls.c: Add x86 tail-call patterns.
>         * gcc.dg/kcfi/kcfi-trap-section.c: Add x86 trap patterns.
>         * gcc.dg/kcfi/kcfi-trap-section-per-func.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-32bit.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-arity.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-fixed-r10.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-fixed-r11.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-retpoline-r11.c: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

[...]

> +/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32-bit
> +   KCFI type identifier to potentially mask.  Returns the type ID with
> +   x86-64 specific adjustments to avoid embedding ENDBR instruction
> +   sequences in the type identifier values.  */
> +
> +static uint32_t
> +ix86_kcfi_mask_type_id (uint32_t type_id)
> +{
> +  /* Avoid embedding ENDBR instructions in KCFI type IDs.
> +     ENDBR64: 0xfa1e0ff3, ENDBR32: 0xfb1e0ff3
> +     If the type ID matches either instruction encoding, increment by 1.=
  */
> +  if (type_id =3D=3D 0xfa1e0ff3U || type_id =3D=3D 0xfb1e0ff3U)

This should use the ix86_endbr_immediate_operand predicate. Exactly
one target dependent immediate (0xfa1... for TARGET_64BIT and 0xfb1
for TARGET_32BIT) should be avoided only with flag_cf_protection &
CF_BRANCH. All this is handled in the predicate.

Uros.
