Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A32C25B50
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Jan 2023 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjAXTNv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXTNu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Jan 2023 14:13:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6A4B4AD
        for <linux-hardening@vger.kernel.org>; Tue, 24 Jan 2023 11:13:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso3098419pjj.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Jan 2023 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8vZxWipWKD/y6gIGV8IcYkBWgrI0RpcVv2og9ppdhk=;
        b=AUx42BzA/CGJONaVzcRrHfTT6euc4wQEdvIA3NN5xozyS/Uf+1DGVufE1t++NLz4r0
         h9bCEljWaqZfuXMkRtL4kPoDA0yEDV668w3F0khTtSdEqiV+zXeLTZsg7FfY0ndsaDBU
         C1T6LZS+sdaeDKdsXSlZYyiv7vY+yEliG8qpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8vZxWipWKD/y6gIGV8IcYkBWgrI0RpcVv2og9ppdhk=;
        b=5V5R7Wt3CSBMb89w0HcT+jpP5g9tlNKE1pZlBlUmLv9MAw2+BnohBut+l1xjZk/Bix
         oQImlC2HgcNXi0SudCSc9aFFxdVQHwszD7Uh+iwDNIEU47srPxhSmgW1JnIT4OFKap9P
         8TudodrJC9S39kU32AyV1E99iO02RJWzR27+et83G6L0FjBfslJNFNJoGjPwTOB+PmY3
         jX05m+dKp2oEIxIH7bL5yperYub34DA8m3YVqho0pxNxa113EhmTLS+qPEMSitmNYDo5
         wvxYlq5G1RYb9LZJy8/0bbA3jwMK3KbhkIpNV7mUB1Y9OyI50lnhVTZd/bh4TvJmdy4D
         qs8g==
X-Gm-Message-State: AFqh2kq9SfnvZ0hI81/7tYXdti56A7VqD7+OmvpvNbvyAky/6LSirRZ+
        d1dE1BRxG/AfN2EdxBTCe7T1C5U7kQXXmfeY
X-Google-Smtp-Source: AMrXdXvXc5WNqKd6ppNcy4hEoJSrMOGTA7ElcOYyy/A7mIhQ7a2zLRJv2L0kT6m3lnZFKPII4uUTbA==
X-Received: by 2002:a17:902:eccf:b0:195:17e5:e168 with SMTP id a15-20020a170902eccf00b0019517e5e168mr23273705plh.12.1674587628783;
        Tue, 24 Jan 2023 11:13:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b00194955b7898sm1993385plb.237.2023.01.24.11.13.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:13:48 -0800 (PST)
Date:   Tue, 24 Jan 2023 11:13:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: KSPP status meeting
Message-ID: <202301241110.DE9769A8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

Tomorrow will be the next KSPP status meeting, Wed Jan 25th 10am US
Pacific. Everyone interested in Linux kernel security hardening is
welcome to join. There is now an actual calendar for it:
https://calendar.google.com/calendar/embed?src=47005f8f50f21da6133d7239f3cb93d1624d2e1949963ea75dd86d5f2d5721e0%40group.calendar.google.com

Also note that the Meet URL has changed from last time, but should
remain stable going forward:
https://meet.google.com/grn-oshi-cpq

See everyone there! :)

-Kees

-- 
Kees Cook
