Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B756C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjAESFv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 13:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjAESFK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 13:05:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6F60842
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 10:04:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 17so40178086pll.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0P8fWNB9uGiIbEBnadT8SZ/GnrLR3KrMQPnTu697WXU=;
        b=eHv012K+wdORG+6g8TCLO+HUDJknB406VNyrXM/nfxeii7+a+W90WE6MNBjWm9opwo
         o39UmpFAl4/rtjmDyklQwDOEssFsvXqIJlyiC2LmEuFeSBgQ+AfkMng0eSvfskSVOUtr
         M3AyqpJmHpbEX9I97056RTdRgpsxknXpyWyoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P8fWNB9uGiIbEBnadT8SZ/GnrLR3KrMQPnTu697WXU=;
        b=c7KOESdmCrVY843QtTNXSwq42RDJkXS6/OSZIoFNVtv3l838zwDGYmMEfUAkh8vhQQ
         G05B/rglTn9eUZP84x672Gt7CDEZxQ5zW0QvkXUZCtFpmFYGaoD32GfjiDifItZYofpK
         rHpIu+f7uWsqbV/TjPiAvi+Q4wsGh86FBJubzXC0/F3Fz2PCtdCop2Qp0nMuHZLPJYSg
         KcrVx3FRFkKEQvF0tN7mvD4uKRv0+GS8gZ9ADlKG/Kr2KABKZe69mxoyi//mgOw3h++f
         jsDDrt3qHlGtn92aKY6do+11d8cLUEOZBz9C6ZhznvrBwMfg4J7YES3m7mn1mUpr/Gj/
         TVlA==
X-Gm-Message-State: AFqh2kpSB4+LaH0fO0ozZ+bAgh4OwX8yhkoWms2dUoKQK4QA29P+sfR7
        TKrLWQ/Q1DLdfGpE40ZNi78XMg==
X-Google-Smtp-Source: AMrXdXufN+/oh/UGgwRcTi2k/DtAOkHqn7zTKMSm+wdkn8ikP+9NewxMGZWcNYnDPdJxmVHjDyGi4Q==
X-Received: by 2002:a17:903:2312:b0:192:8c7f:2654 with SMTP id d18-20020a170903231200b001928c7f2654mr43094188plh.0.1672941864581;
        Thu, 05 Jan 2023 10:04:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b0017f592a7eccsm26349263plf.298.2023.01.05.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:04:22 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:04:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        stable@vger.kernel.org, io-uring@vger.kernel.org,
        Dylan Yudaken <dylany@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] io_uring: Replace 0-length array with flexible array
Message-ID: <202301051003.27CF3DC@keescook>
References: <20230105033743.never.628-kees@kernel.org>
 <Y7Z+xN+BDy5yoK5f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Z+xN+BDy5yoK5f@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 05, 2023 at 08:39:48AM +0100, Greg KH wrote:
> On Wed, Jan 04, 2023 at 07:37:48PM -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct io_uring_buf_ring's
> > "bufs" with a flexible array member. (How is the size of this array
> > verified?) Detected with GCC 13, using -fstrict-flex-arrays=3:
> > 
> > In function 'io_ring_buffer_select',
> >     inlined from 'io_buffer_select' at io_uring/kbuf.c:183:10:
> > io_uring/kbuf.c:141:23: warning: array subscript 255 is outside the bounds of an interior zero-length array 'struct io_uring_buf[0]' [-Wzero-length-bounds]
> >   141 |                 buf = &br->bufs[head];
> >       |                       ^~~~~~~~~~~~~~~
> > In file included from include/linux/io_uring.h:7,
> >                  from io_uring/kbuf.c:10:
> > include/uapi/linux/io_uring.h: In function 'io_buffer_select':
> > include/uapi/linux/io_uring.h:628:41: note: while referencing 'bufs'
> >   628 |                 struct io_uring_buf     bufs[0];
> >       |                                         ^~~~
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > 
> > Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> Build problem aside, why is this a stable kernel issue?

My thinking was that since this is technically a UAPI change, it'd be
best to get it changed as widely as possible.

-- 
Kees Cook
