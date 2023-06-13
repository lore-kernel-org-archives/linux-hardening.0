Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6090EB64D8
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjFMTZl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFMTZh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:25:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734E1FD0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:25:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3d800f671so18146105ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=Vuk5lprGVMjZyBqOAnxPZ1cP0qnAz1VOxXLVHd6COwWrk6uWeCNnFqJLd5ZlTB4xBN
         dzgZf7Jh9tixFAfZz3fmSPAlXZ/It7xgz3OZdv0ga4USAGY4venLvhA6oqd85Vcqq+o1
         kX6/a+xeL6i8dTiBdduqpe2IX31UD9Xg8A/SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=CTIGl2IZMGVlb50m5pCD0fzSJCpSXjTUWs9igz+O49FoUb3hKX4XxrqvQGVKqPC01B
         c2gfU4MyUbMbRAA3TfpDl52D5qgSqxT9JUbDi70sRBriaIsDv6x/mNnM06pXfgoBcomc
         60VZQ/0nc9bFcrm/3XdJgErIdA38nlADC6FOobPic1ssGfmW5zDW9Dy19sOL6WEDhUZ7
         uZBq//tgAizULcwx62/fbS7SmcmKScVZoHS1IG8yduzWuzttSMrSofUG3EYxnm6fBFuE
         sybLgFvs+CRRRz8U7RcVy7sMGdC6+3GP8xIq8CdNjYlU2ymGwTifNMGv80oc7tkSDdSC
         Ebuw==
X-Gm-Message-State: AC+VfDxOcSOvWKCHpVaiHWwmso8u5Kl4vdk/poQvefJmHx15ZBaKhqHA
        Kkd1HYcfQIBn2tieX2IPuq2bvw==
X-Google-Smtp-Source: ACHHUZ7qXyztF8y1MkcPh+Rc6qnYC3E972aaXz8caME05mHnNSqufHjosMNobu5acZ7aPD5pnWR3Bg==
X-Received: by 2002:a17:902:e887:b0:1b0:f8:9b2d with SMTP id w7-20020a170902e88700b001b000f89b2dmr12528414plg.29.1686684325037;
        Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902f68a00b001a072aedec7sm10714545plg.75.2023.06.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:25:24 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:25:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-hardening@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: Replace strlcpy with strscpy
Message-ID: <202306131225.779997E@keescook>
References: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 12:33:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since the return values
> from the helper macros are ignored by the callers.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
