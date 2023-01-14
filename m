Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E950EC3DA78
	for <linux-hardening@archiver.kernel.org>; Sat, 14 Jan 2023 01:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjANBDx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 20:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjANBDv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 20:03:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAAB7F9C3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 17:03:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso24287029pjl.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 17:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGRtEnP8tCYPsc7mH3xQrT0Rqmj2jXGGXr5AGL9dWMM=;
        b=GxOk4Aiam9pT06oQtTdFqY0rxHZiNQ/naEpmnmM1Y1hZQoj+8cEB1YKzkuxCTiCW2v
         B8HTSohUMsqDgCAoO2QuesIX2ZrrdxuC/TbX5rFVLswsBxkxoz1zCTQsRLraoi4+wJPh
         IoTShqqVw+Jq/Knx97925a8ZKmWIgQw/OjLZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGRtEnP8tCYPsc7mH3xQrT0Rqmj2jXGGXr5AGL9dWMM=;
        b=L50v67N/kh5YugrhcmRv69KC+sb+Ese5prtCDqGenL5DOKcqoibzlwIR6o7DOgw38e
         cdrKxaNJ1PIJbhCXWKfrDvQ0B4/Oe9j7OBn6cKW3Fs/lb3bpYeP7bi588l7sRbefkrz1
         9KggvUbPH8MFQxbyvhhWkHwfkF2P7CVNISEonipD/rAhrWJPxYG5ddinqsPEAGw9zpAj
         J4oDXmjoolwhtFX6svwUOViUXfELxAEBKQlzKKEkVP2dPInaETMQPQnPfytDMXfdp5I8
         KpXlAhQN4DoHsOIY4UNglrgpb+n5vHKWlz+kaSGVm5iMVrW9wWpTipdjIgvF7j1hIwF0
         mdhw==
X-Gm-Message-State: AFqh2kqNdALOoLbIxz5rqvNluM+/gRJ7+Qdl1+PTF+7e0DZu1rNA+Uhj
        1Hi6OR8hRw45M4kyOPDnHiUILJ3mqb0ZzP2J
X-Google-Smtp-Source: AMrXdXsQ15weg+BBNoYTK6oAg/z4nml3AmlK0p8s/PWTWUa7VhmDn/CgRSMUeuLCGABxFNqJXIdyhA==
X-Received: by 2002:a17:903:550:b0:194:7a42:2d33 with SMTP id jo16-20020a170903055000b001947a422d33mr1440160plb.28.1673658229632;
        Fri, 13 Jan 2023 17:03:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm1659469pli.309.2023.01.13.17.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:03:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 17:03:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Replace 0-length arrays with flexible arrays
Message-ID: <202301131703.D2D667E3@keescook>
References: <20230105223225.never.252-kees@kernel.org>
 <Y7qyVPlNBQaGbInf@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7qyVPlNBQaGbInf@unreal>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 08, 2023 at 02:08:52PM +0200, Leon Romanovsky wrote:
> On Thu, Jan 05, 2023 at 02:32:32PM -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace all remaining
> > 0-length arrays with flexible arrays. Detected with GCC 13, using
> > -fstrict-flex-arrays=3:
> > 
> > In function 'build_rdma_write',
> >     inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:
> > ../drivers/infiniband/hw/cxgb4/qp.c:597:38: warning: array subscript 0 is outside array bounds of 'struct fw_ri_immd[0]' [-Warray-bounds=]
> >   597 |                 wqe->write.u.immd_src[0].r2 = 0;
> >       |                 ~~~~~~~~~~~~~~~~~~~~~^~~
> > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h: In function 'c4iw_post_send':
> > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:567:35: note: while referencing 'immd_src'
> >   567 |                 struct fw_ri_immd immd_src[0];
> >       |                                   ^~~~~~~~
> > 
> > Additionally drop the unused C99_NOT_SUPPORTED ifndef lines.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > 
> > Cc: Potnuri Bharat Teja <bharat@chelsio.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/infiniband/hw/cxgb4/t4fw_ri_api.h | 26 ++++++-----------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> <...>
> 
> >  #define FW_RI_SEND_WR_SENDOP_S		0
> > @@ -618,12 +606,10 @@ struct fw_ri_rdma_write_cmpl_wr {
> >  		struct fw_ri_isgl isgl_src;
> >  	} u_cmpl;
> >  	__be64 r3;
> > -#ifndef C99_NOT_SUPPORTED
> >  	union fw_ri_write {
> > -		struct fw_ri_immd immd_src[0];
> > -		struct fw_ri_isgl isgl_src[0];
> > +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> > +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
> 
> smatch built from commit 40351132df3b ("strlen: add __builtin and
> __fortify functions") produces the following warning:
> drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:575:17: warning: array of flexible structures
> 
> Is it expected? What will prevent from getting this warning from 0-day
> build bots?

Err, I'm not sure I understand? Does smatch define "C99_NOT_SUPPORTED"?

-- 
Kees Cook
