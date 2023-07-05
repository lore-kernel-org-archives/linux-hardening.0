Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE0EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed,  5 Jul 2023 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGEWVJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGEWVI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Jul 2023 18:21:08 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB41725
        for <linux-hardening@vger.kernel.org>; Wed,  5 Jul 2023 15:21:07 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b87d505e28so31346a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 05 Jul 2023 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688595666; x=1691187666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4t/HHKLfozsv67Y5fojGuZxU83pEeYbU9lCaGZWyjqY=;
        b=Te4W7od8zDqp8hEuanxEO19H9IYsRKKKTlsuKFVa61Q1VTWbAxI1pKlXkm/ylV9aE1
         XuNqtjFrnUW+vRwl5Tf6C9JSiHzM/fNbYk3uft864rJstXhk1ciMxX/bQupw9xuWZGtI
         z2sjU+7IyzKGpCmixvqckwbZVSCiSp8qgmG0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688595666; x=1691187666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t/HHKLfozsv67Y5fojGuZxU83pEeYbU9lCaGZWyjqY=;
        b=bOvi23sNRixr+n6NZ6VwTtxK3YErWLIlVlUYkTplZOZnim4YlgCFYTMe92ATpIk7GV
         4Lag3aRVwSHDYZSH+GqyENGuDz4LK/qVp105oNSMoXC1mbYSrVcFnSWK/ne/JfZcZ9oX
         nddSQrujm/kHWsr1dph0ywk8+uDtO14bv3WIxTSEriDEMt1xfMzZs4+/15jInyw+zZ0O
         rD4n0fFPK9V5LeXPPkxuZA9nqkFaGD6SZNcvVgq/8rc6w5Rhm1BNKBtvoPzU2qAsEqnX
         c9uOT75LmHNzTcJERe3jcsGMgIM2rXt8ARCvnMM+2EneZhJ0RbLQLJRLKK+F0v+J4QDr
         iekw==
X-Gm-Message-State: ABy/qLZxWIICchPys8dXvBvmvwqupIu+w3WJxjRIsKw9zNK2+0jW9W28
        uQRcCuR0a1Eol1wvBYtAf0Gsgd/C3XFGpWYPtQA=
X-Google-Smtp-Source: APBJJlFsEWM7S7tH8ZFTVSIlif6SLJE4BnrZDceBK0WHyrayzJpK+1U70cJKEvh2+HI4RfMccPZIew==
X-Received: by 2002:a9d:66c8:0:b0:6b8:67bf:fdf2 with SMTP id t8-20020a9d66c8000000b006b867bffdf2mr296865otm.11.1688595666568;
        Wed, 05 Jul 2023 15:21:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020a633508000000b005579c73d209sm56667pga.1.2023.07.05.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 15:21:05 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:21:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        John Stultz <jstultz@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated
 ramoops memory regions
Message-ID: <202307051516.AE6080BF@keescook>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook>
 <ZJSES98P+zzrhBI5@google.com>
 <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
 <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
 <696269e1-8b97-66ed-c9b0-ce1b8d637d24@quicinc.com>
 <bd531778-a587-e4d0-e360-432208f064ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd531778-a587-e4d0-e360-432208f064ea@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 04, 2023 at 08:07:09AM +0200, Krzysztof Kozlowski wrote:
> On 26/06/2023 19:34, Mukesh Ojha wrote:
> > I have tried multiple attempt already to get this patch in
> > 
> > https://lore.kernel.org/lkml/1675330081-15029-2-git-send-email-quic_mojha@quicinc.com/
> > 
> > later tried the approach of patch #9 along with minidump series..
> 
> For all dynamic reserved-memory-ramoops thingy, I think Rob made clear
> statement:
> 
> "I don't think dynamic ramoops location should be defined in DT."
> 
> https://lore.kernel.org/lkml/CAL_JsqKV6EEpsDNdj1BTN6nODb=hsHkzsdkCzzWwnTrygn0K-A@mail.gmail.com/
> 
> Please do not send three versions of the same patch hoping one will
> sneak in.

If I understand correctly, the driving issue here is that minidump wants
to be able to find the crash report "externally". Perhaps pstore could
provide either a known symbol that contains the address that was used,
or could add something to the kernel crash image (like is done for
KASLR), so that an external consumer of the kernel crash image could
find it?

And then the RAM backend for pstore could gain an option for "just
allocate regular RAM" for holding the dump? In other words, the address
is chosen by pstore, but an external consumer could still locate it.

-Kees

-- 
Kees Cook
