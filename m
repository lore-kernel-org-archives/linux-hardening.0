Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F1C433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 24 Feb 2021 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF74660202
	for <linux-hardening@archiver.kernel.org>; Wed, 24 Feb 2021 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhBXTKT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235985AbhBXTJU (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 24 Feb 2021 14:09:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 527A164F16;
        Wed, 24 Feb 2021 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614193395;
        bh=PxDG3veJbNLyGyeroA2Pjfvxfc8wcJtTEAXzJyz6Q1U=;
        h=Date:From:To:Cc:Subject:From;
        b=kSL75zfidFWCa3nX4HBG5O0E4kB4mRGvnehoXEbkmf5DSSY1Mmy25DEzopyXCN1Y0
         RR2JqUARIdspqhgdROz0cjWbp6tLBdX/8egll1JmtiM3mLDTSKm4TH/H/KUdqOXtWX
         dH2jxkvjHiFejfCatI1wTmCc9re12Vkr7ynGoCHj7VbUn1qRj6UsOXACJb+jkxxfZv
         TWpu8GSR1CSF7kGH3jdhC4+rwGKarf/PbvmjU1iQv37Oaj9l/BbyEo73R98XoTn0mD
         MzF67+fc4EpAYz5MMg3Q3pcAlP4raIFcIe+O9tvf/2MYbZKpi7EiMr7Y6dB93G+4Oi
         CHDlTB0rijKSQ==
Date:   Wed, 24 Feb 2021 13:03:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] f2fs: Replace one-element array with flexible-array
 member
Message-ID: <20210224190313.GA144040@embeddedor>
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

Refactor the code according to the use of a flexible-array member in
struct f2fs_checkpoint, instead of a one-element arrays.

Notice that a temporary pointer to void '*tmp_ptr' was used in order to
fix the following errors when using a flexible array instead of a one
element array in struct f2fs_checkpoint:

  CC [M]  fs/f2fs/dir.o
In file included from fs/f2fs/dir.c:13:
fs/f2fs/f2fs.h: In function ‘__bitmap_ptr’:
fs/f2fs/f2fs.h:2227:40: error: invalid use of flexible array member
 2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
      |                                        ^
fs/f2fs/f2fs.h:2227:49: error: invalid use of flexible array member
 2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
      |                                                 ^
fs/f2fs/f2fs.h:2238:40: error: invalid use of flexible array member
 2238 |   return &ckpt->sit_nat_version_bitmap + offset;
      |                                        ^
make[2]: *** [scripts/Makefile.build:287: fs/f2fs/dir.o] Error 1
make[1]: *** [scripts/Makefile.build:530: fs/f2fs] Error 2
make: *** [Makefile:1819: fs] Error 2

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/603647e4.DeEFbl4eqljuwAUe%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/f2fs/f2fs.h          | 5 +++--
 include/linux/f2fs_fs.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..3f5cb097c30f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2215,6 +2215,7 @@ static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	void *tmp_ptr = &ckpt->sit_nat_version_bitmap;
 	int offset;
 
 	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
@@ -2224,7 +2225,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 		 * if large_nat_bitmap feature is enabled, leave checksum
 		 * protection for all nat/sit bitmaps.
 		 */
-		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
+		return tmp_ptr + offset + sizeof(__le32);
 	}
 
 	if (__cp_payload(sbi) > 0) {
@@ -2235,7 +2236,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	} else {
 		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
-		return &ckpt->sit_nat_version_bitmap + offset;
+		return tmp_ptr + offset;
 	}
 }
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c6cc0a566ef5..5487a80617a3 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -168,7 +168,7 @@ struct f2fs_checkpoint {
 	unsigned char alloc_type[MAX_ACTIVE_LOGS];
 
 	/* SIT and NAT version bitmap */
-	unsigned char sit_nat_version_bitmap[1];
+	unsigned char sit_nat_version_bitmap[];
 } __packed;
 
 #define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
-- 
2.27.0

