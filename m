Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E3C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhLMUj3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242282AbhLMUj3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 15:39:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832AC06173F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:39:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u80so15963089pfc.9
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U7SpVhaJqlRekCkuqabbataiuHulOV/UqdyZUkTKpI=;
        b=BbJA6E5ZKpt0snCX6tizQXaWuNHrLvnWhQKUykkvcxslCMelZ6/QA2cgvBM4MAB7wO
         3It3dRHtbHE2Sp5vbdjmTHwzWl9CT9/thqOA/LO/pvXZcncH6Rb4JHZUactkoS+xfc5P
         odch4+K+IeG0JSNQb7Q68K6UQPSsni0WbRe7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U7SpVhaJqlRekCkuqabbataiuHulOV/UqdyZUkTKpI=;
        b=rbVJyDaPD0DnQhIX7XaGLzglGPe2KMYdLNzHAf5imHBglV4nkl1soHQE6gQ1fCWqjp
         5fo44aG8FLawQzwqYNXckwdXeIKrMnFhx7W31bJX4ZUY7xChJnFQUmyG/KIaWGAEA2FP
         YpZXWJMf/AklB4fVWQHIoZh4w+7PjlaMGktLXjI6Q0XiiKQi4kVgO9TGIwUVqnM/imK9
         eHo2y9w0DOWHA6RcEZSznzv8xWGFIOyNFYy+ZtDCwXNQdU/l99ch91peVGydWI8DW372
         SidubPHHkDEZaKWksZeY0tdgbVnw+Ip7bwUvXf+bzFW8yqaXGfxZbeTq5ZkZEzDdeBcc
         JhwQ==
X-Gm-Message-State: AOAM530kC2sy882cJusEdtTvkJ2uYPNIYIQNNS3BpUguCS06lkjuSua2
        9eORYRKhkcwHtldkAYned0L6DQ==
X-Google-Smtp-Source: ABdhPJyIyDeOWFkaqyO4+QH72bHsH32NTFAnedf0kYCNhGtwwk18QXAZwRlLjFj0ymScsj90CRDMiw==
X-Received: by 2002:a63:4b11:: with SMTP id y17mr703577pga.214.1639427968693;
        Mon, 13 Dec 2021 12:39:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm13252828pff.107.2021.12.13.12.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:39:28 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:39:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, wangweiyang2@huawei.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] lockdep: Use memset_startat() helper in
 reinit_class()
Message-ID: <202112131239.7BB7563C80@keescook>
References: <20211213132618.105737-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213132618.105737-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 09:26:18PM +0800, Xiu Jianfeng wrote:
> use memset_startat() helper to simplify the code, there is no functional
> change in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
