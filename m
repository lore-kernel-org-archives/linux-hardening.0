Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F5EE4998
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbjHRUZV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380009AbjHRUZE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 16:25:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502E4215
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68879c7f5easo1136055b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=egJ39qsdNDnaP8eBPC82Q2jt0LO0zgNc95KY2wtH+1V9wbBTLh1Ky6jQ8rTauBiJ/b
         ht64aXi61KNBL+Y8bEkkcaHZ81EwY79cKy4mJrPXZWraEd9SsbYba8O66Uznhj9BPFlo
         Uapx6baXCoHKgND+281kPb5nFph/dYaduliqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=E4W/hspzWC2bQYAHx4g82U5szYZBFfbKJ3AzUrnLxVEcO79G9v2Cu7pDM1BG71gAWG
         flVlLshLrtGCLn6GCB1GUn6000kr55+ccTlf+y/dVuUI44v06P/MrxIrtyN3l9ToJyXk
         7WSsarOOtOm7F6evSoW5fg6544z3jI+eJnBVO7oQU+mhbdx6cc3pb4FzlKnNYUUhZ9gr
         5TFv9JsSQLYMg1edwPjaq9k/w0xN1/3A5AjNVc9u0Rp0P3yGrNCgfUzMrHDFwFrpQ5T6
         9P+xhbVBHRoInsuTumo50xGkAYhKtrRLGscGn9cHNQkmm/mvvlC8Kk7vAp0jfNxsPLAP
         Gz1w==
X-Gm-Message-State: AOJu0YwtG3v2NlpD452LfNA/SbNg0Zt9T/xhhrcane/uCgskEqn2Va3n
        q/5cZA7yklSlc8ajNxzkd6JYmg==
X-Google-Smtp-Source: AGHT+IFzZ5xua6284VP9UIz+L1TCJGOBeZWzRVDjkLYvOiLi5m1A3dBrZZ7aSqweUnt5zS1+NUVOeA==
X-Received: by 2002:a05:6a00:24c6:b0:687:3022:9c1a with SMTP id d6-20020a056a0024c600b0068730229c1amr298176pfv.28.1692390299149;
        Fri, 18 Aug 2023 13:24:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b0056428865aadsm1755227pgp.82.2023.08.18.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:24:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:24:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181317.66E6C9A5@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
 <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
> [...]
> extra checks (supposedly) compile down to nothing. It should be possible
> to build alternate refcount_t handling functions that are just wrappers
> around atomic_t with no extra checks, for folks who want to really run
> "fast and loose".

No -- there's no benefit for this. We already did all this work years
ago with the fast vs full break-down. All that got tossed out since it
didn't matter. We did all the performance benchmarking and there was no
meaningful difference -- refcount _is_ atomic with an added check that
is branch-predicted away. Peter Zijlstra and Will Deacon spent a lot of
time making it run smoothly. :)

-Kees

-- 
Kees Cook
