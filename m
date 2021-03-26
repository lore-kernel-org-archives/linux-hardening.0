Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F04BC433C1
	for <linux-hardening@archiver.kernel.org>; Fri, 26 Mar 2021 18:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED00061A10
	for <linux-hardening@archiver.kernel.org>; Fri, 26 Mar 2021 18:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZSf2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 Mar 2021 14:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCZSfO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 Mar 2021 14:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3673861974;
        Fri, 26 Mar 2021 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616783714;
        bh=jjSlvlfTYmDgqztkBlh2xh49URpXSxlyKygsNdwn/sM=;
        h=Date:From:To:Cc:Subject:From;
        b=qMcmVYRvChY5q3/+UXJcxZw16T82WgRE0H90UgLwmrU6TY0680BZZJruVft6ISsAg
         GmmRridcvTl6apEM2tipTFBvcGUVaetEZxL5fHFm0MvAKojq0AWo65vm0TsWiEU/to
         4vF+wcH0qlO/wEnn8yB6a95w/HlRvz74JN7ZSq0LLSuKDnFrtXgYDHgqo1I6HnUO6g
         vQJ2+lBm/4zzGyRD9BG4+Zun4FjMrXB4aJjK1HPIAkmutNJ2DSbwHaojkMrhWicx13
         dB0X/7r298VQtGG11JYaifQYwSuRoQWmpx+W/rOkGX6zF2HmRVskEyzcSxFUMHl90N
         PxC1vd05sR90Q==
Date:   Fri, 26 Mar 2021 12:35:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] hpfs: Replace one-element array with flexible-array
 member
Message-ID: <20210326173510.GA81212@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Also, this helps with the ongoing efforts to enable -Warray-bounds by
fixing the following warning:

  CC [M]  fs/hpfs/dir.o
fs/hpfs/dir.c: In function ‘hpfs_readdir’:
fs/hpfs/dir.c:163:41: warning: array subscript 1 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
  163 |         || de ->name[0] != 1 || de->name[1] != 1))
      |                                 ~~~~~~~~^~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/hpfs/hpfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
index 302f45101a96..d92c4af3e1b4 100644
--- a/fs/hpfs/hpfs.h
+++ b/fs/hpfs/hpfs.h
@@ -356,7 +356,8 @@ struct hpfs_dirent {
   u8 no_of_acls;			/* number of ACL's (low 3 bits) */
   u8 ix;				/* code page index (of filename), see
 					   struct code_page_data */
-  u8 namelen, name[1];			/* file name */
+  u8 namelen;				/* file name length */
+  u8 name[];				/* file name */
   /* dnode_secno down;	  btree down pointer, if present,
      			  follows name on next word boundary, or maybe it
 			  precedes next dirent, which is on a word boundary. */
-- 
2.27.0

