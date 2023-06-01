Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2CC7EE2A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjFAQGa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjFAQG2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:06:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C38E4
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:06:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso1286230b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685635586; x=1688227586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eOOqjN+PIiYI5ZExNxAoyDJGJiX7/+eSzb019vDm9Y=;
        b=K0iegWJjaW9mH/T3pRWJ7G/M65aTd3e3+/biI3QuWdIaY+7/2lYnspXXfTOLeKTWSo
         S6KVoYeaCoQf3/pSStOWIEpzLi4f/xEMG+Kz9ME/MJrmLwja6a+BrSF8Mtu0BJY5yd3o
         g0mZG6qoS+IW5FJIQP1vL0lMQ1ZucXMOEROSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635586; x=1688227586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eOOqjN+PIiYI5ZExNxAoyDJGJiX7/+eSzb019vDm9Y=;
        b=aJxlzTVdHkcUkpgdY0fubY3T5Ou+G/Mo4UFChwVoSgaFKlGw5Un95OEXaFGSPt9lgj
         SOgF/AgkTlNIJUHGwsDRASqy6ihl39dydWFz8H3QYxdyC0HWLF4wzMo3htG74Eif8scL
         gntItytpkaaFxR7v4ji28oHtYc4H6ocLf/Eb4al2qugENDHpUzhZmarNzUPdqtgQadMc
         +7rY5N6hX1eV8lhQ3uSFqIHBDoY3Q9UAGx2OPH5Vr8vDGTbHN1m13kNa0Ot/6EJ8/t4f
         HagIMJE160yCXL8JomJkXdMQi8N7GzVib7PyfPMibRruzalHmm3T0GNFdy1lRKVxYeKi
         +g3Q==
X-Gm-Message-State: AC+VfDwUOFng7Ohk4e7W/uTHOwg2OFbHc0UEH1rYiFrsi9cZdVSU0uPm
        mxvBCo3iJWppq2GERbHod+gnrQ==
X-Google-Smtp-Source: ACHHUZ7ggT8cTZTPts5u8DP6/HtiHZwzkxdKqCuLNHHvcyqQXzew8mZFEIjTsjf3XQoMyOw6qh4/8w==
X-Received: by 2002:a05:6a20:2d27:b0:10c:ff51:99bb with SMTP id g39-20020a056a202d2700b0010cff5199bbmr11880335pzl.20.1685635586444;
        Thu, 01 Jun 2023 09:06:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78259000000b0065017055cb4sm2491967pfn.203.2023.06.01.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:06:25 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:06:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] checkpatch: Check for 0-length and 1-element arrays
Message-ID: <202306010906.DEC4F7EED1@keescook>
References: <20230531004929.you.436-kees@kernel.org>
 <f8efee7cd9f6f685dcf8b90f9169029fec6481e3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8efee7cd9f6f685dcf8b90f9169029fec6481e3.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 31, 2023 at 10:50:58AM -0700, Joe Perches wrote:
> On Tue, 2023-05-30 at 17:49 -0700, Kees Cook wrote:
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> > 
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
> > ---
> > v4:
> >  - combine errors (joe)
> >  - switch to kerndoc url (joe)
> >  - add __packed for struct matching (joe)
> > v3: https://lore.kernel.org/r/20230527020929.give.261-kees@kernel.org
> > v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
> > v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
> > ---
> >  scripts/checkpatch.pl | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 30b0b4fdb3bf..64d21b6aa6df 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7430,6 +7430,16 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for array definition/declarations that should use flexible arrays instead
> > +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> > +		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> __packed could be used when a struct is defined and so
> needs to also be added to $sline.

Agh. Yes, thank you. v5 on the way...

-- 
Kees Cook
