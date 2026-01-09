Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711C347DD
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767934895; cv=none; b=d1Q7AhtLj+n3jucASd65+/tH56nRmEMsyomiG5TtWIRWZdE0QEecKNlA2Ky1k/52hsM3Ke6RhReF+fhjp95kKgTr3cdKirXFEoxIpA++az2q7Aa7ThJo6px8yxDMFA6jldbukf6pGjGHHeUjgvTz3gBgY6sPzbNb32oy55Kl7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767934895; c=relaxed/simple;
	bh=JKkKa3LUtBxbJ4Mpq9B/dTUt3/TLRmczxgcYv+sPziM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laCmOWGasjlTY9eRbc0pXjFDjIZ881dr04yf9B3wyOMHSpAc6OR5S5gulwXFq4HorLw1htqgj9p+tQ6vqEdwBnpEr28U8JCdlHNbWb/gAtNh8PVmIe+OVZ7jg6g3MQFOQiT2dqcnpc8Jl2OOGiL6iq3aohQtcXcAzjZ/oTNeczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/SHlnH/; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/SHlnH/"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5eea31b5c48so785351137.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 21:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767934892; x=1768539692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEaKEaXu7xiIUePbJBeX3i6JNgIg05KVjFc/E/HctyM=;
        b=c/SHlnH/WhdOIQUIvMsCH6pZVVMhHBpCE+HdwCizgNzwmMcRdg0olrEOVn4zaPjeiA
         0t2EBJyXU7PtcAEvcF68PHC1+5Dzipps4l4G82eOjlD3Dcj4zJWmSQ4YaGJyWRzRyzil
         mrY6sTiA8aF1r9bulT1aUs523rTzbdKSNiJAs1M9YpBa6/C5zs30TCWMByxEj8tDZgPY
         8ly8t1V9ea3V3r994c3F8Nfn9f67E7Um4G2QfHzSfe5tmoRuQvr1JjmOFplB21/eANPC
         +0oZ2kFY5H/IfcSiT3eDpVp7XjnlDSui1frmYs2dPUjEbcrNm5dwaOEWYpdk0HPCzC/y
         eTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767934892; x=1768539692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEaKEaXu7xiIUePbJBeX3i6JNgIg05KVjFc/E/HctyM=;
        b=b1PzNcVWd05hm38n7dE+gmGW/GBxXL5KW7lXQ7fsxoKh7btyFFGRFozM5nO3mLxOCG
         QMvI5Di5vPsmeJC0oTEMoNebU3U0uSJEJhecYrpBfineYSlycyPQ08PYqQ6NHKtFlV3n
         MSFCl5/FVab6ouDcZfCJl5KGFQC+LstwTilSDPDa9QqUjw9AdqHZYmnMCAPPsLoyHsyM
         3UuFNn/cS7MogNkoLUPq7iwmbRGPdJ+C4P5K4J77RN6wUkrgxDnR+piaTlrgGtXe71Jp
         UZlhk1uPKi9VwyE05v31xedIbCyO03G5Zz8oxD482K8jHnUfeCEvflsa3Fs16eBWhvoI
         HNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1FfVQoYhMAWUlCClpDlaY/kK8lQRJMgCCxcqzq5W4H3V+r6XBJVA9Qbh+ngD7sTW63qRDMLtaQR4gsjc43H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcdxzQKJADvUhN+PegP7pf+geSiGVGadN90Ty5CYBISGcSGn6
	rHYqacNOzsjWuy1EIVIeLc5F/mU/mAAHyFsR6PW49+jC3W/pA2N0hLQgy/WCn0EZz3Y8itDIK+2
	O64cVmRzAlbGzYQWaxfQ4qcadRW2g1A==
X-Gm-Gg: AY/fxX62cOUJcusyNnk99UQDHvQXtcui4qOChFKDLEyDjvo0V1FE3TDYUVWSuLD6GV2
	rt/I1m9qy+5iRaMoPrie8VKBdqaHQz17h6Itz48tWwxRR4zLVEAjuNB4vHKl2gc+se6uK5nAC6R
	jkuLe3jy1m5Vbm0092U6xKovQzA6OqEV7rCxQIqUXczxqf9mCQaouqUnlIbOSKjYCZ8iWtmg9QC
	Sku6WhBc8BU7qkH/DWbZvOW8bfxKMqHu52un6SVWXNXCuDl5PyDzg1EQ7QhWy1yC/mrR2bI6fO/
	XunzEQg4FA==
X-Google-Smtp-Source: AGHT+IFYOsfhRLW2uIVOO+YWAR1JwXTI/DvYnGjXhAv53qFZzouFvVQynZ7XAH3suPCjd76IdrmFUvID8RPEBFQ5Lmk=
X-Received: by 2002:a05:6102:38ca:b0:5dd:b287:e5f4 with SMTP id
 ada2fe7eead31-5ecb06309a8mr3249410137.0.1767934892600; Thu, 08 Jan 2026
 21:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
In-Reply-To: <20260108092526.28586-36-ardb@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 9 Jan 2026 00:01:20 -0500
X-Gm-Features: AZwV_QifKdUTfT0zCnamNUAf7WQYCgO8j_yTWpOR3oeXGxKhplI9OBxn_EKkKh4
Message-ID: <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> Use ordinary RIP-relative references to make the code compatible with
> running the linker in PIE mode.
>
> Note that wakeup_long64() runs in the kernel's ordinary virtual mapping
> so there is no need to record the address of .Lresume_point in a global
> variable. And fix the comment while at it.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wake=
up_64.S
> index 04f561f75e99..15233a4e1c95 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -14,7 +14,7 @@
>
>  .code64
>         /*
> -        * Hooray, we are in Long 64-bit mode (but still running in low m=
emory)
> +        * Hooray, we are in Long 64-bit mode
>          */
>  SYM_FUNC_START(wakeup_long64)
>         ANNOTATE_NOENDBR
> @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
>         movq    saved_rsi(%rip), %rsi
>         movq    saved_rbp(%rip), %rbp
>
> -       movq    saved_rip(%rip), %rax
> +       leaq    .Lresume_point(%rip), %rax
>         ANNOTATE_RETPOLINE_SAFE
>         jmp     *%rax

If this is already running on the virtual mapping, this can simply be
changed to a direct jump.


Brian Gerst
