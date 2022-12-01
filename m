Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04CC47088
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 18:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiLASS6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLASSu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 13:18:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F2A430D
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 10:18:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2896056pjo.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttDTTn0msLi3yulrL0NYUUesa3El3fK1mxiDYXquzzA=;
        b=aeFFB3BHCmHkvKimGZvJUbM8qhEI04p1++4qzxmAccBsAT3OnNl1rhHdS042nDjuks
         OLkAFEFdOxYcHzXhiMwbcuo3+csSOk5EuPr7TLh4kuR8VSdIYwznNiDNUFshDJoRLlvy
         EbA0jC+V0s0hblXMcqynk21iTQ3irSRPC9+ds7QwmDSh9j888yaIf66r1hQvXBlX76k1
         bcpCKnuPPe1bOpYib36pwX72AVkSwRyU8eUCD2I+aAiFAzLC5Aeitm6B9Ekckb48ZGux
         2XI1A6T6LdJ4qhNp+3dKSedm5jRj1KtfzncxTykAySmScfSZaDssP1r7JQJ9YHJOEAEP
         Z2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttDTTn0msLi3yulrL0NYUUesa3El3fK1mxiDYXquzzA=;
        b=NoIzcsru1Pci8irjQRfKHa6DHGFwHZRScyWRf7j+sb/MmvHxE2X8M2NW0ASR8d+03E
         /oWXbFtCcaZCW79C4Dl00GqA2QnaZC4c9F2hr4Xz/N4t83clGFgt0/IgV5zOyqTMHboP
         xwKWgq9j5N9uFHSYYdfKiMRIZZeDOJxGSZHSoIEj97Ap50O2RhSHbiWW56/UYh8sWRkR
         LkE2IR1zMoNtYcbNXiq8cAXIAG+Q7C8kTyQ2MlpyMF4nk0sD3bb9aZowMS4SijQbEeo6
         AGw45KXIaSSiYISdJf8KUc4tqHdRI5WJoQ22/wYUG5C/2qf/aAr/ClmOZrILypDczYK9
         ZldA==
X-Gm-Message-State: ANoB5pmSbJQ+hITxohSNgfIgCqLnCuzFeaTqWvyBkr+gQQw+bccwRwC1
        rKSV7RHy5o3VQ8tH4ef5B/7zXA==
X-Google-Smtp-Source: AA0mqf71vriUfgppVEBnIix/98ORtNcdQs3rF+02zBz8gzW0ifovd0y3sZcvN7NTTGzsbw/9U4e1pg==
X-Received: by 2002:a17:90a:4705:b0:219:255:78a6 with SMTP id h5-20020a17090a470500b00219025578a6mr37641747pjg.114.1669918729255;
        Thu, 01 Dec 2022 10:18:49 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f23-20020a63dc57000000b004639c772878sm2848115pgj.48.2022.12.01.10.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:18:48 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:18:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     coverity-bot <keescook@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: emulator_leave_smm(): Error handling issues
Message-ID: <Y4jwBahPrkwOI3w9@google.com>
References: <202212010825.8589611F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212010825.8589611F@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 01, 2022, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221201 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Wed Nov 9 12:31:18 2022 -0500
>     1d0da94cdafe ("KVM: x86: do not go through ctxt->ops when emulating rsm")
> 
> Coverity reported the following:
> 
> *** CID 1527763:  Error handling issues  (CHECKED_RETURN)
> arch/x86/kvm/smm.c:631 in emulator_leave_smm()
> 625     		cr4 = kvm_read_cr4(vcpu);
> 626     		if (cr4 & X86_CR4_PAE)
> 627     			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE);
> 628
> 629     		/* And finally go back to 32-bit mode.  */
> 630     		efer = 0;
> vvv     CID 1527763:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "kvm_set_msr" without checking return value (as is done elsewhere 5 out of 6 times).
> 631     		kvm_set_msr(vcpu, MSR_EFER, efer);
> 632     	}
> 633     #endif
> 634
> 635     	/*
> 636     	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
> 
> If this is a false positive, please let us know so we can mark it as

It's not a false positive per se, but absent a KVM bug the call can never fail.
Ditto for the kvm_set_cr{0,4}() calls above.  That said, I'm tempted to "fix"
these since we've had bugs related to this code in the past.  This doesn't seem
too ugly...

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index a9c1c2af8d94..621e39689bff 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -601,8 +601,9 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 
                /* Zero CR4.PCIDE before CR0.PG.  */
                cr4 = kvm_read_cr4(vcpu);
-               if (cr4 & X86_CR4_PCIDE)
-                       kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
+               if (cr4 & X86_CR4_PCIDE &&
+                   WARN_ON_ONCE(kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE)))
+                       return X86EMUL_UNHANDLEABLE;
 
                /* A 32-bit code segment is required to clear EFER.LMA.  */
                memset(&cs_desc, 0, sizeof(cs_desc));
@@ -614,8 +615,9 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 
        /* For the 64-bit case, this will clear EFER.LMA.  */
        cr0 = kvm_read_cr0(vcpu);
-       if (cr0 & X86_CR0_PE)
-               kvm_set_cr0(vcpu, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
+       if (cr0 & X86_CR0_PE &&
+           WARN_ON_ONCE(kvm_set_cr0(vcpu, cr0 & ~(X86_CR0_PG | X86_CR0_PE))))
+               return X86EMUL_UNHANDLEABLE;
 
 #ifdef CONFIG_X86_64
        if (guest_cpuid_has(vcpu, X86_FEATURE_LM)) {
@@ -623,12 +625,14 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 
                /* Clear CR4.PAE before clearing EFER.LME. */
                cr4 = kvm_read_cr4(vcpu);
-               if (cr4 & X86_CR4_PAE)
-                       kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE);
+               if ((cr4 & X86_CR4_PAE &&
+                   WARN_ON_ONCE(kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE)))
+                       return X86EMUL_UNHANDLEABLE;
 
                /* And finally go back to 32-bit mode.  */
                efer = 0;
-               kvm_set_msr(vcpu, MSR_EFER, efer);
+               if (WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_EFER, efer)))
+                       return X86EMUL_UNHANDLEABLE;
        }
 #endif
 

