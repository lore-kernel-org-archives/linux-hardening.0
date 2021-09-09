Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1351AC433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFED61108
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348475AbhIIXMV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347875AbhIIXMU (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 19:12:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 678DC610FF;
        Thu,  9 Sep 2021 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631229070;
        bh=qI+46Ea8gyDuK37vgtlT0gB4jyidNDsAKRJ3889xuwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uGmstYBOpdTL/asymH2h1fKfJ+cTNRyP1qVB2RQKnRBfkEiiwctc0tY6Q0wU292MJ
         SXD9ci1kp4aVYZ3OlDvDawcpabPKzo6y2pFG1KPGiL+vzlAAaUywrUs8vlKAaVyU4N
         0AO+p2asdgUIK7+MtfxxSvuoxU1bSk76SAR68V4c=
Date:   Thu, 9 Sep 2021 16:11:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-Id: <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
In-Reply-To: <202109091549.FF8E0C61E2@keescook>
References: <20210909161409.2250920-1-keescook@chromium.org>
        <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
        <202109091549.FF8E0C61E2@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 9 Sep 2021 15:51:23 -0700 Kees Cook <keescook@chromium.org> wrote:

> > That's an "error", not a warning.  Or is this thanks to the new -Werror?
> 
> This is a "regular" error (__bad_copy_to() uses __compiletime_error()).
> 
> > Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> > older kernels will be a common thing down the ages.
> > 
> > If it's really an "error" on non-Werror kernels then definitely cc:stable.
> 
> I would expect that as only being needed if __alloc_size was backported
> to -stable, which seems unlikely.

Ah.  Changelog didn't tell me that it's an __alloc_size thing.

What's the status of the __alloc_size() patchset, btw?
