Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBEBC77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEPTB4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjEPTBu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 15:01:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6857D96
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 12:01:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so34575ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684263696; x=1686855696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
        b=YTcgXElpvGt3LVfiNgl5PSEl/rBXxtslgzs1wn0AulV9NHy7s3dRPgUgymNAKMd4u5
         dobM79MDBBTmVDF8lrKoENPSGJIbzl032aZ+Ie0w8hNTx80kVCt54FdiVcZ6LR+4YxjA
         L6PuoiBV9Q/FJUVAooL5QT+66KDs7lg3YwX/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263696; x=1686855696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
        b=BTOl4NGi7JWEW6upbRTy/Qh2spmIyDAXxB/GTRgQ0VYRbt9Rq25V82OE8JPbra7ypq
         hvHrqo6IweFlnhByCKT5U460911mu+AbcVRLLWAJ7/wUeiRXz1gNCuazy3enM5sO+Dqc
         EVuQzQULiBBG02qz6TBBlrHpkqZ8IK28lTswvdAU4M5NR+VVXT087NhiD/KW5DQdoi80
         mQHe/2v741PdCH4xG/ELIu2dbiJ3/IFt2W9NZ3+KRyONsQ1KnhlVaqzBv/GQNsIG/2ee
         jJDgDojfgpomPh5+FmRaoFRlYEAW6wnHI6WZZ8L5mJE6RN7hMBHKFi/2zdFB5kpkvz9V
         JSJg==
X-Gm-Message-State: AC+VfDywrwwD0L1JlzASM8HvfnX/l76+t97QvNZSVAKLqlzcc3SdC7Ii
        19Y9PF2XlekuwCJ8S4sidjvVrg==
X-Google-Smtp-Source: ACHHUZ5ZLD7j3APDOySoMJHuE3aU18Lrbi+vh403ZC/xZCJwhn9YLHMEtvqEWZXDOHofmDlW+yYTpA==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id l18-20020a170903245200b001adbc860851mr29197280pls.45.1684263695791;
        Tue, 16 May 2023 12:01:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902728f00b001a69c1c78e7sm15783248pll.71.2023.05.16.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:01:35 -0700 (PDT)
Date:   Tue, 16 May 2023 12:01:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iavf: Replace one-element array with
 flexible-array member
Message-ID: <202305161201.4AF77552@keescook>
References: <ZGLR3H1OTgJfOdFP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGLR3H1OTgJfOdFP@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 06:44:12PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct iavf_qvlist_info, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/289
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
