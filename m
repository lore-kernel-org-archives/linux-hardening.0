Return-Path: <SRS0=mkbF=EF=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B65C55178
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358E7206E3
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="in5Ey64O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJ3T0d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgJ3TZk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Oct 2020 15:25:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8366BC0613CF
        for <linux-hardening@vger.kernel.org>; Fri, 30 Oct 2020 12:25:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r3so3451448plo.1
        for <linux-hardening@vger.kernel.org>; Fri, 30 Oct 2020 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwqDDwLjsVYw6Whxs6WBNDQqodgj/3KGgtAXZxmlzdc=;
        b=in5Ey64Ooa7h9u9fOLI75hRMHbBrWTVJ4fTHsuIRjGV28rrYyCZIMYHTYv5VM5FGtC
         qi6ok+56l3Jt27UzF3akA9pGaonaWrDiR5n1r2cJTK0M3+dISSQnwks9zKIdsJmVwwkg
         F3zf4CSNqHc+e5eN8drTa+2k0VX4ySRLdoHB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gwqDDwLjsVYw6Whxs6WBNDQqodgj/3KGgtAXZxmlzdc=;
        b=fXAMSrdFfe8UElHdKUFlxFDrUV1qKHDm4vUmgPIsDrAiZWU6hYdLiG4wQMwoYabdgu
         oVyVO5E71rOpUEAIsXK2v0UMIaND8zEBk3wcSF9Ljoqm8HdTXmPbHxw/PkbUTv0AgT/8
         MJgC3cbfm85tdBLthBVoXooa+YyfD4prjcJqND4ZQKZYnFN1qxJjSyu0olfuYO0ZmwD0
         trx5/Xvc62Ar7Re2qqfFWkuAxdCX/JDcLVFr7ZMLSYo3nAbT65qSYaEi8KYhmsCzG+1w
         uB/J3A0nszhqZtxmcKZR3JI2eBZ1AZgngsLVDT7SmV2q3sEiEMwAYSpucCVLEijCyLUm
         ycMg==
X-Gm-Message-State: AOAM531Zcg9qlX/I32o4ppVN75PQvzoqPOsZ8803LzB7plYb1fAj9z38
        3nBTP4fABWzH4zP29yXiEkDkjQ==
X-Google-Smtp-Source: ABdhPJzS7AYNBywkEkiPG3bwCpsnEKWb+YgsaJTHo362/atJQ2fZSXau2VlI8LwbB6SC2AXEvdlryg==
X-Received: by 2002:a17:902:b192:b029:d2:f08:f85a with SMTP id s18-20020a170902b192b02900d20f08f85amr10218034plr.49.1604085940123;
        Fri, 30 Oct 2020 12:25:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w19sm2254173pff.76.2020.10.30.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:25:39 -0700 (PDT)
Date:   Fri, 30 Oct 2020 12:25:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH v4 2/3] Modify return value of nla_strlcpy to match that
 of strscpy.
Message-ID: <202010301217.7EF0009E83@keescook>
References: <20201030153647.4408-1-laniel_francis@privacyrequired.com>
 <20201030153647.4408-3-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030153647.4408-3-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 30, 2020 at 04:36:46PM +0100, laniel_francis@privacyrequired.com wrote:
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 2a76a2f5ed88..f9b053b30a7b 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1170,7 +1170,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  #ifdef CONFIG_MODULES
>  	if (ops == NULL && kind != NULL) {
>  		char name[IFNAMSIZ];
> -		if (nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
> +		if (nla_strlcpy(name, kind, IFNAMSIZ) > 0) {
>  			/* We dropped the RTNL semaphore in order to
>  			 * perform the module load.  So, even if we
>  			 * succeeded in loading the module we have to

Oops, I think this should be >= 0 ?

-- 
Kees Cook
