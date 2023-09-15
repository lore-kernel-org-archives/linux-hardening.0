Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C67CD37A7
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjIOTnD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjIOTmo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:42:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018351BF2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:42:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf57366ccdso26214645ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806958; x=1695411758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=WaD0aTyDH/uutpVV8adNXlYXUhfqEf+U/H86LF52FutN6nw4UgSWcRY+/j7ENhjbgB
         VZKLGelUiNKYNJF8jZ9sfR2Apk6zSj4CWlFuxMeqBbV8lWkuyrkE1LAK8gEaaraW8g5a
         YitWmqcEfS43fv1RxMxGnBWFAoFAIYXmX+Do8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806958; x=1695411758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=RrurYcRDO8C+SJCZ5X57IJbLZOgE5T+wWjS8ytSBz4aCIp3RRmdUdtJ4YhMuTmlFoa
         IeqYk/l81JY5PrBQNF2EfygUmptK2NwojvNdR1R+sqUXqjctEartWOY7N2CmddRNoFXr
         yGHJDVdLzcjkSzxpBNaTgFCcDi5MFC0XFV4JoxvJrJIwSqqdgmVkJxOe0F10X9zGpZ09
         GuSTkIU4w+HkdHOhl8D/6gv9fww1hV8HNbWT47/wDYmOJ2AdPndd2ICzwB3HV0Lug3Xw
         1d3FhLMMJ1fPfmLeXYNN3GTOc+BWnVFM/xFJC0BXNvhyZ49shNtPH+IQQ7xP9xwcshx+
         qMMw==
X-Gm-Message-State: AOJu0Ywj+joDig4c+USbI8He9pHchbgdCtc9G9x4abZV2Z7pO+3Kxv3e
        pfMh/ViPWhT2HsneH/l2+Eh/YA==
X-Google-Smtp-Source: AGHT+IERfok0jFzZlZtdhSIeue7UAgumLdb8qFaPg7HdEwWvabfB1YwxclxmfbPVjycC8GbPAfm1aw==
X-Received: by 2002:a17:903:110e:b0:1b8:8682:62fb with SMTP id n14-20020a170903110e00b001b8868262fbmr7918269plh.4.1694806958504;
        Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm3831900pls.146.2023.09.15.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:37 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:42:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tls: Use size_add() in call to struct_size()
Message-ID: <202309151242.BC470261F@keescook>
References: <ZQSspmE8Ww8/UNkH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSspmE8Ww8/UNkH@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:12:38PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
