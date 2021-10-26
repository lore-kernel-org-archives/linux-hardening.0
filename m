Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE294C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FC66109E
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhJZWhs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhJZWhq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 18:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1B1861078;
        Tue, 26 Oct 2021 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635287722;
        bh=F7c4FLOG/JXpD5fMAX/T0ZjE8OJGkErTGZeG75EeKr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7GGPV0a/Y0GUtoRJFPI+7hug+nZfuTykCoG6S301E2bNQWk77gwDGwnS0od4vXjG
         6eMUZO782AO5h4UEW9A0dbIW15ABmnbs91m9QqrjGHXyRITRll2SfCbz2MpjdX8irx
         KKj1kK03Fta62LWrP9FAztnV/3OoSDWNniishGobnNo9N8hjntmc2TTHj+oZyAh2oY
         5cyQ5OYdTGHK9y06i04G9bDCWxXXw9Ck/MwbFpFf9bQ6Yaag3bFkDWpVt5oRUJzucc
         nTzvn/rMoYcS7NCRt3QE/D8uK0pI2PA8PrSUWB3/iUuPJraxRc2riY7cukPSW6WHtZ
         VhClmkjPry6Bg==
Date:   Tue, 26 Oct 2021 17:40:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
Message-ID: <20211026224016.GA1488461@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
 <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
 <20211026184201.GB1457721@embeddedor>
 <87h7d3beqq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7d3beqq.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 09:30:53AM +1100, Michael Ellerman wrote:
[..]
> > I think I'll take this in my tree.
> 
> I've already put it in powerpc/next:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=61cb9ac66b30374c7fd8a8b2a3c4f8f432c72e36

Oh, great. :)

> If you need to pick it up as well for some reason that's fine.

I just didn't  want it to get lost somehow. I'll drop it from tree now.

Thanks
--
Gustavo


