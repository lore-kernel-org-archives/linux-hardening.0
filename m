Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A5C6FA91
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Sep 2022 05:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIVFaa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Sep 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiIVFa3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Sep 2022 01:30:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035CAB4F7
        for <linux-hardening@vger.kernel.org>; Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t190so8075787pgd.9
        for <linux-hardening@vger.kernel.org>; Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=29krL0qvuFg0KCphJZfO0u7z2tvgm5X6ahpdbCTG5JM=;
        b=n2CDFCVq+NijhKq28N0Aj315cnhJnRhM4bxGYBq+d9sJPi7E9uujmDTxRYvi5M2We2
         lIbhnGBVBDwMTmPm4TFmJjWPUY3nRltAQWpXrXCg1v4oGqm+nVHzlU5jdmJHrxz7I1Hl
         tYp5BSHxCOH42fzVB/A8OR4XlMt8IE7wguFeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=29krL0qvuFg0KCphJZfO0u7z2tvgm5X6ahpdbCTG5JM=;
        b=Nia+6Ypgv2OT2cyvdGwc0Dw/x2eSY7+372MoDnRLGMn4xrKRO0efLRin/hNoO70f1J
         R/IJvtssrx3RbhtTLdjdi5Sc1rLFWN0Kz6wOaChr439wqTmVGrT5MOwhXKpZR0S5fREM
         1gCk18bsKYHWr8I8KInzNCkmoU0I9v+xY74gWOYh1tXTROthVS/tSYJ2Ddyvv2s295m/
         GM1JIiG4+4Ez1bXtKauLt1GiRQwCP4G5k4Ax2R5sVBS2/eH7/oFLFdQdehOxTkeH6Wj0
         O9jkKhNTAzz4Dun1K5QpKZSHICgEexwZW3vuDlstFTMDnmIehJrKBMIPEn1jEFGJ2Y2f
         zhlw==
X-Gm-Message-State: ACrzQf3o/dpKevu4Wjruh3eA21BebfOB9ajruXE8kicY1iYzpio8xIQ8
        34PjUp2WUlrYSmd+KkBExhgXxI8bYHOlRA==
X-Google-Smtp-Source: AMsMyM6v2iHcKBv3dbH5kl/i70Ai8m8LshgThkTu5jlpNWXMW8oMZccFmHnMq8TJAFDqKc01zRPIrg==
X-Received: by 2002:a05:6a00:1743:b0:548:8629:ceab with SMTP id j3-20020a056a00174300b005488629ceabmr1764304pfc.23.1663824628324;
        Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l187-20020a633ec4000000b0043057fe66c0sm2834975pga.48.2022.09.21.22.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 22:30:27 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:30:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [RFC] docs: Define c_paren_attributes for attributes with
 arguments
Message-ID: <202209212229.1C07A60456@keescook>
References: <20220902223507.2537469-1-keescook@chromium.org>
 <d1af650a-1e0b-a650-4cda-57fb1d54f1af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1af650a-1e0b-a650-4cda-57fb1d54f1af@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 09, 2022 at 02:08:30PM +0900, Akira Yokosawa wrote:
> Hi Kees,
> 
> I expected some responses from Jon, but looks like he's been busy
> elsewhere. Let me chime in.
> 
> On Fri,  2 Sep 2022 15:35:07 -0700, Kees Cook wrote:
> > While Sphinx's "c_id_attributes" is needed for basic attributes, any
> > attributes with arguments need to be defined in "c_paren_attributes"
> > to avoid errors like:
> > 
> > include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'
> 
> These warnings are from ./scripts/kernel-doc.
> So I think you need to teach the script about "__diagnose_as" so that
> the kernel-doc comment of strncpy() can be converted to reST doc
> which Sphinx can understand.

Ah! Thank you, yeah, I couldn't figure out where it was coming from.

> Past changes in ./scripts/kernel-doc might give you some hints.

Yeah, including changes from me for similar things. How quickly I
forgot! :)

Thanks,

-Kees

-- 
Kees Cook
