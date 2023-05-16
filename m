Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14050C77B7F
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjEPSTP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjEPSTO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:19:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95D46BC
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:19:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643465067d1so10669069b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261150; x=1686853150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2KXWalTdvuGRBWwyxeiECFs48vb0kc6jIG6BVZ17mo=;
        b=Z+oc/RnmkqCau1eig8XC59UFZDXTkKpJLVIle+4Fox0TpnKXHVaVyftTO51uf+LWTX
         IcxX+7w1jlQ3yRO8Q4hNA1rbsRiqf14wZo1H/OmgD0pGGRHlElIMPYPqO0hK9ONPzhL0
         U3caLl/jlIPZqNdr5fhCkQQMWIz7+cJDQYnY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261150; x=1686853150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2KXWalTdvuGRBWwyxeiECFs48vb0kc6jIG6BVZ17mo=;
        b=jVVezBbbLwGT7OtO39TQpKvDmheGBvtmiU1swueyaA+JVqgt9zg7L+ot00ZeekPdQo
         zPol4IA5V9UO0hw80iviwD0DBl66C/SnRY+XGDbhJiZ4JLviQv7V7RLHYiyzx14Zn6fX
         q5iXdpKYBWxIAJdgk6Me5OadghcZ1V7l0M2M3Apv6Ewtbxt61Gi187/TcIvBMACFbbFq
         G39tI/ad/m+qvcKMuZu/Cr4S6FMP+xpWl2lgxj/S2CU0kdQBBNp8NEIXWtHKxHrovoBc
         rJuIW2aUIltgqiG1hhZd8kwz7RQ0S93M3RjwoP9XciMg7sPDdq7edzKH4ErEUajofQPr
         Gj8w==
X-Gm-Message-State: AC+VfDymtT4xkdsdcHYBl1A9MDCTwz3xorW950aH1y+vfsRgDyuU+o3k
        bo7mknjBuhdvdLZAw/Cz1hgsMA==
X-Google-Smtp-Source: ACHHUZ5JIQKxCPQ27BHIeg2iA39AMfvy4E6QWK0tSVz7aRpKK8uGONHyNmjFI2YOy2GrosvFVaFsWA==
X-Received: by 2002:a05:6a00:22d3:b0:64a:a432:f313 with SMTP id f19-20020a056a0022d300b0064aa432f313mr22510808pfj.31.1684261150336;
        Tue, 16 May 2023 11:19:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0062607d604b2sm13768911pfo.53.2023.05.16.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:19:09 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: libwx: Replace zero-length array with
 flexible-array member
Message-ID: <202305161119.B6E9737124@keescook>
References: <ZGKGwtsobVZecWa4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKGwtsobVZecWa4@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:23:46PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated, and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Transform zero-length array into flexible-array member in struct
> wx_q_vector.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/286
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
