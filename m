Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA5C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 23:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbhLMXbw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhLMXbw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 18:31:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C3C06173F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 15:31:52 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y16so21005254ioc.8
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 15:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=uiBzuM8r8ioHjMgApkzDHqgZYcstJX42l7Bsr3gpsPQ=;
        b=t5KKyEzSTtUdvvCmw8pHFWdxwwHEeHi16sMm9QZiOaro0uLwYZlgCOp7jr9Isys+M7
         5ppSfIhgO3I4V3FnrCcUhWUKUi3hta2TwJUoVWi5U9vMg8mYyhKXR2oJWeYCGzWLxl0m
         OyeX+DDiKPvV5Ty4Ax5UUv2RyIlC8B5JYtaLeef7oML7UPzpdZ5g7nvBA9hu8lrJ5b2f
         RSnpQJE4fYH7BEnjZp7t8cqXoPdJnHtediabkFbNzH//g56ewQBxdqMtjMIOxbFkGgZ/
         8MDwE0uHmsU9r9EzVDJunsXbPCOWMMmluNJfCEjVEEzJ7bnFymFDSG3CyKZAsfZ1K+bE
         bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=uiBzuM8r8ioHjMgApkzDHqgZYcstJX42l7Bsr3gpsPQ=;
        b=XoMrwsNLm90/aUzaDs4YYGRpF8Qq7wRx6wQ5YtcU/020xKKfwIqNOZGPGSVnA6DuhR
         p49ZGQRVcuW7TaFoQeo23TwfthGh7/uPIU3VbWxZEHbsd5uWaMx07pKPl8Jo+wwdc0VY
         kgdZWYqDUKNkqpuEnXjD5lwJ9AX9QLP92kJeMK/zaJZk1x/QvUWOmXN2xHYkd7wn5yag
         xoD9QStd68Z34P/I9bhGHea9tDAsqCK2RgL/88xzlJPRkr/PFX7m4uATmi1HmQlT6R/Z
         BH1Y41LTxsjjiqBcb2RnAGgi8+9xMcccRQYbgekwMMI55LgVOmutHmKQlc+Eego1kndQ
         NOFg==
X-Gm-Message-State: AOAM533jpVhM4Loo89HZC2/vXr5nMadSfj/3RqKqrKc2hhpuvUj6DVOD
        rI3PkG4uRpSIXVqLg/UPZOQ5IA==
X-Google-Smtp-Source: ABdhPJwZdCxAZbnRirMUyxwq3+dXPLxT+7soIgG+IIckJWFuR/FnyAlx+UYW7BSeafbgjw5za/3bgA==
X-Received: by 2002:a6b:7e44:: with SMTP id k4mr1203769ioq.103.1639438311104;
        Mon, 13 Dec 2021 15:31:51 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d17sm7780949ilc.79.2021.12.13.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:31:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20211118203712.1288866-1-keescook@chromium.org>
References: <20211118203712.1288866-1-keescook@chromium.org>
Subject: Re: [PATCH] drbd: Use struct_group() to zero algs
Message-Id: <163943830994.160816.6815884532342154175.b4-ty@kernel.dk>
Date:   Mon, 13 Dec 2021 16:31:49 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 18 Nov 2021 12:37:12 -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add a struct_group() for the algs so that memset() can correctly reason
> about the size.
> 
> [...]

Applied, thanks!

[1/1] drbd: Use struct_group() to zero algs
      commit: 52a0cab35c568f896067641d8e07f798341954f5

Best regards,
-- 
Jens Axboe


