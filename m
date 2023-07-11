Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FBCEB64DC
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Jul 2023 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGKQOx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKQOw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Jul 2023 12:14:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E0E5C
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jul 2023 09:14:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3a8d21208so5126528b6e.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jul 2023 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689092090; x=1691684090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq9YViWYg4uFChvJGSLE3j7fYiOn1S8zzbS7MgZUOXM=;
        b=JnU40aqXrl+cQXJk+/mWGhypL/UL4FW42fibfXNLp4FDHbP6XSKttylnrv712ddyCS
         QQiAkK4VyodEzrwPiYTOu3AnXnDvRdzb3zq1Eb9j/1HiZN1ZbrRv0XaTUkXjQRh/C60X
         aRnapaN/LqPA5iZkV1sZtWXCNBY011f1uE2TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092090; x=1691684090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq9YViWYg4uFChvJGSLE3j7fYiOn1S8zzbS7MgZUOXM=;
        b=JDbg8z+JOQxbBoINVa+2mmHkYKLg+XiYz/ZpM5v8xZ9zm7WsHZK/dA5Qqj80B4k+Xt
         WmNkyZ09oYjTNp2JQFK3im5Ks3PSF5VS+rpxddJjl3JE+Y3+E06lUvPg0+aYUx6ycNKu
         vT1zx0E8drseF5X3YIf1FOPvNHrH9JOb16Av4rfsRNEcAQbbysyq2TBBc0VZcZHcnJal
         fWCWbLrQEYUTdRAj+sGh1esMAclGVUnkeUge+l8g2tt23YdtV9sYz0PqlMPdRkI7zvTp
         UOSloK/JHa2bOZIVC8OWey6n1Y4PgZMG1vQbfVdck+6t94LzS6dQdtFTHLOsZ3bAeEGL
         a3ZA==
X-Gm-Message-State: ABy/qLba3Hut94LDZSrDvWDKEU/QGTnOxHoEli0BvqH5lCiMmxe/DJH/
        hrqNNwpl1hTvtWgZxvAyX0tY+A==
X-Google-Smtp-Source: APBJJlHccKfb9VbDm1W28Cl55SHynKCuE6YH+AftvD/+oHJ7aeij8ZFnaHC/iLkVZXwDULUqM4kjfQ==
X-Received: by 2002:a05:6358:290b:b0:134:e4c4:ebff with SMTP id y11-20020a056358290b00b00134e4c4ebffmr16820772rwb.11.1689092090568;
        Tue, 11 Jul 2023 09:14:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a63724a000000b0055386b1415dsm1802755pgn.51.2023.07.11.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:14:49 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:14:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: remove redundant kasan_reset_tag() from
 freelist_ptr calculations
Message-ID: <202307110914.8D460C7@keescook>
References: <20230711134623.12695-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711134623.12695-3-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 11, 2023 at 03:46:24PM +0200, Vlastimil Babka wrote:
> Commit d36a63a943e3 ("kasan, slub: fix more conflicts with
> CONFIG_SLAB_FREELIST_HARDENED") has introduced kasan_reset_tags() to
> freelist_ptr() encoding/decoding when CONFIG_SLAB_FREELIST_HARDENED is
> enabled to resolve issues when passing tagged or untagged pointers
> inconsistently would lead to incorrect calculations.
> 
> Later, commit aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing
> metadata") made sure all pointers have tags reset regardless of
> CONFIG_SLAB_FREELIST_HARDENED, because there was no other way to access
> the freepointer metadata safely with hw tag-based KASAN.
> 
> Therefore the kasan_reset_tag() usage in freelist_ptr_encode()/decode()
> is now redundant, as all callers use kasan_reset_tag() unconditionally
> when constructing ptr_addr. Remove the redundant calls and simplify the
> code and remove obsolete comments.
> 
> Also in freelist_ptr_encode() introduce an 'encoded' variable to make
> the lines shorter and make it similar to the _decode() one.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, this is much more readable!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
