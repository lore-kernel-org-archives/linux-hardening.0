Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55193C2FC04
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 03:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbjHQDGu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 23:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbjHQDGp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 23:06:45 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8152D68
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 20:06:31 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56d6879dcaaso5130503eaf.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 20:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692241590; x=1692846390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2p3LkM2+1hMmzQH3J+BFjxfC28vADf3DXoxU36vbMDU=;
        b=YWRD5kZv7ZKqKBCnexiXsRnLveJ2OLY2djqkeNp76lKGKoV4Xn6ox3zkv0Np5p33rp
         ojV9KS9gmoNvHEJfB9xwad5gG4dmLujJHTgJSV5pahXa2FpoBgCsuBZ737hZPRrRCvGL
         LhcSb00jyJkEdKFGveAdxo2pRwaJLR4fAN0Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241591; x=1692846391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p3LkM2+1hMmzQH3J+BFjxfC28vADf3DXoxU36vbMDU=;
        b=FZwfDCzDtAMVyyMpea+Nt2yq7qJkXFzPA8n+04errAEQwh3hxPU1826lesBK8ZlreK
         QwykYzSfwAPPZEodfYhHAbxcnjsY+zu8acL613nTBIkeAxUSP5ZRVH4kta4cUERks00f
         dKBM/miqJ61p4hjWIXCmPkhZN4ZhjFEVJ6K8CR9pTbsxl1zGaWeZ0WQ3ZppZkplQWu5F
         5hjI3XewT+C4E5DgnJ9QckiKS/2X0Lu+C45NWtFCpYKehW4SSbKP5ANJwoF9945jiM2S
         tTgqryQagQLN3iujdghx6EkXM/8E+0n6yiLQVPO05PaXkWX13sEtwEddiVNlmaTWeKdH
         4qhA==
X-Gm-Message-State: AOJu0YwuU9+btVFeTSIkBfy5z4Dsp9kY78yRUdRE3sZiygWRvxIFITQU
        X4Slp4+LgCRpauh9oIGq4ZCO/MFP2pDh7w6XtiM=
X-Google-Smtp-Source: AGHT+IH1oVDvqjD3T3jAtvKneAa+KIiuN6VtidgwyIxoKunNFZPWMy7NBrz0MStgvao4aq4yjLarZA==
X-Received: by 2002:a05:6870:4713:b0:1bb:68ce:382c with SMTP id b19-20020a056870471300b001bb68ce382cmr4951014oaq.8.1692241590803;
        Wed, 16 Aug 2023 20:06:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a290300b00263f40cf83esm498114pjd.47.2023.08.16.20.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:06:30 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:06:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: refactor strncpy usage
Message-ID: <202308162006.497A819DC@keescook>
References: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 09:39:24PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `make_first_field()` should use similar implementation to `make_field()`
> due to memcpy having more obvious behavior here. The end result yields
> the same behavior as the previous `strncpy`-based implementation
> including the NUL-padding.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
