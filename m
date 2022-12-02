Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E44C47088
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLBWpF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiLBWpE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 17:45:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41FEFD3A
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 14:45:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so9596421pjc.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3g7XrbFOHXQF84HyWbDjCgysLpIstvnI1wUbPPgABA=;
        b=At5haCX0bqTar1Hvr2E7GoSlV7BYTAzAoBnBeufNfeWUPuu09XlGeBfDcuw/woFlkY
         MAoYg7cSqqBrvmZIlUR4mg79NpZQB1cl7vF86cvnp0qezdTmFYpkd/qQMQnSfY9IxEe/
         z9DsxCTVoqnv9k7Tp1Bfu6zCgoi/tXo1diHYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3g7XrbFOHXQF84HyWbDjCgysLpIstvnI1wUbPPgABA=;
        b=lvEkN2JKodmG7+N3Y4pPM1YBCeO6PJl0Zkqqa/OtqWz4ie4ggv9sG1+L/HrrwmW4s1
         5f2RGxsMEfprhijCDsITHx6IUUlvy/M89NGHVAduEQxx6UZUkaxRjweglNSVpT/MgQTr
         u569GDd0O5tGznVsuHSHO6veukpRV7lZYyhvr27AKqzoQqNAFkTJUBWd+XkSBP0+kVVG
         SPeRS8vm8HlzCrCVvdskiYtZTGAYcgL6Os5XftcqtNYyJdKD1AOlkXezQMO073N4pazC
         4yKIN2w35DSsKjpkfIEqomicuxsIwTEBnI7pfGGwlj63kTrGBQcm8EIao5o7SpVepU/l
         K/Ng==
X-Gm-Message-State: ANoB5pmox7hEjZijEflZb4VSxkm/TSBQ8FnzUhfP2PaUhY5LSy7vGzZc
        0WYa1Jj/koTc6EAO8OKloicEZg==
X-Google-Smtp-Source: AA0mqf7g/vrgrIfaXm/Vy5WBdrTrf3KHzSxktB9dINYAefMkQIEOxE769QQVIaD8W9k87/+oOB4Oew==
X-Received: by 2002:a17:90a:2845:b0:219:396b:75c7 with SMTP id p5-20020a17090a284500b00219396b75c7mr28120993pjf.41.1670021103201;
        Fri, 02 Dec 2022 14:45:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t66-20020a625f45000000b0056abfa74eddsm5749253pfb.147.2022.12.02.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:45:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:45:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: add F_SEAL_EXEC
Message-ID: <202212021444.3433C0E5@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
 <20221202013404.163143-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-2-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:59AM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> The new F_SEAL_EXEC flag will prevent modification of the exec bits:
> written as traditional octal mask, 0111, or as named flags, S_IXUSR |
> S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
> any of these bits after the seal is applied will fail with errno EPERM.
> 
> This will preserve the execute bits as they are at the time of sealing,
> so the memfd will become either permanently executable or permanently
> un-executable.
> 
> Co-developed-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Oh, one note on tag ordering here. Since you're sending it, I would
expect this to read as:

  From: Daniel Verkamp <dverkamp@chromium.org>
  ...
  Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
  Co-developed-by: Jeff Xu <jeffxu@chromium.org>
  Signed-off-by: Jeff Xu <jeffxu@chromium.org>

-- 
Kees Cook
