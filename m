Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D18BC46467
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Jan 2023 23:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjASXVP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjASXVD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Jan 2023 18:21:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170E38656
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 15:20:26 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so7432557pjm.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 15:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2hfaQxi9cFOV7vzi506y1iP58o1zwbZebSpOexl7T0=;
        b=SaeJmlkBkZZgNofiVArOtL70JfeQV6oYKFgXSlR0ACjI4+TKUfUc3uSFgUSt1JOwLT
         mmEdzpzahxFByGob55f2NOBSwan+7yzbv+kDlVCCMZae91rj+QZCKfTcWxBS8FWmaUrb
         khgdNh646eYRLU6GgE6l4IZcK8m2FH1zbl7Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2hfaQxi9cFOV7vzi506y1iP58o1zwbZebSpOexl7T0=;
        b=hA2TfBhMZ6199FUyqvifl66cngVjfiMBmitT06rq/Y4vJWLAmPBnPdKWmSf4VzJyOK
         41/A5o+wLjItOl57CM1KH8xWx2wyojKfLbxF7qNK+lbkWEIdThRZImnVMHciwXCv6jiK
         FFqIyjFNs4wpNCD9DWMIVck4F5g+sv5y3yyYCKH1+Aidjl2T7BT7czFW9o2ik0jK/BPF
         Bt8akEYWkibC/e/2QjQPiiC71YTK2SxiYE7qmA9ONcOOwu2NUMMLIsIA8mLvhFTQIymP
         vHtscxthtaeWibFTPBNSW9+3dQlJFxyRdFOL6sD5/6NNVO5MsdKSAxOsMIszYuI6Kxbt
         1Kqw==
X-Gm-Message-State: AFqh2koKo2doJVO8xy0J5ya7l+2LdqZQa89MiLwJqRuSx4jA0g7+aypU
        rHhgKBckXsPys5w0vhbn1MP3GQ==
X-Google-Smtp-Source: AMrXdXvM9LlT41/krWx7wqjPwEmZuSGoStb7t0B53XpaKhzzk9O2QC3U2ioFx0FKZa+FRtgVo4KOJg==
X-Received: by 2002:a17:902:da8d:b0:194:7a42:2d33 with SMTP id j13-20020a170902da8d00b001947a422d33mr17343030plx.28.1674170426410;
        Thu, 19 Jan 2023 15:20:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm25604620plh.124.2023.01.19.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:20:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 15:20:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Replace 0-length arrays with flexible arrays
Message-ID: <202301191518.3DB46101E9@keescook>
References: <20230118195905.gonna.693-kees@kernel.org>
 <167409066308.2374724.17477861672467900544.b4-ty@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167409066308.2374724.17477861672467900544.b4-ty@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 19, 2023 at 08:48:52PM +0000, Sean Christopherson wrote:
> On Wed, 18 Jan 2023 11:59:09 -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct kvm_nested_state's
> > "data" union 0-length arrays with flexible arrays. (How are the
> > sizes of these arrays verified?) Detected with GCC 13, using
> > -fstrict-flex-arrays=3:
> > 
> > arch/x86/kvm/svm/nested.c: In function 'svm_get_nested_state':
> > arch/x86/kvm/svm/nested.c:1536:17: error: array subscript 0 is outside array bounds of 'struct kvm_svm_nested_state_data[0]' [-Werror=array-bounds=]
> >  1536 |                 &user_kvm_nested_state->data.svm[0];
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from include/uapi/linux/kvm.h:15,
> >                  from include/linux/kvm_host.h:40,
> >                  from arch/x86/kvm/svm/nested.c:18:
> > arch/x86/include/uapi/asm/kvm.h:511:50: note: while referencing 'svm'
> >   511 |                 struct kvm_svm_nested_state_data svm[0];
> >       |                                                  ^~~
> > 
> > [...]
> 
> Applied to kvm-x86 misc, thanks!  Based on the linux-next complaint, I assume
> you (temporarily?) applied this to your tree as well.  Holler if I've confused
> you :-)

Thanks! I've removed it from my tree.

-- 
Kees Cook
