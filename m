Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C87C77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjEPSUa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEPSU2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:20:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB79ED0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5341737d7aeso2755212a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=ZpDWOGHhmLyAAR3xhqoNa9cHCEOfaCd0mVmq1oY9OAifiLQJPIAeDcvcIht0WKv8cy
         E4P4LnxaKMWlpehlw+14xCiOVeHMnRMwzLYGGBcC/85waa4EQvFMxrt3dhJbR8aZLMZj
         7MB+YXAb06DvCz9MejAWuoSkxao6BIe7GZygE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=YVFUPOK2hXCzvbxZwajD5vO27q8DsWdeilH+M/SCe9kP41JfqUHrUkxyQxzoSzbl0d
         pV03Bc8VTuT86ktNmG5EA8Ek2PYTm8k1XPgqHwv9SOh9TIYIPRZWNFLyohWb5a83HwS/
         aUI4Jz0BvrkfcwQZN983ByE5MAjeGaXlHKq0W71QdftjwCzZ5kEUR+jpBXjRBYed1FAq
         mMCT2MKXXfpZuF9/VWafZtLL4FO50NDj33hSGwG/ZShzH8tADIs+FbFzDpFvE0bbAXkP
         MQnTaUjF5FhgAoBf/mrSiRbSkeLVIWMBpBzG9n1UKI1P05rDWEU+zTExogPNjRwGrWuv
         zxrA==
X-Gm-Message-State: AC+VfDygjunxjLCTtPADRLtD2XVyh51H8jMAb30wAuGVz2tjEqZX9T5H
        jTyFHDLLfAIhSqjOblfF6L6sww==
X-Google-Smtp-Source: ACHHUZ4CrDdQ4iLXNCzFZanLvMVQj9bV0mnZNPCVTJTpjTHbdVtXwUPj91zfKnKk5etlpLq1vX01gA==
X-Received: by 2002:a17:902:d507:b0:1ac:310d:872d with SMTP id b7-20020a170902d50700b001ac310d872dmr50492221plg.52.1684261218846;
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001a69d1bc32csm15799763pll.238.2023.05.16.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161119.A5486474@keescook>
References: <ZGKHM+MWFsuqzTjm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKHM+MWFsuqzTjm@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:25:39PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated, and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/288
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
