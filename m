Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70EC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Apr 2022 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiDLSgN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiDLSgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Apr 2022 14:36:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E74EDF5
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso3821768pjb.5
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIORrv+/2LRk4nx6ozs3wWj/aKmJXy1Yh96OLl5WUNE=;
        b=T/14KOgusZu9tE7Blvj716S2MXYnWYGVXdWWFu+K6ZQDeNHFwkMMIHNUFluS3bodzj
         /tNQdZvWhxuJ0PLZ+WAjbo9t4/nnirzb7Ha22W5twpHPDukCX+a7chuh2iMg/+hoCCnq
         EvOCgHo5h9VByatHhCI8kqXmIR668+T8d9bj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIORrv+/2LRk4nx6ozs3wWj/aKmJXy1Yh96OLl5WUNE=;
        b=0zM03meBZOfGkMw2U9mw8dKha+96nDU3208EH9YbAqCL6r651fwZWXjkGOkB4XKLT6
         mikfDMDLr+CcnYShHZaAKwyIGRJ9uD4fwnU8VJh9aARlXPQO7gWgKj258d4wUkOZugni
         tpYkS+IkrKow5L8r1RDI9psAURceOTiKDQ3YzpdsS+AvwcMuik2GjEwU4BdAPnuKU5Bv
         SBStXCAFcEB/EY1+E3vxaffX2ql2GU5OMKvfyVeIfBjaDCPvVh6TFZoxkvcctn2hLJFw
         PLkNSDdQFXc6EazKcNoGsThxAKpqOicsbZUCLnc5NSGowg8cUf1r+ZWgXmOO95G6doUF
         l2Nw==
X-Gm-Message-State: AOAM531El9qYAhYRWSQHc2g3DclUrqEGdmUJjuebCQmj1PidfZZYvQto
        4ALhvuodeuiE2DBKP4WN2Pv/+g==
X-Google-Smtp-Source: ABdhPJwqcoomSOwjtJV29/CjOi1tnfkh4AfcHk1QUOr0hmpLGP9VH5eKPVzKPHi8RM6bXgAHa+o/9Q==
X-Received: by 2002:a17:903:2284:b0:154:3b97:8156 with SMTP id b4-20020a170903228400b001543b978156mr39323752plh.95.1649788434440;
        Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j18-20020a633c12000000b0038204629cc9sm3597529pga.10.2022.04.12.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        PaX Team <pageexec@freemail.hu>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4] gcc-plugins: latent_entropy: use /dev/urandom
Date:   Tue, 12 Apr 2022 11:32:48 -0700
Message-Id: <164978836579.3579300.2356881730976056198.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405222815.21155-1-Jason@zx2c4.com>
References: <CAHmME9pV4SdoSyMq4kax3w3Vu1nPxjO3faCZKq8d0RDo8t731g@mail.gmail.com> <20220405222815.21155-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 6 Apr 2022 00:28:15 +0200, Jason A. Donenfeld wrote:
> While the latent entropy plugin mostly doesn't derive entropy from
> get_random_const() for measuring the call graph, when __latent_entropy is
> applied to a constant, then it's initialized statically to output from
> get_random_const(). In that case, this data is derived from a 64-bit
> seed, which means a buffer of 512 bits doesn't really have that amount
> of compile-time entropy.
> 
> [...]

Applied to for-v5.18/hardening, thanks!

I dropped the version number change, added a pointer to the GCC bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105171, and noted the
rationale for the buffer size. I'll get this sent to Linus shortly.

[1/1] gcc-plugins: latent_entropy: use /dev/urandom
      https://git.kernel.org/kees/c/c40160f2998c

-- 
Kees Cook

