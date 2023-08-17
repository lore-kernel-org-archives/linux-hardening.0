Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C8CC3DA58
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 17:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjHQRAv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 13:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353791AbjHQRAV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 13:00:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00B2D73
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 10:00:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-688731c6331so2215200b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291619; x=1692896419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJhpOKYygfVTwv/muBcWLGwZoRPdxuU8yz2KMU9B00o=;
        b=BXFnBPkfR3sQEgInQUXxcixS4Rxh5w0uTrfa8bekCw4+fl6YRwyldBR2Cd6t1X9x8z
         3Uzvb4SGP3p+l/QkarFDWiXW97wF+umwHMIfTdKYKMnIlSevQoPRHpj0/Muw/v4aJDt6
         HcVyK5RXx+fRlZYdVgRmcyTrUqOulmp6cFuDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291619; x=1692896419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJhpOKYygfVTwv/muBcWLGwZoRPdxuU8yz2KMU9B00o=;
        b=ejkJhpnkUzPch+JVd45kaVUxBeRpDMgALNpp10VaZ1q+BmhIs8zzCXUic+K9l6RyQw
         9hjtrgM6+svF9b5KpsyTojuqnyyzNDfr5oOt7/0poqTSJVWYQ0UXiPEGeAiXYtrThTDl
         0KCjAwfNQVjft+aGxSywEtCgz+SXdE4NurUGY+/KtqNwBALhZfUgBpfDDPQN+uxZTxef
         IjalyCKNWkO443sij+XneMh/Pfovlv81/z6oSRxcJzd4/bgMfJAV0Ny0SmtMAknZB+wv
         Yp/ogh97/VZcgWNKFc+KEAmvy5FgiBPt/mCds670mVSxcmUER1tWWu3sHqSI90IUUMff
         jOXg==
X-Gm-Message-State: AOJu0YxtVZTtM5QUpl8+8j/O4zD7yZ6U9BXqDTgoKHF0VYvRv+N0qp8Q
        IR5qb0zODZEU2JAZMUS24dOagA==
X-Google-Smtp-Source: AGHT+IGfkKsLOQz6+e+EW5vzdI+McSp2GYuMvONN8EpwvhQgT4MGydmr4ZY2beFstZQdjjWOFyBPoQ==
X-Received: by 2002:a05:6a20:8421:b0:13b:a4fd:3017 with SMTP id c33-20020a056a20842100b0013ba4fd3017mr304951pzd.46.1692291618930;
        Thu, 17 Aug 2023 10:00:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b006884844dfcasm7319pfh.20.2023.08.17.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:00:18 -0700 (PDT)
Date:   Thu, 17 Aug 2023 10:00:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Przemek Kitszel' <przemyslaw.kitszel@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308170957.F511E69@keescook>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 02:35:23PM +0000, David Laight wrote:
> From: Przemek Kitszel
> > Sent: Wednesday, August 16, 2023 3:06 PM
> > 
> > Using underlying array for on-stack storage lets us to declare
> > known-at-compile-time structures without kzalloc().
> 
> Isn't DEFINE_FLEX() a bit misleading?
> One thing it isn't is 'flexible' since it has a fixed size.

It works only on flex array structs, and defines a specific instance. I
think naming is okay here.

> 
> > +#define DEFINE_FLEX(type, name, member, count)					\
> > +	union {									\
> > +		u8 bytes[struct_size_t(type, member, count)];			\
> > +		type obj;							\
> > +	} name##_u __aligned(_Alignof(type)) = {};				\
> 
> You shouldn't need the _Alignof() it is the default.

In the sense that since "type" is in the union, it's okay?

> I'm not sure you should be forcing the memset() either.

This already got discussed: better to fail safe.

> 
> > +	type *name = (type *)&name##_u
> 
> How about?
> 	type *const name = &name_##_u.obj;

This is by design (see earlier threads) so that
__builtin_object_size(name, 1) will get the correct size. Otherwise it
doesn't include the FAM elements in the size.

> 
> You might want to add:
> 	Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #count);

That would be nice, though can Static_assert()s live in the middle of
variable definitions?

-Kees

-- 
Kees Cook
