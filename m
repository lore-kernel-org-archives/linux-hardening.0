Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5AC7EE2D
	for <linux-hardening@archiver.kernel.org>; Wed, 31 May 2023 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEaQVt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 May 2023 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEaQVs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 May 2023 12:21:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F712B
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 09:21:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7757912a0d7so29761039f.0
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685550106; x=1688142106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg+/RwjgAOmuS7CF1LaIbSlSxY/uKBLgXsnl2EkkK7k=;
        b=E4TcNKU3cNdfY2ktgFq62wNxOPeKBNKmHA3yKEXTCab0bm2UE3Oj4hxBs99EjQfBRo
         lc/eWGxWQMgtPaeTBZYDDszDeFBL1nMMQFK3ECeF0M0Fd43+vgu5lJcQ+I/gDMc3st+N
         kYu8uwZCISnSzIG8RRQsUw4+kFRXZCtLb7mn6VoxBILAnN5K2JyU7BEbKVgb2mLUl6xA
         yMzQqELcEVbhDeU33AB5ipI9SChFC6tqQjC0PI/uFqsAuPPH23lHnDTmCEsBiYc7Yukw
         qog/3QUJsR+T8G43Y/Ja+hevdBnfNS9cI73yw0/UQ1lht8AGRySuGrJl6/Sktrsq9TI6
         dYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550106; x=1688142106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg+/RwjgAOmuS7CF1LaIbSlSxY/uKBLgXsnl2EkkK7k=;
        b=RmM/DoHKTwJi1r+/8V3eglgYQUxi8U1UDN9gbeGP5RZJ2gEvZreFtK7wN8d3o0cLxM
         +90b6jpwkUOIx6tYfB/R4XXulVZNJGNrTtc7w0FKIQgfFmVYhmoRZGvA7amxGhrE3kZh
         U5WYC1epj/Ia96sa0l+uwMH/2wMTgd9GxCONgfXZhtX/pPkVJGR1NjvxbjfvH38UJzka
         KiqwDp4TV2dOyHn/WsJLpx5QZBO4OFs3un3tZI6F/wgvxjlmQQUW8vstuu8P+hYf2Veb
         FWy1jay3ilpzSP5skNdZEQsLWPSu/7FXP8pXwIqaMI1v4PB8SRSC+TL5MFqPfVy2pfZP
         rnKw==
X-Gm-Message-State: AC+VfDw301XvHpFieoIfmwfuNhccZ/OJriUVzCmL3B4Vm/CXRtVhAtQF
        it1n2/SpHd5uzQInLgX9htN4rg==
X-Google-Smtp-Source: ACHHUZ7GTzr9QD+I+vo+zw7ihxMJan5que1vsiWmGxti6PhH0u6IJbyHy05bhK4+ZjTcZ3qoKq1pRw==
X-Received: by 2002:a05:6e02:20ee:b0:33a:9887:ad6e with SMTP id q14-20020a056e0220ee00b0033a9887ad6emr1697813ilv.2.1685550106535;
        Wed, 31 May 2023 09:21:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i19-20020a02b693000000b004143ffd4399sm1503313jam.39.2023.05.31.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:21:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530155608.272266-1-azeemshaikh38@gmail.com>
References: <20230530155608.272266-1-azeemshaikh38@gmail.com>
Subject: Re: [PATCH] block: Replace all non-returning strlcpy with strscpy
Message-Id: <168555010526.195181.15421490997743979443.b4-ty@kernel.dk>
Date:   Wed, 31 May 2023 10:21:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Tue, 30 May 2023 15:56:08 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] block: Replace all non-returning strlcpy with strscpy
      commit: 8e8fedab1194ef90e007636eb3d224c4f8e979a7

Best regards,
-- 
Jens Axboe



