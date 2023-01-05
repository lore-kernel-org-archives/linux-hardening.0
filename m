Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC62C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 22:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjAEWjt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjAEWjs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 17:39:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA11C41E
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 14:39:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 7so62421pga.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdgAvYTBrYnbaUNEv8BIMTzu3Oe5iPdX/uTy6lOBdp8=;
        b=gJQpryXWL+Io+7TfOdR/L7h/MnG9VV9Jz4HEcSeFaLzheIGBhT9XVgQEh2hUgBSpNa
         Akn8+/KMom7qedcO0/agBltAVVd9K44Ma+Ijw97Rs+h7VkcrpJGeESfcc/2L/As8HuWD
         g3BOFMWbO9TtxJ4bWD1f8ZtH2kyVn1Tk+Lyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdgAvYTBrYnbaUNEv8BIMTzu3Oe5iPdX/uTy6lOBdp8=;
        b=GQf3xpp1a6wScNrMugrLRIZ+DYQUVvHx6E5MGb7WYQ/dAfgybO4Y+uc995im24Q+Ff
         FSJHYljb3I/MEblRhelwaujNgvss+xM5rRfFqplP+61G53uQ9CiLQq6a7RQGBUPFboP+
         xND5odIhW1oP75Ee3obG+82gkj/r/ZDxgvv+5CpVWjZ/34YHQKpuWc1iVIG0CgkmegLq
         9DmdXwpfPfUsSNelPSotGvQLFhtGUwqf6Ps9BKyK3vu1btWZ7IPv+yeGgSr/pYXciP2T
         Bb/Bk2waq45hujtoNUKoIMfNnQhL32EVdxzKzmzaDwMtGRwmhgDJlP9ck/qs0BKNopbo
         N2gA==
X-Gm-Message-State: AFqh2kq8htTLRFAXXMnBEr6E8N2oEC8L2xATZ0hGQtvfRiUtXjfK6JFZ
        WKJdCF5a4Vw6unZzvNMt7KJR8w==
X-Google-Smtp-Source: AMrXdXuRg8ap1gfmlr1QRcGiFifKwVjGE0OZvbRtHILaqVmV92+uxnMIKqYkNiGkvtxG9Rd772hvxg==
X-Received: by 2002:a05:6a00:1816:b0:583:2a52:6ae3 with SMTP id y22-20020a056a00181600b005832a526ae3mr4621197pfa.6.1672958386670;
        Thu, 05 Jan 2023 14:39:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7-20020aa78f07000000b00580f630a05csm21128326pfr.180.2023.01.05.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:39:46 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:39:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memremap: Replace 0-length array with flexible array
Message-ID: <202301051438.4FCD7E8AF@keescook>
References: <20230105220151.never.343-kees@kernel.org>
 <Y7dLrdOETjg/+XKq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7dLrdOETjg/+XKq@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 05, 2023 at 04:14:05PM -0600, Gustavo A. R. Silva wrote:
> I think this is the same patch:
> 
> https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/
> 
> It's actually in linux-next.

Ah-ha! Thank you! I'll move to linux-next for build testing.

-- 
Kees Cook
