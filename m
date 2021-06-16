Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510DC48BE6
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 19:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C993661245
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 19:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFPTRw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhFPTRw (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Jun 2021 15:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7037761246;
        Wed, 16 Jun 2021 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623870945;
        bh=IvOX7e7xwWw8kATTBWzntUT0pPIkKcE0mRSQyPOrEgY=;
        h=Date:From:To:Subject:From;
        b=APAWLFxeH3GdnbqxmxxCxYeTgLmgvr2wh7LkOBMHwGf+RmGW6iQuqgc38qCIgAf+l
         IjRZxnIXdC5itonxfBhxByV28eur8qASKt9ViSaK2nbjCx2uMlVd/t18JoQEXNhfMn
         0oFKlbOr1ad8I/PNKYLN47+tgV9izXlWQmxKrDKv82MDvnO2rJcFhseSRbVl6xh+lp
         OeKdNeacJZnp1WecXaO5P+I6TtdCMopVK6GqtPfHmkqunImwu1aRjRBxO9V1JtjzGy
         4aJ2qkDHkQwRCfYQWMLgtWP8LP9qQ4YEQYS5L8ClYkt1FkTUoTxy/qiNQx290RXBoY
         +hyJB2nTi8CcQ==
Date:   Wed, 16 Jun 2021 14:17:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] xfs: Fix multiple fall-through warnings for Clang
Message-ID: <20210616191714.GA104231@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix
the following warnings by replacing /* fallthrough */ comments,
and its variants, with the new pseudo-keyword macro fallthrough:

fs/xfs/libxfs/xfs_attr.c:487:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:500:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:532:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:594:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:607:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:1410:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:1445:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/xfs/libxfs/xfs_attr.c:1473:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Notice that Clang doesn't recognize /* fallthrough */ comments as
implicit fall-through markings, so in order to globally enable
-Wimplicit-fallthrough for Clang, these comments need to be
replaced with fallthrough; in the whole codebase.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

I'm taking this in my -next[1] branch for v5.14.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

 fs/xfs/libxfs/xfs_attr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 611dc67234a6..7994e80358f7 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -483,7 +483,7 @@ xfs_attr_set_iter(
 		if (error)
 			return error;
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RM_LBLK:
 		/* Set state in case xfs_attr_rmtval_remove returns -EAGAIN */
 		dac->dela_state = XFS_DAS_RM_LBLK;
@@ -496,7 +496,7 @@ xfs_attr_set_iter(
 			return -EAGAIN;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RD_LEAF:
 		/*
 		 * This is the last step for leaf format. Read the block with
@@ -528,7 +528,7 @@ xfs_attr_set_iter(
 				return error;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_ALLOC_NODE:
 		/*
 		 * If there was an out-of-line value, allocate the blocks we
@@ -590,7 +590,7 @@ xfs_attr_set_iter(
 		if (error)
 			return error;
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RM_NBLK:
 		/* Set state in case xfs_attr_rmtval_remove returns -EAGAIN */
 		dac->dela_state = XFS_DAS_RM_NBLK;
@@ -603,7 +603,7 @@ xfs_attr_set_iter(
 			return -EAGAIN;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_CLR_FLAG:
 		/*
 		 * The last state for node format. Look up the old attr and
@@ -1406,7 +1406,7 @@ xfs_attr_remove_iter(
 			state = dac->da_state;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RMTBLK:
 		dac->dela_state = XFS_DAS_RMTBLK;
 
@@ -1441,7 +1441,7 @@ xfs_attr_remove_iter(
 			return -EAGAIN;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RM_NAME:
 		/*
 		 * If we came here fresh from a transaction roll, reattach all
@@ -1469,7 +1469,7 @@ xfs_attr_remove_iter(
 			return -EAGAIN;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case XFS_DAS_RM_SHRINK:
 		/*
 		 * If the result is small enough, push it all into the inode.
-- 
2.27.0

