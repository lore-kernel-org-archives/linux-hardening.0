Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2EC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 10:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRKJj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJRKJi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 06:09:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE11A385
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 03:09:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl1so13447160pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKUSHBzIV9AmjcAPIwH4d1e4/pivyZO+yk3jBrIXqik=;
        b=Og8qUuzdDioBAnndTRdVzqW2TKX37JQVBINZ/GxEZMvHmg91nkbp/PJcaf8RpNdIEr
         CX+xnORcAVblgI6/GK7I1zT5c5+88KvTGhc96WQKY4nHKe4MQ34CBQjvxc4GiiK13BwG
         JbpG2Xjma0DFxR3gRlBpequA1KZ/aXUeyFs4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKUSHBzIV9AmjcAPIwH4d1e4/pivyZO+yk3jBrIXqik=;
        b=PYEPthoIy7tPEJr04ko/fowJwn2UDDFBKDsJMzUpACrMIkFuDhdCpIiKI08Syd/2zq
         /CkJQJri8+uyWG74WqbwqB+y2Kq3lxc0R8OBvOJ+Uljgv8T0EYWBQO6zO9MPymy6wtGE
         rFmtODG8jhtcSgXUyEayKesvdHiXs/K7hLB7gmNx0Cb+Ua9h4uDHzf5mPZT5MBBZrZlA
         2NQWXpktOzz0nEnZ8DaEsFr6mh6Pu+dSs8zsq9dIAldsAT1+tQl06+4yohqa9IKyOVJJ
         +y4w/p5B0Gsu+EK+G7nxno6tydLBg7TU4kPUiWrg6a/GRkiLhAHI15cIhSqw9VxTdKnC
         o5Vw==
X-Gm-Message-State: ACrzQf2dd0Hk9IOu5rQtc1kf78O8vEdIIzYhS1TTWRj6g2dSizrtKYsV
        HnWbD6qGEV9lPWw/jnGE5IMHOQ==
X-Google-Smtp-Source: AMsMyM5wU1XEsuBMrD5Wn9zq3F5URSQDleuB2+Yfz06/29+vEOi6q0FdiYAl8IeHpZIEEsdsNB+sDA==
X-Received: by 2002:a17:90b:1c11:b0:20d:459b:ef0e with SMTP id oc17-20020a17090b1c1100b0020d459bef0emr38396657pjb.129.1666087774961;
        Tue, 18 Oct 2022 03:09:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017da2798025sm8337107plg.295.2022.10.18.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:09:33 -0700 (PDT)
Date:   Tue, 18 Oct 2022 03:09:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael J Ruhl <michael.j.ruhl@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] igb: Proactively round up to kmalloc bucket size
Message-ID: <202210180307.484A016FE0@keescook>
References: <20221018092340.never.556-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018092340.never.556-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 02:25:23AM -0700, Kees Cook wrote:
> Kees Cook (2):
>   igb: Do not free q_vector unless new one was allocated
>   igb: Proactively round up to kmalloc bucket size
> 
>  drivers/net/ethernet/intel/igb/igb_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Ugh, yay for my MUA vs commas. Sorry for any future typo bounce spam. :(

-- 
Kees Cook
