Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30235ECAAA1
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Sep 2022 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIPVba (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPVba (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 17:31:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2BA6AC9
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 14:31:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so21506717pgs.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gAOpf4VaiyzuyzEgBlSDI/rb/mxIT2fGVc3O4sRyz8Q=;
        b=ESaZCkLet+Qy6/RvuyqCTnQHokSf4VLHnPureVwo7ogYklmGP1Sztila7n66Rd4Rpx
         p8mM7GZYSPEVPVnneskMYs3iQhwxLf9yo9KPvmptyMHSHdIHgLLpttwzX2mDEzYLLpST
         vioqg93hpJQCo9Uc4aIg3ueQPLLjc07hHzXxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gAOpf4VaiyzuyzEgBlSDI/rb/mxIT2fGVc3O4sRyz8Q=;
        b=sh/eiCpgmyAxhOi071KeMUemd2wHdWZuZSCTXWquHtia+P1DF4GvJZM3cmWHCmcrRl
         XUBv8QX+pKMI2xgexhpjDrLVJEpHXctA1LlnmtSnfrJwIRfVjnYPvOQH+R3edKbq8F8q
         IJkjengDIUStJJ1zTQlfNWtSeQEXp+i1UmT1OFPBvB22djXTz9qeC5yBFXNMfyzAAK3a
         NqtpW8kI5mEbrcn/4JDmCQ/QdYW9ItXI0bpkUBrV+UiuB3neDe2y3bI0dmyvka14aWOh
         cye+HpeCjl8HXsXAKsUXRHi59PKJBs+tOdVLv9tJhXN59DgrCf9wVb4xnfcFqENB8ZQ0
         5+gQ==
X-Gm-Message-State: ACrzQf2gjuHgGFowx+uYNHAdsjZ+355ETV3Lwe9/pETHNbVpNutYCkTY
        U+0jY/gBYhGpVIhwnaAwSTqbFA==
X-Google-Smtp-Source: AMsMyM6NXdExmvfrm3oknYIgGPotEd25We5Echz9dev/PyZDMj2iXCY/P49FQgqOgPGc3Lo0M3EjBQ==
X-Received: by 2002:a05:6a02:309:b0:434:d151:639e with SMTP id bn9-20020a056a02030900b00434d151639emr6100944pgb.124.1663363885331;
        Fri, 16 Sep 2022 14:31:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm15307582ple.62.2022.09.16.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:31:23 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:31:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: harden i2c_mux_alloc() against integer
 overflows
Message-ID: <202209160812.2B4AB7FC@keescook>
References: <YyMM8iVSHJ4ammsg@kili>
 <YyMt2cWtHC2SeG62@work>
 <YyMyKQnWgu0SL6jj@kadam>
 <202209160101.2A240E9@keescook>
 <YyQyfaI0WCsQ8F48@kadam>
 <202209160630.CF7AE9708D@keescook>
 <YySOewo2YUY+fk1l@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YySOewo2YUY+fk1l@kadam>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 16, 2022 at 05:55:55PM +0300, Dan Carpenter wrote:
> On Fri, Sep 16, 2022 at 06:31:45AM -0700, Kees Cook wrote:
> > On Fri, Sep 16, 2022 at 11:23:25AM +0300, Dan Carpenter wrote:
> > > [...]
> > > net/ipv6/mcast.c:450 ip6_mc_source() saving 'size_add' to type 'int'
> > 
> > Interesting! Are you able to report the consumer? e.g. I think a bunch
> > of these would be fixed by:
> > 
> 
> Are you asking if I can add "passed to sock_kmalloc()" to the report?

Yeah.

> It's possible but it's kind of a headache the way this code is written.

Okay, no worries -- I was curious if it would be "easy". I can happily
just spit out the source line.

-- 
Kees Cook
