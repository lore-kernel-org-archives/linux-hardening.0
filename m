Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370DCC433E7
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C024A2242A
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDfA2GEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJSXDU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgJSXDU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 19:03:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A46C0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:03:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gv6so40878pjb.4
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4PkP79+pUs49czqynJ/TcLY/lzxuEmosCR5PCWSgn7w=;
        b=fDfA2GEqOej7PjG6ScaflfIrMQBKzf8cdrAHVSjEeWFJ8Yuo6Nq828o3hJrLjK+y3Y
         KcQmfp6UdLA48h8eNvoi12ntmv00dpVTpTiiCdUmcTqtMpuu6ExIjUcPZ34tPotNY/qt
         RcA4OOdOP19xWDouk6X4GHjbi2otV9ETxpkDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4PkP79+pUs49czqynJ/TcLY/lzxuEmosCR5PCWSgn7w=;
        b=cQap+fhvDTrBjDD2We3rd4b0DjUQSONdhqdIvIlQaNI21SZwLn6F+6GxSrAGooHEkY
         ua7Mx9v5YvuHgKPnLXW5aZqecRXVTfTjqqAdRneRuYBUXD5bqkbMtURHLM5vrYd39K17
         TtTUVw/zB/3kCCEt5Ld6dVcoqLLFkaQ+ba9SbJpgXDUPf9yEFIi2uCfKdFnwmobw9WYx
         GUBVcHwC+ZyFA/J4ziyx1Dfj3FwVKh4nRit1YCjRKs3NZp7dxc61JDO7q/XBzTYYKoff
         dk+KHwRou2PMMergUvBJUKbNgQ2SKA5H9V+O3lzSBARUr7MNjvvQXj5sEm7yPUuWMDOO
         lzoQ==
X-Gm-Message-State: AOAM532DVcOUdfGD9hU22l/WjedrnZXpbjfdnp+DHkhz/7DUZmMuh01P
        doMTe2C3fGOLGiJgCMGpQ3vWHQ==
X-Google-Smtp-Source: ABdhPJxP9TuiWW+EE6HJp2cmIIyu0t7K+v06G3TEXmbdx4n3FKqDfSqF8sgAK56EWmXWnVx6FdeQwg==
X-Received: by 2002:a17:90a:c901:: with SMTP id v1mr51122pjt.103.1603148599904;
        Mon, 19 Oct 2020 16:03:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jx17sm41779pjb.10.2020.10.19.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:03:19 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:03:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, kuba@kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Message-ID: <202010191602.AA2A948@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019152331.20583-1-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

[process nit: please don't use "--in-reply-to=" for git send-email, as
it ends up collecting all the versioned threads together, which makes
them harder to review. Each version should be a separate thread.]

-- 
Kees Cook
