Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A777C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3490860F02
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhKAVle (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhKAVld (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Nov 2021 17:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4960160F36;
        Mon,  1 Nov 2021 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635802740;
        bh=o9BhX1v0G8aG5VLLIt4ACVxhyMumDqgiXaDLy9mafQo=;
        h=Date:From:To:Cc:Subject:From;
        b=IcTpUsKNJv/Otokzezyy+ehIwPwwGdmmZ82qqltirtsH5u3fioCqOK03JuV9UZhUD
         1b79Rk5SgMscrEqEnlYvINzBh472t/vGQk3AUtTEvgvlPK7R67jz1ft1ZxSLr+Zs8L
         Nox0nZmwh7V5R3JgxGw4NpDJL/NjjC7VQNm63yYJiIHIwhrIWqAV4BgkY0yD5lcppl
         1WL0A0Zr8NkrFgZ48Up2rs/GAyQeLM6I05TehyDGeI5sn2hIFFdHGSJ7GozPlsvqns
         SCBE8ea6TuT5FhuqvnwDBG2RNggoKysMkqgmGVl+k1MoC1n8EbWd3sxMudV4jiMxXE
         kL6e3Lc9uzTGg==
Date:   Mon, 1 Nov 2021 16:43:41 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        jing yangyang <cgel.zte@gmail.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Various hardening fixes and cleanups for 5.16-rc1
Message-ID: <20211101214341.GA29478@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/kspp-misc-fixes-5.16-rc1

for you to fetch changes up to ebe4560ed5c8cbfe3759f16c23ca5a6df090c6b5:

  firewire: Remove function callback casts (2021-11-01 13:44:26 -0500)

----------------------------------------------------------------
Various hardening fixes and cleanups for 5.16-rc1

Hi Linus,

Please, pull the following hardening fixes and cleanups that I've
been collecting during the last development cycle. All of them have
been baking in linux-next.

Fix -Wcast-function-type error:

- firewire: Remove function callback casts (Oscar Carter)

Fix application of sizeof operator:

- firmware/psci: fix application of sizeof to pointer (jing yangyang)

Replace open coded instances with size_t saturating arithmetic helpers:

- assoc_array: Avoid open coded arithmetic in allocator arguments (Len Baker)
- writeback: prefer struct_size over open coded arithmetic (Len Baker)
- aio: Prefer struct_size over open coded arithmetic (Len Baker)
- dmaengine: pxa_dma: Prefer struct_size over open coded arithmetic (Len Baker)

Flexible array transformation:

- KVM: PPC: Replace zero-length array with flexible array member (Len Baker)

Use 2-factor argument multiplication form:

- nouveau/svm: Use kvcalloc() instead of kvzalloc() (Gustavo A. R. Silva)
- xfs: Use kvcalloc() instead of kvzalloc() (Gustavo A. R. Silva)

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      xfs: Use kvcalloc() instead of kvzalloc()
      nouveau/svm: Use kvcalloc() instead of kvzalloc()

Len Baker (5):
      assoc_array: Avoid open coded arithmetic in allocator arguments
      writeback: prefer struct_size over open coded arithmetic
      aio: Prefer struct_size over open coded arithmetic
      KVM: PPC: Replace zero-length array with flexible array member
      dmaengine: pxa_dma: Prefer struct_size over open coded arithmetic

Oscar Carter (1):
      firewire: Remove function callback casts

jing yangyang (1):
      firmware/psci: fix application of sizeof to pointer

 arch/powerpc/include/asm/kvm_host.h   |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c      |  3 +--
 drivers/dma/pxa_dma.c                 |  3 +--
 drivers/firewire/core-cdev.c          | 32 ++++++++++++++++++++++++++------
 drivers/firmware/psci/psci_checker.c  |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
 fs/aio.c                              |  3 +--
 fs/fs-writeback.c                     |  6 +++---
 fs/xfs/xfs_ioctl.c                    |  6 +++---
 include/linux/firewire.h              | 11 +++++++----
 lib/assoc_array.c                     | 22 ++++++++++------------
 11 files changed, 55 insertions(+), 37 deletions(-)
