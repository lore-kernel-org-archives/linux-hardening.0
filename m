Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F4C3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 04:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjAFEW0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAFEWU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 23:22:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE632277
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 20:22:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso548719pjo.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 20:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGWD+jfRiKeIQRhUlYhv18AOK19GA0uVfO6DJ6wW9xo=;
        b=Qx/Sc6eBGD1WS+NYhJg3ZkIWz+KNeDpe7i6MTHZyT8u+OIs3wWnMY1FXUutDo1Hrr0
         eEEIgS0CugsgWmq2tsY1L5OXMgikwU4dvu3B9xWf9FW17vulbRljYIEu1aHtcfzyCBJ7
         f/RAc7UJhNuY8syPOjs9JGQ3d2ynAdgWY89Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGWD+jfRiKeIQRhUlYhv18AOK19GA0uVfO6DJ6wW9xo=;
        b=if3l3Ma+8AsjUcJyizrX9fHkIBPgTZWe/QFk8TFOLmA+UJ8Kdy2ZpVg4uCAQUO2y8p
         k58YxExkOatIEYOBNyZemD417tbA+ZETJlv4gLAHjgAvemosTIXIrJJhJ+1a6GHs41ik
         o92t0SU3qw8ixp4CyhPGXtK7owBudFBeIHNGZXd3X6WUxcT900h9XGVC4/Drxcm8WXMt
         bDYJS8BpIAUtAiOA4WlO21Dq9cdPnmtXItVUGHm0/qiN13BndXA4fbUPHfUSMHDLhuBk
         D/jOiPu2nIkJRnxkbsAAvsyTvph6n5K20TmZH9kmjX2EQI7s0X/9wiYQuPsyP03lfOFk
         i5AQ==
X-Gm-Message-State: AFqh2kpslBqFAMJnV42mG6TPAX+5CS0my4ntMwFsy8IZBIeytwzFJGDm
        NNcxXCqrYX/EtnOMxTZ5zfGhgQ==
X-Google-Smtp-Source: AMrXdXuaPp8teht4jYnNx8xph4n3y4KgWAziqnyhVLFUe0joH+LWYntfx/GZhFy1gnunTYAAGzDgXA==
X-Received: by 2002:a17:902:ebca:b0:191:117a:414f with SMTP id p10-20020a170902ebca00b00191117a414fmr64827715plg.27.1672978938888;
        Thu, 05 Jan 2023 20:22:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13-20020a63e34d000000b004a3510effa5sm78223pgj.65.2023.01.05.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 20:22:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 20:22:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: Replace 0-length array with flexible array
Message-ID: <202301052021.5AEF89CB@keescook>
References: <20230105233420.gonna.036-kees@kernel.org>
 <CAMZ6RqK96DNAPO5A32i3EaDErU0C2RDtL4-JN2O8A5RBBUo3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqK96DNAPO5A32i3EaDErU0C2RDtL4-JN2O8A5RBBUo3ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 06, 2023 at 09:55:30AM +0900, Vincent MAILHOL wrote:
> On Fri. 6 Jan 2023 at 08:34, Kees Cook <keescook@chromium.org> wrote:
> > Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> > "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> > using -fstrict-flex-arrays=3:
> >
> > net/ethtool/common.c: In function 'ethtool_get_max_rxnfc_channel':
> > net/ethtool/common.c:558:55: warning: array subscript i is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
> >   558 |                         .fs.location = info->rule_locs[i],
> >       |                                        ~~~~~~~~~~~~~~~^~~
> > In file included from include/linux/ethtool.h:19,
> >                  from include/uapi/linux/ethtool_netlink.h:12,
> >                  from include/linux/ethtool_netlink.h:6,
> >                  from net/ethtool/common.c:3:
> > include/uapi/linux/ethtool.h:1186:41: note: while referencing
> > 'rule_locs'
> >  1186 |         __u32                           rule_locs[0];
> >       |                                         ^~~~~~~~~
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: kernel test robot <lkp@intel.com>
> > Cc: Oleksij Rempel <linux@rempel-privat.de>
> > Cc: Sean Anderson <sean.anderson@seco.com>
> > Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> > Cc: Amit Cohen <amcohen@nvidia.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: resend, this time without missing netdev CC. :)
> > ---
> >  include/uapi/linux/ethtool.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > index 58e587ba0450..9b97b3e0ec1f 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
> >                 __u32                   rule_cnt;
> >                 __u32                   rss_context;
> >         };
> > -       __u32                           rule_locs[0];
> > +       __DECLARE_FLEX_ARRAY(__u32,     rule_locs);
> 
> Can't this simply be a C99 flexible array member?
> 
>         __u32                           rule_locs[];
> 
> As far as I understand, __DECLARE_FLEX_ARRAY() is a hack to allow the
> declaration of a flexible array within unions (which otherwise do not
> accept flexible array members). However, ethtool_rxnfc being a struct,
> I do not see the need for __DECLARE_FLEX_ARRAY() here.

Good point -- I think my eyes scanned through the "union" above and I
just jumped at using __DECLARE_FLEX_ARRAY. I'll send a v2. Thanks!

-- 
Kees Cook
