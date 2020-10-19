Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB5C433E7
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46502231B
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="sXDG5RrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgJSPYD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgJSPYD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 11:24:03 -0400
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D23C0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 08:24:02 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CFLBj0Ddtz8sgZ;
        Mon, 19 Oct 2020 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603121037;
        bh=YBH+A4g8ccyD4uON+MQlziXTqZZcIoaD3+NiF9H+flc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXDG5RrIc8JpdqdRwiOBvHfkoqX2H/lfYZKiklOJOZyoD6Q8gw37RZCkyhyA5rQRK
         aq5+jNTTJg7uu39SCUsE4o6hrcPZdVevJlF5U11riR9+zDN606ne48smOSCIEwJ2NA
         48F+3etGnuXpf0CckgVwFVRXYFa1j8XEdSwTyJxM=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFLBh41jNz8sgM;
        Mon, 19 Oct 2020 15:23:56 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Date:   Mon, 19 Oct 2020 17:23:28 +0200
Message-Id: <20201019152331.20583-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


I hope your families, friends and yourselves are fine.

This patch set answers to first three issues listed in:
https://github.com/KSPP/linux/issues/110

To sum up, the first patch fixes an inefficiency where some bytes in dst were
written twice, one with 0 the other with src content.
The second one modifies nla_strlcpy to return the same value as strscpy,
i.e. number of bytes written or -E2BIG if src was truncated.
The third rename nla_strlcpy to nla_strcpy.

Unfortunately, I did not find how to create struct nlattr objects so I tested
my modifications on simple char*.
This is why I tag this patch set as RFC.

If you see any way to improve the code or have any remark, feel free to comment.


Best regards.

Francis Laniel (3):
  Fix unefficient call to memset before memcpu in nla_strlcpy.
  Modify return value of nla_strlcpy to match that of strscpy.
  Rename nla_strlcpy to nla_strcpy.

 drivers/infiniband/core/nldev.c            | 10 +++---
 drivers/net/can/vxcan.c                    |  4 +--
 drivers/net/veth.c                         |  4 +--
 include/linux/genl_magic_struct.h          |  2 +-
 include/net/netlink.h                      |  4 +--
 include/net/pkt_cls.h                      |  3 +-
 kernel/taskstats.c                         |  2 +-
 lib/nlattr.c                               | 36 ++++++++++++++--------
 net/core/fib_rules.c                       |  4 +--
 net/core/rtnetlink.c                       | 12 ++++----
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
 29 files changed, 70 insertions(+), 59 deletions(-)

-- 
2.20.1

