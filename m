Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD6C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Nov 2022 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiKPW4g (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiKPW41 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 17:56:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7941663D2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 14:56:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so268658pjk.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GiOuTv0Y83uWeHmwFnOugVQTYhEP8LeyahdHa6ev9kM=;
        b=kmurDlnR2S1s1gwNG3LHjq+Kf8wCcMB9TxESeQ3Hb2PKt7WZ72hWg3HebhuF/Hkl8p
         EnrC1JK3X1LI1kbm4pintY5WjeXy/tHNe6HiTxxsoNPTZ62+eV032UoVaOnUI2SlUTQ4
         khPDRPKIXNSwQUvud9C4Q7AAr+hP5FvGKw2g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiOuTv0Y83uWeHmwFnOugVQTYhEP8LeyahdHa6ev9kM=;
        b=g7SZPl4slSDuZM7jJwSdCGhb8r5YHUMVBea5CaPWeTn5yUn02/Ox17ZtudNUnvDLXM
         OsMtaDj6lxgur9qVHAbuDNpPbs/6/isLEtGap5MjQs7s+8HNicVvTRkPXO+K5rwEGM9l
         oUDOygVKQTaVI3UJH+O3DVdZ9Ur+KJtEIClsOzlfxpfX20YEiREGCp3Z6DYPB8/gjFLA
         csNUAIuO3jDpQKif1WKOyu3x4jEtLamXogq0m2W9K11n1alfUDjNHYAEXWmytbXaEJvg
         Di07+niz5CXIHbydI575vCPWuIWEW8DJ2amDCDr9rxixO6YhCNXH9mTbqB1ORd1pg5Tk
         vLEg==
X-Gm-Message-State: ANoB5pn47Xkp0Go+z2dhvWq7RA2+Z/vBG9Wn9IOxdsEZNYPg2pGBHjho
        /cjhbUkRSHeuNn4o3DNnAmMiUw==
X-Google-Smtp-Source: AA0mqf5Nu4Mo958iwkxzCF8h2kIG4oIVU16gDjPtH0QISGOyY0LgClbiU1M4UIpRtwz0SsX1MdNy2Q==
X-Received: by 2002:a17:90a:3d49:b0:213:9458:8a93 with SMTP id o9-20020a17090a3d4900b0021394588a93mr5881187pjf.233.1668639386171;
        Wed, 16 Nov 2022 14:56:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k135-20020a636f8d000000b0046ff7db0984sm10265642pgc.72.2022.11.16.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:56:25 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:56:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: split up copies in the ack
 construction
Message-ID: <202211161454.D5FA4ED44@keescook>
References: <20221027212553.2640042-1-kuba@kernel.org>
 <20221114023927.GA685@u2004-local>
 <20221114090614.2bfeb81c@kernel.org>
 <202211161444.04F3EDEB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211161444.04F3EDEB@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

[sorry for the dup; resending with Gustavo actually CCed]

On Mon, Nov 14, 2022 at 09:06:14AM -0800, Jakub Kicinski wrote:
> On Sun, 13 Nov 2022 19:39:27 -0700 David Ahern wrote:
> > On Thu, Oct 27, 2022 at 02:25:53PM -0700, Jakub Kicinski wrote:
> > > diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> > > index e2ae82e3f9f7..5da0da59bf01 100644
> > > --- a/include/uapi/linux/netlink.h
> > > +++ b/include/uapi/linux/netlink.h
> > > @@ -48,6 +48,7 @@ struct sockaddr_nl {
> > >   * @nlmsg_flags: Additional flags
> > >   * @nlmsg_seq:   Sequence number
> > >   * @nlmsg_pid:   Sending process port ID
> > > + * @nlmsg_data:  Message payload
> > >   */
> > >  struct nlmsghdr {
> > >  	__u32		nlmsg_len;
> > > @@ -55,6 +56,7 @@ struct nlmsghdr {
> > >  	__u16		nlmsg_flags;
> > >  	__u32		nlmsg_seq;
> > >  	__u32		nlmsg_pid;
> > > +	__u8		nlmsg_data[];  
> > 
> > This breaks compile of iproute2 with clang. It does not like the
> > variable length array in the middle of a struct. While I could re-do the
> > structs in iproute2, I doubt it is alone in being affected by this
> > change.

Eww.

> 
> Kees, would you mind lending your expertise?
> 
> Not sure why something like (simplified):
> 
> struct top {
> 	struct nlmsghdr hdr;
> 	int tail;
> }; 
> 
> generates a warning:
> 
> In file included from stat-mr.c:7:
> In file included from ./res.h:9:
> In file included from ./rdma.h:21:
> In file included from ../include/utils.h:17:
> ../include/libnetlink.h:41:18: warning: field 'nlh' with variable sized type 'struct nlmsghdr' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>         struct nlmsghdr nlh;
>                         ^
> 
> which is not confined to -Wpedantic. 
> Seems like a useless warning :S

Yeah, this surprises me. But I can certainly reproduce it:
https://godbolt.org/z/fczq8sqbv

Gustavo, do you know what's happening here? GCC (and Clang) get mad
about doing this in the same struct:

struct nlmsghdr {
    __u32           nlmsg_len;
    __u16           nlmsg_flags;
    __u32           nlmsg_seq;
    __u32           nlmsg_pid;
    __u8            nlmsg_data[]; 
    int wat; 
};

<source>:10:21: error: flexible array member not at end of struct
   10 |     __u8            nlmsg_data[];
      |                     ^~~~~~~~~~

But the overlapping with other composite structs has been used in other
areas, I thought? (When I looked at this last, I thought the types just
had to overlap, but that doesn't seem to help here.)

-Kees

-- 
Kees Cook
