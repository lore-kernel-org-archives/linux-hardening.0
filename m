Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C7C46467
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Jan 2023 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjASUvg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASUvC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Jan 2023 15:51:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CE37B7E
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 12:51:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u7-20020a17090a410700b002291f69fbb5so1426768pjf.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsNKOZkXicuUiWtCUwXDxRNTwl8e+lP+GlMNu/Zjg6M=;
        b=JF8NAJSFnN55aB49k7/Uv/peGr/u7pSGRAMLm4JpTT83MaFh90yvAduttmZCb6BwHK
         t75bfnPw7ZPhC6ASYCKjOWRQ57+FbZtWIF2D801w/Tw1Wvv4fMdA7cCcz4kNwiu4mTMs
         2HNcfs4P7uP5DgdmSE2yE9v3IE45bVlHqKcEdIFADNd9GYzp3JjRTDUnuij/uHgfTd41
         Gzc7X8fsplVxQmdZxq+nCRZedaGXAaK/SQCAlU50jMepBJtGuNlRfaI78x92soGJLQsg
         Bg5U9I4f/vbZJ7CkoMUc9+Oef9zVN3/w3O/FycYVMRSWmMHAKFz7io7Zxubv9cO0ATvb
         7U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsNKOZkXicuUiWtCUwXDxRNTwl8e+lP+GlMNu/Zjg6M=;
        b=2nEwFy3AqS9ln5y+U9fVXV4qlWRVnYvK+ltgZtmRRUPlM0CZqAOAUmLqNLiwfxPn9L
         WlmW4bSF9uyKFl5D5hdfEb4WOU8skmvg478lz6cGb1XpHay2RQo3t4H8v+G4sUrQjWH2
         HDo8OrPb4YBlXSJ+w49fksCBf3Qa9eIA/pUMADQv00rA0Brt2OJ+5NKxwkrl3Q2oxUEE
         6CTLJiL5zQph08vYaI+GI7BrVR9bNLDxQ9Cj3lADNHl/gopW3ZhZJX8NG8MDdffT/g+P
         W2lEtrsrm9QJOcy5kWEVsApql7UHGJ29XOWyMoU3xJYApPbgdwBgnU90Ift+3cBt3nqb
         EHKQ==
X-Gm-Message-State: AFqh2krkpw4+x+jLEoB1u3lZ+iMrq7rLP7ejZk36c4Z76OeH/FtKRcyf
        xDChWWm+4C/vgp8kYmIudnSv64HBuIs=
X-Google-Smtp-Source: AMrXdXt00r6KEjTmHH+Xwy4v/JD/mxOBK32bvnMYN1yS2pn4RGD9SGTHp9Qit1Etf++FfDA6vUdtwX9BXvk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab94:b0:194:6417:cd27 with SMTP id
 f20-20020a170902ab9400b001946417cd27mr1100464plr.34.1674161461022; Thu, 19
 Jan 2023 12:51:01 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:48:52 +0000
In-Reply-To: <20230118195905.gonna.693-kees@kernel.org>
Mime-Version: 1.0
References: <20230118195905.gonna.693-kees@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409066308.2374724.17477861672467900544.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Replace 0-length arrays with flexible arrays
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 18 Jan 2023 11:59:09 -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct kvm_nested_state's
> "data" union 0-length arrays with flexible arrays. (How are the
> sizes of these arrays verified?) Detected with GCC 13, using
> -fstrict-flex-arrays=3:
> 
> arch/x86/kvm/svm/nested.c: In function 'svm_get_nested_state':
> arch/x86/kvm/svm/nested.c:1536:17: error: array subscript 0 is outside array bounds of 'struct kvm_svm_nested_state_data[0]' [-Werror=array-bounds=]
>  1536 |                 &user_kvm_nested_state->data.svm[0];
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/kvm.h:15,
>                  from include/linux/kvm_host.h:40,
>                  from arch/x86/kvm/svm/nested.c:18:
> arch/x86/include/uapi/asm/kvm.h:511:50: note: while referencing 'svm'
>   511 |                 struct kvm_svm_nested_state_data svm[0];
>       |                                                  ^~~
> 
> [...]

Applied to kvm-x86 misc, thanks!  Based on the linux-next complaint, I assume
you (temporarily?) applied this to your tree as well.  Holler if I've confused
you :-)

[1/1] KVM: x86: Replace 0-length arrays with flexible arrays
      https://github.com/kvm-x86/linux/commit/2a8c2de0544e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
