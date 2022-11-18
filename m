Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332CCC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiKRRGl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiKRRGf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 12:06:35 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B111465
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:06:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so5505591pgm.6
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGuGWp5XCDdHJkP/ZVzcY0JNFnAf0r/m3zS2HVfgluM=;
        b=EF20HVvgV91jn4cZ3X3NrdTFvw1O1FGOatUDshSJu6yJPlh+xkrX/7AsdG9iutTwh3
         D2kSGxbYUBU3Nh7zBm54rQsCM21o1p1wb4g3y5FQ1cE6jG8zwnQ7sCpAp65yXz/8dAOJ
         DgZXfwYSGezpi9JmZc+1nFbRmCINaF3Upd3UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGuGWp5XCDdHJkP/ZVzcY0JNFnAf0r/m3zS2HVfgluM=;
        b=Zb8f9TSTT9psRxn1JYc4Pe5wpj5BTXHvA81Sw7OP3koHzHAa9cdQSDjXFiGzxTnzo6
         r5GxTFg1UWPhdAniA+bdeMCxuGRtsFftvWLbMnlnUFIcCDeRNEFhrAL22j15/O31zcr7
         YKhpmPUESyE+PlRTGl3RTq8GKyGfbhEAHdze/Me5aN++BBt0tr1tLynYeeDRyoTla1xA
         xedcXwLgq1OVB7JZ8ZRch2HwvAhbsF4+Ok8j+KkfRUyry977MV8m7dXy17C7JbG9tfEa
         ejfpRhodkZYMUhCmAxK1L8xn6Ryh8kQKjcspqqTLSwyTBKcgw8HDkzn5Mc+EwRqrLijL
         0+SA==
X-Gm-Message-State: ANoB5pnPesvLyznmGohshWb/bhzZAqTqrmiHC7uLvb00s00kS5V3uSci
        Y2SyvXJ9DBvWnGFCesszNXZyTQ==
X-Google-Smtp-Source: AA0mqf66Th+JaUaR6SALYWcOu+b5KEs15JPlRbwXz1ZO7OP5vyoVUmI5BCievEOVALjrQFn4+48xbw==
X-Received: by 2002:a63:3d8:0:b0:476:eee6:d394 with SMTP id 207-20020a6303d8000000b00476eee6d394mr7387317pgd.228.1668791191672;
        Fri, 18 Nov 2022 09:06:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19-20020a621513000000b0056c0b98617esm3435797pfv.0.2022.11.18.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:06:31 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:06:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] slab: Remove special-casing of const 0 size
 allocations
Message-ID: <202211180906.3030FDDB4@keescook>
References: <20221118034713.gonna.754-kees@kernel.org>
 <20221118035200.1269184-2-keescook@chromium.org>
 <f008f8a2-8d5e-88ab-8d23-a2043ea5abe7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f008f8a2-8d5e-88ab-8d23-a2043ea5abe7@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 18, 2022 at 12:34:01PM +0100, Vlastimil Babka wrote:
> On 11/18/22 04:51, Kees Cook wrote:
> > Passing a constant-0 size allocation into kmalloc() or kmalloc_node()
> > does not need to be a fast-path operation, so the static return value
> > can be removed entirely. This is in preparation for making sure that
> > all paths through the inlines result in a full extern function call,
> 
> So with the kmalloc_trace() already solved, we could now say it's not "in
> preparation", but simply "makes sure", right? I can correct that while
> picking this patch.

Yeah, good point. I missed this when updating the commit logs. Thanks!

-- 
Kees Cook
