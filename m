Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C56BC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48608615E2
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhJUREE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUREE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 13:04:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5973C061764
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t11so837651plq.11
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
        b=kbtKqp869IvvyYrIFZ+BH/Q0al7dwwzh5cM6+zpyBkF7KGxb3RdZG6AjqL12NXrkvj
         i8TwIJqIVmoMIBKGrwILTA3CQO+qDER/xHXw3nm0xh43UVeuwQ5oTRs40LK7OHGWTEpH
         JrpCjJhrhkPbXr4Kp1cbU+RO3L2iBO/XAW84g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
        b=d868GewQlJzLjLPdWXqMElYiVYH4R/s9XY7AG20r9zDRwUUSITag349FCMVuNx9uN6
         a2XbyTyc9RLa3ZQikaJDWcndFfYDXk/JE6CIWb4QEP/obpdXICORGKg3CVQTzdAYDOwl
         0+BNF55Vwlyr/CKUBAq8IajI8Aq8b3eh4qP4qDL31aUmGibDXPAqTHeC+aRf7SYWrmMw
         cgWo36V+Ny5oVtzo0offkrn2rb8el2oNOGnQwJBcSwbMq0jVufbN9btDk4FZuvPo1Bza
         0Infnhom4NzSjlfBu/Rki6I5gMO+RxBGQ2qfkqQmPjo8VQTmsmWyrfUECPH5M08B5jWp
         0mKQ==
X-Gm-Message-State: AOAM533kTT+THH7drnltirFFwbPn9GrmUlpbob1nNEf+FoSDcUu9KqNG
        Yr0JV4KwWAr6vRw63N6PH3rPCg==
X-Google-Smtp-Source: ABdhPJxkAyOwGvHc7ivx7LjrapCTdkqnEb6o93YA/TplTcs4cE/vfWTTgvplAtmr9P2ANXp/IgvLCw==
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr8130252pjd.81.1634835707409;
        Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l29sm5899803pgc.47.2021.10.21.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:01:46 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:01:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
Message-ID: <202110211001.F9F26D90@keescook>
References: <20210928222229.GA280355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928222229.GA280355@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 28, 2021 at 05:22:29PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
