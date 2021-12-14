Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B601C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Dec 2021 22:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhLNWrm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhLNWrl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Dec 2021 17:47:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F29C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 14:47:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e3so69115112edu.4
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 14:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCX8/Hqkkmsc7s8OoncQ2ygzJ7gumAwZl1sLrK9wpaE=;
        b=B7tL5v1bMp+BDC5s8TZoUSFQG4zXAQcv5FngmioPcul/1hnbkkO9E8ewfR4MOh1dJr
         LExoG5vgcs3iAf3RZW9XhlT3zMFTEZ0vOq9INnzos+zrPiS0vO3bJPVFmL/hqe5EZvrJ
         vG4ulmzleaIAFvXcpfbX2GTGVADiDU1Fr6SA/EMPSfEZW/hUzB9BbEqnYG4ytcnHRfBW
         E1dWSUNAEceRIHA+sU37056AlSN3u2qF5OpoHCixEszEN+HvQdTs+ORygh3aCvQc+xrR
         NdGb2SKb5y8oOewin1ak1+nY3gVbawin4eTo2D8qdyfGL3unRbEI79DhFPjXuOmG+ilU
         EIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCX8/Hqkkmsc7s8OoncQ2ygzJ7gumAwZl1sLrK9wpaE=;
        b=ji8EVpDWZ6PCCLiCvmt7sVzfmsq1hdgqFOR89dhLVSmolJtB0mv9AZKfKF4JUQvdlr
         SjGoaUQcxEVjPzdqcvQfTp7vO62TD3oD/90PAuJVre7yWtinMi/reWkJXRYzJspnnggE
         HEzmzBzZfPFD5gAEvniCdtRPfpx4hQyrs1bwsyJQ3LWsx+Yh6B7LNkffltQlyLraP11z
         KuUoLCDKwjCOnA5Yi3X8H/xnwDcHwic3fC107W33BxBKkHyJCtE9t6oLvi0IWTUn/PVB
         50UWSJP0EHoXuKd+qVLJjKk9UOsaVyTgrhAlkgMRVnOc1RjKwReLHa4U2NipuH8CdYkS
         DLyw==
X-Gm-Message-State: AOAM531xos0Ft5xHgJ19PjN+SrlBnFgJ49F9BKOpb7KR95qx0rn04VHj
        1lC1kL6bCWOo+ntNYIgPNBTbPNgdkT1oj60DKFav
X-Google-Smtp-Source: ABdhPJzIcu0cK8oFwIMlnj2GOKq7A90qrnk+9/eDShno+/EyDaHfWZQyD4u4EBk7RpLdqrkLyWgJHG51AdwmapcggB4=
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr8724777ejc.12.1639522059848;
 Tue, 14 Dec 2021 14:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
In-Reply-To: <20211214114854.133328-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Dec 2021 17:47:29 -0500
Message-ID: <CAHC9VhRYZgDLsouVYkecHK1208dAHwLoGZ56sSTf1zBJ00R0ag@mail.gmail.com>
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, keescook@chromium.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 14, 2021 at 6:48 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Make use of struct_size() helper instead of an open-coded calucation.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c       | 2 +-
>  kernel/audit_tree.c  | 2 +-
>  kernel/auditfilter.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into audit/next, thanks!

-- 
paul moore
www.paul-moore.com
