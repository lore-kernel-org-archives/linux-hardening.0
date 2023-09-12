Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BFCA0ECA
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjILMEH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjILMEG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Sep 2023 08:04:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541710D0;
        Tue, 12 Sep 2023 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694520242; x=1726056242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACZgrW/KIF4Ck9dMiAJqlqiVeTFE5RSDcL0NrmB6dZo=;
  b=eWIRm1yovFcgdinfB6a28kSO6+4EDWgNrP8hbQVU/0gSTguyZfd/opcj
   VMHf2q98A5aYgkwt1pajHyG35XFbSOGTkN5dfWbiyFZDEU6YYvzkt7mEC
   i/thi4LmhLK9bWstSwtO/IhIaRGmwlDdrHiU5sPwX+y+SLul5bdmo9IFH
   UmYcFsPlFp8fP1lfhK5xU+/TsbkBjBRpxSNxeWu7Tr/+VOJSohqvRqZPv
   vWXIS8LUiu4RxP8hx66cJP+/l2GOqP/4n5x1Ra/ZGwOdEcOL0dwrMStT9
   6zNlZUO9bRTmdhjZE51fDxbkqCC+V1OJddjomT1voMGA44ESpV+xBgx5W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378265386"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378265386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720389743"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720389743"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2023 05:02:53 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 2BFE8332B7;
        Tue, 12 Sep 2023 13:02:52 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc:     Kees Cook <keescook@chromium.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
        Anthony Nguyen <anthony.l.nguyen@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 0/7] introduce DEFINE_FLEX() macro
Date:   Tue, 12 Sep 2023 07:59:30 -0400
Message-Id: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
with trailing flex array member.
Expose __struct_size() macro which reads size of data allocated
by DEFINE_FLEX().

Accompany new macros introduction with actual usage,
in the ice driver - hence targeting for netdev tree.

Obvious benefits include simpler resulting code, less heap usage,
less error checking. Less obvious is the fact that compiler has
more room to optimize, and as a whole, even with more stuff on the stack,
we end up with overall better (smaller) report from bloat-o-meter:
add/remove: 8/6 grow/shrink: 7/18 up/down: 2211/-2270 (-59)
(individual results in each patch).

v5: same as v4, just not RFC
v4: _Static_assert() to ensure compiletime const count param
v3: tidy up 1st patch
v2: Kees: reusing __struct_size() instead of doubling it as a new macro

Przemek Kitszel (7):
  overflow: add DEFINE_FLEX() for on-stack allocs
  ice: ice_sched_remove_elems: replace 1 elem array param by u32
  ice: drop two params of ice_aq_move_sched_elems()
  ice: make use of DEFINE_FLEX() in ice_ddp.c
  ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
  ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
  ice: make use of DEFINE_FLEX() in ice_switch.c

 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++-----
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 39 ++++---------
 drivers/net/ethernet/intel/ice/ice_lag.c    | 48 ++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c    | 23 ++------
 drivers/net/ethernet/intel/ice/ice_sched.c  | 56 ++++++------------
 drivers/net/ethernet/intel/ice/ice_sched.h  |  6 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 63 +++++----------------
 drivers/net/ethernet/intel/ice/ice_xsk.c    | 22 +++----
 include/linux/compiler_types.h              | 32 +++++++----
 include/linux/fortify-string.h              |  4 --
 include/linux/overflow.h                    | 35 ++++++++++++
 11 files changed, 130 insertions(+), 218 deletions(-)


base-commit: 73be7fb14e83d24383f840a22f24d3ed222ca319
-- 
2.40.1

