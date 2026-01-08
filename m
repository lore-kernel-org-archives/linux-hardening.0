Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CC486B7E
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874122; cv=none; b=nd1Pdun4GzgictN1w5feyO3YhfCk4/DEdf5oun+itLEVMkZJFThSv+njO1zEMsY6rI+8nf925DgJ083XIiidH00bJbYZEKy6kJO/+qiMfMHXzD4lV0C9h8rhMC5JzuTvsMf3lC4MxqTqbFcRXrf3E6MFAdCEzMVOS40zLpN+bwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874122; c=relaxed/simple;
	bh=LVZ40STMU5xbF6u53KkyjwWQqgB7f/pceRkg9uq5PPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0edu1WwYsN9yC8bTE7e2r0/8/2McmKaJvuuSSEZWVpZ1EOK71gx0VIK4sgR4v3Kq7MoQJIPMZ/JiYRRrm4TgDiqZldEM2nfKTBbZSimJPDEN9DjoD/BrJTb1dmYpnA7tKM7a4rSGk+RQEu8WhqZQXglJK6kx1q7/7BzXzRSBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKYt1ntS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKYt1ntS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1706092f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767874115; x=1768478915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIu4seuzZ/2olyXDJICl58waAHMxO6oQqWCq3D4UNEU=;
        b=nKYt1ntSdhfPNItzHL/GFC9AfE1FVc+C4PZzBgisiUIgChJ8x6z4VALQ+ezpImujRX
         DBM280Fdomemm8g/WZVqImS1OPG9wgdg1q72EklMNV8xLfi3WM5JD8L9cGjs1bOJTPZL
         oNB0BF9S9KkvLfdDuHEjGRMNyqH14jL0hVTHzqx+uUtLl4Psg4HLD3m//vcR2UsuHg5S
         DmKA1D/3Z5uIaUb16LnUR0rLxPmlJdd03YPBUVSgkipvWSZz6dNG6Zy0TATFOux7rxbe
         5xiPQviBi6BkyUmhwEaVBrCAYj45d8I20UbIfM9WjinP1qMSI7oQQTnnjJLV1s1oB0CD
         QaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874115; x=1768478915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIu4seuzZ/2olyXDJICl58waAHMxO6oQqWCq3D4UNEU=;
        b=g37tCx3NmpagqVwpRrsUAAuUqQMXkAWIZKrZxRVniUy3JFgUrWIQtnDUZkAzBe3Wbv
         SuRhDEGCKMw0eR1IEAdJ3hNBoiIRG6nqtva3m+01L4eIhEn4SebMhTy0VgDowD8f8RwO
         2COev+eUcOL8Di0nDtYky48bfa1L3bvqB8S5LDLIStO9FVt0Wlwsjb9lZtDfTLIf6FrZ
         5SiqAssUWsVnAEXlA/TY2uz7dM7nzoZNqLDb+74vJ5oLwWLQFmVSE1baT4s7LXhdu9NE
         pwQ7V9D2oW+dB6tblmClIYtySDoXorXs+YKMLB659gOYt4bJ7LkEpoi1Y6qYEEsN1Yn6
         sUgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+PW0WJpyzB1BJnDDi7ZRuarXQSJuK7jHjM4bxaku1eYURhZD12JeR9FfFnwJZWhplMYdwu82sCxt2+Gnz+9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEVcirj1d5EdkaYCBAyvK92+8D1tc2kNVZAwvOBxji/6NeVZo
	xCIuUy3TroGadwa4OeTO/UZm9WlPXhJpx9Ke8ShYrZtPO8e8KyZQffv+
X-Gm-Gg: AY/fxX6ykogci97+xgg3Vi4R2nOpE5ubBwFFlJqA48DVivqMJyLGZShsbBI8vcj5rGB
	XqeTOGy+NHsC8ZmboDxMBXJwWv7EzEi1taPLBs9fpOYZsocvvyuIi0Zc7VMKPft6VUyuRWhWdu/
	oDyh1o7ZZQb8qz0yEpVrKTkWBGuS/HmP40xTpex+7JbmLtbbPaU6ZDOYSE8Bqxij2asaA0bDY7Y
	cxoSLqhS5f9PHOafpYOCHULY85+b1HpzWwS4/Dxb4GuS2NoUJjkmco5mgEDACfTBm8wiknuHmhv
	omm6Wd9t9NEXkfxT1hRzWOc8UI0xxMQRGil1qIvuXIOFcCszNiRfdd8J/bU4P7OgFbGrlOcuzU2
	Gl0hSu/2qBmKmpbvRLvsOr5OkqDC7jbUCFZ2sTIvDLBEIocJSMLOLTGRx65/4EcoqREY6u73hip
	ezYtb6djl9Oe4fTm+bDAZ7E/+PYiu6Sy5QahtMzRCIhHLifYABiGQ1
X-Google-Smtp-Source: AGHT+IFm9ZkcvtfxpyCjKOXSbNye77in1xcaHgylREjxy9RB1BXkEpaaBATrtkNU7jLQmaBC/9pwHw==
X-Received: by 2002:a05:6000:1448:b0:431:a0:7dea with SMTP id ffacd0b85a97d-432c374ff61mr7814372f8f.40.1767874115069;
        Thu, 08 Jan 2026 04:08:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm16146325f8f.43.2026.01.08.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:08:34 -0800 (PST)
Date: Thu, 8 Jan 2026 12:08:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Kees Cook <kees@kernel.org>, Uros Bizjak
 <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
 linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 11/19] x86/rethook: Use RIP-relative reference
 for fake return address
Message-ID: <20260108120829.6ea6aa0a@pumpkin>
In-Reply-To: <20260108092526.28586-32-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
	<20260108092526.28586-32-ardb@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 09:25:38 +0000
Ard Biesheuvel <ardb@kernel.org> wrote:

> Pushing an immediate absolute address to the stack is not permitted when
> linking x86_64 code in PIE mode. Usually, the address can be taken using
> a RIP-relative LEA instruction, but this is not possible here as there
> are no available registers.
> 
> So instead, take the address into a static global, and push it onto the
> stack using a RIP-relative memory operand.

The comment implies the address is 'fake'.
Does that mean it could just be a constant?
Clearly the unwinder would need the same change.

	David

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/rethook.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index 85e2f2d16a90..50812ac718b0 100644
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -11,6 +11,10 @@
>  
>  __visible void arch_rethook_trampoline_callback(struct pt_regs *regs);
>  
> +#ifdef CONFIG_X86_64
> +static __used void * const __arch_rethook_trampoline = &arch_rethook_trampoline;
> +#endif
> +
>  #ifndef ANNOTATE_NOENDBR
>  #define ANNOTATE_NOENDBR
>  #endif
> @@ -27,7 +31,7 @@ asm(
>  #ifdef CONFIG_X86_64
>  	ANNOTATE_NOENDBR "\n"	/* This is only jumped from ret instruction */
>  	/* Push a fake return address to tell the unwinder it's a rethook. */
> -	"	pushq $arch_rethook_trampoline\n"
> +	"	pushq __arch_rethook_trampoline(%rip)\n"
>  	UNWIND_HINT_FUNC
>  	"       pushq $" __stringify(__KERNEL_DS) "\n"
>  	/* Save the 'sp - 16', this will be fixed later. */

