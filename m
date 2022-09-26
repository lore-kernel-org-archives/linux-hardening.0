Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836FC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIZWCT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiIZWB4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5E6E513F
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a29so8029501pfk.5
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NT8F/Sj0Q9yRmFZyi3XfPWnAIOXfMEUrjgewG27HyFQ=;
        b=fG1qXK+12aDUGiqFjjOVulomtauZVkrqe3h5VvQdj+htLs5ndcJc0MdCDW+x5UcrKn
         +lcSzfixuuBRg6TR4H06W6f12YdqwR6ooH1yFU/iPC/F1VPkCdt3wyLOsZZwuGLjvFd1
         VzTQPpWPTGPrSs8uJT3B0igrvLR7gppRnrVAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NT8F/Sj0Q9yRmFZyi3XfPWnAIOXfMEUrjgewG27HyFQ=;
        b=ZCJsVWFiG8TLMpwt3LDTEbrhfTNIDL66SszopVOGhrLwBi79lRhwZDNU/nvoStNxZF
         UktvIZx9Mq7qxXp2q8xV2Cu6DI/MqXx0JbNnI/+TMKQHZNcywpVSGko5Wea6OP4IhHgU
         mMmclote+IItxqUtQIGcp5oCyz0KakvGvVmpYTwIb7DnhAYzlujRTpCwF1vJy6Y0pSPB
         LWibFgeQ47UsM0dLdUXuZGZEWQ3NRXbW1fr9+sH6GnMBsa1I64xB2dD7WrVIaLOhoa6B
         KuZTl9fBZBFhHW6Kgsbab0swMb2ENiuJLXsqUJUfblIFNCGlW9UGcSiQApTo+U8HLSLZ
         da6g==
X-Gm-Message-State: ACrzQf2mdqNBSLSrj9o/zch7FrlFLq/GHTn47la7JpRWr35mDFfU/Kz+
        7PytVct5N4Zi7SGqyvwFinIacA==
X-Google-Smtp-Source: AMsMyM4y9lezo0/S2wIwtV3prmWvVTnyikbgsWsF5HtyKR42X3AVNNebI3RAI2KsxQVWW4FtvnHm9A==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr22561085pgc.616.1664229713937;
        Mon, 26 Sep 2022 15:01:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a63eb07000000b0043a0de69c94sm11034189pgh.14.2022.09.26.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:53 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: sh: rcar-dmac: Replace zero-length
 arrays with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.E08CDA4@keescook>
References: <YzIdsJqsR3LH2qEK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdsJqsR3LH2qEK@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:46:24PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/217
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
