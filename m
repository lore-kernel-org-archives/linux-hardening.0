Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F94C001B3
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 14:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjFUO4E (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 10:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjFUOy5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F535BD;
        Wed, 21 Jun 2023 07:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC076157B;
        Wed, 21 Jun 2023 14:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFA8C433C8;
        Wed, 21 Jun 2023 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358954;
        bh=Vg/q4ub2LEKrZ4zBjRc7OAhNi+XpqXacU3lh8zGDHJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owSMvesLWC51zX/w3HurcDsigUZBkUjBx89d/v/tKRNiBBfM/VPhtcpo9dR8B3ZMc
         PDe+zG2re5PUV2UEoOrM44yZHSL3P+gwidySNM86UXsHOIUSf0Qky5oJOnhwT+qYA1
         VHjBdUj8aQhn7E2OJZeHktqkQXMulITgMesuwodMynt+FeodeotnCrKXtehojXdeP7
         Rt5fDUl3pvcPlLE3os7F2iynv0K5izO/6hmJUsAU9Ve36RmcIDosxIvUwnFlexo8aD
         jsOHq3F8CCbhDrNkVWbhpXiTw0SnWBypegWbqxSnOuDF1wlYqhYk6Oc8oJmKfY5I3P
         dUULt9UrCqVDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 56/79] pstore: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:09 -0400
Message-ID: <20230621144735.55953-55-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/pstore/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032..20624d6006e6 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -223,7 +223,7 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	}
 	return inode;
 }
@@ -390,7 +390,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode->i_ctime = record->time;
+		inode->i_mtime = inode_ctime_set(inode, record->time);
 
 	d_add(dentry, inode);
 
-- 
2.41.0

