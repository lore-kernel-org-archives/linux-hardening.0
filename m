Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2CCC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 18 May 2022 20:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiERUVL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 May 2022 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbiERUVJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 May 2022 16:21:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70D77F03
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 13:21:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so6684725pjp.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1YyneiqAhP2skYJhZG2vdelPFXsdfsTJ3CJYnzR02Y=;
        b=mXJwCdTGU/Ox9qVjYl4IfaSVZDN0CPcyG5aS9Q0Gl2sPg5O9wSmomrc8Jy+lMxH3o/
         zU+yGjQMVDiCfodJ++RAp9K1TsdHxUzF2BARh4MtL/gv0/DPxasbQvp48pI5TU5BYKm9
         bnGRyfqDMA4iwhSUwTXkxpKse6PQVxaFMecg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1YyneiqAhP2skYJhZG2vdelPFXsdfsTJ3CJYnzR02Y=;
        b=aWwNrrQE2lxgDis7M8sKh19n0WpONUOPPpIXzEcIX+iorzjNif4WiV1G3J7YZWlgUs
         6Yg06ySOeEJ5LZowpoZQXhbwjStjl4+DZNWwZA29cmyhr5u24w+yA5/bA20pdJDPnaeQ
         0yEQaoYEoJjHGRmlOe2J3lK3NgaqXL9MUT1kGNRuuMp/z8QZdggY9CGDgUFa1s4f4Ox+
         rIxaFNHDDvpoI1jlGTcymQCpCOfJ8pf0/16BKfWP65pfmebHiMIPt5BH2VO8/AEN2M3Z
         7iwgO26acif5N77Z+DTjXn3UP6XwqhhdE5VeCFH9ZVCpRyleYwbk7xrLmmKVSMxYVjh1
         tZVg==
X-Gm-Message-State: AOAM530B7HuQxXsnOuN7QwLC4lHV+b0uAh7kaLslrKfK/YwYtR7Mb5N8
        qqL+ebeaE9u54Sa78qTsHbK4ng==
X-Google-Smtp-Source: ABdhPJzHz3qqkVHEieBNuWdEWbta0GSniXSx+soddHqy7nGvnJNH9ZWx1lfGNk/h2UWWPq9ty3hseg==
X-Received: by 2002:a17:90a:530e:b0:1db:de96:dff5 with SMTP id x14-20020a17090a530e00b001dbde96dff5mr1228602pjh.22.1652905268636;
        Wed, 18 May 2022 13:21:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015eaa9aee50sm2089590pla.202.2022.05.18.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:21:08 -0700 (PDT)
Date:   Wed, 18 May 2022 13:21:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
Message-ID: <202205181229.E12F85BBBE@keescook>
References: <20220517210230.864239-1-keescook@chromium.org>
 <2692904.1652861114@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692904.1652861114@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 18, 2022 at 09:05:14AM +0100, David Howells wrote:
> [...]
> I don't want to do the following, say:
> 
> 
> 	struct afs_vnode {
> 		struct netfs_i_c_pair ni;
> 		...
> 	};
> 
> as that would then require a lot of s/->vfs_inode/->ni.vfs_inode/, but maybe
> it would be better to include a struct inode in struct netfs_i_context, and

Right; that's why I kept the struct internal -- the implicit ordering of
inode and netfs_i_context is already present in all the users.

> On the other hand:
> 
> 	warthog>git grep '[>.]vfs_inode' -- fs/{9p,afs,ceph,cifs,nfs} | wc -l
> 	181

That seems painful. Maybe _new_ users of netfs could be written to use
the proposed netfs_inode:

> so maybe a mass change to, say:
> 
> 	struct netfs_inode {
> 		struct inode vfs_inode;
> 		...
> 	};

Better yet, netfs can define a macro helper. I'll send a v2...

-- 
Kees Cook
