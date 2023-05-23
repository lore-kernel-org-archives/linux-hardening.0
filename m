Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D667CC7EE26
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEWReE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjEWReD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 13:34:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B1B5
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:33:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae58e4b295so50301435ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684863216; x=1687455216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5TaiMEFaVRXBBXmrOT5rVhJkyEwfpcOBFjZH1D7ygU=;
        b=Myk//XnL+kcfvxEiu6r+DEazWtDYHot8a7HGhSgrCLT9b1EVVnsag052Ai+KzdXHoi
         1nNww3UZcbHk7SCmfSTINJ4IyaPi7b6r1OSROire4HNLINsmBtaJWqinJ6DoaLbeUtTW
         /UxiVGHhvdzOV1dasHhaBpQAj/fGwcY+PYVKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863216; x=1687455216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5TaiMEFaVRXBBXmrOT5rVhJkyEwfpcOBFjZH1D7ygU=;
        b=gOvR5NIWkae1Dhn1ljqjHHvm0JSYmjTaMQRfPvSY5awQvxF8aHOKZKM61r1e3742QE
         neXj/kqEdgBKmDezkSv0nXAEdSBHDTTfYVG+FyasKgPy0vXxXS8c1Z1zwKFD/7mWDbG0
         AlTbgAMFO4i3CRnj+Ro1Fx6EJS1HKO2wlGsTlprk0+EadIflu7y+jtF54jjv6mracFvi
         Bd3Ih5qATX4l7EVE9lqK9EX6ETmoYeYwALnhjizvtScBwrbxrI9yPhlwrKp5Dyoc4UQN
         pDOe7PFhJaNZ1fHntaHlPCxOIiebuFzx8spkUZfbqglgKexoIsUbIJu6sxWsORyltaxW
         Th0A==
X-Gm-Message-State: AC+VfDwCJajoxYws+KdyBLWg4Fs5aS/BuBxzGgnqLmuLzL3ao3bQ1LVT
        l0Ik3IwNSDjCcs+m5FPQtB5zEg==
X-Google-Smtp-Source: ACHHUZ5nwNAWC6zOqEQfgyyaEtHV6Q5KAnW9bk4XY0Mad+k3IZZq1+L248juk8kAqBZXvMIP4RNNjg==
X-Received: by 2002:a17:903:248:b0:1a9:3b64:3747 with SMTP id j8-20020a170903024800b001a93b643747mr18446929plh.17.1684863216117;
        Tue, 23 May 2023 10:33:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001a2104d706fsm7052433plx.225.2023.05.23.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:33:35 -0700 (PDT)
Date:   Tue, 23 May 2023 10:33:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Message-ID: <202305231033.2842F1500C@keescook>
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 23, 2023 at 02:11:50AM +0000, Azeem Shaikh wrote:
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
