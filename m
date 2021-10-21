Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBC3C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC0A60D42
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJUPwm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhJUPwm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 11:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGNuVhi5Wfv6Y5HCVEAnOz4vrOFq78Ll27lC1Wx8arY=;
        b=P9ocbqOMPwGPDtcqSl8W3vS2APczBuW1ORWMZ6WH/XpkBQMgY6q7/+o4QRvIqNOqquJNia
        OOQwQ2kYYdQdwqzZUDIbEYFZrfe6zmukvZJ7W7vPYTz8XaW9dedia/H6EzIJ7D0itfnboZ
        q3pZmQyWMyy+1XWXupBnTQH45yhD0Os=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-ac72UTMwP7qXZHsTGwdAFg-1; Thu, 21 Oct 2021 11:50:19 -0400
X-MC-Unique: ac72UTMwP7qXZHsTGwdAFg-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so42313wmj.8
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wGNuVhi5Wfv6Y5HCVEAnOz4vrOFq78Ll27lC1Wx8arY=;
        b=Q6jq4KGgja0OSjqh+Z/C4e91ZHPI7cBrnS04BD8MGH8wVZNBFrMDymhipK97Sp+G7E
         QIUfy+yiZu8wrZK350vTDXD9ylXHHf+ZRvHHOa5nSJM1mluBJas8e7A7qwaQ2ue5SO9Y
         GD+gv38+5JAwo1XQlZj8TYPt4InCEwMMxsvLjQEWe/YCxHbcdDOciG8U4O1nTnTPOakp
         1s9SZ5qMGSIIGYdEmLrSAm2V+d0t1796r4KgRlhdkbzTq1h9GV0A6ybpXIcf9gR7+F3Z
         GVjRDMgWR37MJ8lkadIJDArQ7oOyX/iv1EslEuulTVAI+7Z3m/HDkADKTrR+9sSW0ytv
         0Sfg==
X-Gm-Message-State: AOAM532wcjQz8leNJSo4Qs25JdIersgkhK0iVOS+ojrNk3q2/5GvLVdI
        0v9ybdEh/96T22a96LhX8CORkAaCvQwBFH4qO4cXQOawJDU9xv28eM5GCX6+cwYhZ8x4FxBnMKJ
        p2yRQzT5LhpvDKZCZB7fW0veenU1J
X-Received: by 2002:adf:bb08:: with SMTP id r8mr8428734wrg.247.1634831417841;
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgRmpVw7GQoX5QS0ErkShGxQ4LBQKq9b//e8IAFwGPYgHiV4rJyKGUD+AIXN67lgBoTTfX1A==
X-Received: by 2002:adf:bb08:: with SMTP id r8mr8428696wrg.247.1634831417574;
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id r17sm6082878wmq.47.2021.10.21.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
Message-ID: <f0c1baad-b003-9a8e-48b4-14e7e5a1c4c6@redhat.com>
Date:   Thu, 21 Oct 2021 17:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to zero
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@pwning.systems>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211021154046.880251-1-keescook@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021154046.880251-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 21.10.21 17:40, Kees Cook wrote:
> Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
> After fd_install() finishes, the fd can be used by userspace and we can
> have secret data in memory before the refcount_inc().
> 
> A straightforward mis-use where a user will predict the returned fd
> in another thread before the syscall returns and will use it to store
> secret data is somewhat dubious because such a user just shoots themself
> in the foot.
> 
> But a more interesting mis-use would be to close the predicted fd and
> decrement the refcount before the corresponding refcount_inc, this way
> one can briefly drop the refcount to zero while there are other users
> of secretmem."
> 
> Move fd_install() after refcount_inc().
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Jordy Zomer <jordy@pwning.systems>
> Cc: linux-mm@kvack.org
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/lkml/CACT4Y+b1sW6-Hkn8HQYw_SsT7X3tp-CJNh2ci0wG3ZnQz9jjig@mail.gmail.com
> Fixes: 9a436f8ff631 ("PM: hibernate: disable when there are active secretmem users")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1fea68b8d5a6..924d84ba481f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -217,8 +217,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  
>  	file->f_flags |= O_LARGEFILE;
>  
> -	fd_install(fd, file);
>  	refcount_inc(&secretmem_users);
> +	fd_install(fd, file);
>  	return fd;
>  
>  err_put_fd:
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

