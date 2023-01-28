Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91853C38142
	for <linux-hardening@archiver.kernel.org>; Sat, 28 Jan 2023 00:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjA1A53 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjA1A53 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 19:57:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0C59E4C
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:57:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso10285741pjg.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt7riAo5IZBBNRUJXz8pkp6XLTWUB7DMintBQ4mnJ+w=;
        b=Sq13TwL2JvleGsf86UiBkqxxqQvlrn+9JqKhbgZya6YonVrMlwpl9H7V+w46KzX9gU
         XwtvFHc9MH103QXuWyqPeBIM+fap2Pn5mv1AVcStBkuR5SFqlWG7SO52BDCawpXKIqGC
         DC9qIjbacFWuEMHWWUq9xpWei55rvNP66T/eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt7riAo5IZBBNRUJXz8pkp6XLTWUB7DMintBQ4mnJ+w=;
        b=t69XJreGSPydJmDdlY5lezF+yE9oJAf1a+2p7S+9jvDPMN7pIL8GBQXubqj6PGH8PK
         YneCClz7W/pC+YSJqzi00ODbEpBoTvr17stkPK0XC+uQWz+U7KR84i+wMY/bLHZPK4yY
         Ywv79ErDooHDBo5ndQxkumzkIb+3CV9G5yuBeAP+4DmgmoMUpl0uuF9KJHc1FRH1lOht
         +6oez+ScUPlyoJpwXWSWonc6dJZqlgDhyBmfCiM1yZsLoCZUa7Rj4KzHE/Mrn6NBaRHp
         tEOS1VPG3W79g7wFEZcb/w0XNWX6W8yCa9KiMrTlUbaIJIG6nzSNlX0S7DM9SW2+DeBY
         RSQg==
X-Gm-Message-State: AFqh2krzmY5muJFGE3L6fPvpPnamabBe3izLt+y+VQuDtXoY4QVyGWIV
        KVvE9SK4d/yDcGnxn1tP5OUQgg==
X-Google-Smtp-Source: AMrXdXsGqzy4vwJ6nXgO7LJDjvy6Wk/X1EG3VvmKvq0e98qtLO69306EqidXqDBkwJxu6pgTQQeNrg==
X-Received: by 2002:a17:90b:3b87:b0:22b:afe2:2bb4 with SMTP id pc7-20020a17090b3b8700b0022bafe22bb4mr30492573pjb.8.1674867447456;
        Fri, 27 Jan 2023 16:57:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a6b4900b00228c8aa7916sm5553751pjl.38.2023.01.27.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:57:26 -0800 (PST)
Date:   Fri, 27 Jan 2023 16:57:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <202301271655.A51DC1CF@keescook>
References: <20230127223816.never.413-kees@kernel.org>
 <Y9RwpuVyEi2SBmdQ@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9RwpuVyEi2SBmdQ@ziepe.ca>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 08:47:34PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> > While the op->size assignments are already bounds-checked at static
> > initializer time, these limits aren't aggregated and tracked when doing
> > later variable range checking under -Warray-bounds. Help the compiler
> > see that we know what we're talking about, and we'll never ask to
> > write more that sizeof(ucmd.cmd) bytes during the memset() inside
> > copy_struct_from_user(). Seen under GCC 13:
> > 
> > In function 'copy_struct_from_user',
> >     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
> >    59 | #define __underlying_memset     __builtin_memset
> 
> This seems strange to me
> 
> I thought the way gcc handled this was if it knew the value must be in
> a certain range then it would check it
> 
> If it couldn't figure out any ranges it would not make a warning.
> 
> So why did it decide "rest" was in that really weird range?

It's because it got bounds-checked at the lower end (for the minimum
size test).

> 
> Is this just a compiler bug?

I don't think so. This just keeps the bounds within the buffer size now.

-- 
Kees Cook
