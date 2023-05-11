Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2809CC77B7C
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjEKWQt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 18:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjEKWQq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 18:16:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370359D4
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 15:16:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf21bb42bso66185685ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683843404; x=1686435404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYCkZW2ogs6OMYlPsNws7SbZYW9dz6tYyPZ1gWxGb8k=;
        b=HkV1/6IE9cIGy1RW+z8Arp7eRsUPZAmopg2U5rg8IL4m0as9cOGnhLviwEqhk9uyp6
         L3jkbvNUMZdBL9WuorKQ1KWPD0BAN8cdDO3oAfZd9vcxKrWlTvqtoaeJDwuulQeXEvPO
         0izSDa+iwdk5v+qk7go4AYxUGOs9Y2NI5sJjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683843404; x=1686435404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYCkZW2ogs6OMYlPsNws7SbZYW9dz6tYyPZ1gWxGb8k=;
        b=JjmYV2DIs1hmkV73Hq3iyCanJNFbXH3iUS16HZ2Dz2P+YQ61cVMKBf4OZ4nNZdnCdj
         yKI20rZ8gHBU2Sx1FyQiuOA4VHHSWmMRufqV+ajwiip43JTOLf1jpZxJtk9ltIJlvNAB
         kbicus24zteI9tstV3KVGBLoXsPSz6YS9kYKNpsrJlp2aMDkTWBhLktOFBHKhiY1/1xO
         1t/mhs5s5JmXGC313Q/wf6/+PpcGboDG5IeD1rN517lwlcfk77CsaDEKyC3aaZ9wPwLF
         VTbzEVmbfvB16gCYcn2uE/TwTj3VpIOF8t9Ex5XaCILf878hl0SahnMuDBtBYloFAMLB
         h8qw==
X-Gm-Message-State: AC+VfDytk0KNV7wV5P2o9WftbtKGTB+qEhC8woW0buHIlItkwtKY1X82
        GInr+U/8DRkSyN8C+Vc656p/tFMcuTMNXR6QDdBoKA==
X-Google-Smtp-Source: ACHHUZ4JoAef92WR5VbZemTNr+hT6tqc5aZjq7DFDEUq2hse935X6MfDjjp8jOrQMbQVJQhzcASqmg==
X-Received: by 2002:a17:902:c952:b0:1ad:ca0e:cf23 with SMTP id i18-20020a170902c95200b001adca0ecf23mr4279369pla.3.1683843404353;
        Thu, 11 May 2023 15:16:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020a170902834900b001aaf2172418sm6406127pln.95.2023.05.11.15.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:16:43 -0700 (PDT)
Date:   Thu, 11 May 2023 15:16:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>, GCC <gcc@gcc.gnu.org>,
        Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        linux-hardening@vger.kernel.org
Subject: Re: [wish] Flexible array members in unions
Message-ID: <202305111514.576EB7F@keescook>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
 <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
 <202305111410.CFE0875F@keescook>
 <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 09:43:49PM +0000, Joseph Myers wrote:
> On Thu, 11 May 2023, Kees Cook via Gcc wrote:
> 
> > Why are zero-sized objects missing in Standard C? Or, perhaps, the better
> > question is: what's needed to support the idea of a zero-sized object?
> 
> Zero-sized objects break the principle that different objects have 
> different addresses, and the principle of being able to subtract pointers 
> to different elements of an array.  There would also be serious C++ 
> compatibility concerns, since C++ allows a struct with no members but it 
> has nonzero size, unlike the GNU C extension where a struct with no 
> members has size zero.

Okay, understood. If this is a C-only thing, we can ignore the C++
impact. What depends on the "different objects have different addresses"
principle? And why do unions not break this -- they could point to the
same locations within the object? And don't flexible arrays already need
special handling in this regard?

-- 
Kees Cook
