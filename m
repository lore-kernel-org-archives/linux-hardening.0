Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE42FC32771
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Aug 2022 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbiHSWSQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Aug 2022 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiHSWSP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Aug 2022 18:18:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D8C28
        for <linux-hardening@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so598204pjg.5
        for <linux-hardening@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=BcAPABzciTIGP2cxF54N2Wsd/iSJnRwhaMTJUEPlID3X+lEPUS9PKxCYhEulFZwRxd
         06bqrTdWnqjtnqc2C3v4TI8GRA6eiJXScnwQfLinTWZ/GYZMRuQkN3HbWHc1PSDNRaEY
         Xl4RNP3A6PtVIwmuNLThV2GWpVrvVfgQSzyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=ZVvsmlGl53WFpAecPhVSK8KpN06VMZ4Y59M2880IBeIQTgNfO4s7GKHLjQgO9WVJDM
         /P6Y3s4d8SJTA4ZLsHaW9qFwJgrJ9J0BYJIxzub9Wc0CnS+Vn5oOnYhFP+770BfoNzYz
         jTJNpRDbTolcIoqZACCsBmTS+Bv3wLjEXhLwFGc84O13QzVKXhXboziwg+a/RcU9F9Ct
         5xazw1c6CwIoRxA9sY2Qe98qCO5CfvHiZe7IijOL9uB9n0mtE/dy7EbDn426NWTTWF13
         6EDoc0LKk0rl4W5BQJVK6phmvbwddvjXp4J6hwgqqZbgfBISdhvJEmZYsDvY3EsP3TMI
         9mSQ==
X-Gm-Message-State: ACgBeo0RqX7z/36Ur7Z0xHCqnV5/GcJKEfsiOPK6yejm72PLg7snUtp0
        EJhbsOXPhh7Kr/VKQeO4B+PJ/VBSCe0C9w==
X-Google-Smtp-Source: AA6agR5RK5bWwK14DmSWfIsVl2lWE7zgftE7SAP1zrNok3zDiq4QmjJez0ZgiEkrRJEXvaPKAwRg5Q==
X-Received: by 2002:a17:90a:8911:b0:1fa:c8f7:1450 with SMTP id u17-20020a17090a891100b001fac8f71450mr10531200pjn.123.1660947491479;
        Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm3603350pjh.50.2022.08.19.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:18:10 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:18:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, davidgow@google.com,
        corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
Message-ID: <202208191518.980071F7@keescook>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819053234.241501-8-tales.aparecida@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 19, 2022 at 02:32:33AM -0300, Tales Aparecida wrote:
> Replace URL with an updated path to the full Documentation page
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
