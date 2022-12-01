Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3A0C43217
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 16:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiLAQZy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiLAQZx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 11:25:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83068A47E1
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 08:25:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4472007pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hs75c2RhI6TXhTdmq3LNKwlHtjDutkhRkFYCtYKKrI=;
        b=Qpi4DGe/ljQZkxVzxzmv+mwMi5BwzACkFN6l31jQTjSBelVBkQ+PVUo3Xz03lrAst2
         zwJpCgGZQhZClhELY3Vy19Ae+NDtrzl+1S/d+CWrtVEgEwZ1vc5pLer3Pn5yNB2w7pA/
         eLesWhq2wJwal07BE5Ij1HetfU6apauIQlfJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hs75c2RhI6TXhTdmq3LNKwlHtjDutkhRkFYCtYKKrI=;
        b=Di248Snb/l0bz8ef+QzTqK2XjH/kZn1wTl/24spc64fqrq+D1ZiEChQvELkiL2dfPp
         lupwcE5xfwmNDC1kKsl7K7lc48spajO1aK7rW/1bNzNoOYDl48AiVQERQpqgzOwHAaSW
         MwaqsYyJ7GuuIWVk7ryX5N0giR2tzaP53HSSD+q9jpJkLx8qI5/+CA2DJv0ibEoznm7E
         qNVRZu7BTAqF9dt+ZglNahS+fni5J8g12KW2jUz64bqmojMtjRhpJ1L0IHzJc/AjxxKM
         NrFfgnBr9wwVz4SxAK87F/fhCONfs/MQnY+exBb3tVwULhvpv3u1DukNsudsLRYEetSE
         g2Wg==
X-Gm-Message-State: ANoB5pn4jk2EFCws9AvW09uMBG+oEVDVHKy8NIEXdm2t+0MBbWSY26bm
        NoJB062rJxIzzcaGoHa6T4DyXQ==
X-Google-Smtp-Source: AA0mqf5Yoi5gUr2+jfODvzG0lhgp9wysmv7TqcWatFoaSj460wZp7jPXjwuGpbg91q0r7SYRxRSPbg==
X-Received: by 2002:a17:90a:4594:b0:218:f745:76fe with SMTP id v20-20020a17090a459400b00218f74576femr39246937pjg.245.1669911952042;
        Thu, 01 Dec 2022 08:25:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00176b63535adsm3861906plh.260.2022.12.01.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:25:51 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 1 Dec 2022 08:25:50 -0800
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: emulator_leave_smm(): Error handling issues
Message-ID: <202212010825.8589611F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221201 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 9 12:31:18 2022 -0500
    1d0da94cdafe ("KVM: x86: do not go through ctxt->ops when emulating rsm")

Coverity reported the following:

*** CID 1527763:  Error handling issues  (CHECKED_RETURN)
arch/x86/kvm/smm.c:631 in emulator_leave_smm()
625     		cr4 = kvm_read_cr4(vcpu);
626     		if (cr4 & X86_CR4_PAE)
627     			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE);
628
629     		/* And finally go back to 32-bit mode.  */
630     		efer = 0;
vvv     CID 1527763:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "kvm_set_msr" without checking return value (as is done elsewhere 5 out of 6 times).
631     		kvm_set_msr(vcpu, MSR_EFER, efer);
632     	}
633     #endif
634
635     	/*
636     	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527763 ("Error handling issues")
Fixes: 1d0da94cdafe ("KVM: x86: do not go through ctxt->ops when emulating rsm")

Thanks for your attention!

-- 
Coverity-bot
