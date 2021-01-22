Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B940C433DB
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Jan 2021 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5120C23AF8
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Jan 2021 19:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbhAVTv2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbhAVTYg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 22 Jan 2021 14:24:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899E2C061797
        for <linux-hardening@vger.kernel.org>; Fri, 22 Jan 2021 11:23:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g15so4539123pjd.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Jan 2021 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qLtZEw46MuUNIjgfTBmQVdFoDCzD4gSGophFRfdj9c=;
        b=bGs9+RQfEZapH5a6I/1sAlxe6lblz17BbDMoY8hk8D51nuXTqTlFFPMyDuDfmy6gET
         rfbZANKErdA7BepjLInotLIqN/JDkxzqGrIafLjzcoaHk8W1PBvXutMoCveAieUleL3Q
         h5iVo1yVNFeoJpjXCmXq7wvFHfJyDRr7p0jiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qLtZEw46MuUNIjgfTBmQVdFoDCzD4gSGophFRfdj9c=;
        b=V8yijfwpQnmNgGBZ/EOQS2YGdgKJJyqPSUsaLajP5ash1dSNGHpHyM6dawSy5AgdNz
         K2Oz2BtxooJp4stQZPWB66vDbPek6043Msel4LEeFJ9YwIYnLW89ho4foS6CmE0itzHy
         iP2zMs0dEz2IGxYmC+iA8iux71/oHXbYtzEbm0ftOpsD4yrD58XZtqu3VZnOnGnaLaIw
         g9x9AxMO6S2eodlgPATzXcbLPPp1IBFXlWGgR+ICtKtuu36Fwfu3/7ByO6Lc009Iez/h
         tRevWL/ll14+7RpgCrGtsRpfbsObB1N79rfjtTuNdJc4d9cbd4rtExFYxVqhRSzdAVAb
         7lCw==
X-Gm-Message-State: AOAM532IgqoXrauXPcfRrpZyaa3GzzYLx0jgqmkO+ZjD1ghGhyjHu0YF
        7NH7I/mlGd3bksRPyiZJ+soV5Q==
X-Google-Smtp-Source: ABdhPJwWPLudcsSrSLClh8DTzDJxX4J0dgf3E1K4QJTquK5uVVrb0Hfo9aMXXqcH+ClQbrHFJWsa0Q==
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr6874931pjo.222.1611343436131;
        Fri, 22 Jan 2021 11:23:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm10639957pjd.26.2021.01.22.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:23:55 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:23:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Robert Karszniewicz <avoidr@posteo.de>
Subject: Re: [PATCH] Documentation/Kbuild: Remove references to gcc-plugin.sh
Message-ID: <202101221123.23BA3181@keescook>
References: <1611338653-175404-1-git-send-email-r.karszniewicz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611338653-175404-1-git-send-email-r.karszniewicz@phytec.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 22, 2021 at 07:04:13PM +0100, Robert Karszniewicz wrote:
> gcc-plugin.sh has been removed in commit
> 1e860048c53e ("gcc-plugins: simplify GCC plugin-dev capability test").
> 
> Signed-off-by: Robert Karszniewicz <r.karszniewicz@phytec.de>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
