Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA218C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Aug 2021 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F75360EFE
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Aug 2021 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHPQ2W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:28:22 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:51532 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhHPQ2W (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Aug 2021 12:28:22 -0400
Received: from MTA-08-3.privateemail.com (mta-08-1.privateemail.com [68.65.122.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id BDDFD814E1
        for <linux-hardening@vger.kernel.org>; Mon, 16 Aug 2021 12:27:49 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 32DFE18001B5;
        Mon, 16 Aug 2021 12:27:48 -0400 (EDT)
Received: from APP-04 (unknown [10.50.14.154])
        by mta-08.privateemail.com (Postfix) with ESMTPA id 1465D18001B0;
        Mon, 16 Aug 2021 12:27:48 -0400 (EDT)
Date:   Mon, 16 Aug 2021 12:27:48 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc:     "keescook@chromium.org" <keescook@chromium.org>
Message-ID: <846523794.787379.1629131268027@privateemail.com>
Subject: Potentially interesting memcpy/memset/memmove calls
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev17
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hiya!

Kees asked me to develop a query to detect calls where the destinations could need some attention as part of his initiative to harden memcpy calls.

Regarding:
(https://lore.kernel.org/lkml/20210727205855.411487-1-keescook@chromium.org/)

As a result, I created a CodeQL query to detect some questionable instances. This query identifies a struct having a flexible array member when it is supplied as a reference to memcpy/memmove/memset's first argument. The query was performed on 5.13.11.
I'm now compiling a database with `make allmodconfig` to see if it finds anything else, but you can see the preliminary findings below.

URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kernel/fpu/core.c?h=v5.13.11#n229
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kvm/x86.c?h=v5.13.11#n10972
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n500
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n528
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n536
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/message/fusion/mptbase.c?h=v5.13.11#n1854
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/arcnet/arcnet.c?h=v5.13.11#n1145
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c?h=v5.13.11#n336
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c?h=v5.13.11#n74
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/platform/x86/sony-laptop.c?h=v5.13.11#n4529
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/platform/x86/sony-laptop.c?h=v5.13.11#n4548
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/scsi/be2iscsi/be_mgmt.c?h=v5.13.11#n865
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/w1/w1_netlink.c?h=v5.13.11#n614
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/w1/w1_netlink.c?h=v5.13.11#n199
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7007
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7011
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/ethtool/ioctl.c?h=v5.13.11#n450
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/ipv4/devinet.c?h=v5.13.11#n262
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n1037
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n831
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/virt/kvm/kvm_main.c?h=v5.13.11#n1506
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/virt/kvm/kvm_main.c?h=v5.13.11#n1522


Best Regards,

Jordy Zomer
