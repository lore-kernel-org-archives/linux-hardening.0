Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFBC001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHJSbs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJSbs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 14:31:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B626BA
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:31:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdb08e9057so3635485ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691692306; x=1692297106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRu5f/aCaNR7Qpd/C7QF+nwdA4/ZGiMpJZ4g0pj/koI=;
        b=exUC1YmUgaJK8xNE59qi6sgwc1o8df+FleF0y7jxgEHwbhiyyvm8Zhv3VcrEuZGxPY
         jY9Bc2bZFTJOemXPLDAQWt5/ThKn3uUeS1rlrBzAgvfAM2H/opLXONw4vgGZz9ntcYps
         rrdJnMvIsw+XBZcetaMgLhBoFIOCKq47ScnEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692306; x=1692297106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRu5f/aCaNR7Qpd/C7QF+nwdA4/ZGiMpJZ4g0pj/koI=;
        b=Fds69TCbr4glig7AdhVKRO1k3Ywn78NYFZ1CiUofZreAWiy3/51zTJBRZ4dB1siVTc
         SrrbFKE/4uCNuxthW4T6wnxiQBKOreHi+qMhtaaK4cYn9H6Fhq+Gw5FgCc2QL4/AP6KD
         2Wz7EEQoHBlM1PXjWgSeREVoDs2pVZoVvdB1ib4UCYhlLDCPfDFY2ORt+tpO0DellDea
         JqpewfUTNH7kzxbmDi0cVP+oUby4N0mJlGoUS+fkqmKfNAQR0bXtP7dzekQWbEepYgOd
         X4RazBlnxAe4duwtQ+Va337UYG6gvLvsyvyyalPMm+rQCLxhU28YcLTcXvx2SpgZU72B
         CZpg==
X-Gm-Message-State: AOJu0Yxpns3IacA+5kOJpYdY4+4Mnknqi/x7iS5mlueTW1PkfUrbbKP9
        qpd+JWCvABTIVz1MTIM4CnBWDw==
X-Google-Smtp-Source: AGHT+IHHObZZyY9Or/OTawwzOxroUBnHrJSBanqV1Yfo/0w0RduYz4qwgfpa6K1IKDxG+5xqeFlspQ==
X-Received: by 2002:a17:902:da92:b0:1bb:1494:f7f7 with SMTP id j18-20020a170902da9200b001bb1494f7f7mr3698148plx.23.1691692306542;
        Thu, 10 Aug 2023 11:31:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm2103416plb.156.2023.08.10.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:31:45 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:31:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
        Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v1 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308101128.C4F0FA235@keescook>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
 <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
 <e6565705-4867-c07f-5cc7-4e9155b5a4e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6565705-4867-c07f-5cc7-4e9155b5a4e9@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 06:24:47PM +0200, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Thu, 10 Aug 2023 06:35:03 -0400
> 
> > Add DEFINE_FLEX() macro for on-stack allocations of structs with
> > flexible array member.
> > 
> > Add also const_flex_size() macro, that reads size of structs
> > allocated by DEFINE_FLEX().
> > 
> > Using underlying array for on-stack storage lets us to declare
> > known-at-compile-time structures without kzalloc().
> > 
> > Actual usage for ice driver is in following patches of the series.
> > 
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> > v1: change macro name; add macro for size read;
> >     accept struct type instead of ptr to it; change alignment;
> > ---
> >  include/linux/overflow.h | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index f9b60313eaea..21a4410799eb 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> >  #define struct_size_t(type, member, count)					\
> >  	struct_size((type *)NULL, member, count)
> >  
> > +/**
> > + * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
> > + * a trailing flexible array member.
> > + *
> > + * @type: structure type name, including "struct" keyword.
> > + * @name: Name for a variable to define.
> > + * @member: Name of the array member.
> > + * @count: Number of elements in the array; must be compile-time const.
> > + */
> > +#define DEFINE_FLEX(type, name, member, count)					\
> > +	union {									\
> > +		u8 bytes[struct_size_t(type, member, count)];			\
> > +		type obj;							\
> > +	} name##_u __aligned(_Alignof(type)) = {};				\
> 
> Hmm. Should we always zero it? The onstack variables are not zeroed
> automatically.
> I realize the onstack structures declared via this macro can't be
> initialized on the same line via = { }, but OTOH memset() with const len
> and for onstack structs usually gets expanded into static initialization.
> The main reason why I'm asking is that sometimes we don't need zeroing
> at all, for example for small structures when we then manually set all
> the fields either way. I don't think hiding static initialization inside
> the macro is a good move.

I strongly think this should be always zeroed. In the case where all
members are initialized, the zeroing will be elided by the compiler
during Dead Store Elimination optimization passes.

Additionally, padding, if present, would not get zeroed even if all
members got initialized separately, and if any memcpy() of the structure
was made, it would contain leaked memory contents.

Any redundant initializations will be avoided by the compiler, so let's
be safe by default and init the whole thing to zero.

-Kees

-- 
Kees Cook
