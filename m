Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DEC47092
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2461DC0
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFBSDL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 14:03:11 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41670 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFBSDL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 14:03:11 -0400
Received: by mail-pf1-f179.google.com with SMTP id x73so2797576pfc.8
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QcAc3xpbq6mLinHs8cXNP7UooUJNCieL/STNfq/k4D0=;
        b=Hflp9s800Hj2D2XM6bJiMGZ5r0m3Ef9CHGvvFZMmMB0I3nIJo4O8RRVb4GyC9804bK
         v94gfr6S+cZIaELM3xJkHU5bTZQ8v4Ouk2uoBjwQ2PJxU1nPn/E0cUCWPopTn0dh/bRo
         DzM8rd93fX4yK6LBx6gvL19oBxr9YSzIFQPUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QcAc3xpbq6mLinHs8cXNP7UooUJNCieL/STNfq/k4D0=;
        b=Xri5tBPKNFNoyL3L9FkpbQlU2zXJTKQllQMMWhM2cGV4G3NjsYoK6TkCU1ztAnW+6d
         uf7VN4C05+Xe52JokRvJzdOwZOxqzpmmnh38LRoSopl9wriWgf+WyQulJbuH2/46Yekd
         IDZX71f2ciZh6Sz/E6guMSoZN197i/NFQHcPsNeC96oYtmpq3u2fM0J+ey3cqev3DRiB
         zXO9dSfeg4hBVHnycfzY19cfP1sVwMEn5EqyYLPtwLThHPL4YkkgTqvQbTMHs2xMjy81
         D/xsKJHsNAAjdGdIAMDoJXgcgNkPTU5+1PisGGEsEsQPjzoHqLJJmIYJt7FxxD4WpPNj
         N9dw==
X-Gm-Message-State: AOAM531QTg7XsxOkYXwBCXrOv8ZL0ZlVpmTELjVMEjSDL8+pbW8e0oOe
        Brq+4135fuFrj+tpi5tLynS+0g==
X-Google-Smtp-Source: ABdhPJyqP4fRvL+ZxEDU1MMjYnQQXdCkpSaWoeRi6uM8dZgGFYgmTgVhhfRwgvcSKAIgXV3UEi1Sjw==
X-Received: by 2002:a62:3344:0:b029:24c:735c:4546 with SMTP id z65-20020a6233440000b029024c735c4546mr28651087pfz.1.1622656828035;
        Wed, 02 Jun 2021 11:00:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w8sm397227pgf.81.2021.06.02.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:00:27 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:00:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi: Fix a handful of memcpy() field overflows
Message-ID: <202106021100.86D738D@keescook>
References: <20210528181337.792268-1-keescook@chromium.org>
 <yq1eedlos1b.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1eedlos1b.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 01, 2021 at 11:38:47PM -0400, Martin K. Petersen wrote:
> Kees,
> 
> > While working on improving FORTIFY_SOURCE's memcpy() coverage, there are
> > a few fixes that don't require any helper changes, etc.
> 
> Applied patches 2 and 3 to 5.14/scsi-staging, please update patch 1.
> 
> Thanks!

Awesome; thanks! I've sent v2 for patch 1 now.

-- 
Kees Cook
