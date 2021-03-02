Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648CC433E6
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Mar 2021 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB8764ECF
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Mar 2021 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhCCHWs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 02:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382687AbhCBW4C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Mar 2021 17:56:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F67C061788
        for <linux-hardening@vger.kernel.org>; Tue,  2 Mar 2021 14:55:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id a4so14882120pgc.11
        for <linux-hardening@vger.kernel.org>; Tue, 02 Mar 2021 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzpUTsgKH5OxhHkG6eA7x07tUVhj7iVZ7Jw5z2KPfUs=;
        b=hBTURCh0z5/YZpqXwY2Z8Pc+7K7f0gcOD49C1C8rHpZh7SHn4oz95yNunNRlL3drfW
         A+wRSnEANH9mnquIwrpekIfT+2y4hNjg7kxBF/CC3TrhxtkDA31M1J+PygB3941Z+Uv8
         2AiB9easEjwbCly12NeeBhYlDTtLo39fJgyzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzpUTsgKH5OxhHkG6eA7x07tUVhj7iVZ7Jw5z2KPfUs=;
        b=R316yF4MNq41w7URq2w5CeKKYfu8JFUrquBMMBg/CEjAUCME1zeoes4KsCEiarob4N
         GJ306pk8RBWJMampIMnLUcyhZE7rBh2JNVuk+cKQUGRcI6uquoTSfA+PtPc+/DDqYyZg
         TCOYVdJN3AsWfxnfDGK0EVw3325/eX6fHbNpScTlwuBPy3hC2bWS9gbIqtth6qMCnS8B
         GCwLcqGNy4DzrDShyA8jOceQJTxTHgniC1jlq7r6x2mkTZRQLR+mr/MQc5mmV38lO8jA
         zOwfC0WdliziN9YAoHgeUyu4dvdtcIVGA6iVtGYeiJ+fymoaI+5ydUZ3dYhEySFpkn3P
         QSBw==
X-Gm-Message-State: AOAM530gE+TowUySJVraHOnlWRZ333lFSdwEiKtb2mZ79S/2/81OKK1m
        Ugi7o1Fh8k8oO/bhRworztarEw==
X-Google-Smtp-Source: ABdhPJxL3PDqshkuC1AAjV4vXEMzG1xytC8Vgf5zwDQxOhGG0a7xSQlvwwS/wpHTLHJmdUQReHiQBA==
X-Received: by 2002:a62:b515:0:b029:1d6:aba1:e22 with SMTP id y21-20020a62b5150000b02901d6aba10e22mr5201588pfe.47.1614725713983;
        Tue, 02 Mar 2021 14:55:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm3309818pfo.167.2021.03.02.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:55:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] gcc-plugins: latent_entropy: remove unneeded semicolon
Date:   Tue,  2 Mar 2021 14:54:18 -0800
Message-Id: <161472564886.3871405.9093502047975131970.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418070521.10931-1-yanaijie@huawei.com>
References: <20200418070521.10931-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 18 Apr 2020 15:05:21 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> scripts/gcc-plugins/latent_entropy_plugin.c:539:2-3: Unneeded semicolon

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: latent_entropy: remove unneeded semicolon
      https://git.kernel.org/kees/c/5477edcacaac

-- 
Kees Cook

