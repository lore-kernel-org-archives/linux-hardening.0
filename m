Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B13C77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjEWRUx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 13:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbjEWRUu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 13:20:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658ECA
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:20:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6754110a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862448; x=1687454448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+vO/cCzHwQuFnPVrGLDZXukRrxNDu5SHC6BXOa81Zs=;
        b=hTrpGv/LdaPA65qPf/L+BSDkbT6zxNZTQPjO/67q6q9Xdc3oYNnP6YT9VTuIFvwA2n
         zzddg+xmleQpDg8/38lvv8BZYegLr+KluMOfzUuair0+1TpySYCCpJhlWYGOgB9PEhXt
         X+fTUDs9r+oaJYcBZwZTy6oX1F0dGqIStzIwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862448; x=1687454448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+vO/cCzHwQuFnPVrGLDZXukRrxNDu5SHC6BXOa81Zs=;
        b=KPO8YufnxmDJn/tv3NjrW9D8GgOxVlvkhCy9kW55L/2zFAB4cT21Cg7lx/+8tux6aN
         GNGDZnsP6acGeEvhrZMzlUr+7qOTSeUB3LepINqDyJbdr2YgctbpBlrGZhXpiloTuIT4
         qu5f8Zct8b02OaO+i80HTzCYHxYYzAuqEmU3XNILrkFOKWrET/Gi9Mwo7XFXBuwOk0Ku
         l4Z646L6kz07Ugm5TgCG+IqqOvQ+eV3AryvgxPuXFituN4ZGGc9mIyJ/tKmK3ZT5LG50
         cf67qDNOft2nZgH6VGSsmT8MF4Qm3rpzS105s9cpZzZINgpH0aulRD3jh1On9/CzvDNk
         Gjlw==
X-Gm-Message-State: AC+VfDzmy1z8Sp1B8DCxsB3cSBK1O3fY2i3nG1hiZZRMCR8gl0s+RipE
        N4OR0yF6KMtykE6l4ttZHev8yQ==
X-Google-Smtp-Source: ACHHUZ4P8xDP0TNAyj32JLK4hmrdVTDjOgl2B0qIzRYWdP+XmmGQKtfRjG2ZNIm+vY9oedRsM1SR9Q==
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id ju10-20020a170903428a00b001ac4a41d38dmr13144028plb.51.1684862448641;
        Tue, 23 May 2023 10:20:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001ae44e2f425sm7007182plg.223.2023.05.23.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:20:48 -0700 (PDT)
Date:   Tue, 23 May 2023 10:20:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231020.37C95FD@keescook>
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 23, 2023 at 02:14:25AM +0000, Azeem Shaikh wrote:
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
