Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F9C04A95
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Sep 2022 05:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiI1FYx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1FYw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Sep 2022 01:24:52 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 22:24:50 PDT
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25049C231
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 22:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gWzKGv7ReSAIH4DneQWl5fiCWt4LtZZ79FmYwJ148Qw=;
  b=RbJqOYELmywi2qpCX++yU160vSfYahRTsW7BlXZBmn835XbUq1FoPh6K
   pu5K2iHgPeoYtksxOibNMJE45ze2xahWUTamv91k4fUxPHjdGRaV1xbEL
   nQfLFSDHtniIk6cGlqcw/YIqMNE+V3G5OiJz5As6iRrUCKnB1iPGd2qpc
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54847897"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:23:44 +0200
Date:   Wed, 28 Sep 2022 07:23:44 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     cocci@inria.fr, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [cocci] spatch --jobs N missing matches?
In-Reply-To: <202209271425.50502D365C@keescook>
Message-ID: <alpine.DEB.2.22.394.2209280722150.2844@hadrien>
References: <202209260912.8DCCD70@keescook> <alpine.DEB.2.22.394.2209262259030.2915@hadrien> <202209261505.9AE38B8@keescook> <alpine.DEB.2.22.394.2209272235060.2842@hadrien> <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
 <202209271425.50502D365C@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Tue, 27 Sep 2022, Kees Cook wrote:

>
> On Tue, Sep 27, 2022 at 11:09:35PM +0200, Julia Lawall wrote:
> > The problem is fixed in github.  Coccinelle was doing some caching of
> > header files, that was not desirable in the case where one actually wants
> > to match the code, and not just get type information.
>
> Thank you for the fix! I can confirm things appear to be working
> correctly now. (And took 124 minutes to run.)

OK, long, but at least you get the result.

> > [...]
> > Actually, there are not that many memcpys in the considered code.  Then
> > there are not that many that refer to the last element of a structure.  If
> > level2 produces nothing, then level 1 should not be applied.
> >
> > In the original rule order, all of the pairs of a flexible structure and
> > any structure are considered, regardless of whether any memcpys are
> > present.
>
> Ah! Yes, I keep forgetting to start with the narrowest part first. :P
>
> I also forget that I can do a "depends" on something that has no other
> matches, but if it's built on prior rules that I use in later rules,
> then it limits that rule directly. I haven't quite managed to think
> sideways hard enough. :)

Actually, that is the only purpose of depends on.  Your original rule had
a depends on level2 that was unnecessary, since the rule couldn't match if
some metavariables from level2 were not bound.

julia
