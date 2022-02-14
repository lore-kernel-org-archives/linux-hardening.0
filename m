Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29C2C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Feb 2022 20:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiBNUvy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:51:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBNUvu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Feb 2022 15:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5DECF94ED
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644871767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPJv+2s91+qxlbeq2Ny6bT4Ihe2WEyqS+/iM8RL4Bn0=;
        b=A0gk0Qeiw5Wqo2Juggm1NgHf8L5OKm00mr6v4+wMA0Tm5KBquQhrhBK5rzkbHH0P6HjwoH
        AUbcW7RpyrmTOBStPnzgJbdCc0hYQObVAZIUfasApxqelZPK7ZI5/7Cy4VyMhlYTj0H5Yb
        zpMU2mbj/OzcoqrLLC7dGrQl98MsXxA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-fgOGLOIfPZ2OExV6y1Cfgg-1; Mon, 14 Feb 2022 15:07:34 -0500
X-MC-Unique: fgOGLOIfPZ2OExV6y1Cfgg-1
Received: by mail-qt1-f197.google.com with SMTP id br10-20020a05622a1e0a00b002d37e07e79aso13401971qtb.4
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 12:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iPJv+2s91+qxlbeq2Ny6bT4Ihe2WEyqS+/iM8RL4Bn0=;
        b=vVa5HkkL9Q5foP0orTUQQ8bSoqLYzFM58GPJgDh0nV8A7ZphwWHNJbD3Gp3q4uRm/z
         W9Uwz0hGa9opo+nY/OyfRkpCdJOBGfx5wI7Jk/GbrX9AU74pcyUUsUyGY8pDRONjBMmq
         BO5tQCpGACP1E5YqFIOONwZMWJewjc4DnKKUwfr52J68C++ID2ecnnX+1bUd9Pjy7Cs9
         cR4x4rKge6xFhsHjz9SJ3nL+Vtea8+n796rPwq2kuKCrJHWGgQCbtOxWi8NWWiFTbad7
         Pc1vSN/sWoFOp6kIyke472sh8tYMnEpySWJGXPHRf/l7D2PWdlopLVMZtsbZEjKSiwNJ
         Cu6Q==
X-Gm-Message-State: AOAM531uPwtrUC6NMjWVJRGnii4Wm/XPCDenylwv4XEYvwE6rcEqRvTh
        kyFpQSiUrEMGKZJ3m6P6iRaiw5fYgY9zR9fOHDIG69MKfku1pCgQuJVnlPknoBKsXxp4WQx/MLh
        gl80EPS4Tvve9aI3akNBu1W8l8JqH
X-Received: by 2002:ac8:58c2:: with SMTP id u2mr440862qta.509.1644869253744;
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziQ3LUbgpn5decE7UKkR4L9MWWc2+J8EzWdi5Gt9Je1G/dpGasfQR+cKCLqAzYrwsLSIfSRw==
X-Received: by 2002:ac8:58c2:: with SMTP id u2mr440842qta.509.1644869253496;
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c21sm18647378qte.68.2022.02.14.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:07:30 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220214200730.a3qz6ocy2ohwafrt@treble>
References: <20220213182443.4037039-1-keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20220213182443.4037039-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> GCC 12 was correctly reporting a potential use-after-free condition in
> the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> when size == 0:
> 
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    56 |                 ret = realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    58 |                         ret = realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
> v2: simplify logic (josh)

Thanks, running through testing now.

-- 
Josh

