Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD689C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRQ4h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 12:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJRQ4g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 12:56:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44741C1495
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 09:56:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so14596704pjl.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aX+f1aKTWuCaRtpe8oYSPCaFSr1D16+zAAHvgYMM3Zo=;
        b=R6Gv+3IG1iLaOlVgLEbN8WjYPxZerEqODSTfzQyFFbWHEdFWJFjm8eUEgFnxiI4U0E
         p9HnxoiRwzbxGiNmlrZbpkmfHnTR3W2ShE4fQ7ddsGomhyxGT3zcNzhjsHGa+FkVEsbI
         B5VojHp0lIqcyWsOjBOCy1RWTAA+nyNXqcrmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX+f1aKTWuCaRtpe8oYSPCaFSr1D16+zAAHvgYMM3Zo=;
        b=3zsouf85GVwBvtcmD6r5LwEuF9e+5bgbx8gLEYShpqLM3Lum8U7lakNJN20tL+7qWy
         mbA1Bou9ohmlb8E4RI0Jb/kcsZOhA/kn8ZJciOammnhnCzVnsmDqcfjJv8fRaDtZUjYr
         HxNAuLmBTXX72CxLBwpgpj2Fk0LdmB4IkYMJA/yVHFwVToHN95Dcw9WtiE149V6gnm0Y
         7CljpmbnyzPxPxH2C/DEg15kDxzqJzIiT1zlZCh16iK9ZkiCjTrjdS70wTa22PU4hZkq
         pzsbej0s5vecJ7lmTjBaR3aYAhT3M68G73NTwEF2ExEeA+hu+Bp/p6eEG7W2XkWa2Qqj
         kT/w==
X-Gm-Message-State: ACrzQf0uYGJfWuGLUzEhl0FnZPq46WjZ57jXWIHC6m6YKEOPgluNbfej
        zxLiRsJ2TeY20MUgv3WlRVKe4Q==
X-Google-Smtp-Source: AMsMyM7EiDhq7ZjZ2Gd1Bxbo03ECXLOB8ZkjJ+Y7TCVR1Yhm0ucGTwlAWAUsfIX6Zkb1a/L9MHkXPA==
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id j6-20020a170903024600b0017996b51ad2mr3949944plh.37.1666112194673;
        Tue, 18 Oct 2022 09:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f23-20020a63f757000000b00460c67afbd5sm8327716pgk.7.2022.10.18.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:56:33 -0700 (PDT)
Date:   Tue, 18 Oct 2022 09:56:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf, test_run: Track allocation size of data
Message-ID: <202210180948.0A0D16844D@keescook>
References: <20221018090205.never.090-kees@kernel.org>
 <CAADnVQKBfPeDqHE8U6f79XKqrQsLWysRQMweBhwBd-qRP0FDpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKBfPeDqHE8U6f79XKqrQsLWysRQMweBhwBd-qRP0FDpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 09:29:07AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 2:02 AM Kees Cook <keescook@chromium.org> wrote:
> > +       alloc->len = kmalloc_size_roundup(size + headroom + tailroom);
> > +       alloc->data = kzalloc(alloc->len, GFP_USER);
> 
> Don't you need to do this generalically in many places in the kernel?

The size tracking or the rounding up?

The need for rounding up is surprisingly rare[1] -- very few things actually
used ksize(), and almost all of them are due to following some variation
of a realloc idiom. I've sent patches for all of them now, so that should
be a short road to solving the problems ksize() created.

The need for missed size tracking is also pretty uncommon (most
dynamically sized things already track their size in some form
or another). Finding a truly generalizable solution is an ongoing
experiment[2].

-Kees

[1] https://lore.kernel.org/lkml/20220923202822.2667581-1-keescook@chromium.org/
[2] https://lore.kernel.org/llvm/20220504014440.3697851-1-keescook@chromium.org/

-- 
Kees Cook
