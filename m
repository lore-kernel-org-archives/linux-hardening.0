Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB2EE8019
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 16:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbjIHQLP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244937AbjIHQLP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 12:11:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723E1FC4
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 09:11:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68e3083aa1dso2109456b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694189470; x=1694794270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5XWofP145WE08el5mK8likzGh8OJQmJSQyhLGqN5AY=;
        b=Dbk7SETP19gMkTfxq5vqgtybjsaCMa5WcAlBBq407JsTgsO1SPIp5Ffbq21uaZCX++
         c1K6A5r5xZlhA0AA00Y9qge6ZjblRnwJj3U+AHmVsJItCPYFF+lKnkl6/yxni6F5c/Mk
         r0+iW3+Rt1i6h8MlhYA/FV7atKiHfHkpPbdgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189470; x=1694794270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5XWofP145WE08el5mK8likzGh8OJQmJSQyhLGqN5AY=;
        b=tHdrdBHEIwNfaJZ6UCBqLJV1HdYs2GPlYUKQpfalK/Ndk6lWOBCvbHWgJmTC9oCNvM
         /riM/pqpLXwyITwGKFQr36f/irmdylaTrtT700Kglhk69pQxgaSmhuFHyjSsf/I8SjBL
         EzvWt6Hzg7tbnG1fbKISxLQZpJma2z+E10mMilgqhDVY65GGozLU5rXgrj9/Lv51C1Lu
         vvBxuXweOWP4bQAC3uZQPCuZ/rVZUvtuDCqs+Lxzh5G/5cgLy1piRZd1T7JUyfTu9ffO
         851HbATYikZyZdhvs5qvhuK4ROPamF8x7rwSDMmNyUmGDNZljPriLXtbMkON9d8avv7T
         zEBw==
X-Gm-Message-State: AOJu0YyfMgD5GIJGvTUvFB8PhMoZYrnpqw92XR1PHlE0lG2pktwF7OQp
        +/xkY1+0sUwkNAxc5+Fmlm/WXWR1BpQt8+40xAQ=
X-Google-Smtp-Source: AGHT+IEUvxwSx4nLanWnBC4W0VoCUil6UkDi838YCC8GDKfesIx0vo5YJCoPib+C0X/g2//i/dWCaQ==
X-Received: by 2002:a05:6a00:852:b0:68e:4303:edb8 with SMTP id q18-20020a056a00085200b0068e4303edb8mr3129470pfk.30.1694189469777;
        Fri, 08 Sep 2023 09:11:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a00138e00b0068782960099sm1148785pfg.22.2023.09.08.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:11:09 -0700 (PDT)
Date:   Fri, 8 Sep 2023 09:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <202309080910.44BB7CEF@keescook>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 08, 2023 at 07:03:17PM +0300, Alexey Dobriyan wrote:
> On Fri, Sep 08, 2023 at 08:53:12AM -0700, Kees Cook wrote:
> > On Fri, Sep 08, 2023 at 06:14:38PM +0300, Alexey Dobriyan wrote:
> > > __DECLARE_FLEX_ARRAY(T, member) macro expands to
> > > 
> > > 	struct {
> > > 		struct {} __empty_member;
> > > 		T member[];
> > > 	};
> > > 
> > > which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
> > 
> > Ewwww. Isn't this a bug in C++?
> 
> Sort of, but it can't be fixed.
> 
> > > changing UAPI structures layouts.
> > > 
> > > This can be fixed by expanding to
> > > 
> > > 	T member[];
> > > 
> > > Now g++ doesn't like "T member[]" either throwing errors on code like
> > > this:
> > > 
> > > 	struct S {
> > > 		union {
> > > 			T1 member1[];
> > > 			T2 member2[];
> > > 		};
> > > 	};
> > > 
> > > or
> > > 
> > > 	struct S {
> > > 		T member[];
> > > 	};
> > > So use
> > > 
> > > 	T member[0];
> > > 
> > > which seems to work and does the right thing wrt structure layout.
> > 
> > It seems sad to leave C++ broken, but I guess we have to do this.
> > 
> > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > > Fix header guard while I'm at it.
> > 
> > Hm, when did that get broken? Maybe that should be fixed separately?
> 
> By your last commit?

:( Oops. I'm shocked this hasn't caused bigger problems.

> 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > 
> > Probably a Fixes: tag would be nice too.
> 
> OK
> 
> Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
> Fixes: 3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper")

Okay, can you please split the patch so they can be backported
separately? Then I'll get them landed, etc.

Thanks for fixing these!

-Kees

-- 
Kees Cook
