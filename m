Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD8CC001E0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 00:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHIAAQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHIAAP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 20:00:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794C1BCC
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 17:00:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686e29b058cso4493319b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=S7jrgnEEVtUldEZ4fNsxO5xEuNoE09AvfT2epMDZGQwiwLRniNAO2qXPn/6oani3Iy
         y4s2i5y5E7eP3BXt/GkDQ4kjTfxQGB4SkA14rz4hamND0QYauUTmcIS/uSJRQYbug7do
         jM9Zck/hWLwlAHtfJLiKY7st0kDikdcU5ZVQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=JNQ/NkJttPIGxA4qORM3n4qp/A3I3EzcmvMZ/PWN7u85Kgcukq2q6YUlhR8aaoluJe
         K4pV0jaaAMcPjT+QyDs6hVjnSUWqFYh1w3c7CPv0DBGnK/TdWAqa6waDtYXMlIhrRwk1
         TNIPNELmwG/E6/vFqyMv8KQDpvmq7Qk8Oc5/W16yfnPP15B0BUWgHoFEU/KtvKiD/+fO
         LOQYW/8H29Xq2c3dXc39sLYqFBkGcLa8JTGxSI4XIh3PhVEig61OpuyppFLWRCBIvBwP
         DCjs+fuvOvJRjmrnc8Fqg1yGvzvZWPZ2pbSmppnlWDedO57ueo645AkoOkfbPMOuBqkz
         cPXg==
X-Gm-Message-State: AOJu0Yy/UhlAyN17GGOL2/qrzl7EacWldtg1vCzuBPEniM/+cgVvFrBo
        FsrN5dYkT6nY1tVhV6BtOgLVsw==
X-Google-Smtp-Source: AGHT+IGsb7fkWGDseQQ2Ri6YAXrzLtLS9DjCLOnwlVVwzX1UZy1oeQM7mZIdp9cIPi7Q5ULncQgshQ==
X-Received: by 2002:a05:6300:808d:b0:13d:ee19:7723 with SMTP id ap13-20020a056300808d00b0013dee197723mr980401pzc.35.1691539213546;
        Tue, 08 Aug 2023 17:00:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b00686bb3acfc2sm8609957pfn.181.2023.08.08.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:00:12 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:00:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Justin Stitt <justinstitt@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <202308081659.BD539443@keescook>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
 <20230808233855.GI9741@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808233855.GI9741@breakpoint.cc>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 09, 2023 at 01:38:55AM +0200, Florian Westphal wrote:
> Justin Stitt <justinstitt@google.com> wrote:
> > Fixes several buffer overread bugs present in `ip_set_core.c` by using
> > `strscpy` over `strncpy`.
> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > ---
> > There exists several potential buffer overread bugs here. These bugs
> > exist due to the fact that the destination and source strings may have
> > the same length which is equal to the max length `IPSET_MAXNAMELEN`.
> 
> There is no truncation.  Inputs are checked via nla_policy:
> 
> [IPSET_ATTR_SETNAME2]   = { .type = NLA_NUL_STRING, .len = IPSET_MAXNAMELEN - 1 },

Ah, perfect. Yeah, so if it needs to zero-padding, but it is always
NUL-terminated, strscpy_pad() is the right replacement. Thanks!

-- 
Kees Cook
