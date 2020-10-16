Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CCC43457
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA94207C4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="NEgbtZJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406442AbgJPNCC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
Received: from confino.investici.org ([212.103.72.250]:21565 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395446AbgJPNCC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCQzM6rFWz15VD
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602852751;
        bh=3ZFxT5Pgj7LckFFzj8k4rQZZ17NMlJ6mCefPJW1uUNw=;
        h=From:To:Subject:Date:From;
        b=NEgbtZJhGGdpAfHIikmufWfjIJ+69vu6d0HR5sLH9+1eomjpFXG2ah8Xn4WZSvN7/
         HTownQWq1HzGJedpTnEuk85PPI4JSxeS2Pnf/Ghynyju93Awp+qN88B0tiKliD4zNu
         C4JKKUzWVjVWZMv/4/aCOIP2Jp+VcIXyIlJOI2QI=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCQzM6CVjz115p
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 12:52:31 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Subject: [RFC][PATCH v1] Fix and rename nla_strlcpy to nla_strcpy
Date:   Fri, 16 Oct 2020 14:52:13 +0200
Message-Id: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


First, I do hope you are all fine and the same for your relatives.

This 3 patches set answers to three first steps of this issue:
https://github.com/KSPP/linux/issues/110
Basically, I fix an inefficiency in nla_strlcpy where memset was called before
memcpy.
Then I modified the returned value to follow strscpy behavior and update where
this function is called and returned value is checked.
Finally, I rename nla_strlcpy to nla_strcpy and propagate the modifications in
all files where nla_strlcpy was called.

Unfortunately, I did not understand how to instanciate struct nlattr objects so
I tested the modified function by calling it directly on char *, this is why I
marked this patch as RFC.

If you have any remarks, feel free to share them so I can improve the code.

Here are the stats:
 drivers/infiniband/core/nldev.c            | 10 +++++-----
 drivers/misc/lkdtm/Makefile                |  1 +
 drivers/net/can/vxcan.c                    |  4 ++--
 drivers/net/veth.c                         |  4 ++--
 include/linux/genl_magic_struct.h          |  2 +-
 include/net/netlink.h                      |  4 ++--
 include/net/pkt_cls.h                      |  3 ++-
 kernel/taskstats.c                         |  2 +-
 lib/nlattr.c                               | 35 ++++++++++++++++++++++-------------
 net/core/fib_rules.c                       |  4 ++--
 net/core/rtnetlink.c                       | 12 ++++++------
 net/decnet/dn_dev.c                        |  2 +-
 net/ieee802154/nl-mac.c                    |  2 +-
 net/ipv4/devinet.c                         |  2 +-
 net/ipv4/fib_semantics.c                   |  2 +-
 net/ipv4/metrics.c                         |  2 +-
 net/netfilter/ipset/ip_set_hash_netiface.c |  4 ++--
 net/netfilter/nf_tables_api.c              |  6 +++---
 net/netfilter/nfnetlink_acct.c             |  2 +-
 net/netfilter/nfnetlink_cthelper.c         |  4 ++--
 net/netfilter/nft_ct.c                     |  2 +-
 net/netfilter/nft_log.c                    |  2 +-
 net/netlabel/netlabel_mgmt.c               |  2 +-
 net/nfc/netlink.c                          |  2 +-
 net/sched/act_api.c                        |  2 +-
 net/sched/act_ipt.c                        |  2 +-
 net/sched/act_simple.c                     |  4 ++--
 net/sched/cls_api.c                        |  2 +-
 net/sched/sch_api.c                        |  2 +-
 net/tipc/netlink_compat.c                  |  2 +-
 30 files changed, 70 insertions(+), 59 deletions(-)

Best regards.


