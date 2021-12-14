Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC6C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Dec 2021 17:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhLNRIm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Dec 2021 12:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhLNRIl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Dec 2021 12:08:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5BC061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i12so18386393pfd.6
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNMBPkOZLTOjGHzj7TrbFcH7DnoXgRnqiGbYIqbL1q4=;
        b=I5YCEBIuM4wLVG+10oAs8zl2Y8rw4EHHkAmh/I4E44zFP9tBSFGtnyO5a1sedypDbj
         9sLt1sCqcmti07lntyomqev0i0pxZDoUdJkoc8rs8XwjjfWTNYIxW23VZIvfWCq0lzLS
         3QnfygM5ZPPJhjpTUgG584iBA3igOerNtlu78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNMBPkOZLTOjGHzj7TrbFcH7DnoXgRnqiGbYIqbL1q4=;
        b=6Cg3ken6Qd0Yfh6gwIOe4SG6p2KpDNDNyBOK7YhFK1valjnKUGCDAQN1W7E+MONrXu
         MjcpXuuETdx+KLbna5W9Ru8jUP/253hk3LigXuZhafeT/h5jnD4HKiQyw207qMdn+QD5
         iSURigZZIxe0L4axZhojAJCmmX7FdSfDymtvkJ1Xqd/R98JRHfj2RfFRhreid1Fgh0mO
         TTjE7b2es4VcArp/X7NTY4jFqZjvBLQ7HSq6EzshlCtKTzK6A0zsshC0dAL28x65zGLI
         NKFaSE8902gJlzxk/fo+gtP1BX6pl7Tjwp1oR7qLhHafTZf7Cl+g8RacolJjvo+DL4Mz
         LhTw==
X-Gm-Message-State: AOAM533sw55yd6YOuWXIY0ESP+d80/ufvAytgQRKXDWvzFcABkJEKCoo
        SOnKXCSWZWfkC4QBm4g14GaJxQ==
X-Google-Smtp-Source: ABdhPJwqjW4UK7mVPGEv5vhhpnk4m9IYAQDxyH+VhHu5Np86nXt828Bh4x/umWIjuN85a32RUYKnwA==
X-Received: by 2002:a65:654f:: with SMTP id a15mr4564083pgw.195.1639501720555;
        Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b19sm412774pfv.63.2021.12.14.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:08:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
Message-ID: <202112140908.80D89AC9@keescook>
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214114854.133328-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 14, 2021 at 07:48:54PM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calucation.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
