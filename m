Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573BC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjEVUPe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjEVUPc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:15:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDF119
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5346d150972so4727075a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786526; x=1687378526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdrje6wvnlDZ+Z6wbd9zxIlTwzeS32i409hLZznOFcY=;
        b=IKgGDbfMAFcTW0fCraBOWKLWmKW3iVgSXiA5H6aqBySMQvF33LN3e/4WaaVBfsNkiv
         rlwvatxvFaLKPYJiJOQxmwX7qux9hU+DbTGFv0sTcdeK2WbWfEGPKqRy9tINpmr6Gs9P
         +LMTABtMt4FGiI3+DOzwVFbwur7RscLj5yUcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786526; x=1687378526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdrje6wvnlDZ+Z6wbd9zxIlTwzeS32i409hLZznOFcY=;
        b=N0i8g4hSpco4pVviv/DsE94jwXUpqHF+NjT5K7JmOot4JITpcU+MZMJQnx+apApz9H
         4byRNXVsYPznmCwVX2lHJPMXlvXvPmUDrkT/XfzvTQqf0A0e0LWD7/Cw97BrufoFbktm
         hVbaioev2AW6bg3RJJ9JPLN0E/Omz8C4vtmGwormqZ+eLAtN6HjLgDxNkrlIEk6WLYrM
         D+csBGEXAg5ymdaWXZeLrFLQiRCBxLKe0ggwQY3ZnfnGfledv4ZF+yFnYNHdf8VX9Tcf
         VZJlPvcVuu1uvjucJQeYY1WktsiV3V7ZPQ+/FyYTj4+TOd1yYPJbeCtxnVdmv0IY4VZ3
         TF0w==
X-Gm-Message-State: AC+VfDzqjrGfVlF/DhwgwjhoYC4cu113Yn8T8Oivhy0mydevLP7xRDm/
        +46Jw52welN4saL9iNDWfD6BEw==
X-Google-Smtp-Source: ACHHUZ7wj/gcQ29SqjtFdOT9i9jtD3FakkeSS/upmgojrQC0P7/HF13gNCI198y84KiPEaHhCoJBeg==
X-Received: by 2002:a17:902:b288:b0:1ae:56ff:74e with SMTP id u8-20020a170902b28800b001ae56ff074emr12788781plr.9.1684786525810;
        Mon, 22 May 2023 13:15:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b001a6ff7bd4d9sm5339234pla.15.2023.05.22.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221315.B1E5C7B@keescook>
References: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:51:49PM +0000, Azeem Shaikh wrote:
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
