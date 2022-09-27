Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81853C07E9D
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI0CWf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI0CWd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:22:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED4AA3D7
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:22:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y136so8461475pfb.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4u3DF202lZRW0YOPuz3zxb4HZyH1RZ22Lsn3DoaRjKE=;
        b=JeE3U11iOk0uuiMw6Ukzurncyh213htFxID3LVptKPtm/h9sEEUbPC1B0I1b7CEKQS
         GBDx+APAnctavyUBFGJ7JdxI+VOAPGzR7NzYl/4/aLh7ojYEz77xZVqEOnhySNJCVRN9
         tNh0bUJCXbCN0go3kUhaovd3r62M4f10vHeuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4u3DF202lZRW0YOPuz3zxb4HZyH1RZ22Lsn3DoaRjKE=;
        b=lAzipetDIMfMU+YThWxLv2aRgLShjxgN+gI6qDcWuUAoHTdm65CsptOkEKbdCkh6YS
         z1q7YOYvg2jxyz3ybo9iz876kQI2gTN+Jzui4Je27yd7PHSDXk8Kc9Rh4cO3X/fb1Ojc
         K8FK+Csc8hYrCZx/PSAG7gtFY3gZAw8Dt8hzOifD36cJ13qHKuIs2MJIycESTYygpHZ3
         DqDY9dnAtxNOcmCgwEfgD+Jf2e1UR/45AAc/W+RVxg74n/Rlfm2fi1Ax+lTVHeRAd6IK
         DUIbKp5xRINM8lV/lpMm1WmGE5rcH0R2tDWmnqgfO8W6ktE4JgVqREsSR8vB+CYXgqL8
         ty/w==
X-Gm-Message-State: ACrzQf02pJCdNjqjddHJVc4X4uMLDCx6m3XUf2uj1qZHyoKnr5PCXfh3
        6e76ghqEOzmAWO7v1lthoWGX1A==
X-Google-Smtp-Source: AMsMyM4XIvwSnoqajH9j/PTPQ5c5zIvRChiseWAkIXp1b211TTbIE+Xwz/yjVPu3Po52v+Jq5u9gPQ==
X-Received: by 2002:a65:6e4a:0:b0:438:874c:53fd with SMTP id be10-20020a656e4a000000b00438874c53fdmr23105047pgb.355.1664245352087;
        Mon, 26 Sep 2022 19:22:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg8-20020a056a02010800b004348bd693a8sm189625pgb.31.2022.09.26.19.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:22:31 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:22:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: ethernet: rmnet: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261920.3A2EA07D4@keescook>
References: <YzIei3tLO1IWtMjs@work>
 <202209261502.7DB9C7119@keescook>
 <20220926172604.71a20b7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926172604.71a20b7d@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 05:26:04PM -0700, Jakub Kicinski wrote:
> On Mon, 26 Sep 2022 15:02:48 -0700 Kees Cook wrote:
> > On Mon, Sep 26, 2022 at 04:50:03PM -0500, Gustavo A. R. Silva wrote:
> > > Zero-length arrays are deprecated and we are moving towards adopting
> > > C99 flexible-array members, instead. So, replace zero-length arrays
> > > declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> > > helper macro.
> > > 
> > > This helper allows for flexible-array members in unions.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/193
> > > Link: https://github.com/KSPP/linux/issues/221
> > > Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>  
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Not directly related to this patch, but I just had to look at pahole
> output for sk_buff and the struct_group() stuff makes is really painful
> to read :/ Offsets for the members are relative to the "group" and they
> are all repeated.
> 
> Is there any chance you could fix that? Before we sprinkle more pixie
> dust around, perhaps?

Unfortunately I don't see a way around it until we can make changes to
the C language spec, and that's measured in decades. :(

Perhaps we could add some kind of heuristic to pahole to "hide" one of
the internal struct_group() copies, and to hide the empty flexible-array
wrapper structs? (pahole already can't tell the difference between a
0-length array and a flexible-array.) Would that be workable?

-- 
Kees Cook
