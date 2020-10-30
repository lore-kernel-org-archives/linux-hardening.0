Return-Path: <SRS0=mkbF=EF=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69750C55179
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF31206B2
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="Npk5xjWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJ3PhI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:37:08 -0400
Received: from confino.investici.org ([212.103.72.250]:57073 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgJ3PhG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Oct 2020 11:37:06 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CN5yl28rnz12cc;
        Fri, 30 Oct 2020 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1604072223;
        bh=j4NYs9Jl6xgkNi0+LQhpNE5IV9k30c3Bw/mkwJWZ+2E=;
        h=From:To:Cc:Subject:Date:From;
        b=Npk5xjWT1c6jf9wXK7Xc5cSrjgSGTfOAFhAoOWUgKVBpgS5La3DCOV5OaXut3BCni
         R12JkEhRXtUL0wFJzjqBYYjH7XSMwqlujhuixXKXlWSEYff8iFGlDjYrpIfOxIo4Hs
         XgHDKCa2tTnuMyMgyc7/Z6SgBaAzUBPs026ISvR4=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CN5yl0BM3z12cb;
        Fri, 30 Oct 2020 15:37:02 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v4 0/3] Fix inefficiences and rename nla_strlcpy
Date:   Fri, 30 Oct 2020 16:36:44 +0100
Message-Id: <20201030153647.4408-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


I hope your relatives and yourselves are fine.

This patch set answers to first three issues listed in:
https://github.com/KSPP/linux/issues/110

To sum up, the first patch fixes an inefficiency where some bytes in dst were
written twice, one with 0 the other with src content.
The second one modifies nla_strlcpy to return the same value as strscpy,
i.e. number of bytes written or -E2BIG if src was truncated.
The third rename nla_strlcpy to nla_strscpy.

Unfortunately, I did not find how to create struct nlattr objects so I tested
my modifications on simple char* and withing GDB with tc to get to
tcf_proto_check_kind.
This is why I tagged this patch set as RFC.

If you see any way to improve the code or have any remark, feel free to comment.


Best regards and take care of yourselves.

Francis Laniel (3):
  Fix unefficient call to memset before memcpu in nla_strlcpy.
  Modify return value of nla_strlcpy to match that of strscpy.
  treewide: rename nla_strlcpy to nla_strscpy.

 drivers/infiniband/core/nldev.c            | 10 +++---
 drivers/net/can/vxcan.c                    |  4 +--
 drivers/net/veth.c                         |  4 +--
 include/linux/genl_magic_struct.h          |  2 +-
 include/net/netlink.h                      |  4 +--
 include/net/pkt_cls.h                      |  2 +-
 kernel/taskstats.c                         |  2 +-
 lib/nlattr.c                               | 42 ++++++++++++++--------
 net/core/fib_rules.c                       |  4 +--
 net/core/rtnetlink.c                       | 12 +++----
 net/decnet/dn_dev.c                        |  2 +-
 net/ieee802154/nl-mac.c                    |  2 +-
 net/ipv4/devinet.c                         |  2 +-
 net/ipv4/fib_semantics.c                   |  2 +-
 net/ipv4/metrics.c                         |  2 +-
 net/netfilter/ipset/ip_set_hash_netiface.c |  4 +--
 net/netfilter/nf_tables_api.c              |  6 ++--
 net/netfilter/nfnetlink_acct.c             |  2 +-
 net/netfilter/nfnetlink_cthelper.c         |  4 +--
 net/netfilter/nft_ct.c                     |  2 +-
 net/netfilter/nft_log.c                    |  2 +-
 net/netlabel/netlabel_mgmt.c               |  2 +-
 net/nfc/netlink.c                          |  2 +-
 net/sched/act_api.c                        |  2 +-
 net/sched/act_ipt.c                        |  2 +-
 net/sched/act_simple.c                     |  4 +--
 net/sched/cls_api.c                        |  2 +-
 net/sched/sch_api.c                        |  2 +-
 net/tipc/netlink_compat.c                  |  2 +-
 29 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.20.1

