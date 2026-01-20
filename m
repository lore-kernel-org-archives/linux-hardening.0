Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33433DED1
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928669; cv=none; b=g9+u5mqkT456aJUe6m+f3Kee7U3DdnPtWBolahrSmcYWyCGPvlXmPqG1UEziy6zkeSblSzW6y6Ae5zJYbd2s9MwvQ72EJgGjZzU/fe55LXDaTBIvefxS1uVr8WXGpUvSev/lCyvKWXV1+wAXTAwixPa5jqgGu3W+UeHcdGgD5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928669; c=relaxed/simple;
	bh=Ycy21iUncoH/EI2xFovIFcUv/mmTJGHGmyFSb6UEnT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSOPSId2QephKvJvjTFDcLcT3h3Am8ksxRDaBgA0Kph7V5AHEkIoSdj6wJLmejlIyn9bbpvpcC5T2HHc5l3YMs0Dpy14EWo9uDqGxU96q3SQ2+n2nXPwql8QX0EWIzwomqjzCQ/XuKrEpJNdpKjCdGwFCNp7YP/DRo9NkTCtHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDA6o+l1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDA6o+l1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a377e15716so110587495ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768928667; x=1769533467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jBNcNLijS6CegFyscucRvLlda8lrhInLC4WxoMsJSU=;
        b=tDA6o+l1BsBl+fpfCTJN0Qj0VHDzGN0lpVwlBkUF82kQOyHLAeLtSNhV+R91PLXRgi
         cX0nBUxF80VpkQ6qZ8BuxeZzowOEb29oomsj7J0uLiJksJSitLAUwPKD7kKZX33AkCgq
         u62TlHkXPG9CE+dj/SwJRcgtdJJ8x3/9ILfuO+tV7IgSj+ItLnLKbcQBn7RDP765bcLY
         8KxsErOwlj0ojwKOfAeMfBdlFf9Ju4RQodpEIynsbpnbHR53lJ6ZHMt2+aH5dNVodgWM
         Shmq1ugjl52ZjYbblvnsbmosTRBcRGjyE0IbVLcWbRfAQEKNmHJ7GjYU6bMRak7O5pIz
         Z2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768928667; x=1769533467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jBNcNLijS6CegFyscucRvLlda8lrhInLC4WxoMsJSU=;
        b=LpkiGq0PO2WvBEoX8OaCJLIof58Th9r1d5dt5sq+EArRSVaMM0FN8NRFNRGG81b+I2
         c8unx3H4865L5R6GRHd1zho12H8J5OVAk8VfeeoHRxkl0HBU1yhs8h0DkSTP9ecOFQaP
         qU559tpJuj3TLWMlKa1wjO5/CUJ2B7tgZ7vZPyaLV51G1N2heRih71q2WVzxGDEBrzmp
         OuQBb/ThHx+GCiva2g2PnL40Y730zxTN5HZ5ZLqZb67ZbET+EY4JVTAT2DK2YTc0KMro
         ct0cEB4MruHLKboMg1C+PiQC4rz/kQWhaNePMiGNqYiX3CpkiTQzmIIxEvX7lMCEhz2h
         JV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVwF6TVmnwnUnsMNoBQ2kVYeANy3LwX3MBIOymVwg3Wegv37xCaf+4mRVBGiXa/xCRbsaNLVWXuL9QEeLDl06k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBi5ojezTp47uGc/oAlxSrhBotgqa93dt6SawkmsWbxkEH9xl
	1Ua8cG6i6MOawYigDl6b4G4KojeF6Cw8Pp+aCsDIeKEqx7g4PbA7fF6nc4C8p3Iy14Qzd+m0WXR
	VP+5+xQ==
X-Received: from plbke15.prod.google.com ([2002:a17:903:340f:b0:2a7:6fd5:9ab9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40e:b0:298:616a:ba93
 with SMTP id d9443c01a7336-2a718857417mr116338325ad.9.1768928667435; Tue, 20
 Jan 2026 09:04:27 -0800 (PST)
Date: Tue, 20 Jan 2026 09:04:26 -0800
In-Reply-To: <20260108092526.28586-31-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-31-ardb@kernel.org>
Message-ID: <aW-1mv3OU-GcRyAQ@google.com>
Subject: Re: [RFC/RFT PATCH 10/19] x86/kvm: Use RIP-relative addressing
From: Sean Christopherson <seanjc@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 08, 2026, Ard Biesheuvel wrote:
> Replace absolute references in inline asm with RIP-relative ones, to
> avoid the need for relocation fixups at boot time. This is a
> prerequisite for PIE linking, which only permits 64-bit wide
> loader-visible absolute references.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/kvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index df78ddee0abb..1a0335f328e1 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -807,8 +807,9 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
>   * restoring to/from the stack.
>   */
>  #define PV_VCPU_PREEMPTED_ASM						     \
> - "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
> - "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
> + "0:leaq 0b(%rip), %rax\n\t"						     \

Please use something other than '0' for the label, it took me forever (and looking
at disassembly) to realize "0b" was just a backwards label and not some fancy
syntax I didn't know.

It might also be worth calling out in the changelog that this function is called
across CPUs, e.g. from kvm_smp_send_call_func_ipi(), and thus can't use gs:
or any other "normal" method for accessing per-CPU data.

> + "addq   __per_cpu_offset - 0b(%rax,%rdi,8), %rax\n\t"			     \
> + "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time-0b(%rax)\n\t" \
>   "setne  %al\n\t"
>  
>  DEFINE_ASM_FUNC(__raw_callee_save___kvm_vcpu_is_preempted,
> -- 
> 2.47.3
> 
