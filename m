Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D614C43214
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Aug 2021 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AA1610CA
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Aug 2021 15:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhHTP5L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbhHTP5K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Aug 2021 11:57:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B0C0613CF
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 08:56:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u15so6154767plg.13
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3a7vVBUf0KW7MXt4FnTeXqGlzkeA3TVHAyOaxNZlwQ=;
        b=mWy+dsfzuC4WR7e/bELnLc1DBewBd+6uqLCiUlPpSL/hR3JFjiFZGkc64dOnkcT9C9
         qDMRqhN9IlO5CQXHcgzIx3Y2JRqX6MsEMYyUkp08whfolpRdd2uxh73eqsjx32WZPMfY
         SPWC7Ec8QNUjnKmK0pksWV2GR2YpxIveB+TMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3a7vVBUf0KW7MXt4FnTeXqGlzkeA3TVHAyOaxNZlwQ=;
        b=INAWsaHgCyrVPOcxoyTGDcIu/mexmlIfWBFfMxS0VNAKHsVBA52yRh3BOvGxW2Rawc
         x7JFR4wWh3ABda43KmS2vy2DgesCs+KdnGxyNxXihLNekRFERjexo1+76ndaZBJNY414
         VDf9pGDM6pxt1gaUbRk+VI+WV5XJJNDRTWs8/U7P3g4ip4s60qeCK4fQe8Fds4ehj3V3
         ohvRpDX2VpCBDTr3AMekWwfSjGdj9W409Hx7oxioDQXDET7lmWEji3JsMjvMItxOW7Ce
         VsBpyjhQkYYTbfDv+DK3nfd1cSU+81xyTKTDRCzlhI5kKyyRDggt4zLXCLk+cBR9bVU1
         mg2Q==
X-Gm-Message-State: AOAM53068dWxFueJyOav8x6+OEZgUjtPtyc5eJr19gnGrRlic22zGxIG
        hotUXH+585twrf0RdoMpTnImCA==
X-Google-Smtp-Source: ABdhPJyhg05jtv2sdt7XrLbWPk8JBbrR41kaovvHCcwZtOZ4P7Cf6Qg2VrCTEpx9+rp1igwyJ9xLVA==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id h4-20020a170902f704b029011acdee0490mr17049722plo.37.1629474990741;
        Fri, 20 Aug 2021 08:56:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm7304926pfh.103.2021.08.20.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:56:30 -0700 (PDT)
Date:   Fri, 20 Aug 2021 08:56:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 56/63] RDMA/mlx5: Use struct_group() to zero struct
 mlx5_ib_mr
Message-ID: <202108200856.E0E8711CB@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-57-keescook@chromium.org>
 <20210819122716.GP543798@ziepe.ca>
 <202108190916.7CC455DA@keescook>
 <20210819164757.GS543798@ziepe.ca>
 <202108191106.1956C05A@keescook>
 <20210820123400.GW543798@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820123400.GW543798@ziepe.ca>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 20, 2021 at 09:34:00AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 19, 2021 at 11:14:37AM -0700, Kees Cook wrote:
> 
> > Which do you mean? When doing the conversions I tended to opt for
> > struct_group() since it provides more robust "intentionality". Strictly
> > speaking, the new memset helpers are doing field-spanning writes, but the
> > "clear to the end" pattern was so common it made sense to add the helpers,
> > as they're a bit less disruptive. It's totally up to you! :)
> 
> Well, of the patches you cc'd to me only this one used the struct
> group..

Understood. I've adjusted this for v3. Thanks!

-- 
Kees Cook
