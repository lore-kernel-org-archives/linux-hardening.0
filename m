Return-Path: <SRS0=thHn=D6=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D4C388F9
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE4E2168B
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnFi588v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461783AbgJWRl5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461716AbgJWRl5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Oct 2020 13:41:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8CC0613CE
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 10:41:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so1920853pfa.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LXf+ps04hNA8w+H1+miMvzPAvHztSBOVbDdk9iOmq8k=;
        b=MnFi588vQfQJmITiUeRUTl7N1y3NTrdlvWnV+UsAmYTKoHTRgUZ3s0jjA/mkUTrzsw
         4jBvh0zMjF1cYrjvYrjJbeTW8e6RtzRIFzoi6nIfhIvJAN1Cut8E0Xh/fVSBmFcIecJE
         d5IYeehTuGOCPdYKx4qrcIiIQaAthk1Q1km2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXf+ps04hNA8w+H1+miMvzPAvHztSBOVbDdk9iOmq8k=;
        b=qNYEadSZUyseadNilJDrYqSdv1chv68zv/9JRbj5utLgUwdhc3ZN/twTt36fU5sUFz
         JV68tNHiZbMPUSS5ic+HTbpblpeSdDSgtiUSAXIryFAwNhPX82ghUgI1/ou/6Vf9sW3N
         N1waIiymd6Xgw2BXj3G+J+sMPW/dIp65UmTXtsa1q2+pwhweoIDx7gwoisx9NpXcClhe
         bFjF209HxFvGj9br0PR98q+ENva1XpE1v+3FA1TKRYUnqogVR3VmKTQhdwAl8ZjIvlIM
         5+6M0NS4wsyl+xR7Q1wh4dVxoK6P27XbNkHsyLJg0B90rI/b1sIIpSqgVodHUISPCUyI
         BILw==
X-Gm-Message-State: AOAM533eSACAXkx6hjGpPjy25c07Plz6aolWTQXmfBANQOg9sc+GrEw5
        AkPtbr7V3lFDSm8LMRRldmo/Gw==
X-Google-Smtp-Source: ABdhPJzNjzldV09CDkT31lkmu0Subn56dMJ8RuLmx5OlvCyYHBlYpnyIwPrAXMJJyGw5A+/mQH1xqw==
X-Received: by 2002:aa7:83c9:0:b029:158:11ce:4672 with SMTP id j9-20020aa783c90000b029015811ce4672mr3221655pfn.23.1603474915101;
        Fri, 23 Oct 2020 10:41:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 197sm2787448pfa.170.2020.10.23.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:41:54 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:41:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [RFC][PATCH v3 3/3] Rename nla_strlcpy to nla_strscpy.
Message-ID: <202010231041.9FAB4A2714@keescook>
References: <20201020164707.30402-1-laniel_francis@privacyrequired.com>
 <20201020164707.30402-4-laniel_francis@privacyrequired.com>
 <202010211649.ABD53841B@keescook>
 <2286512.66XcFyAlgq@machine>
 <202010221302.5BA047AC9@keescook>
 <20201022160551.33d85912@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <b55d502089c44b3589973fa4e0d90617@AcuMS.aculab.com>
 <20201023082920.6addf3cb@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023082920.6addf3cb@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 23, 2020 at 08:29:20AM -0700, Jakub Kicinski wrote:
> On Fri, 23 Oct 2020 08:07:44 +0000 David Laight wrote:
> > FWIW I suspect  the 'return -ERR on overflow' is going to bite us.
> > Code that does p += strsxxx(p, ..., lim - p, ...) assuming (or not
> > caring) about overflow goes badly wrong.
> 
> I don't really care either way, but in netlink there's usually an
> attribute per value, nothing combines strings like p += strx..().
> Looking at the conversion in patch 2 the callers just want to 
> check for overflow.

Right -- this is a very narrow use-case (NLA). I think this series is
fine as-is.

-- 
Kees Cook
