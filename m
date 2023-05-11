Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09FC77B7C
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjEKQ0N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbjEKQ0M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 12:26:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F9FB
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 09:26:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf21bb427so63827965ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822371; x=1686414371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFE6EmlE8h99fLdr/n78erJnKE49/4tug0gzOrRNkC4=;
        b=EykkaEjgbAGDvabHBLyWwMb5BAmPVn90y9ZuwrOrcyra7YiaUkI9aV5h2w1lCQ37o7
         fFGwZbZxXs1vpisb0PJBT57PCO3eTyqHbVObO3K1AvlePcvsae6uSA3oFs045YJS57tY
         9jMnxtB9ysCQBRTDrq10wyatmNMEGxhOlioQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822371; x=1686414371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFE6EmlE8h99fLdr/n78erJnKE49/4tug0gzOrRNkC4=;
        b=awk6GzwNJzlJw0UFhgZ10GBJdZM/z6JRvXsXwOanETSL+mQ4b7y0UqdmPaf9KKXBSd
         Lv1QGVH8524kw4cfvZRo2EpbFjoEAY+r7Y3E1RwOFYBSYtDbHsieT+NgDYtExDuhKpl2
         Zma/9nYeCsvtN1W8SkZ0GWakpo9JFyt3/B2CyZyhxxVuOfKguiWFSYXD0tKL4MhQcaWQ
         1lUSplRGL/Yx554X7leZF8HTk9G8tOEmeh1RYpN0ISIAGfbKPEkgx+Cr91J1+bQ+IoeA
         2NA3ykvBx/zOWESZuVLm/G8Nu4FzLPch0mpU7BRyHHyb34qsX2WuKOExL1fTp82RgA8i
         rFpQ==
X-Gm-Message-State: AC+VfDwne8eq/Az1uT7t7sdfl3aYdksXX0qo0dobvBHadkaM6hgcREcL
        g8wNscRaLuP6gnDr06T1jyXB+g==
X-Google-Smtp-Source: ACHHUZ7YjRd0bUpXxDJX4dIe0JbB/PRyLu0ViHF56BI+ScwquFW5Ze9lgc93oetrShHB7yrf9gYNCQ==
X-Received: by 2002:a17:903:1d0:b0:1ac:7624:51d7 with SMTP id e16-20020a17090301d000b001ac762451d7mr15220371plh.69.1683822371220;
        Thu, 11 May 2023 09:26:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b001ac94b33ab1sm6137598pls.304.2023.05.11.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:26:10 -0700 (PDT)
Date:   Thu, 11 May 2023 09:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110926.05E8FBD7E@keescook>
References: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 10, 2023 at 10:11:19PM +0000, Azeem Shaikh wrote:
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
