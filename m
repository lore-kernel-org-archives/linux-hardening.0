Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B43ECBE9
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181783; cv=none; b=Dm5xgfCIOMKbe3p3zOQL3FusuqovoNxzN7OwhT55Ay6hSF8eEkKukcARgatC2GJmG7gblXSLN5Cag4LpirFzym6Fv7Cqj7Y0N5DUaL9pWV3qg7S/E0aTiKpHyNp8YP9ScquEFEWM23vk9SriMO9YFJH3z9JCo6ZGSlghGNRai14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181783; c=relaxed/simple;
	bh=fmdH479ERMQHqfNok+4D+xQW71EB6yw68t5LcQSj+xU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKuHOiBzCmL0Qd84j9meyAEtywtlSCjCEbBRUDOOKi2U1Zs5t0L8+iOTBEppA4RFwe5okgEOyBzL86mn1vjryb3Zq3QLceBKPqJBNvCPTbebBaBXY75MtAkjnsXHDzRSIm0JuN2+hgyukLYKtZ8XxxAcfL+ZET6xR20bcaBcQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzgiOWEq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzgiOWEq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so583755f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779181780; x=1779786580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+iXZtTOejOCcBOlkcK88mcsIwo9JMpHwqyMFaYtyNQ=;
        b=kzgiOWEqzWkabWaw2E2bDBcCWmo8NhZl7k966k71XIt0hKz2a9fKXpzoqzPFFJju1g
         PJ+F68Xb5UFtaHOSiLLo4T+6fph1WeBzjwWB6qN5HuYyzq40SPMlXBLKmDmdUsalz4EM
         84uMYnTvwYnK9t+30/a9OEvgbcXRK46eoEUrRVjQ2XAuJMFJE5PYzrpEHDnUwud60g8c
         si/Yu2wHF05cfMI5t+Xq4JCNdDBpiwiyErN53rDcKaAfwJOmF2VCfEcyE6JfC9M2bsjQ
         EEs9rrMq4W0PdU4v5+EMngXnEbSFLYtEmgIYbZ8VsdN7mbUokmRQnx6kyWK8oCkAksm3
         S1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181780; x=1779786580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+iXZtTOejOCcBOlkcK88mcsIwo9JMpHwqyMFaYtyNQ=;
        b=qNdN6rT4aDzJ8erxdiLthwaa+qpKr/ERRUK7Q+K/DhRfypY+APsbnKXtIZT5adbBHN
         8qSSAxdf4W8q0EU+xcsXi44Chek5uLzwoBttIoNGpq6s9YKIoAZc/IC/Nfpgb+xMariH
         uUuWkR4vo1AZvZiOprCDed1WRSIvUizs48ODIptoJSXDHkzuAMNW9ANpcv78EITOUq6+
         7gNJlAx7gs2En9BKgJ4EZEjCDO5lMUSAMGL0vfT+FBl21UrHrUyd1gtBPTHliyJkIAux
         PMpGUV4wXqPyt/f6CT4ZddE+knQKr9t3NSm12QoGYpPzm6+UABA7iSKOp48+9ED28mmy
         UPTw==
X-Forwarded-Encrypted: i=1; AFNElJ+wISKVrTXjyzqgda5UcvmBIgqLZ4PTqSXCnnz0lIPJPViy7dtA+iRtcKSjfAwkkQ8ZF9yokSHzDEzR98xfF7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKo1R7i2R55svAtVvntPkPKxMCHm2X6qhEsfOEnKxVX5n+a2Bh
	LQDgf/ajeHkD5Gr3IXq2+ZmHIKPFDYBIvSN1mRm8/48/TZLzF2j+QHNq
X-Gm-Gg: Acq92OELM8bd/jP/nYDwtPYQwDtLW6l85HZFAy/mfs8upvZzeoiuxqdLRgRl82bc4cj
	hc49dALo44Zvf6wTDSPdd9dYPrmnJDlsCdBjCR+D1VJ7nx6DMZDIcZ93bdPeeJGnKUvqdV8snz+
	jeY+BiW9bxSPPeGNcAI43QwDYrSv0p7/SExiq9oT1OGqGGoZIP6ECKaWNd+8yga3+cxOJ9rvN1T
	sFt0IE+Gf95pCeepcFZwm1TkXOgET1BFwZhybZXb7CyssgijYXcC6+LNyQ1wn62MxIgnNAlkxF+
	d6XnHOzBe97089fwSAxsajgWfqyONVUdJzvhVe3TqNQauAf25Cvm23F66pMseARONs2bSMVH6XD
	/wQRPdnnPl7oajYORCUjZy5OJCAKXXuNW8V7o74iZWs4ib8X7gs5O5i6YQbARvKUx2BGrIzwNBI
	hIzDnDiGNt5q5HCDOL2p4dWe2Ottd7UcOFC28fdpW+F24wszdQKbR4x6iecI0uLB2t
X-Received: by 2002:a05:6000:2902:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-45e5c594d5dmr28915798f8f.29.1779181779524;
        Tue, 19 May 2026 02:09:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm46500351f8f.18.2026.05.19.02.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:09:38 -0700 (PDT)
Date: Tue, 19 May 2026 10:09:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Milan Tripkovic <milant2002@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org,
 Dusan.Stojkovic@rt-rk.com, Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: Re: [PATCH v4 1/2] riscv: lib: add memcmp() implementation
Message-ID: <20260519100937.1a186752@pumpkin>
In-Reply-To: <20260518131407.1026049-2-milant2002@gmail.com>
References: <20260518131407.1026049-1-milant2002@gmail.com>
	<20260518131407.1026049-2-milant2002@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:14:06 +0200
Milan Tripkovic <milant2002@gmail.com> wrote:

> From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> 
> Add an assembly implementation of memcmp() for RISC-V. The implementation
> uses the ZBB extension for word-at-a-time comparison and an assembly
> fallback for non-ZBB systems.

I think I mentioned before that the only ZBB bit I can see is the
byte reverse at the end needed to get the correct sign.
For non-ZBB it would be better to fall back to a byte compare
at that point.

Oh - and there should be change info for this patch in this email.

-- David

> 
> Benchmark results (QEMU TCG, rv64, Aligned):
> 
>   Len   | Default | NoZBB  | ZBB    | %NoZBB | %ZBB
>   ------|---------|--------|--------|--------|-------
>   1 B   | 20.3    | 25.0   | 20.9   | +23.2% | +3.0%
>   7 B   | 88.9    | 107.5  | 155.7  | +20.9% | +75.1%
>   8 B   | 89.6    | 110.9  | 176.2  | +23.8% | +96.7%
>   16 B  | 134.4   | 172.4  | 334.8  | +28.3% | +149.1%
>   31 B  | 163.5   | 220.5  | 606.2  | +34.9% | +270.8%
>   64 B  | 203.8   | 235.9  | 968.6  | +15.8% | +375.3%
>   127 B | 224.6   | 268.7  | 1362.8 | +19.6% | +506.8%
>   512 B | 235.7   | 271.1  | 1913.7 | +15.0% | +711.9%
>   1024 B| 256.8   | 290.6  | 2123.6 | +13.2% | +726.9%
>   4096 B| 263.8   | 302.9  | 2290.4 | +14.8% | +768.2%
> 
> Benchmark results (QEMU TCG, rv64, Unaligned - Offset 3):
> 
>   Len   | Default | NoZBB  | ZBB    | %NoZBB | %ZBB
>   ------|---------|--------|--------|--------|-------
>   1 B   | 20.7    | 21.7   | 21.5   | +4.8%  | +3.9%
>   7 B   | 96.2    | 99.1   | 96.9   | +3.0%  | +0.7%
>   8 B   | 97.5    | 118.5  | 110.5  | +21.5% | +13.3%
>   16 B  | 136.7   | 166.6  | 172.8  | +21.9% | +26.4%
>   31 B  | 167.6   | 206.5  | 211.9  | +23.2% | +26.4%
>   64 B  | 204.4   | 229.9  | 240.3  | +12.5% | +17.6%
>   127 B | 229.6   | 261.7  | 269.0  | +14.0% | +17.2%
>   512 B | 245.5   | 260.8  | 269.9  | +6.2%  | +9.9%
>   1024 B| 246.9   | 261.2  | 283.5  | +5.8%  | +14.8%
>   4096 B| 250.7   | 295.8  | 299.7  | +18.0% | +19.5%
> 
> Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> ---
>  arch/riscv/include/asm/string.h |   2 +
>  arch/riscv/lib/Makefile         |   1 +
>  arch/riscv/lib/memcmp.S         | 125 ++++++++++++++++++++++++++++++++
>  arch/riscv/purgatory/Makefile   |   5 +-
>  4 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/lib/memcmp.S
> 
> diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
> index 764ffe8f6..5c5299678 100644
> --- a/arch/riscv/include/asm/string.h
> +++ b/arch/riscv/include/asm/string.h
> @@ -18,6 +18,8 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
>  #define __HAVE_ARCH_MEMMOVE
>  extern asmlinkage void *memmove(void *, const void *, size_t);
>  extern asmlinkage void *__memmove(void *, const void *, size_t);
> +#define __HAVE_ARCH_MEMCMP
> +extern asmlinkage int memcmp(const void *, const void *, size_t);
>  
>  #if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>  #define __HAVE_ARCH_STRCMP
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 6f767b2a3..b529e1be1 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -3,6 +3,7 @@ lib-y			+= delay.o
>  lib-y			+= memcpy.o
>  lib-y			+= memset.o
>  lib-y			+= memmove.o
> +lib-y			+= memcmp.o
>  ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>  lib-y			+= strcmp.o
>  lib-y			+= strlen.o
> diff --git a/arch/riscv/lib/memcmp.S b/arch/riscv/lib/memcmp.S
> new file mode 100644
> index 000000000..a531e481c
> --- /dev/null
> +++ b/arch/riscv/lib/memcmp.S
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +/* int memcmp(const void *cs, const void *ct, size_t n) */
> +SYM_FUNC_START(memcmp)
> +
> +	__ALTERNATIVE_CFG("nop", "j memcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> +		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
> +/*
> + * Parameters
> + *	a0 - Pointer to first memory block (cs), also return value
> + *	a1 - Pointer to second memory block (ct)
> + *	a2 - Number of bytes to compare (n), transformed to end pointer (a0 + n)
> + *
> + * Returns
> + *	a0 - 0 if equal, positive if cs > ct, negative if cs < ct
> + *
> + * Clobbers
> + *	t0, t1
> + */
> +	beqz	a2, 2f
> +	add	a2, a0, a2
> +1:
> +	lbu	t0, 0(a0)
> +	lbu	t1, 0(a1)
> +	bne	t0, t1, 3f
> +	addi	a0, a0, 1
> +	addi	a1, a1, 1
> +	bne	a0, a2, 1b
> +2:
> +	li	a0, 0
> +	ret
> +3:
> +	sub	a0, t0, t1
> +	ret
> +
> +#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
> +memcmp_zbb:
> +
> +.option push
> +.option arch,+zbb
> +/*
> + * Parameters
> + *	a0 - Pointer to first memory block (cs), also return value
> + *	a1 - Pointer to second memory block (ct)
> + *	a2 - Number of bytes to compare (n), decremented during loop
> + *
> + * Returns
> + *	a0 - 0 if equal, positive if cs > ct, negative if cs < ct
> + *
> + * Clobbers
> + *	t0, t1, t2, t3, t4
> + */
> +	add	t3, a0, a2
> +	or	t0, a0, a1
> +	andi	t0, t0, (SZREG - 1)
> +	bnez	t0, 5f
> +
> +	addi	t4, t3, -SZREG
> +	bltu	t4, a0, 7f
> +
> +1:
> +	REG_L	t1, 0(a0)
> +	REG_L	t2, 0(a1)
> +	bne	t1, t2, 2f
> +	addi	a0, a0, SZREG
> +	addi	a1, a1, SZREG
> +	bleu	a0, t4, 1b
> +
> +7:
> +	beq	a0, t3, 4f
> +	REG_L	t1, 0(a0)
> +	REG_L	t2, 0(a1)
> +
> +	sub	t0, t3, a0
> +	li	t4, SZREG
> +	sub	t0, t4, t0
> +	slli	t0, t0, 3
> +
> +#ifndef CONFIG_CPU_BIG_ENDIAN
> +	rev8	t1, t1
> +	rev8	t2, t2
> +#endif
> +	srl	t1, t1, t0
> +	srl	t2, t2, t0
> +
> +	bne	t1, t2, 8f
> +	li	a0, 0
> +	ret
> +5:
> +	beq	a0, t3, 4f
> +6:
> +	lbu	t1, 0(a0)
> +	lbu	t2, 0(a1)
> +	bne	t1, t2, 3f
> +	addi	a0, a0, 1
> +	addi	a1, a1, 1
> +	bne	a0, t3, 6b
> +
> +4:	li	a0, 0
> +	ret
> +2:
> +#ifndef CONFIG_CPU_BIG_ENDIAN
> +	rev8	t1, t1
> +	rev8	t2, t2
> +#endif
> +8:
> +	sltu	a0, t2, t1
> +	sltu	t0, t1, t2
> +	sub	a0, a0, t0
> +	ret
> +
> +3:
> +	sub	a0, t1, t2
> +	ret
> +
> +.option pop
> +#endif
> +SYM_FUNC_END(memcmp)
> +SYM_FUNC_ALIAS(__pi_memcmp, memcmp)
> +EXPORT_SYMBOL(memcmp)
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index b0358a78f..456929971 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
> +purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o memcmp.o
>  ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>  purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o strrchr.o
>  endif
> @@ -41,6 +41,9 @@ $(obj)/strchr.o: $(srctree)/arch/riscv/lib/strchr.S FORCE
>  $(obj)/strrchr.o: $(srctree)/arch/riscv/lib/strrchr.S FORCE
>  	$(call if_changed_rule,as_o_S)
>  
> +$(obj)/memcmp.o: $(srctree)/arch/riscv/lib/memcmp.S FORCE
> +	$(call if_changed_rule,as_o_S)
> +
>  CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
>  CFLAGS_string.o := -D__DISABLE_EXPORTS
>  CFLAGS_ctype.o := -D__DISABLE_EXPORTS

