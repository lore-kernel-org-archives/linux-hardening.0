Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55DC4332F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 02:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKBCPq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBCPp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 22:15:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B7BC85
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 19:15:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u6so15240871plq.12
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ti4EogjuUVSAXjX8LKJ5hd8zLc80cVbv91Rg8a9RWk=;
        b=SXTEaTLbwee5S4XolBwI4kB+WP1KdH3mnJ3ahA/qoXfTtCtDsFiyAseNonjQExpXV3
         XLuYqXcX4CjgjbZDCXvLak5xAt966BJwAZ8cMbPpYmkubLfavf2PIdJ9qIHrAiWg7taj
         Ieeei7HD6EHVn8+ECUxxrcaq9oiuXK38JTtRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ti4EogjuUVSAXjX8LKJ5hd8zLc80cVbv91Rg8a9RWk=;
        b=rP93+RUkop9Vm0C1DZKgYuO91VKMdGC9J6vvSrNOKYMBNdn8jP8s8jvTEtBl6BzG6x
         89t9vDCKFpJHJoW3gCL4e7mQm5AIf3xH6ZJe2chsEDZl6MThbk7NvIRFDCFQKJjJqR9N
         f7X1P3eQ83jzBy1VaBxshQttZPAtpMGYZsdIO4Ngp+JBZ3VGNvDkZmY5y0HSwpJ0+lxm
         OPh2n3MfwPrFtArKghEY4KjY8rQQ3y4bGyJj1jd1NZliGOAH9tOYU9qdn6y4Y/DXHlqj
         yl5hKdBFxTnu5pjee+Azv8dc4TjOgr/bmYSYtePRT64ZM9xn0VqyjHGoyfqxVEC8XL5B
         Am0Q==
X-Gm-Message-State: ACrzQf0CVYw91nA0Q8FFr5KGK+iVbK+0XRfya1XXDryjqB0Ry1T2+ODK
        EBIlUZupRm0vUrYihmiQ3mhG+A==
X-Google-Smtp-Source: AMsMyM5b+oJlZwQ+kjV5skbKpGaSNTevCyYJYHxZ7APrAMcrG2wKPhqa9r8hcgYlWWqPfX7Y4lYMXQ==
X-Received: by 2002:a17:90b:1490:b0:212:68bf:fcc5 with SMTP id js16-20020a17090b149000b0021268bffcc5mr5661510pjb.52.1667355344859;
        Tue, 01 Nov 2022 19:15:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f63-20020a17090a28c500b00212daa68b7csm197048pjd.44.2022.11.01.19.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:15:44 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:15:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202211011915.02EDB6377@keescook>
References: <20221022182828.give.717-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022182828.give.717-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 22, 2022 at 11:29:47AM -0700, Kees Cook wrote:
> This is so very long over-due. We just need to do this and put an end
> to this legacy operation.

thread ping. Should I carry this in my hardening tree instead?

-- 
Kees Cook
