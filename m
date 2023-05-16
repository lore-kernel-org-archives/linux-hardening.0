Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA75BC77B7F
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjEPSTt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEPSTr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:19:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944997AB2
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:19:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3fe67980so8107465ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261177; x=1686853177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alPm1FkLfJCzAk9pEVOJArmhF62w6dqf91iv/i5ryBk=;
        b=GfVb7bP9VkgyQIpD6rmCEdxEa2h4o48x0FB0TnkzXoe0SUE9nRrwUQ0Qx4s+FJPmUN
         o+GTZGH33myPwTlPd14fYLgg3Dbpev6hLXs3CIuI+C+mXv0lsQGdfzbsgR4KXgYJwRlL
         o5om+MRUpKCRVwbB+6dHjMS696gCKLhrt9p4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261177; x=1686853177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alPm1FkLfJCzAk9pEVOJArmhF62w6dqf91iv/i5ryBk=;
        b=EGIseY9p4AwgsikxwcrUzPVbe15HFNTwUMbVU2wIlSY6chVb97YPX3EowNsTf+9D2A
         dETRgynFuyEN7WPuPVnriblAudvCtLgcauuN3iIJ7+1IZN0o5PcCWcyyCCr65V36C4X6
         8UHu294fiBUvfzCOzmyw+VlsyHUD7kWkLxCsiKUJ8SewL9gbj8/Rnr7tDKUKPXI2oz5g
         KtBf47mDc8nlmixKzjyO8k0DCpRUlEV8XTVOwLL7b/Kdfi7J7Y6mux/iJPcGex7t9Q8I
         hafQl+pbOamTfA59WKmLPyW1rda8MhjPKUd/YI1PiAAObCretPnCNQOrVZsrOhnUdhf6
         TgLg==
X-Gm-Message-State: AC+VfDz6BOYJDxWb8F1xmkXg1mJDXutsTAqs6FbCbImXoSavHGpFDgeL
        sEegjTzi//Dq1pKmi6Ix+PLtjQ==
X-Google-Smtp-Source: ACHHUZ6uVa+nfzK9d6+UKGJYTR7xfDV6f0n91uwgaR0OIfF6UxU7TS/xzV7gJVCr5GhfD4qejQviBQ==
X-Received: by 2002:a17:902:db02:b0:1ac:815e:320b with SMTP id m2-20020a170902db0200b001ac815e320bmr36577912plx.17.1684261177044;
        Tue, 16 May 2023 11:19:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001ac68a87255sm15831519plq.93.2023.05.16.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:19:36 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: wil6210: fw: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161119.2158E464CF@keescook>
References: <ZGKHByxujJoygK+l@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKHByxujJoygK+l@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:24:55PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated, and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/287
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
