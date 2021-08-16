Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641BDC4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Aug 2021 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3816A60F41
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Aug 2021 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhHPTLo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:11:44 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:42205 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhHPTLn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Aug 2021 15:11:43 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 2212180B12
        for <linux-hardening@vger.kernel.org>; Mon, 16 Aug 2021 15:11:11 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id D2A7E18000A2;
        Mon, 16 Aug 2021 15:11:09 -0400 (EDT)
Received: from APP-04 (unknown [10.50.14.154])
        by mta-13.privateemail.com (Postfix) with ESMTPA id B3FA618000A0;
        Mon, 16 Aug 2021 15:11:09 -0400 (EDT)
Date:   Mon, 16 Aug 2021 15:11:09 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc:     "keescook@chromium.org" <keescook@chromium.org>
Message-ID: <1517972876.806883.1629141069696@privateemail.com>
In-Reply-To: <846523794.787379.1629131268027@privateemail.com>
References: <846523794.787379.1629131268027@privateemail.com>
Subject: Re: Potentially interesting memcpy/memset/memmove calls
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

Hi There!

I just re-ran the query and added a check to see whether the size argument of those functions isn't a constant; this should eliminate a lot of false positives. The amended list with fewer results can be found below (still ran on the same database).

URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kernel/fpu/core.c?h=v5.13.11#n229
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n500
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n528
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n536
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c?h=v5.13.11#n74
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/w1/w1_netlink.c?h=v5.13.11#n614
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7007
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7011
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n1037
URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n831

Best Regards,

Jordy Zomer

> On 08/16/2021 12:27 PM Jordy Zomer <jordy@pwning.systems> wrote:
> 
>  
> Hiya!
> 
> Kees asked me to develop a query to detect calls where the destinations could need some attention as part of his initiative to harden memcpy calls.
> 
> Regarding:
> (https://lore.kernel.org/lkml/20210727205855.411487-1-keescook@chromium.org/)
> 
> As a result, I created a CodeQL query to detect some questionable instances. This query identifies a struct having a flexible array member when it is supplied as a reference to memcpy/memmove/memset's first argument. The query was performed on 5.13.11.
> I'm now compiling a database with `make allmodconfig` to see if it finds anything else, but you can see the preliminary findings below.
> 
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kernel/fpu/core.c?h=v5.13.11#n229
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kvm/x86.c?h=v5.13.11#n10972
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n500
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n528
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c?h=v5.13.11#n536
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/message/fusion/mptbase.c?h=v5.13.11#n1854
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/arcnet/arcnet.c?h=v5.13.11#n1145
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c?h=v5.13.11#n336
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c?h=v5.13.11#n74
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/platform/x86/sony-laptop.c?h=v5.13.11#n4529
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/platform/x86/sony-laptop.c?h=v5.13.11#n4548
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/scsi/be2iscsi/be_mgmt.c?h=v5.13.11#n865
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/w1/w1_netlink.c?h=v5.13.11#n614
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/w1/w1_netlink.c?h=v5.13.11#n199
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7007
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/ocfs2/alloc.c?h=v5.13.11#n7011
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/ethtool/ioctl.c?h=v5.13.11#n450
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/ipv4/devinet.c?h=v5.13.11#n262
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n1037
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/sched/cls_u32.c?h=v5.13.11#n831
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/virt/kvm/kvm_main.c?h=v5.13.11#n1506
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/virt/kvm/kvm_main.c?h=v5.13.11#n1522
> 
> 
> Best Regards,
> 
> Jordy Zomer
