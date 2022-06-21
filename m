Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A6C43334
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Jun 2022 19:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbiFUTuq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiFUTup (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Jun 2022 15:50:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EF15A03
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oN7PLx4BY0IcP386vIfVV3m4tbd5B2wSClnZJJ+gcCM=;
  b=JbtEC+CeZAGFlLx3Vouq2gpXM2dU0yL/BkbvouT1exHxcLvCiQgWvdkb
   shoAxCSb3aroEMpJ5HGr6J2zQIlKYcxG0Wl96iJU/nVPL0ERGG92sTyKa
   ecl4/UHTgMX2Z9FM/Vu9h3uwfQhZ02v/JCC1sOnKiil7Gh2GKwlU3tPoZ
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,210,1650924000"; 
   d="scan'208";a="17426876"
Received: from 71-219-62-252.chvl.qwest.net (HELO hadrien.PK5001Z) ([71.219.62.252])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:50:42 +0200
Date:   Tue, 21 Jun 2022 15:50:39 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Coccinelle <cocci@systeme.lip6.fr>, linux-hardening@vger.kernel.org
Subject: Re: replacing memcpy() calls with direct assignment
In-Reply-To: <202206211109.A819E8118@keescook>
Message-ID: <alpine.DEB.2.22.394.2206211544160.2194@hadrien>
References: <202206211109.A819E8118@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Tue, 21 Jun 2022, Kees Cook wrote:

> Hello Coccinelle gurus! :)
>
> I recently spent way too long looking at a weird bug in Clang that I
> eventually worked around by just replacing a memcpy() with a direct
> assignment. It really was very mechanical, and seems like it might be a
> common code pattern in the kernel. Swapping these would make the code
> much more readable, I think. Here's the example:
>
>
> https://lore.kernel.org/linux-hardening/20220616052312.292861-1-keescook@chromium.org/
>
> -		memcpy(&host_image->image_section_info[i],
> -		       &fw_image->fw_section_info[i],
> -		       sizeof(struct fw_section_info_st));
> +		host_image->image_section_info[i] = fw_image->fw_section_info[i];
>
> Is there a way to reduce the size of this cocci rule? I had to
> explicitly spell out each "address of" condition separately, though I'd
> expect them to be internal aliases, but I'd get output like:
>
>  *&dst = src;
>
> etc

I don't disagree with Greg, but I will still answer the question :)

>
> @direct_assignment@
> type TYPE;
> TYPE DST, SRC;
> TYPE *DPTR;
> TYPE *SPTR;
> @@
>
> (
> - memcpy(&DST, &SRC, sizeof(TYPE))
> + DST = SRC
> |
> - memcpy(&DST, &SRC, sizeof(DST))
> + DST = SRC
> |
> - memcpy(&DST, &SRC, sizeof(SRC))
> + DST = SRC
> |
>
> - memcpy(&DST, SPTR, sizeof(TYPE))
> + DST = *SPTR
> |
> - memcpy(&DST, SPTR, sizeof(DST))
> + DST = *SPTR
> |
> - memcpy(&DST, SPTR, sizeof(*SPTR))
> + DST = *SPTR
> |
>
> - memcpy(DPTR, &SRC, sizeof(TYPE))
> + *DPTR = SRC
> |
> - memcpy(DPTR, &SRC, sizeof(DST))
> + *DPTR = SRC
> |
> - memcpy(DPTR, &SRC, sizeof(SRC))
> + *DPTR = SRC
> |
>
> - memcpy(DPTR, SPTR, sizeof(TYPE))
> + *DPTR = *SPTR
> |
> - memcpy(DPTR, SPTR, sizeof(*DST))
> + *DPTR = *SPTR
> |
> - memcpy(DPTR, SPTR, sizeof(*SRC))
> + *DPTR = *SPTR
> )

You can make a disjunction for the sizeof, eg in the last case:

\(sizeof(TYPE)\|sizeof(*DST)\|sizeof(*SRC)\)

That would reduce the number of lines by 2/3.

Note that it would not be good to put

sizeof( \(TYPE\|*DST\|*SRC\) )

because the C rules for parentheses with sizeof in the type case are
different than the rules in the expression case.

On the other hand, I believe that the above rule will require SRC and DST
to have known types, while such a type is only necessary for the
sizeof(TYPE) case.  So it would be better to have one rule for the
sizeof(TYPE) case, and another rule for the other sizeof cases.
In the second rule, SRC and DST can just be expressions.

julia
