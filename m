Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B5C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjE3XVN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjE3XVK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:21:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B76E134
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:21:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3734076b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488859; x=1688080859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7vYtyLdqVYJlU5zArPBdwQtjT1hwksutVKyiK2hts=;
        b=RtPOvBx3dMlTDpe5c0TAtd0y9Qiu8xj+GDcQbPfPV6YQuOZqmHe1nzftLegPTWVC0m
         mHLFvnsGa2fjECeOc1fJZ0mhJcVPVQJchWzNFW0Rt4Sq+TDlebqDgNKELlMzewvMrcVI
         ueVdwLUUz8VblSnY+SJnhGcOYbbtLKRK2O+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488859; x=1688080859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc7vYtyLdqVYJlU5zArPBdwQtjT1hwksutVKyiK2hts=;
        b=OGg7TlqCx93NCPJNFttc1n7LnWkhZPZCoz4xCMapYqBYEEe1oKb9dKcR6gJNFOHP5a
         TWfx/buaHolMrexdjuiMZcp/ntLP9VGR3c215qqbtiTumMho6N/7b1aQeZyYsjjqYc/6
         +2XKwheMJ9EetrUUWPozqK27SkKdBAp7ksY3x+NXIUTASW6kcaKrf8UtyLhz0bzjfFKK
         JD6/TgcV//9xNhr3HBmOOWFDBXCwCMaP29yXNP5CqDxk+TjZi1w6DnbkXpHn2HqotUGV
         HO4rnc4PeWf+Y8ECWldqzkDOOUA3j3bCOzZMjIF6qfemhlPzvPQzMd9qNASe6Zp58t5P
         7/NA==
X-Gm-Message-State: AC+VfDxoSSaYxJivluGLcKYezCcVpBex/knMQ0dfjY2mrf/oyxqGbPiZ
        6x4uRhAKZLJbjvgk+qlH6aEfKQ==
X-Google-Smtp-Source: ACHHUZ6/4RM2ME+yk788hdtWvOu/8I1E6GpaaAjTf2G5gm2Qi0K9bve9DfbijZUHfFnTHBAyzlxOEQ==
X-Received: by 2002:a05:6a20:8f09:b0:110:d78f:8156 with SMTP id b9-20020a056a208f0900b00110d78f8156mr4691119pzk.19.1685488859674;
        Tue, 30 May 2023 16:20:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm9362967pgb.70.2023.05.30.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:59 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Brian Cain <bcain@quicinc.com>, linux-hardening@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301620.52B9CAC512@keescook>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 04:26:08PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
