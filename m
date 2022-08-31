Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E013ECAAD1
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHaRtO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHaRtM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 13:49:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC9D5DDA
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 10:49:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 73so5765455pga.1
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VFkJurdbJUTCWb5htdv9XL8GXl+ooHeGwTuU6qvLebw=;
        b=VostS88Kk2T9x6tzKXLo0TDqNIb1gPQ3/yzR073wKLNexwMTG22DFuQ+O6EvlCnOd/
         OgcP5p9wktNxFostue0wrRjsLrG7khl70oMXkKD0a01OaDu6xqWF9GcUVBxHL22V6uPZ
         SzGoOnicvDtJasw1c4prIQQ8Lu5uYdlCrU2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VFkJurdbJUTCWb5htdv9XL8GXl+ooHeGwTuU6qvLebw=;
        b=4Iciwzi94whK6breopj3AR/A32uulNBcjVXXN0k/DlwnCkv+5dhgYz8NUFZHReTKxT
         zha+eWlbdBCsmP9zBhxeY3Eb8givj4cTxmwlLcHEHSns2X1LPF5guEJiLkoq3eilJ+H6
         OprRbJbIRiA7C3IGraXu5vD55+xbWmPSSpDyLwX1yFkCxxj2/0I9m0ddKTRx6YysEhwf
         TaPQu5+QVC6sq1NsGUCNfqpSYMokzFQ4sPB8ioSKn6s8HF9j6wHtM5icWHOksUy42dCl
         3cBp9Sn1RaN3YYsZxpW1B1ufBQGtN3roIq6gbHt+viea9ADsJlCU/QpjZFCpxSp9q3sw
         S2Mg==
X-Gm-Message-State: ACgBeo0d53E+ndN7JP2JM+LcaeCciSd/ytivbYWAiDt+h+uQ7z9Oex03
        RjPernIu7liUp/EhFf4POEZC9g==
X-Google-Smtp-Source: AA6agR6daGH4O55c1EA2PgDANyYrLnYplMbFqZwe+Sa2xZJSfsxf22bpjN5zJ9lCWZGLXIpgNqWdKw==
X-Received: by 2002:a63:f011:0:b0:42c:7687:7322 with SMTP id k17-20020a63f011000000b0042c76877322mr9329970pgh.126.1661968148965;
        Wed, 31 Aug 2022 10:49:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b0016d3935eff0sm10016902plh.176.2022.08.31.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:49:08 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] overflow: Allow mixed type arguments
Message-ID: <202208311040.C6CA8253@keescook>
References: <20220830192147.47069-1-keescook@chromium.org>
 <787894a0-b1b7-43c2-c509-f246f94f58f7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787894a0-b1b7-43c2-c509-f246f94f58f7@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 09:52:32PM +0200, Rasmus Villemoes wrote:
> On 30/08/2022 21.21, Kees Cook wrote:
> > [...]
> > + * *@d holds the results of the attempted addition, but is not considered
> > + * "safe for use" on a non-zero return value, which indicates that the
> > + * sum has overflowed or been truncated.
> 
> I don't like that wording. It makes it sound like there's some ambiguity
> or (implementation|un)-definedness involved in what the destination
> holds on overflow. The gcc documentation is perfectly clear that the
> result is the infinite-precision result truncated to N bits, with N
> being the bitwidth of d.

Hm, well, I think use of *d should be strongly discouraged on overflow.
How about just adding the specifics to the end?

 * *@d holds the result of the attempted addition, but is not considered
 * "safe for use" on a non-zero return value, which indicates that the
 * sum has overflowed or been truncated. (*@d will contain the
 * infinite-precision result truncated to the bitwidth of *@d.)

-- 
Kees Cook
