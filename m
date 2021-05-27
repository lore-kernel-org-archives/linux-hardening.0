Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CEC4707F
	for <linux-hardening@archiver.kernel.org>; Thu, 27 May 2021 21:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1FA613E2
	for <linux-hardening@archiver.kernel.org>; Thu, 27 May 2021 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhE0Vcs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 May 2021 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbhE0Vcs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 May 2021 17:32:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC7AC061761
        for <linux-hardening@vger.kernel.org>; Thu, 27 May 2021 14:31:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso1251730pjq.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 May 2021 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggxXu6khFzuHqhI0ulwwbMYsWS89137XDyToRCuLR6Y=;
        b=dZ+XUsedmo86h4NhBMsgswFCTPlxr3liApdTFu+31HaTfDmWsBUULBS4+NAXxo95f9
         1ORhr+Nb9eiOqs3M1fMfwySr/Lh2N8IRUndewhoIRakj+vjdn+eV4SZk38wSebLH2dI/
         FbGaPq2YWUdTN7HT1Zx7F7bdsQnM2nSG7OnOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggxXu6khFzuHqhI0ulwwbMYsWS89137XDyToRCuLR6Y=;
        b=QbVbhSpfBqBGboZP5gpbwMFoKzhOq4yyhnb2DG9GTEg6VnfTFgEERxjiR9G9g1jzKt
         9xKbEuCqejV+K9NCZBleu5k58Y3zOmGhZzsGfO1mmyCKoFDITi2xUMdC434oKu/+8KWk
         64ydiB3RTfLwwT9eP1Mh08gqxV1+wrZg+4BL8hogsZvmVjBLU8TROTyCGTjuejpDfLgM
         5iCzy92kcDfoG5YVNUq59erOnaE/2I59I+7qRwS6pH+Kf71VKXE+YunR4FB3zmrlzDJ0
         YU1SLeKry3PViyK9E8QfQxgOQbwLVhUwUPd4vJSyQCMcRE1rfLss+3QV3GNN9JKOAd9T
         oZPw==
X-Gm-Message-State: AOAM531DNqzJ/DeM1QnkMj5O0HPXi4nL/2MJRkJknt2Do7m7ydp9adm0
        nM3X/PsivzGWLtHorO0dSKNvu/Qy8uniQQ==
X-Google-Smtp-Source: ABdhPJzwu8ym8ft0mEUJfJozHYnglV77DSgsagFBD/Q4TMQwQdy9KB3lKermhhPFy/AQ7tte+s40xQ==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr568949pjb.133.1622151074440;
        Thu, 27 May 2021 14:31:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm2952946pfg.102.2021.05.27.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:31:13 -0700 (PDT)
Date:   Thu, 27 May 2021 14:31:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH][next] xfs: Fix fall-through warnings for Clang
Message-ID: <202105271358.22E0E2BFD@keescook>
References: <20210420230652.GA70650@embeddedor>
 <20210420233850.GQ3122264@magnolia>
 <62895e8c-800d-fa7b-15f6-480179d552be@embeddedor.com>
 <bcae9d46-644c-d6f6-3df5-e8f7c50a673d@embeddedor.com>
 <20210526211624.GB202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526211624.GB202121@locust>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 26, 2021 at 02:16:24PM -0700, Darrick J. Wong wrote:
> On Wed, May 26, 2021 at 01:21:06PM -0500, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 4/20/21 18:56, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 4/20/21 18:38, Darrick J. Wong wrote:
> > >> On Tue, Apr 20, 2021 at 06:06:52PM -0500, Gustavo A. R. Silva wrote:
> > >>> In preparation to enable -Wimplicit-fallthrough for Clang, fix
> > >>> the following warnings by replacing /* fall through */ comments,
> > >>> and its variants, with the new pseudo-keyword macro fallthrough:
> > >>>
> > >>> fs/xfs/libxfs/xfs_alloc.c:3167:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/libxfs/xfs_da_btree.c:286:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/libxfs/xfs_ag_resv.c:346:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/libxfs/xfs_ag_resv.c:388:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_bmap_util.c:246:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_export.c:88:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_export.c:96:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_file.c:867:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_ioctl.c:562:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_ioctl.c:1548:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_iomap.c:1040:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_inode.c:852:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_log.c:2627:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/xfs_trans_buf.c:298:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/bmap.c:275:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/btree.c:48:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/common.c:85:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/common.c:138:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/common.c:698:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/dabtree.c:51:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>> fs/xfs/scrub/repair.c:951:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> > >>>
> > >>> Notice that Clang doesn't recognize /* fall through */ comments as
> > >>> implicit fall-through markings, so in order to globally enable
> > >>> -Wimplicit-fallthrough for Clang, these comments need to be
> > >>> replaced with fallthrough; in the whole codebase.
> > >>>
> > >>> Link: https://github.com/KSPP/linux/issues/115
> > >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > >>
> > >> I've already NAKd this twice, so I guess I'll NAK it a third time.
> > > 
> > > Darrick,
> > > 
> > > The adoption of fallthrough; has been already accepted and in use since Linux v5.7:
> > > 
> > > https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > > 
> > > This change is needed, and I would really prefer if this goes upstream through your tree.
> > > 
> > > Linus has taken these patches directly for a while, now.
> > > 
> > > Could you consider taking it this time? :)
> > > 
> > 
> > Hi Darrick,
> > 
> > If you don't mind, I will take this in my -next[1] branch for v5.14, so we can globally enable
> > -Wimplicit-fallthrough for Clang in that release.
> > 
> > We had thousands of these warnings and now we are down to 47 in next-20210526,
> > 22 of which are fixed with this patch.
> 
> I guess we're all required to kowtow to a bunch of effing bots now.
> Hooray for having to have a macro to code-switch for the sake of
> stupid compiler writers who refuse to give the rest of us a single
> workable way to signal "this switch code block should not end here":
> 
> /* fall through */
> __attribute__((fallthrough));
> do { } while (0) /* fall through */
> 
> and soon the ISO geniuses will make it worse by adding to C2x:
> 
> [[fallthrough]];
> 
> Hooray!  Macros to abstractify stupidity!!!!
> 
> Dave and I have told you and Miaohe several[1] times[2] to fix[3] the
> compiler, but clearly you don't care what we think and have decided to
> ram this in through Linus anyway.

To clarify, we certainly _do_ care what you think. It's just that
when faced with the difficulties of the compiler's implementations of
handling this, the kernel had to get creative and pick the least-bad of
many bad choices. We're trying to make the kernel safer for everyone,
and this particular C language weakness has caused us a significant
number of bugs. Eradicating it is worth the effort.

All that said, as you pointed out, you _have_ asked before[1] to just
have Linus take it without bothering you directly, so okay, that can be
done. Generally maintainers have wanted these changes to go through their
trees so it doesn't cause them merge pain, but it seems you'd prefer it
the other way around.

-Kees

[1] https://lore.kernel.org/linux-xfs/20200820191237.GK6096@magnolia/
"If you feel really passionate about ramming a bunch of pointless churn
 into the kernel tree to make my life more painful, send this to Linus
 and let him make the change."

> Since that is what you choose, do not send me email again.
> 
> NAKed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> [1] https://lore.kernel.org/linux-xfs/20200820191237.GK6096@magnolia/
> [2] https://lore.kernel.org/linux-xfs/20210420230652.GA70650@embeddedor/
> [3] https://lore.kernel.org/linux-xfs/20200708065512.GN2005@dread.disaster.area/
> 
> > 
> > Thanks
> > --
> > Gustavo
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

-- 
Kees Cook
