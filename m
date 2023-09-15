Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6ECD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjIOTnf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjIOTnL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:43:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4B1FC9
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27474c64b0bso1537418a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806985; x=1695411785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=lv1AMfeEfiHIn4vWjkJMk6a+yMVmMhhtfeZJjM3put5fvaifKq7g2lhVGwER0Daw93
         ynoj6O+ATUqllHBeZro2u7NTsIzpaJVLN41BpjOzxK86MFYu8nPdhlfnc4Wpprd8egsv
         I1F+LPgHMza92k1ilz+o8T0LlusPuOj0FSAFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806985; x=1695411785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=svQ0uKRb3ynM+79/nhP1NsMUYHyg5SHq51HUz0EJWGOYltYFRACEGcGONgUFK2bKkS
         wkttEP/FdN8J/LvLsIUqBUrfeKnlG5/ZAWkG1a1h6aSWfWoqSpjSe67amQoTWRVgB2SD
         tALFJacK8EHirhovgpoAPT1j8MGJPT8qOFqkRKYJ3IvsGuHcf0OX1KZ+x6yw9AbmqePR
         1LrQrRJbLqse1KoCvJ4OHOljlEPtlmngmBJ0Nr0D1p2fYaVJ7DcF3p4mg5wuKwnvGNC7
         wQxz1CFt7utPe0xXzp8/MO249/pkx3t8XIiH1YcTkpheuc6AP6No9KOmD8xev740moCB
         WYTQ==
X-Gm-Message-State: AOJu0Yzr/6ORxJJpXIt+oa5E1m3smohdK/Wk4EoXDhwiwF21jfcM1iHF
        Elzmst2DkNDd1yANOZg1c2uoHg==
X-Google-Smtp-Source: AGHT+IFeG9K8dCFdWE7JO8su8gomrvm80dps740wxaqk3Qc6GiQQ8BQQx0l1yX49avLzT86ttQjnhw==
X-Received: by 2002:a17:90b:38ce:b0:274:96a:5007 with SMTP id nn14-20020a17090b38ce00b00274096a5007mr2503313pjb.1.1694806985660;
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ft7-20020a17090b0f8700b0026309d57724sm5200947pjb.39.2023.09.15.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:43:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tipc: Use size_add() in calls to struct_size()
Message-ID: <202309151243.647E424@keescook>
References: <ZQStiorAZPgfMMZD@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQStiorAZPgfMMZD@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:16:26PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: e034c6d23bc4 ("tipc: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
