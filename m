Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73E5EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 23:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGLXhe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGLXha (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD14E5C
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:37:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55c85b53219so153621a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205049; x=1691797049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MJhlCCo0nBuKwoH3lOtwuzRsq3KnF0aXQAOXaQiEk0=;
        b=Ad3IgX8TsrFK9VXenjB6zUxxThDksIJWRbPMMX5M7ri99x96lFJ0HCQv9ymdH2k7Wj
         nVnXq+BDRfQuKkQDLKbi/GOqnEg9H+FOKuUYlOq8301AZ2jdKnxyVBcLd808ygRp6ZIf
         8ZvnPVl4STi4HNWXM7N30sB0LYx1Kgg2D/GKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205049; x=1691797049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MJhlCCo0nBuKwoH3lOtwuzRsq3KnF0aXQAOXaQiEk0=;
        b=FcmbNnndPRoA41ZBdLTAlp/WxkSkfAv9zoUbjKibc34GzFsiIffGMkh835N2YX98x/
         whbALbGd8QnA7ZJOZASfkgN/nhk6XSgEPb+MMLxQBnyTGNVP9cl4xmCAYTj0TLyq140H
         vKF9cGmOpx+gt4wdzF9vSYz8sS4YMVmOAkDj+wMjKZOGTSlRItfXlFx/axBI6nxrVQPG
         XboRHK05xn5XVzPNOrzCO5ge6eY3I3bMqkHPWOFPUZXifZbbVS8MaGWto+v3SuNbYmKR
         xyedwGDUpZVnkfPQ+v/kcj+qKcWJY2VBkSXIwhLT/EON4LrUf7OKxBtywAnUTHnA2zeT
         3puw==
X-Gm-Message-State: ABy/qLbVCfCskG8EGrUVTCTzOeVU90xCpmILUY5VoELXl5EXPiSaSKSQ
        rGVNVUrCTQlZ/oi5YW/OYFooKQ==
X-Google-Smtp-Source: APBJJlFKuVyIJ2dqf3PmBW0kmllPn7ODpA6BH6gvye81w1ha0sM5OKGcmDzJSc9wTyvjKq11vposcg==
X-Received: by 2002:a05:6a20:841a:b0:12f:f9af:3a2a with SMTP id c26-20020a056a20841a00b0012ff9af3a2amr21083174pzd.54.1689205048989;
        Wed, 12 Jul 2023 16:37:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a62ed05000000b00668821499c3sm4106048pfh.156.2023.07.12.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:28 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:37:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/max20730) Remove strlcpy occurences
Message-ID: <202307121637.05F0B4C1@keescook>
References: <20230712214307.2424810-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712214307.2424810-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 12, 2023 at 09:43:07PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with direct assignment.
> 
> strlcpy in this file is used to copy fixed-length strings which can be
> completely avoided by direct assignment and is safe to do so. strlen()
> is used to return the length of @tbuf.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
