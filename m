Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB11EEAA42
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjIOEDg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOEDf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:03:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C698268E
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:03:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69042d398b1so401802b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750610; x=1695355410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdckIkCIpFym7NUpRG7gX2O8Kgm1I4+FpTJ9+N9Nf8w=;
        b=esQwlkVDCg0AEMMAu81jaIgDB7TJXZTvEYj+Lw0TbrqWJ4jCs5JfMw1ULHWt3w+0uV
         9i5eYpW39cdLGlAfLhH8ZbEruBai0g4AuMR372XYpbwmHAhJksMsvmSUbIgyPwlkVOZP
         6UOkm5iEQCBM/flEgnKHqAtkDZtCMBG06f2jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750610; x=1695355410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdckIkCIpFym7NUpRG7gX2O8Kgm1I4+FpTJ9+N9Nf8w=;
        b=SlvO1qGZt6K3KIDWRvY04pMXbld2ibMwkQQf9Kn7t57lOs7sfwRCgKv1GS2NRU7RDZ
         +R6AnxssNiz2yElUnYcli2BKIj5RUC0hd7j86yw5RflAqgB/+FiSRNipJ4KVOe1ph47i
         Lu0TIXRy1zi62tB6MezozKmxNcV9kp1jYitkJfinFKtXHk7/cwRpM2fjs91Mqs1acvZ+
         3R11j/sWhOZ4+klTQw7hDRphLpPVD2Q1I68wkthgGcdnYYqMpcdo9wT6D6YEr2P6zIge
         EZlKqd8yG7Y9/u3buCLNr3W8uJLduL/Cf8nG6cYx2nLTzDzkc7Taf7o1qzdvfcL8mSNC
         BeTQ==
X-Gm-Message-State: AOJu0YwJpgSfA4FjX9U2NKBLpxcfIufKkjF8tvej0Aj+JCoSLc8VPxg3
        qNPeW3tjnu1HsdR8oOmcuB1skg==
X-Google-Smtp-Source: AGHT+IEE1WYc4bw/B4ik03Qzn2D6jVmzYFDS1WbU6ybgM/bCKoZwSIktSE3iQqs/niV/77/brIgkqw==
X-Received: by 2002:a05:6a20:3ca1:b0:14d:a97c:911 with SMTP id b33-20020a056a203ca100b0014da97c0911mr866067pzj.5.1694750609891;
        Thu, 14 Sep 2023 21:03:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm2336357pld.237.2023.09.14.21.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:03:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:03:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: ti_sci: refactor deprecated strncpy
Message-ID: <202309142103.6DFFDEB@keescook>
References: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 13, 2023 at 08:23:02PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> It does not seem like `ver->firmware_description` requires NUL-padding
> (which is a behavior that strncpy provides) but if it does let's opt for
> `strscpy_pad()`.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
