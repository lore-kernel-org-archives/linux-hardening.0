Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7FC47088
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLAS1F (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLAS1D (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 13:27:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC0DAC6E1
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 10:27:02 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so6033141pjh.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCBLFunv2Vft5/XRro/hAOWRadbTKEK4P7Y2KdcX1BQ=;
        b=OP6By/1AvzitGVoe6OCVKnMfu76bUKILx3gGgbD+h1+QsNvMNawnoycQ8TPmxunfOR
         A08HwZhssjH+Tt2hruL2wUSTeFULUiIqFwsPG5K97RKE/Xh26QOrgk9hNI+mEKvAldzX
         CWVj9A23vfavCfyaR0bL1AaKpAU729e3NeD/lQKEHVj5tjsLG8A4aPBp0ZWuIaYNSn3U
         6KTy+DbDd1g6lD69AiiO4iQ/ny8C9zSVgSzRdaeB54oocOwiN2WVXwjplXCrSQvcPfg7
         LrYUlGaE7B+/m58rKjt7kIF009mKwj8K/rsB1AO9AHE0cxOLq2rajlOIco/jm16sXgMc
         QJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCBLFunv2Vft5/XRro/hAOWRadbTKEK4P7Y2KdcX1BQ=;
        b=GB+N2Jkr4zK2wyd6GMjLNGg3dq6/M/UM5TDojziOShSEQLNniYj18UpNNJGb2hj937
         Q+J5hFFjX2D/zg9juJwxpOiyyhsbwmZ9KvjALJF1vQ9cGFezEsbh5sDg6mp+tpW1AvfE
         482wCxoVNm1E2nInECLtY8NZdAylDp8IbUoFO66ughU4puqYAc9GnWnEqoojGpzjBHxj
         9+edNw7ME037SbTq4MBpVxRrh/hi2PM7zRvft4t+Bm9+qLaxi9z+BP//QAVBIGWJgDuJ
         udfiu5xF7leC3VvMiVOzEtiLGEOJW3Me91QuJFBs2K/bCd4imAaEY+ib/ZLxDfuJp2CD
         DiQQ==
X-Gm-Message-State: ANoB5plMHmPPPQX+6K+wtkUNdFQNDU7TMRefQUwoR3cCRh0oQYrw15iT
        6VVA5LBiZJCcqZFaGldKjlfjIPnByKx8wg==
X-Google-Smtp-Source: AA0mqf5Kj0VTFrTLLNw4nbHetuhYfq0yeD8jThvqN47Qa724OS1pxVHFDoKY65/KolPkxxqzpYGktg==
X-Received: by 2002:a17:90b:3012:b0:219:63d9:516c with SMTP id hg18-20020a17090b301200b0021963d9516cmr9882790pjb.108.1669919221995;
        Thu, 01 Dec 2022 10:27:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z36-20020a630a64000000b0046ec7beb53esm2864431pgk.8.2022.12.01.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:27:01 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:26:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     coverity-bot <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: handle_vmclear(): Error handling issues
Message-ID: <Y4jx8UPHg06ylxT6@google.com>
References: <202212010825.C23022D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212010825.C23022D@keescook>
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
>   Fri Dec 14 17:59:46 2018 +0100
>     55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
> 
> Coverity reported the following:
> 
> *** CID 1527765:  Error handling issues  (CHECKED_RETURN)
> arch/x86/kvm/vmx/nested.c:5269 in handle_vmclear()
> 5263     	 */
> 5264     	if (likely(!guest_cpuid_has_evmcs(vcpu) ||
> 5265     		   !evmptr_is_valid(nested_get_evmptr(vcpu)))) {
> 5266     		if (vmptr == vmx->nested.current_vmptr)
> 5267     			nested_release_vmcs12(vcpu);
> 5268
> vvv     CID 1527765:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "kvm_vcpu_write_guest" without checking return value (as is done elsewhere 7 out of 8 times).
> 5269     		kvm_vcpu_write_guest(vcpu,
> 5270     				     vmptr + offsetof(struct vmcs12,
> 5271     						      launch_state),
> 5272     				     &zero, sizeof(zero));

Good bot.  Some day we'll hopefully do more than freak out if writing guest memory
fails, so I think we want this:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b28be793de29..938900c0c994 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5266,10 +5266,12 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
                if (vmptr == vmx->nested.current_vmptr)
                        nested_release_vmcs12(vcpu);
 
-               kvm_vcpu_write_guest(vcpu,
-                                    vmptr + offsetof(struct vmcs12,
-                                                     launch_state),
-                                    &zero, sizeof(zero));
+               r = kvm_vcpu_write_guest(vcpu,
+                                        vmptr + offsetof(struct vmcs12,
+                                                         launch_state),
+                                        &zero, sizeof(zero));
+               if (r)
+                       return kvm_handle_memory_failure(vcpu, r, NULL);
        } else if (vmx->nested.hv_evmcs && vmptr == vmx->nested.hv_evmcs_vmptr) {
                nested_release_evmcs(vcpu);
        }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7f850dfb4086..8f720107b77c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13123,6 +13123,9 @@ int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
                              struct x86_exception *e)
 {
        if (r == X86EMUL_PROPAGATE_FAULT) {
+               if (KVM_BUG_ON(!e, vcpu->kvm))
+                       return -EIO;
+
                kvm_inject_emulated_page_fault(vcpu, e);
                return 1;
        }
