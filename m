Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B14C433E0
	for <linux-hardening@archiver.kernel.org>; Sun, 28 Feb 2021 05:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A4464DEF
	for <linux-hardening@archiver.kernel.org>; Sun, 28 Feb 2021 05:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhB1FBf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 28 Feb 2021 00:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhB1FBe (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 28 Feb 2021 00:01:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37AE664DD3;
        Sun, 28 Feb 2021 05:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614488453;
        bh=xQkMVcApfL3t8q7iWpH6mY+eJIkLuQ6BUnZPCj+gU5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNyRoc/oZOtX9taoGATLjm2dxB0dYBTzztSuW5ONJGVMhWcto8jYx1xD2rtIzLmUd
         N2j5SVb40RAK7hqsrCSUkV0bJDe8w7Vd65nFTzpn3hBeW/py7LEw+bgoTGIa7TUzDP
         P511iZxGBzZZRn79KYKl/HzQ4KXlivbUr4nIDBwq6dkGkkaM1pDdaFUAW2ueh72ZsQ
         UknI/6Hbum4BrrSSKa4jmgC79g8cSvDGE7VBg1n7DJMLx72CtBs+Ncc5aOlLFxdQFS
         yFKlFCtlvUgmJwogKAUJQKAxhnKZtoA2u3PCrTYh3dzEU7TVRyXM2Xq6mcS9obXkP/
         ZUSfeO5eeH9/A==
Date:   Sat, 27 Feb 2021 21:00:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH][next] f2fs: Replace one-element array with
 flexible-array member
Message-ID: <YDsjg1LqnkYIvvtB@google.com>
References: <20210224190313.GA144040@embeddedor>
 <bee16b72-f2e2-b113-9785-7f760be867df@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bee16b72-f2e2-b113-9785-7f760be867df@huawei.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 02/25, Chao Yu wrote:
> Hello, Gustavo,
> 
> On 2021/2/25 3:03, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare having
> > a dynamically sized set of trailing elements in a structure. Kernel code
> > should always use “flexible array members”[1] for these cases. The older
> > style of one-element or zero-length arrays should no longer be used[2].
> 
> I proposal to do the similar cleanup, and I've no objection on doing this.
> 
> https://lore.kernel.org/patchwork/patch/869440/
> 
> Let's ask for Jaegeuk' opinion.

Merged, thanks.
This looks better reason than code readability. :)

> 
> > 
> > Refactor the code according to the use of a flexible-array member in
> > struct f2fs_checkpoint, instead of a one-element arrays.
> > 
> > Notice that a temporary pointer to void '*tmp_ptr' was used in order to
> > fix the following errors when using a flexible array instead of a one
> > element array in struct f2fs_checkpoint:
> > 
> >    CC [M]  fs/f2fs/dir.o
> > In file included from fs/f2fs/dir.c:13:
> > fs/f2fs/f2fs.h: In function ‘__bitmap_ptr’:
> > fs/f2fs/f2fs.h:2227:40: error: invalid use of flexible array member
> >   2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
> >        |                                        ^
> > fs/f2fs/f2fs.h:2227:49: error: invalid use of flexible array member
> >   2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
> >        |                                                 ^
> > fs/f2fs/f2fs.h:2238:40: error: invalid use of flexible array member
> >   2238 |   return &ckpt->sit_nat_version_bitmap + offset;
> >        |                                        ^
> > make[2]: *** [scripts/Makefile.build:287: fs/f2fs/dir.o] Error 1
> > make[1]: *** [scripts/Makefile.build:530: fs/f2fs] Error 2
> > make: *** [Makefile:1819: fs] Error 2
> > 
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Build-tested-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/lkml/603647e4.DeEFbl4eqljuwAUe%25lkp@intel.com/
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   fs/f2fs/f2fs.h          | 5 +++--
> >   include/linux/f2fs_fs.h | 2 +-
> >   2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e2d302ae3a46..3f5cb097c30f 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2215,6 +2215,7 @@ static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
> >   static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
> >   {
> >   	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> > +	void *tmp_ptr = &ckpt->sit_nat_version_bitmap;
> >   	int offset;
> >   	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
> > @@ -2224,7 +2225,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
> >   		 * if large_nat_bitmap feature is enabled, leave checksum
> >   		 * protection for all nat/sit bitmaps.
> >   		 */
> > -		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
> > +		return tmp_ptr + offset + sizeof(__le32);
> >   	}
> >   	if (__cp_payload(sbi) > 0) {
> > @@ -2235,7 +2236,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
> >   	} else {
> >   		offset = (flag == NAT_BITMAP) ?
> >   			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
> > -		return &ckpt->sit_nat_version_bitmap + offset;
> > +		return tmp_ptr + offset;
> >   	}
> >   }
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index c6cc0a566ef5..5487a80617a3 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -168,7 +168,7 @@ struct f2fs_checkpoint {
> >   	unsigned char alloc_type[MAX_ACTIVE_LOGS];
> >   	/* SIT and NAT version bitmap */
> > -	unsigned char sit_nat_version_bitmap[1];
> > +	unsigned char sit_nat_version_bitmap[];
> >   } __packed;
> >   #define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
> > 
