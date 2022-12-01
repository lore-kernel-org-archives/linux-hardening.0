Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C17C43217
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 16:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLAQZ1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLAQZ0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 11:25:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CAD9C637
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 08:25:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so2115440pll.6
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJn63ijABqaX2jSzYldLgtMX1wvMD+wjMrL7ejU3DM4=;
        b=jmk3F/NJq35iV/doRjj3egs6c6k+X6EGEse4MdJIqMjLPyBNbo1AKFivgdvn9isEsu
         b2/fdEveK6CbqH6tF4SjKHNbD8g317v8VOBJ10LrTh8t8eG/36wa+kzxD+shOG6q69+h
         61DU5kG4G81dhs7bHAQo1DboGFu1f9j9UT8cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJn63ijABqaX2jSzYldLgtMX1wvMD+wjMrL7ejU3DM4=;
        b=FEaqAu/5AtaJ8rnPLaypPv7Ag5151WuN2Nxs+xTeGd5F7+jtCOwxQhlmP9LLX4mUVE
         hRCS3/k1sBoiRm5/rT9eh3x5xoR7UYCkfhjt/PTWlPqSIHo013IXcxMLSUQ2UKoz36EN
         XRAv5og8J6jvqqHWjVCcl10lhPakY/kaEESgBtQ6Hzau9XahChu0PHE04QPgEFOnySwW
         ywtTJqPtLKXOoa7a+eAYvILEJ7+uq6G3CF8u4ywa1GUyed5nirxb6LVWCE7f7by5ZQO7
         os+Q2OAg8DNKMldVILZZRDA+RG6nUuXlVu4p3kBpYIaqCw6kHmyf3D+TmLoNO0Ocs+mj
         uNIg==
X-Gm-Message-State: ANoB5pm1MxWZZSHmKbrLryOzwlb10wTn/PJ/Z9Sc7Uo71GUR9/BxafxJ
        muC5fMGxZ9DvoIdRvobetb7f6A==
X-Google-Smtp-Source: AA0mqf6q8cTCMSgXJrxqU+XiXGZ8uzcS2jxNQPGNqjyAVZeXMbJ7HfoBSvKaPcW1v/1bLGUCkYWc0g==
X-Received: by 2002:a17:902:db10:b0:189:5858:43c0 with SMTP id m16-20020a170902db1000b00189585843c0mr38387356plx.71.1669911925434;
        Thu, 01 Dec 2022 08:25:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i22-20020a635416000000b00460ea630c1bsm2749336pgb.46.2022.12.01.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:25:24 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 1 Dec 2022 08:25:24 -0800
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: handle_vmclear(): Error handling issues
Message-ID: <202212010825.C23022D@keescook>
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

  Fri Dec 14 17:59:46 2018 +0100
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")

Coverity reported the following:

*** CID 1527765:  Error handling issues  (CHECKED_RETURN)
arch/x86/kvm/vmx/nested.c:5269 in handle_vmclear()
5263     	 */
5264     	if (likely(!guest_cpuid_has_evmcs(vcpu) ||
5265     		   !evmptr_is_valid(nested_get_evmptr(vcpu)))) {
5266     		if (vmptr == vmx->nested.current_vmptr)
5267     			nested_release_vmcs12(vcpu);
5268
vvv     CID 1527765:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "kvm_vcpu_write_guest" without checking return value (as is done elsewhere 7 out of 8 times).
5269     		kvm_vcpu_write_guest(vcpu,
5270     				     vmptr + offsetof(struct vmcs12,
5271     						      launch_state),
5272     				     &zero, sizeof(zero));
5273     	} else if (vmx->nested.hv_evmcs && vmptr == vmx->nested.hv_evmcs_vmptr) {
5274     		nested_release_evmcs(vcpu);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527765 ("Error handling issues")
Fixes: 55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")

Thanks for your attention!

-- 
Coverity-bot
