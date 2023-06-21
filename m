Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8DEEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 18:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFUSJ7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjFUSJj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B51BFD
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:09:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4596402b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370970; x=1689962970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpKS56YO6XbOetsyWxaBSPZDOmgSxMxVtPPYv6jOKso=;
        b=WpfCWUZeinWi6yBfOIp9eK9fHXs7y3W3CJxsQtCSOL+9ZJwB0cQtVvWzl3ZSl5sepC
         i8YdFlaS/9XV2Wg82MTORgTzlKtBK9L3i4E7/JP/EspwhuDiKhg/9DOf/2Ze7SBCgZUr
         JH8SptsFhYYmhcpQYU+FifKw1N6djtiAHyt1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370970; x=1689962970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpKS56YO6XbOetsyWxaBSPZDOmgSxMxVtPPYv6jOKso=;
        b=N+gNuj8ilfPvgrjKgizrsQYBDIPfxLqD6h9Hk+Fm2pVxmYL9DkA0OjMbO+u/WMc4r+
         +S6atOsMopsD4v53R7f8tIQDdpLiLQ+MROGglInACTNzT4IwbHBQ8FR2DMncG27lGOi6
         15H3if+kiPMMl+Exm3vUZBZYG8kYiulqR5dpohOHJHvAUvBGc4uGKWu1wxMHARsjxTDv
         I/TPfTPN75shPSBFtjTYKNGZ+jRhfjVU0IXKiHNSJHfTC95wMJF6fSEF/ogWMZOMtFxs
         UT6zdR/WFrowO+Axh9ZlN8PydbJp/llH538+n5ZzAiGiyB9KxqRTXYdOywkfZuNziwBM
         iXOQ==
X-Gm-Message-State: AC+VfDzri63XXPHXHOGfOplrAwVU9OKQ2vObXD0RttjHyixpt0cWIobs
        +LeYDHitV3sIZjIEBlvJlxvn66lVIirvCmgj8ts=
X-Google-Smtp-Source: ACHHUZ5FjO//3o1cxickEcjMVH4iLi4UrTcCcOnvUfVCxJ9QqbIqUza86v/28jUXHMQakR8a5uMsaQ==
X-Received: by 2002:a05:6a20:429f:b0:122:24ed:f77e with SMTP id o31-20020a056a20429f00b0012224edf77emr9558877pzj.33.1687370969818;
        Wed, 21 Jun 2023 11:09:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b0066883917159sm3191586pfi.79.2023.06.21.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:09:29 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: Replace strlcpy with strscpy
Message-ID: <202306211109.1D5C9E2@keescook>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
 <20230621030033.3800351-2-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621030033.3800351-2-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 03:00:32AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
