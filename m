Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73130C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 22:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKQWf5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiKQWfe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 17:35:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F6313E04
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:35:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y10so1766417plp.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABjDdrp70mWEwGd143QYXmyVvo4wL46Q8gGoARqo45Y=;
        b=NKxbuJw7Gxm38Y6hH8OzGWlBdSuPg13MEnDt2r/WJztjvIbF8A4Po5QBqvZto8GWOv
         G1zgp9viXVJ/Lsi0GTVdWbsiEe6gaj7IcEdnfDnCdEgdBJAKUasIMTya3SteN3mhuro7
         XhDQATnw7HKWu3rtYOfsD9i9K4CoQw6m9GUys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABjDdrp70mWEwGd143QYXmyVvo4wL46Q8gGoARqo45Y=;
        b=sTJ1I6LshsFdMUOKqOnM+sUyo8AttlIxdD6m4DUExnOXvVQUZUEgZSqwRZpYVHMPpL
         LICnoUu/+RdF+zSO02dULi76vna8I4Ze4oGlmTWqcYASrvtVY4YmwzUUnl44gj0gr74p
         sNHH44aJe5DYWyqaBNX8X0vFM8FMnxwKSicRoldoD46xnQ0+CIyvunpy9rcmP9aQ1jfZ
         UAMb3Yj5TsK7ubEhKbXLmg2prY9+/nolVvfa8ca2wISasBS/RO1uW+OXzMcZ7s0TQteH
         YK8ibnTJpgDs88bLKXVdZjJRNo5ny4OkLq93h5/to0D8X2YaKeWAYm+tLNWtFLiw2OmR
         8I0w==
X-Gm-Message-State: ANoB5pks8QFGroAWSRVUvLHVz8kx4LjApbgYTPXYxHVrXG3kOtTMhDsN
        IdJ1ct34NwmSYQQXU51ndaiOCA==
X-Google-Smtp-Source: AA0mqf4/q+L7EH0uH+MJ7vZW1XsLypum3yDXuWvd25VSL2AcCtRFeGfW/lFpRJ0MmG64uWII/3dQrw==
X-Received: by 2002:a17:902:e2d3:b0:187:2430:d37d with SMTP id l19-20020a170902e2d300b001872430d37dmr4738345plc.28.1668724533394;
        Thu, 17 Nov 2022 14:35:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001888cadf8f6sm1992162plh.49.2022.11.17.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:35:32 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:35:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Ahern <dsahern@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: split up copies in the ack
 construction
Message-ID: <202211171431.6C8675E2@keescook>
References: <20221114090614.2bfeb81c@kernel.org>
 <202211161444.04F3EDEB@keescook>
 <202211161454.D5FA4ED44@keescook>
 <202211161502.142D146@keescook>
 <1e97660d-32ff-c0cc-951b-5beda6283571@embeddedor.com>
 <20221116170526.752c304b@kernel.org>
 <1b373b08-988d-b870-d363-814f8083157c@embeddedor.com>
 <20221116221306.5a4bd5f8@kernel.org>
 <20221117082556.37b8028f@hermes.local>
 <20221117123615.41d9c71a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123615.41d9c71a@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 17, 2022 at 12:36:15PM -0800, Jakub Kicinski wrote:
> On Thu, 17 Nov 2022 08:25:56 -0800 Stephen Hemminger wrote:
> > > I was asking based on your own commit 1e6e9d0f4859 ("uapi: revert
> > > flexible-array conversions"). This is uAPI as well.  
> >  
> > Some of the flex-array conversions fixed build warnings that occur in
> > iproute2 when using Gcc 12 or later.
> 
> Alright, this is getting complicated. I'll post a patch to fix 
> the issue I've added and gently place my head back into the sand.

Thanks! I think the path forward is clear. I should not have suggested
adding a flex-array member to the "header" struct lo these many moons
ago. You and Gustavo are right: we need a separate struct with the header
at the beginning, just as iproute2 is doing itself.

As for testing, I can do that if you want -- the goal was to make sure
the final result doesn't trip FORTIFY when built with -fstrict-flex-arrays
(not yet in a released compiler version, but present in both GCC and Clang
truck builds) and with __builtin_dynamic_object_size() enabled (which
is not yet in -next, as it is waiting on the last of ksize() clean-ups).

-- 
Kees Cook
