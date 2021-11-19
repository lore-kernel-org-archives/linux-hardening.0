Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB26C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9883C60F70
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhKSTH6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhKSTH6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 14:07:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B50C06173E
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 11:04:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id o14so8830862plg.5
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gKCFl0vWdtOCb/3aV8pldCMA2ZxKL7ucYb4JkITvAM=;
        b=e3GDIUh8jfYIpwnABL6s1/QtgS6Jm3imtY2w3vJ7zy3S2h6jeVjvTAxpTw5boylJNl
         TR1NSPBTGbkz3mOOFWNDbfQsOe5Wx4U6kFi5XRuf6NPVuDeolZ158Q8+ThGe1aSXO2oj
         /r+qfiG4u1Of4FrnjhZTMx9jW2l0CVunMYz2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gKCFl0vWdtOCb/3aV8pldCMA2ZxKL7ucYb4JkITvAM=;
        b=P5sdPKpaa/PTGetshCTUsL8WRJzl6ttG8WWXPTtY5kTkVMwNMQmVqW0uLZNvVYSGPW
         PwhmCa0XdiJaQFkJzxLe66/XK/dKfuko5GOJQBnt5IDVzMAU4tL917/ngD+iDi+kscKj
         HFJBg0+uQBEz8Uq/fNIBdax4icPjT32o2Ve8MbrbEAqYTNVjXZAMZ/aUAovTD1pkMG52
         85/zYRphQcrGfgNbfz5PaHTpV01j9xck+0Y20Yz6dAtbpNB5o7bpkW4TEcxLtrUaJhts
         MN21vfHfNhcW1Z6PTwdOvDsJyIExmzNp2LoS9i+inLXTrw2+dI35+1I+4Gnbjvkup3Pm
         MQsQ==
X-Gm-Message-State: AOAM53201a79pJhfekPGCxAOaK46mqsHVotRsd2H50UghR5J/vrgVzCd
        4aVXuOgNqtcq2+v9pGO+Bhf7Vg==
X-Google-Smtp-Source: ABdhPJwDCxXYbbuuUuh3O/yYZjAZzQVmT1fRScATPyisj+4WtYIlCTcjvf6vxYHMu5Uorx79MCqaOw==
X-Received: by 2002:a17:90b:1e06:: with SMTP id pg6mr2468744pjb.137.1637348695802;
        Fri, 19 Nov 2021 11:04:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c16sm323497pgl.82.2021.11.19.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:04:55 -0800 (PST)
Date:   Fri, 19 Nov 2021 11:04:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] skbuff: Switch structure bounds to struct_group()
Message-ID: <202111191103.074D77AF2@keescook>
References: <20211118183615.1281978-1-keescook@chromium.org>
 <20211118231355.7a39d22f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202111191015.509A0BD@keescook>
 <20211119104144.7cb1eac6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211119105253.1db523b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119105253.1db523b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 19, 2021 at 10:53:05AM -0800, Jakub Kicinski wrote:
> On Fri, 19 Nov 2021 10:41:44 -0800 Jakub Kicinski wrote:
> > On Fri, 19 Nov 2021 10:26:19 -0800 Kees Cook wrote:
> > > On Thu, Nov 18, 2021 at 11:13:55PM -0800, Jakub Kicinski wrote:  
> > > > This adds ~27k of these warnings to W=1 gcc builds:
> > > > 
> > > > include/linux/skbuff.h:851:1: warning: directive in macro's argument list    
> > > 
> > > Hrm, I can't reproduce this, using several GCC versions and net-next. What
> > > compiler version[1] and base commit[2] were used here?  
> > 
> > gcc version 11.2.1 20210728 (Red Hat 11.2.1-1) (GCC) 
> > 
> > HEAD was at: 3b1abcf12894 Merge tag 'regmap-no-bus-update-bits' of git://...
> 
> Ah, damn, I just realized, it's probably sparse! The build sets C=1.

*head desk* I looked right at the "C=1" (noting it was missing for the
clang build) and didn't put it together. Let me see what I need to do to
make sparse happy...

-- 
Kees Cook
