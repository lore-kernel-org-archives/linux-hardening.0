Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE898C83F2F
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 21:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbjHaVXe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347548AbjHaVXd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 17:23:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8710CA
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:23:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5654051b27fso968635a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516999; x=1694121799; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBk2nc7/tsG8HvIK0Ux2tDr6Cd5rvQV0q+VnPdDvvLE=;
        b=bITFfR0/v6LZ9c83udPJob0EkDr7pgPLo3Flgw14mF6c3iOYXdMeFwRGHbZxiuG2yb
         4LXjoAn0ApwrL+jYylm3/gakkYPMxOihOobYRACI9pt94fmKelSJzSPbBZx+sMTOfVYz
         2yZpDaLEndr82WadvkMvUDXX2m4Zup4yocV2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516999; x=1694121799;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBk2nc7/tsG8HvIK0Ux2tDr6Cd5rvQV0q+VnPdDvvLE=;
        b=TnZ6DbbkOMZ17gf2yeUXJ1eC84ugZzjYTovYSfh+M8kiFk0xNKly2R7k58krNK/TYp
         mP87Bz9yYCqVpuM+NOjn5gLuX8Jai8sDjft1KJjUoHvCVdEkLeTTDJVZ/gn41sADsQU9
         uW/5nft5z4W+Um+rMzb/64csnGuNATaJYqoRMgLg/mN/jQDMKe9CnM5L/adyHDWElslu
         V3W1UFrRY661KLSrakgmZqy7STloAE4aJlFY26rEHS+XdAZkk9MzUjPJxI1oZ2teHKu9
         u6XdbEjLwj17dKGiTvX1IPW02FGatMhnE1hNXzl5R86ONErEVk6PuZFVUfk0+t87rZO3
         qnBA==
X-Gm-Message-State: AOJu0Yx48TpE/ko4Ltk+okAx69J/Dbas4fDXswnBgtA5UJsNlxvW5KvE
        mkaT7GlbtmT+nv+iFPl7VpyTrxuVxMlHpK2Zo/U=
X-Google-Smtp-Source: AGHT+IEz8wzFp4IGavWS9RsUUFP7kNlRPFz2W4qzVBx/n82c7EXPH5okOuJc3i2XogqmZzAP02YxfQ==
X-Received: by 2002:a05:6a20:1447:b0:12e:5f07:7ede with SMTP id a7-20020a056a20144700b0012e5f077edemr1036854pzi.41.1693516999562;
        Thu, 31 Aug 2023 14:23:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e13-20020a62ee0d000000b00684b64da08bsm1680602pfi.132.2023.08.31.14.23.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:23:19 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:23:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: [Announcement] Clang-Built Linux Meetup 2023: CFP
Message-ID: <202308311421.DD30DFD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In case there are kernel devs interested in Clang that aren't already
on the CBL mailing list:

----- Forwarded message -----
Date: Tue, 29 Aug 2023 17:56:45 -0700
From: Bill Wendling <morbo@google.com>
Subject: [Announcement] Clang-Built Linux Meetup 2023: CFP

This year's Clang-Built Linux Meetup takes place at the Omni Richmond
Hotel (https://www.omnihotels.com/hotels/richmond), which is the same
place as the Linux Plumbers conference (https://lpc.events/). It's on
November 11th, which is the Saturday before Plumbers.

This is a time for people interested in Clang-Built Linux to get
together in person and discuss what we're doing. We're planning on
having presentations, hack-a-thons, and discussions about future
directions for CBL.

This is our call for presentations! If you have a paper,
topic-of-discussion, or maybe a presentation you'd like to practice
before giving the same at Plumbers, please let Nick Desaulniers and me
know about it!

Bonus plus: we're seriously considering swag this year. ;-)

  https://clangbuiltlinux.github.io/meetup.html

-bw
----- End forwarded message -----

-- 
Kees Cook
