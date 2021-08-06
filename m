Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564FCC4338F
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BB961165
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 22:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245523AbhHFWac (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhHFWac (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Aug 2021 18:30:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65589C061799
        for <linux-hardening@vger.kernel.org>; Fri,  6 Aug 2021 15:30:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bh7so177122plb.5
        for <linux-hardening@vger.kernel.org>; Fri, 06 Aug 2021 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=KzU0uWQel4rrqucZdeNEFegtyMHl2eu1JNNVShfFEqSIZQRwT9iIriyUSrEtpZic3k
         xGxqvfScDKAIukCjdhuRPVuxXq1bn5BBIFzAWjRZHxpKhDPQbRw8G6JLb+nhuFX04iXD
         dzpXkbjuO3UPaRbJ37MGU7vlcPgt8zRMN2W2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=GnQ/UX2CA1PgVhFV/YKuEV/K5x/TfocM7JH29ZLodll7FQo93Qk7JrlooHvPk1FH7p
         qv+6sVLhAPbR8Oa5N+dxn0EyH6IjLu+t9D1poOQV2RMlgBHDvJ5ZaqwRgb7G0yGgprTw
         ZsjenOPumNR1Mgqbsi1GgDdPeVopJ+9YW5OVmUoiwMRLT9Tj1Ql5/N+mWL/nutjht3Ad
         7SaQfzcHsmsOvfZgjKhwLurr7XAORUSG1Xyglh4L8ndU6qZTGzQZR3QeIaCWpkMImOy7
         HoKm2KZZyRHQj2KJw+cJIPDlTEtcc5nWipZHd+nWboX9ZtCTYtBtf4Cky4SUCvMmf2aN
         EMAA==
X-Gm-Message-State: AOAM532C0wRt/sf08vqmtEJoxEO2Ehi3r1Io01n2LLH/rpMXcyetqia/
        w7kE3Tqk7Gzq5bShRtsOKEOJ+Q==
X-Google-Smtp-Source: ABdhPJzJNM8Y2Fq8MMmxSifX6jMF7S2TiaF1k771cOv/hwziioYA+1qaKgY1XfHH80q4W3Y3DA4Nvw==
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id z63-20020a6233420000b02903b763950a93mr6951533pfz.71.1628289015923;
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm4058945pfe.37.2021.08.06.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Date:   Fri, 6 Aug 2021 15:30:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipw2x00: Avoid field-overflowing memcpy()
Message-ID: <202108061529.07216CBF7@keescook>
References: <20210806200855.2870554-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806200855.2870554-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 06, 2021 at 01:08:55PM -0700, Kees Cook wrote:
> -	if (element_info == NULL)
> +	if (!element_info || info_element || info_element->len != size - 2)
>  		return -1;
> -	if (info_element == NULL)
> -		return -1;

Gah, a let a typo in. (should be !info_element.) v2 coming...

-- 
Kees Cook
