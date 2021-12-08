Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2649C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 05:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhLHFGq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLHFGq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 00:06:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2379C061574
        for <linux-hardening@vger.kernel.org>; Tue,  7 Dec 2021 21:03:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3542472pja.1
        for <linux-hardening@vger.kernel.org>; Tue, 07 Dec 2021 21:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kCLAEL6kwfeKwN41NqOO8AEPYIdaucdm15Lf3Sx9vGs=;
        b=EmL1YzZJoM5WiBJHVcjdeIDGwc1JlQ1PdJiFDy98ILZTPhEUBxVnt4M5HX+U581wIv
         uqGuShQVj9Jl8+X40vY81ET7pJffG8xzdRFVAmuXdUcDq/Ma7YKYWXbbcGkoFOIiTO/g
         vveSftJZgGYoDS30XYcmKpOiW66zLf9ucvDU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCLAEL6kwfeKwN41NqOO8AEPYIdaucdm15Lf3Sx9vGs=;
        b=tiKeN9YqX0OdNoOqODXJiRC/LNdhxbW5H4lHcoeKAxV/fRh6ecVBa7z0Oh54GMIw+w
         zg3OjvWlmw8upAxnhWJa0oX8eZ3B6UhCdrXu6TDwYhodKj3YDeeZpRId6s3h1+KASDhe
         43vwcZwqN4ChB9Yk2O34Q/2DudpMb7LwA5oJ80dVt9FuTuJG0WStWcb/sK46AMSzRGkA
         1XiWv5CMag1KKKCU9iARUajS0pVh1isTUacxVniDayVuDcGr5QgxYV5HsUKqEs9JPzgW
         WbjLc4V9hBT0IcctcD4wvP4TofOKefdwro453NBYlvaYTMIuavr3PFOTR+07swEsBZmx
         oPZA==
X-Gm-Message-State: AOAM530rIYRUEdNfw1Vm1s3crU/oyx9Nu1MedigH7B+TQ9qqBfDyu536
        zMUhTOlv4kK0eHHXTeHAPCkMKQ==
X-Google-Smtp-Source: ABdhPJwqQ2aJIiM7EKW+gY82ckZLzZBXQcnNTkc7eHxf/nqb4I+6lr0SS/4d1jYIyyTj0+P5GK2Zwg==
X-Received: by 2002:a17:903:185:b0:141:f5f3:dae with SMTP id z5-20020a170903018500b00141f5f30daemr57078699plg.56.1638939794470;
        Tue, 07 Dec 2021 21:03:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm1452743pfh.219.2021.12.07.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:03:14 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:03:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: hinic: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <202112072103.D37C42F69@keescook>
References: <20211208003527.GA75483@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003527.GA75483@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 06:35:27PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
