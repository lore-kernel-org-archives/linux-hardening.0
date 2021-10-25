Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D499C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 22:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D346103C
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 22:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhJYWp1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhJYWp0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 18:45:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FEC061767
        for <linux-hardening@vger.kernel.org>; Mon, 25 Oct 2021 15:43:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n11so8930971plf.4
        for <linux-hardening@vger.kernel.org>; Mon, 25 Oct 2021 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dtMhbuSIysj6diw4zMqJoEHPjXJLlusGYlVV0o/QwE=;
        b=Osd0NSgC1pcBMCS15+zN/gdtj7yePPzh+HndQ77zNZkpsLdMfoQuAIXBeodIVNEWLk
         PznPXgY+MHZcYYYT1JPuvHEFjO0WX861MtVJwxtJjDw/c3pJLGBs9R5r3yRwJFkR+fpw
         oeMvYKTdbbxHQle4O7DBZvJW99bx676XOo/Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dtMhbuSIysj6diw4zMqJoEHPjXJLlusGYlVV0o/QwE=;
        b=0D3Jnl3OxHvU1vCYCG1gOrmsuYWi5yVSmy8fLB85FrFrCPsaQCGcpwU6cOejOE8wgZ
         8couwJBj/7arXdDYVir4tWtMp6+qwijm/lNEGnRHhtvOgVw8KCfAXE+u8VN6yIHWIVgs
         kZK5wRiSy2zXt86eqmxaBGuQKndl+WqqovIFeFe2O/aH5Mz5cVp9vhA8nsTT7lZnnQuK
         yACinjtZLImbZffghx1TiMt40p1M5KjGY1KK18hCsptRXiqHK8xoJMGd9lQUYKu3tQ2Y
         gu4mcAtOJi4jTXNa6JGxZ7x8v6kqGW0HHPN+wZvTFQj62FOkdl+WkuydLUYo3KA3B1gg
         9k8g==
X-Gm-Message-State: AOAM533pis/gKbm5nQt0DbmACxntV00zQ8xTxcOw77135C3rX89Q4BST
        TxELeYDNPZouDadHtijAgeJyRA==
X-Google-Smtp-Source: ABdhPJzefObLbgVGgmk2ZjsW2/mnBC6utxGsG3p2cPD+nYeoyk1eFuzgkPnzNJvQdLnYDVkshJt0NQ==
X-Received: by 2002:a17:90b:84:: with SMTP id bb4mr25775233pjb.2.1635201783745;
        Mon, 25 Oct 2021 15:43:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r25sm16576281pge.61.2021.10.25.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:43:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fortify: Avoid shadowing previous locals
Date:   Mon, 25 Oct 2021 15:42:36 -0700
Message-Id: <163520175414.1020299.2890966678849139996.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025210528.261643-1-quic_qiancai@quicinc.com>
References: <20211025210528.261643-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 25 Oct 2021 17:05:28 -0400, Qian Cai wrote:
> __compiletime_strlen macro expansion will shadow p_size and p_len local
> variables. Just rename those in __compiletime_strlen.

I've adjusted the changelog a bit to have more detail.

Applied to for-next/overflow, thanks!

[1/1] fortify: Avoid shadowing previous locals
      https://git.kernel.org/kees/c/95cadae320be

-- 
Kees Cook

