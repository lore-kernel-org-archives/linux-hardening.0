Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D5C4338F
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A350610E7
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 13:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhHGNLt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 7 Aug 2021 09:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhHGNLs (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 7 Aug 2021 09:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA7966103B;
        Sat,  7 Aug 2021 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628341890;
        bh=wnoOMeXGqb1KEh8yzFi9QRbGOL4x0/t/dZAZSzjf0Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzLzSrz/wuxljxyDYLhysVGQfXVO1vW2Fz5pJp4Htepq1D9oaEFs3WzrZkf/+z1X5
         gCIFd4gAoqbbo/ldvriQLjeAvweoRKvtq3hKk2n5D7Xs1swqdwg7F7hBVu9rydTDuT
         /0l/LYvC2EMl8lBCDTpcKGeQIB1NEV9XO562Cnb8=
Date:   Sat, 7 Aug 2021 15:11:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        alex.popov@linux.com, jannh@google.com
Subject: Re: [PATCH RFC] kmalloc cache randomize and inner-slot randomize
 against slab attack
Message-ID: <YQ6Gf33ta9QtiKaH@kroah.com>
References: <20210807131000.779460-1-wzc@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807131000.779460-1-wzc@smail.nju.edu.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Aug 07, 2021 at 09:10:01PM +0800, Wang Zi-cheng wrote:
> Signed-off-by: Wang Zi-cheng <wzc@smail.nju.edu.cn>
> ---
>  include/linux/slab.h | 10 ++++++++
>  mm/slub.c            | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)

I know I will not take patches without any changelog text, maybe other
maintainers are more lax...
