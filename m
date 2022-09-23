Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F2C6FA83
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 18:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiIWSun (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiIWSum (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 14:50:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457D120BFD
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 11:50:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so1029362pgi.10
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=soz+B5vr0YawBrGLCJUIfst1rVPegj/kO945i6tNuu4=;
        b=OTfy5Nwpn08IcUaVlU1KJ27X+N3yWZ/VpCrAZjSpjUbsjTe/slddbrLCSNWyrUEUf+
         hKFo3f2nFf90BAG6jEHb+7lo8EJfEwNPirhgwBNLji96jC6KqEyl6t0+uMZVhfPqRt/6
         nRku1i36Slqm6llnH2++9t4exlSoETdRFUkh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=soz+B5vr0YawBrGLCJUIfst1rVPegj/kO945i6tNuu4=;
        b=5JKYMwho8JwcA7i9Z/n2PjGeEWq8jqJx971Y90aT5NP949BPMZVB8TOWkINRFEeDap
         3zDYLHt0EOJYPGBXHQzhWTKfDi7TT5Tp0q854oLu6JYd+GAsHojoFdcs7lwCW0vXUVs+
         SrqRio98fE0CUVaBsxlU/ZuYVaznA/40m9vgrbvqmWOpnIqQFsvyZ9QdCJ3s81ElC3Mf
         vim1fU81ZHwlZ2ITQrrvRy/aTgchFwJEMaxi1JshC8diaXxG16rYYhLBzu+4fSO5FL3t
         NoU3Awb+ouA8lZp+RrzCBL2v7ZO7J6v1ZATDtRkrGyAv6zWMB4aEcOXFRnEp+DjvJAz9
         TBzg==
X-Gm-Message-State: ACrzQf1lrH0ZwgvwxBQPaoZn2qzF5Lbj/4VV47cauFQ/tRGHIJGKL6sK
        MlZrIiMqpq2Zbo6JDIvz5V16yA==
X-Google-Smtp-Source: AMsMyM5BOkxT7dmLhP+9f8RXqZTh1AjF61zhu3wqGKFHMmPuMGgEdboAX7cqSq5H5AVVbN7wJUrI2g==
X-Received: by 2002:a63:6a47:0:b0:439:be00:7607 with SMTP id f68-20020a636a47000000b00439be007607mr8719395pgc.301.1663959039042;
        Fri, 23 Sep 2022 11:50:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b0016dc6279ab7sm6423837plg.149.2022.09.23.11.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:50:38 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:50:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Feng Tang <feng.tang@intel.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian K??nig <christian.koenig@amd.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 01/12] slab: Introduce kmalloc_size_roundup()
Message-ID: <202209231145.7654767ED5@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-2-keescook@chromium.org>
 <YyxDFfKmSNNkHBFi@hyeyoo>
 <Yy0JJV4c3DffCF+4@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy0JJV4c3DffCF+4@feng-clx>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 23, 2022 at 09:17:25AM +0800, Feng Tang wrote:
> On Thu, Sep 22, 2022 at 07:12:21PM +0800, Hyeonggon Yoo wrote:
> > On Wed, Sep 21, 2022 at 08:10:02PM -0700, Kees Cook wrote:
> > > [...]
> > > Introduce kmalloc_size_roundup(), to serve this function so we can start
> > > replacing the "anticipatory resizing" uses of ksize().
> > [...]
> >
> > This looks okay.
> > [...]
> > Cc-ing Feng Tang who may welcome this series ;)
>  
> Indeed! This will help our work of extending slub redzone check,
> as we also ran into some trouble with ksize() users when extending
> the redzone support to this extra allocated space than requested
> size [1], and have to disable the redzone sanity for all ksize()
> users [2].
> 
> [1]. https://lore.kernel.org/lkml/20220719134503.GA56558@shbuild999.sh.intel.com/
> [2]. https://lore.kernel.org/lkml/20220913065423.520159-5-feng.tang@intel.com/

Thanks for the feedback! I'll send my v2 series -- I'm hoping at least
this patch can land in v6.1 so the various other patches would be clear
to land via their separate trees, etc.

-- 
Kees Cook
