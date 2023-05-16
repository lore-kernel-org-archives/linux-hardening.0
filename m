Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04060C77B7F
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjEPSS5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjEPSSy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:18:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89F26AB
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:18:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5304d0d1eddso4908433a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261132; x=1686853132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq51/Winy9tdcJdkE3nX1hb1YAR26qiq1QbsKMiUQjw=;
        b=AuNGp7s324pQNR2JPDgYdg7zfF+tEhSJf0t28tdXYYYMmv/8pBaVhUHtuA+q1FrMW3
         GMEecbPpxUfA178sTXMsn1KyAXESzSdPtK8bOSNFMllkT+3myhspkehizpQ7//V4/VoP
         F+ZU5Of6qzXcmAeTdYreTpyPTLR67UyOHb9x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261132; x=1686853132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq51/Winy9tdcJdkE3nX1hb1YAR26qiq1QbsKMiUQjw=;
        b=X11fJjTMO7b9ajiuw0KGhZG5la4otGguZ17GV49/XsX9ZrDhmxcG+NLklImN+6otCM
         qRcpRiJaZvKmz4ZsEQKvg2D30OqFEnixrYjTE+Cq+GX1nbBI9wya9rlXeO9Ddq7XnUa9
         c/9JhvwL22cMq31zgfygcvBSNsDvX/jsY4mY98aSFPNTa/P3i8RdUI4Ylt2LROF3p9bf
         tjYVwPyZBtzKCdw/T84EKM2Lhto6Yu79ThX4T4fTTDSLPtYbZqZWfgyiZyxm5XDKdcmi
         3tdccGT+DXCXNVYHaFKewFhD8a1imYF+pFxSQYnQ/mHvUq4eUDrDrkjkHNQphy8m4nbU
         E6Gg==
X-Gm-Message-State: AC+VfDxbwc1IKNaEMlJXxXPK7XiR9nCZw3kWRPpxnKe527LeYEPaOU5X
        C2GCxT/1onvjgsoroF/lhk+dkA==
X-Google-Smtp-Source: ACHHUZ7zQa6U94ltPkX3/irOR0s/5miFSFka1PrbPo9jaHvLLlTA+6024nF3xbiAQB4c1NJ6cN+qqQ==
X-Received: by 2002:a05:6a20:914f:b0:106:ff3c:be9b with SMTP id x15-20020a056a20914f00b00106ff3cbe9bmr3263460pzc.7.1684261132182;
        Tue, 16 May 2023 11:18:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z24-20020a63e558000000b0050a0227a4bcsm13895907pgj.57.2023.05.16.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:18:51 -0700 (PDT)
Date:   Tue, 16 May 2023 11:18:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mlxsw@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxfw: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161118.86AD596@keescook>
References: <ZGKGiBxP0zHo6XSK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKGiBxP0zHo6XSK@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:22:48PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/285
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
