Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D1C4708E
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 22:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjAEWlf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjAEWld (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 17:41:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0021CDEF5
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 14:41:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n4so40885748plp.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbEJ6C+ug2NsljTwx4DoQKNa+OlQLxZIBsSb223c9lE=;
        b=asfVO7RRpHj7y2lWWMRxdkl4uWIT0Zk7rrOxBjwe9bKXgbEimJH8eSs5y7phpZbhat
         Xstmhy+yo3meVAL6UXTXRdfEM8C08TPjaMjJaVECOe36cCJoonFoyZh8S7sYdx2VU96X
         0sOKfsNGdk4DKJK/HfeyNbwuCgDd+9cgb3jFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbEJ6C+ug2NsljTwx4DoQKNa+OlQLxZIBsSb223c9lE=;
        b=y4wmqWdsUaJZAj8MxbW/vsNHmCMR6JOuMUo8VCFXwI3lbBKnL5Ct5f89Bxj+xKEXq0
         7jol2rjxGkJG/dXDViiVlgWjrZwWnX74TMjaGdzYeKWMoyNS+/l9vml0KDIybHdsiIvh
         YyAK0K99+B88BWjfCI5ncGPMQ2X3AFOFhinORl42LE5NWgSaLWdVlbZLJeKietLei5F/
         UIUmnWTyYHxSwG3ZPcapHRyDPBBCjfYOlAAy1qB7neTotFvRMAFVSYAdS2lbLEK1BWxi
         OhdvCew3cJF+xC3l72++hjzfxOMfD+f7LW0brJfIFIiPpGTL3W2G2jy29evnx34df4Hq
         +M+w==
X-Gm-Message-State: AFqh2koBOqpymSA9Mn67fgWU4fQBLEPdLAF1Ir0NzgU+pIusM5pu+5fR
        zbklwGJ6THeuTACi3YC83yr/EdOdVe15tiCS
X-Google-Smtp-Source: AMrXdXtRgYj4OiBZyps7r7FG9SkHxrncQcTUVL9JLKBGfn3J0hm3xbYWINTp2A3YBjRyZct6O4L3nA==
X-Received: by 2002:a17:902:f78d:b0:192:ae36:f760 with SMTP id q13-20020a170902f78d00b00192ae36f760mr27050793pln.47.1672958492567;
        Thu, 05 Jan 2023 14:41:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001925016e34bsm26665004plg.79.2023.01.05.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:41:32 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:41:31 -0800
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
Message-ID: <202301051441.C1D7291921@keescook>
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

Hm, it's been in -next since September? Is this in a tree of yours that
didn't get pulled for v6.2?

-- 
Kees Cook
