Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127298;
	b=m7HXx60oKTTUYsFJmL0m9U96C+ZdYUpFSSN4L6uNcfx7XQ/247rbZTLApIpwmda/5fxv
	 t3vM8OjsNZL7bYJtKdW55pxmV0L2HHA7pUqJEXVqvobfUDsQbiZ+cGtb4nG+a2Zn7eJpy
	 FWEZ5Kh373ytChvZUuJm7Fk/RDfqCwsCE/NAAk8wzxAAB/8OWzVmENWh5enGtCKZnx8nm
	 hlxwqM17UxX/qmpm2p5NtcW4dzCTC45uIMvZ2K4HW+64CWVHRaUimX5yalHqVQiuZ/FW6
	 tpP+07ebYJe5CY25RjYLUfXthVdXndro0xP0rM5ifoKgVZYtji1vt718gY32uMKmpcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PqOM/IVleeod7A0pYm+8MQSeW6D2IecEyUtYHLW5mL4=;
	b=YqOG2FiuqZCB40VNsdCXm+dHSfoO97uUMLyhmRvmlhURw/VHPeKexIKEzilDvk6xCzD8
	 rJzjACRebSU8q9wP2mxG5G5K2imUANDYYn/gma/5nmb2KFaDfl8Obji2csAOFODQ9SuaA
	 26+LK1Y/1lxvxucGnPkiuM39MWwcXJ1M0PSW5JQZLfm9//BBSMsnB+m4NPibxanKsWUjN
	 Kk1PaFmSaZ0Y3IhjJd66lX/311Mldr126uX0MvSJnamWdFC2Y1lMRx2U7PBzbKAECeyfC
	 9iGYgbI/v+3aTBKbUjwxB2+QGD3nQr1yV2IBCRpLeaRXG+VZGt8PasYqOhIOPWcfhpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nev0cxZu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B0606A338
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 22:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707B0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nev0cxZu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso1895485e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 14:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127296; cv=none;
        d=google.com; s=arc-20260327;
        b=rkwF5SlXdpYJ0COl5IzNV9F9OZkL6ZeNrYCtpCCCrRTkXCZAURICDCv9n5MeJkatKd
         wRdH97VEXJTb41ATxCbFdWhdYyehIwQIzeLP/t5OgYJs75G6dceKFXfQ3i37wEO0RpeV
         vPQfHpIRN81d1rxra13+7wUXiY6wFxkiYF8h9pFxjZ3s19aS4YlFmSZx2T5FGYqNljm8
         VLGiHcyJc59ctBWiXbAWuiKQJ1iDFGsUfjmO5YSbfCCS94A+y6xu1pS6ZGiopKDDlLPd
         FxOyNStJw2o4aMGWz4rpoAnF5A0swkh8UhhYVN9HXxQ0Ime/n7oVwcJKtO82FXYZxj+Z
         +8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PqOM/IVleeod7A0pYm+8MQSeW6D2IecEyUtYHLW5mL4=;
        fh=TzFn7GJkEFjI5sg54AetySncKyqJ0X6KeXzBhxv/Jpc=;
        b=bqecR2LnVtx7Sg00wbjR9YxnmK5hD9JnSSkEqr8UXnb6gQ0qGyamM8+8W/QfJ4Mmzi
         efjPaH4gZSQs7EDByKOL/1DNoFZNa3fhxxyeX+zaV4d1mv9ZrWhhi8G7uz2fvWtxRWma
         CgPPtJ8Hm6bv6/hZREOs/24LVUXjsOQVtDiyvD6daxYFp0r9FZslVG7gcLdvbFoRufXq
         FycvjzbyaznihPFuMP4aLkLIqSfp79JiGduKbV6mxgcZFIcnrgy/9H8lgwZlSlhrdgfS
         FAuMhLCffzzSwhlE09dKF9fMmDJeXn7F6M748nhCweT24t906jtjyJh2g/k0gdzKjZaO
         ls4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795127296; x=1795732096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PqOM/IVleeod7A0pYm+8MQSeW6D2IecEyUtYHLW5mL4=;
        b=nev0cxZuS/Y124NbcheYqiimSGl+rxwr3V0vU3LhZI5Rv5NaqltmvN9z1kF3zLU+6m
         wk60cg0RHMGoK5rx6HkhBDg5TyW+vt2mVv2hVAZIzLb0CQA4WSOwLB5Kpl54Tjm+uzgx
         qdmftJ6CJWfT+rZgZ8NSoxFEiabHtHABuuN+xvaJGP4yRXlNX9kpwEuUoNY4JYymJazf
         P/k/aTMiQDUaqzptxwHffQXgdrjHwj1e4cjf/tdbsYmEZKid/RzauV0RHrUwyfMVzcQ+
         AsqvHeHqF23ElPhtaXNxgOnPzGocQ8vDpL+w8Oc6EDIcrnUJXCHg61+cRuUrcv3lhm04
         mCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127296; x=1795732096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqOM/IVleeod7A0pYm+8MQSeW6D2IecEyUtYHLW5mL4=;
        b=S1Z/X95gvG7XmtzLyUCdgzvrodTVD+hODDWeV3JCnmOX8YZ996R/DtX5f3NGpSGgQx
         yAfo4O+jDWnAzl8FyMwiCO9BhVjC70DBS6OmZMe3P363XAQv/ic2qWl3YHoMRHBQD079
         fNSJuLt0XWglQR+5KgIpUG+STZLu4Tc0KHrwdPewZSru6RDKsqgjdpH3JTT/+AFBqYJq
         qai/irDEsnMqD9WHSd7PtdAene0b8QDTMY97IV+u4Xy2B+pg8wKtGpl4qinUnb3KUowQ
         FS+opMjZlbLi/0N0Qtt3+gt0wrBwire971lfdxZu/YZX0BvcbcpuDJIAySnjPEwTRIqz
         I6TQ==
X-Forwarded-Encrypted: i=1; AL+hErHj9vyEuyUt2VFRyjmtpCGytqscetoVDucSCAzQ0rHGLKaHDah6vnzzY8ApUrvRCFupXftTabwuZvSphSiXlyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Rnwv79mUeOaOgoRUVRw0VKf5Xeewj2nJGJJpNC3poQcjxC+Zk
	A2M61XRlu5Pbp7D4ZuBr5TNEVUsJ7i5pYkCmhHSxF7X3JgjGt52TI5W+O8nWjh5YSaGTS0cul6L
	zbi1ebA0HDhamNLW89VqwKsyS3iLl3pQmSYt2Qj3Y
X-Gm-Gg: AYBFou0aYLypycQcUZsqLlTbc16wJmwKnvIhwBTm4dtBMFJuhgRreQtrC6HtbLIyhW9
	xjpPp8ZZX9eTtNEaOO2Yf0v1ukKtCnsGpeNXAjA5Bpw8+RJtRmZi68xhdBQCxX7D1MVP1RVaH8x
	9SEnrpOEaOZun49uAQmL65NzCmkeiffb03MLmO63GLqWgNZLeI0+l+7wuI93MNcaaWtelYooKUY
	LlsbDysCMEbzmDn8V7WOR/1QM6uierE8hCqaBYnl3qmLENokAabWxQlZi1JO8MuKMvPIx5AFnOl
	J4MGqhea73v0eOHqhSS8vTJSZrGv177xpjlFNIPzcY2WNqiM6nY/mLaAo7vO2Ia2nUm22c9G2ty
	/5KUaPy53XXCrBdCaJnzN3VvgovlIkBwlap+5FlT0jjfjanHjEvCOXvRhhteBpf5AWX37TUPLku
	QMEiAzAhbmLQbG1n/p4Ie8sG3SUuC3iJ4Igv1UN7QHYE8uZFn+QX09UIq5GvmPnmjMuBcp8u371
	uS5dfNYqVVSfK5qpCbX8s458JBTE5YK9F+Q
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id
 5b1f17b1804b1-4bb88809950mr22312695e9.17.1795127295355; Thu, 19 Nov 2026
 14:28:15 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119213147.1094488-1-usama.arif@linux.dev> <20261119213147.1094488-3-usama.arif@linux.dev>
In-Reply-To: <20261119213147.1094488-3-usama.arif@linux.dev>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 19 Nov 2026 14:28:04 -0800
X-Gm-Features: Aa3M54rGe2WhCo8NjeyvCl13h6yYFCLQD9z1s09DtfOo7EUnkavEum06rHONXb8
Message-ID: <CAKwvOdnzNU_xtLeb4vXSFe3DLN9QmdNSSReUmQahsLX+1pZxCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
To: Usama Arif <usama.arif@linux.dev>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org, hpa@zytor.com, 
	gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com, nathan@kernel.org, 
	morbo@google.com, justinstitt@google.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com, 
	atish.patra@linux.dev, dgreid@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:32=E2=80=AFPM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> With KSTACK_ERASE, every return to user space poisons the part of the
> task stack that was used since the previous return. The generic
> __stackleak_poison() does that one word per loop iteration, so a syscall
> that went 1-2 KiB deep pays for 128-256 separate stores. On Meta hosts
> running many small VMs, stackleak_erase() accounts for about 1.5% of
> non-idle host kernel cycles.
>
> Override __stackleak_poison() on x86-64, as s390 already does, through
> the hook added by commit 491a78663e03 ("stackleak: allow to specify arch
> specific stackleak poison function"). Fill spans larger than 512 bytes
> with REP STOSQ and keep the word loop for shorter ones, where the fixed
> startup cost of REP STOSQ does not pay off. REP STOSQ starts to win at
> about 300-400 bytes on Zen 5c and Cooper Lake, so on both no span gets
> slower.
>
> The fill is inline asm, so the noinstr function still makes no calls.
> memset64() would be the same instruction, but it is only static inline,
> and with KMSAN it is an out-of-line function.
>
> In a Zen 5c KVM guest, stackleak_erase() got about 35% cheaper per return
> to user space (71 ns to 46 ns, scan included) over a futex, epoll, procfs
> and Unix socket syscall mix. Same-vCPU futex wake/wait and Unix socket
> sendmsg()/recvmsg() ping-pong round trips got 5-8% faster.
>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  arch/x86/include/asm/processor.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 77488ff5eb8c7c..049231d484ad0e 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -580,6 +580,31 @@ static __always_inline bool on_thread_stack(void)
>                                current_stack_pointer) < THREAD_SIZE;
>  }
>
> +#ifdef CONFIG_X86_64
> +#define __stackleak_poison __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +                                              unsigned long erase_high,
> +                                              unsigned long poison)
> +{
> +       unsigned long count;
> +
> +       /* Short spans do not amortize the startup cost of REP STOSQ. */
> +       if (erase_high <=3D erase_low + 512) {
> +               while (erase_low < erase_high) {
> +                       *(unsigned long *)erase_low =3D poison;
> +                       erase_low +=3D sizeof(unsigned long);
> +               }
> +               return;
> +       }
> +
> +       count =3D (erase_high - erase_low) / sizeof(unsigned long);
> +       asm volatile("rep stosq"
> +                    : "+D" (erase_low), "+c" (count)
> +                    : "a" (poison)
> +                    : "memory");

Surely this isn't the only place using `rep stosq` in the tree, right?
It's not, see memset64 in arch/x86/include/asm/string_64.h.

> +}
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
>  #else
> --
> 2.53.1-Meta
>


--=20
Thanks,
~Nick Desaulniers
