Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77342C0B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:44:50 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAF1B1
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c434c33ec0so112488745ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016686; x=1696621486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlEYv1vw7tFZx186oanN6aqA/SqIi0t9DwwVB+F0Pag=;
        b=Nym0926fJeljW9l5bR36Bkz/wUSYrRxR9PKkG16zMVjYrd+4WCAz5McWTSVQEGHYrx
         tZKOO1cfhRuFtm1zS5kioBYp7KDU/2PVXtw5xZOGi1oBz2ZWsf+nacRCjYrz1nwy+SjZ
         /sfipZ2exAiNnpyi0WrekAb1dJOySJeXtRWj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016686; x=1696621486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlEYv1vw7tFZx186oanN6aqA/SqIi0t9DwwVB+F0Pag=;
        b=eM7yiGryK6s3P3VchT4XN1IoP79AfRbe0S80a3w63FCVtY00ASt5EePXF0kd7+2nEv
         B4b6U6yRLKs1yonC5ueZhI/5e/cpazHV1mqkzVh9Fus35ZXoi8kQrOmXN9elOUvkByfp
         JAOkwmtbehQw+6do6tzXLPrR1U3Zwc4kclvr27YuL6EMJHgHxDvFQsusrnur69Az62ZJ
         e8M+uzuKNsOsiVWEW89nGZIeCMkc1Z1AqSZQ7vis+PtIuC+8Rd2WSYN+iym5vaYHkast
         77zCdnzhmKiwSkU8yIhWU5gz0d3WJVWPBxJmLohsk02K97KZ8xSlDmPDsl/EbtJtgQ4Y
         JVJg==
X-Gm-Message-State: AOJu0YzuEUxWg9xu28W5n8jH8NKnwwCcISrKNtfTh5zYzbiBHAmFLCyi
	K+5z+jIFsB9uO7bOqH79QT5dDQ==
X-Google-Smtp-Source: AGHT+IGL79pSePNuMtT3+0fzT8gZiV8QT6CLoLAdCUDg08JxvU3zZSWKZBPddJhFLKS7s3gB9vi34g==
X-Received: by 2002:a17:902:9a44:b0:1c5:cfd6:9e82 with SMTP id x4-20020a1709029a4400b001c5cfd69e82mr4213045plv.18.1696016686313;
        Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902ed0d00b001c72d694ea5sm4690423pld.303.2023.09.29.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:44:45 -0700 (PDT)
Date: Fri, 29 Sep 2023 12:44:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <202309291240.BC52203CB@keescook>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 11:11:44AM -0700, Kees Cook wrote:
> Hi,
> 
> This annotates several chelsio structures with the coming __counted_by
> attribute for bounds checking of flexible arrays at run-time. For more details,
> see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (5):
>   chelsio/l2t: Annotate struct l2t_data with __counted_by
>   cxgb4: Annotate struct clip_tbl with __counted_by
>   cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
>   cxgb4: Annotate struct sched_table with __counted_by
>   cxgb4: Annotate struct smt_data with __counted_by
> 
>  drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Hm, it looks like this is not "Supported" any more? I'm getting bounces
from "Raju Rangoju <rajur@chelsio.com>" ...

CXGB4 ETHERNET DRIVER (CXGB4)
M:      Raju Rangoju <rajur@chelsio.com>
L:      netdev@vger.kernel.org
S:      Supported
W:      http://www.chelsio.com
F:      drivers/net/ethernet/chelsio/cxgb4/

-Kees

-- 
Kees Cook
