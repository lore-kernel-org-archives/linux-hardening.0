Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B4C32771
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiI0Cb7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiI0Cbz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:31:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D910E11AB
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:31:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so8228199pgc.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9ewTPKheQH/VeUeUiLVY8qIwxsi5cTHr9IDNehA24WA=;
        b=ceUgxe/lC5UBEuGusxsxqzbk90I+VRqqgcguETsJRXfKbyb8zrK1hg9YIE5JlhVEg5
         URXKy3fH3YnoK1O6XjVEfJj794ySV3BXKo2PBpA0KQEn77s1hAAAJyNvP4CMwZ38c3Ik
         YGVWmTp6yL9XcrUlmqJy0/z09zMbE9RSNCkHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9ewTPKheQH/VeUeUiLVY8qIwxsi5cTHr9IDNehA24WA=;
        b=e3ajg5mjiEiKJ8jjQtvnRpu3EckaKalfbiCxwu6TS8GSlL29tRnO97IVloqr9MWNTe
         VAs1jgweXGNNPEnnrEGrBE11KcRWq6KkoXtx8+lsX1UTNV6eyg2Fv2FvLtm7Kqmpc25B
         iPYJeyIPPDkWAgeZk39eR4sE0MN/UkQ2e7n+1rsxbo3lOiYYn0E8vqEM6eJAcU9lxldC
         3p03FxMXhg9f4z7cCZKapGDrM54Mys5GiJXWtJPaLiI7d4IcdBYa9h6kkpxFVNdqys+a
         wSKE7WyrTDE7J4GMrrBhVS4vd5Coz/V/ZAWc/GgYdUe+8XAl9dxgfz9jqJamHpB23DGh
         p95w==
X-Gm-Message-State: ACrzQf0nJ8Gk7T+e3jbX+2+17Jl1f7T6UXcf5RzqeB3jEnQppgXYzP/p
        zDeCU8FUu1Q3b0XOGIXcuoAIfMqaKi9LRw==
X-Google-Smtp-Source: AMsMyM5gEWRHn2o1zuyvj0dRXD8PdoFzFHrXCz4JBSPqHHGptBvX5j2Odrepujc2SJSxuBD4q9WI+w==
X-Received: by 2002:a05:6a00:9a7:b0:54c:27c4:3ad6 with SMTP id u39-20020a056a0009a700b0054c27c43ad6mr27287556pfg.9.1664245913313;
        Mon, 26 Sep 2022 19:31:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b0017872bc9865sm168795pln.63.2022.09.26.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:31:52 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:31:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iwlegacy: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261931.EB84C573@keescook>
References: <YzIvzc0jsYLigO8a@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIvzc0jsYLigO8a@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 06:03:41PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/223
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
