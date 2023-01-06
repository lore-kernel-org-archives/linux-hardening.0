Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5372C3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjAFPDw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjAFPDu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 10:03:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622EA49169
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 07:03:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4028103wml.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OwdKfXK+SNVrPvVK8uWPY9jI3lOu8t40smt1t6yZrc=;
        b=Z/gQJZss/OE/GRRyOiHB4/SFRKQvqNos1nrrpmF/NfzoZ/5zVb+pTRHQ0wnXi0IMV7
         qMLVKBtUWcR4THNiaBTMjFUS1P+UGbTHYyF8d4LFly/TwSdPnotCTdDqZUEUQLPLlDqf
         4jxQ4xK0Ssv28TozR02aKtZ97p1nV33r0iJzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OwdKfXK+SNVrPvVK8uWPY9jI3lOu8t40smt1t6yZrc=;
        b=3s7NUqPFKcymjhpCuNbv92zqHhO4MGL/6vvM8sWGC9DuBq5hyG7zO6W7X1NEy9sq29
         NJkSemnImfogNUlKR6bYUHQElLFvHPWGPNZwNSru+s3TjqXUX/jYJb6esvPCSaGe54mP
         yjiR4dZGM4jltn/JS7J1OF+u+qj5Fee1iTuegQjiNATRabM9bLWLHwCPfV5O7euNh0wb
         F1Qcw5SeDfzekDZmyIaPkc20lihv2D8C6idozRzwq28y6fROYVAdpgOQFXGTy7lOFG6r
         gfgL8mUq6bZCCSpgd4BD7UWdiisi0mvpQHnD3oWSqzH6wH4mwJvRmVHx0XAobo6h5VAk
         l5WA==
X-Gm-Message-State: AFqh2koeKVo+R9YmVHx6zgL+427YwFG+J1aSungTqt6880LYFZaNzb6W
        F7zqI0luD7Ce+py8jTxcAOb/qt7OUnDxtPly9t2dQg==
X-Google-Smtp-Source: AMrXdXvsNwItCisvp7fzc6VLVmnUJvtQuVploPMux0GmwOPd7GZX7XpZtI7ovjzBP3i8v0d4UaGM3MYZAlmvih2v0tU=
X-Received: by 2002:a05:600c:26d5:b0:3d2:1e7d:f9ea with SMTP id
 21-20020a05600c26d500b003d21e7df9eamr3395201wmv.62.1673017427753; Fri, 06 Jan
 2023 07:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20230106045327.never.413-kees@kernel.org>
In-Reply-To: <20230106045327.never.413-kees@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 6 Jan 2023 16:03:35 +0100
Message-ID: <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Check size of table entry and split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Have you considered adding the flexible array member directly to the
union in struct coreboot_device instead? I think that would make this
a bit simpler by not having to copy header and data portion
separately.
