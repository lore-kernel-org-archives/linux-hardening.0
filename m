Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C6C4332F
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Nov 2022 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKHRWv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiKHRWt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Nov 2022 12:22:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC75115C
        for <linux-hardening@vger.kernel.org>; Tue,  8 Nov 2022 09:22:49 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h193so13934453pgc.10
        for <linux-hardening@vger.kernel.org>; Tue, 08 Nov 2022 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMk4PVCi8MpYMDkTe7xjdobh7931rVJKCrHxnRJEZ/s=;
        b=hH8t9+Espo0GrgedJ9kMDPtH/SwZJLvzS42Mpnzj25bSeGNKWC/KhRsX+Bk5RGBoYh
         GS89jcjEhdmZQCZmsXftPjQPRRk67Sp6/5ZHG3Enccq5LOmxhTx1Wil+jM384G6zHYUE
         HEAuY+LA8P/URl4U6jup79JIboPvC9ydZMpHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMk4PVCi8MpYMDkTe7xjdobh7931rVJKCrHxnRJEZ/s=;
        b=myHaozS3UtYZwPOzbYweo7BiSvSt+N0fd9fg0ZjORrecJQ4pViTBEFaw4lFXC1GV7s
         4/RMJ6u6MgYygOXt8fGS3/7qxt1VzDIEXG4BelQ0h845GGJyEcXBha+ZGaTwZ+k4SY61
         AhUincyUhd2LR/OhhuziNJotN+s8RhOEA9rfhCe60bivtVoG3w2zoKIaUb+mXJRggHRO
         2nJlUiHuQzQgwJH47KSRVAZF99IHK11XSZVZj+oc9uxmpaTytIYklPrweS8zhrR1nSo5
         WYgHKr1Wuv35qlfn1C+JJEiqLUDGjXWmSKEsgLRjsmYbmxHPVnVYYppPICPCvh5pEcBW
         fTVQ==
X-Gm-Message-State: ACrzQf2OejtPaf0ziFcusjCp1FCG41TM3KFTptvlmEVAswVW/fgufjma
        PwW6wOXpy0qOOPpXyFtGw5u0HQ==
X-Google-Smtp-Source: AMsMyM4Ab4Kr0QUaf2x7BxJa/AITAVTNdya0GPA8aZCXQG+csEC+UsBcfir62wN3+d9ly4DUl+wEDQ==
X-Received: by 2002:a05:6a02:282:b0:439:7a97:ccd with SMTP id bk2-20020a056a02028200b004397a970ccdmr49560686pgb.297.1667928168583;
        Tue, 08 Nov 2022 09:22:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001869394a372sm7241421pla.201.2022.11.08.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:22:47 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:22:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
Message-ID: <202211080922.8B4A9A16AA@keescook>
References: <20221107201317.324457-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> @Kees should this go through your tree? (After waiting a while for
> the inevitable bikeshedding on whether the default limit should be closer
> to 10000 or 2^31.)

Sure, yeah. I can take it.

-- 
Kees Cook
