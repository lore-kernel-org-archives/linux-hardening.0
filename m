Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6BDC636CC
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Feb 2023 23:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBGXJk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjBGXJe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 7 Feb 2023 18:09:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB63BD82
        for <linux-hardening@vger.kernel.org>; Tue,  7 Feb 2023 15:09:24 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso373778pjt.4
        for <linux-hardening@vger.kernel.org>; Tue, 07 Feb 2023 15:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iu55/RCZIpaMA1fxaFRMx8cHdAiUQu0JOyRvT6OmX1I=;
        b=fUI+bTXbFmQvTPvh0dpEalfNP+l+YFsjg4dlQztnO1CbBhKbPJprVPBN0Xk5dTh9D/
         CbzA04J83m/ywG3eBZWrlhAtCv+FcY3vWfRwbjGhQh+JTp//kEHfT8/GSBz+u6hxeFyP
         dWvyEePKKWiVHWli3fMqOJFMf4oOVJt+ATPBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu55/RCZIpaMA1fxaFRMx8cHdAiUQu0JOyRvT6OmX1I=;
        b=4RcRmgWpvFUkf1aNC4kahmVXLOxA9MwpiBWsRi1TiDOhPzruLaN8svDC+Bea1qug/t
         3OR3RL/ZKMYO2fdaFno0EfGQWYvdBBxn3kQmmzd3fRIZkZuwtC44AxsjeoGYKytn4OkO
         212fxjy4SNk/g2EwkBo6XwAuQXBN0r528W8R3FI4NzAm5ZmzRGIOrSuCbXfW3TKXk+wu
         Bwix7GhwzV3ho0w00UAL5pE4pA/DFxpH/HPAtJauZUh675/bh0WY8isMvroBbpQlQXsy
         D0wXpdvayQjD9NR0mW7xd9WgOaF5lQ5k9ZhkFICknxUXdAbiH+vlghF4ldrMvLMKPaIg
         qvvA==
X-Gm-Message-State: AO0yUKUleV0+FSgyyrdN6qQFkUEsN6nBt9Qu0gxLIqiFbXg1UggnrA3e
        Ch8CPwgwWbk1tgzxzHIIa7doN6zppXRxvbI1
X-Google-Smtp-Source: AK7set8TSsYqfXO8q9VGWKUEdT3Ri83RbMUpXwJ3tTr72Y5r5V6yPvvpq+dLz6v4VSREsB0CE6yHsA==
X-Received: by 2002:a17:902:e205:b0:196:77fd:abfd with SMTP id u5-20020a170902e20500b0019677fdabfdmr4143387plb.64.1675811364017;
        Tue, 07 Feb 2023 15:09:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902b08c00b0019337bf957dsm9419598plr.296.2023.02.07.15.09.23
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:09:23 -0800 (PST)
Message-ID: <63e2da23.170a0220.e2c26.064b@mx.google.com>
X-Google-Original-Message-ID: <202302071506.@keescook>
Date:   Tue, 7 Feb 2023 15:09:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: KSPP Meeting: Wed 10am US Pacific
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

Here's the reminder for the KSPP meeting, held every 2 weeks.

VC link:  https://meet.google.com/grn-oshi-cpq
Calendar: https://calendar.google.com/calendar/u/0/embed?src=47005f8f50f21da6133d7239f3cb93d1624d2e1949963ea75dd86d5f2d5721e0@group.calendar.google.com

See folks there!

-Kees

-- 
Kees Cook
