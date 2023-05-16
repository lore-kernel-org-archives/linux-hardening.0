Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD9C77B7A
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEPQgH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjEPQfz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 12:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94713AD34
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684254886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53NKQ5uw9SnRFMJTCe9LxwJTjXKaTTMdxaGXn1HcNvI=;
        b=S86xauYuvnhTddu9J+49Hlv/fM50+6Jzpakj+AjA090SU5MRimmzpGKfiSXNNT5bPDj2rm
        7/J9Lh0jB6Bk50ZmPtLeb5IODbFFVM6kH5EvLZkkQFAQIn9dn7PP5opJAsV2Vu/biPxFvt
        Drub/6+X1C36PLvgx0ty2s4G3Pg416Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-gLGJma-fPeq_Jh8KrWoaTA-1; Tue, 16 May 2023 12:34:45 -0400
X-MC-Unique: gLGJma-fPeq_Jh8KrWoaTA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f387d3b41eso8749501cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 09:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254885; x=1686846885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53NKQ5uw9SnRFMJTCe9LxwJTjXKaTTMdxaGXn1HcNvI=;
        b=PfFdGtI1RaKInQEnahje6OfNBi1pyBP91tFcZ7zOvJW1zhmO38WwDJBKq7FNlrrdY0
         qXdETOsHBjE9TlKm+G7DRRLtaXEdd9cJDGtbL+ya2uCjGdORxniO7nIdY9u55GdJLw7L
         enwZYymw+ojQ32SoXkMcZq0bKoLLWTC5paUa471H7tWfZWTwi9cxSLlRWZhzgw3kN3CE
         luTUuqTT6KbGv0GTAB6j8xklwSisqgVRX/QMq8qkn5xTiFFu/frKmz91H8NQ8IcFyTJd
         8oP+HePnEowjMMCuUcoeeT/SV1xjIm08pXN7zU8o4ezizHe7soCauIMgvPTAgRKjRSTl
         v77g==
X-Gm-Message-State: AC+VfDy6y6LZ1UoDasK6AMfSKMfR1XRBv0oPGFUhNX4RSDbYzoinRa0q
        fHYRPq1qiSztq/DT23XljQLCQ0LuymH6F5sCUbFdCp3eDYYez7CmXj+lhg1vXy2FSP917d9WSjO
        AODAX/t09hNHHd46QdnqqgEDpTf32
X-Received: by 2002:a05:622a:1883:b0:3ef:3912:ab3e with SMTP id v3-20020a05622a188300b003ef3912ab3emr241905qtc.2.1684254884943;
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45k6UsYhy0Q1O9scbqGvnXiic8Hnt7VxHTJtSYtfcme6kIxey26s7vFgM/LTlqpcCOXk5E4g==
X-Received: by 2002:a05:622a:1883:b0:3ef:3912:ab3e with SMTP id v3-20020a05622a188300b003ef3912ab3emr241870qtc.2.1684254884693;
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id d28-20020ac84e3c000000b003dd8ad765dcsm6336150qtw.76.2023.05.16.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
Date:   Tue, 16 May 2023 12:34:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        lstoakes@gmail.com, Liam.Howlett@oracle.com,
        zhangpeng.00@bytedance.com
Subject: Re: mprotect outbound check.
Message-ID: <ZGOworXBstm+jmw3@x1n>
References: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
 <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 06:41:35PM -0700, Jeff Xu wrote:
> + Peter, Lian, Lorenzo
> 
> Is this related to this hotfix ?
>       mm/mprotect: fix do_mprotect_pkey() return on error

Doesn't look like to me, that seems to only avoid replacing an error with
another error, rather than stop returning error for any case.

AFAIU this shouldn't be intentional, but Liam could correct.  Maybe a
bisection would show at least when it got changed?

> 
> 
> Thanks!
> 
> -Jeff
> 
> 
> 
> 
> 
> 
> On Mon, May 15, 2023 at 11:00 AM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1
> >
> > For example:
> > Consider the case below:
> > 1 mmap(0x5000000, PAGE_SIZE,  ...)
> > 2 mprotect(0x5000000, PAGE_SIZE*4, ...)
> >
> > in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.
> >
> > I know that munmap will accept out-of-bound cases like this (because
> > memory is freed anyway).
> >
> > Is this change intentional ?
> >
> > Thanks!
> > Best regards,
> > -Jeff
> 

-- 
Peter Xu

