Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417B3AD531;
	Mon, 10 Aug 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361016; cv=none; b=KSpkGS2G8AMm1zZkzWnZjjMDOvZ8hawhdQqXmm2Lc8e5JNV/Vl17w+jD528Z7VDJNumnkmKIO8cd/dBsivIWdIT4u8cevh6JDNTEVLcF8vn7qnMiWSy26srTcjWkE4kWYs0muhNFBp+XX4ZoK1JLhLC6dkUGkEjdmol+itLlmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361016; c=relaxed/simple;
	bh=AjAr5gjAkQ1Yp4bxsaEgjcFfiPlkVc5weZHWpMGWB5s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kh5JSgFE8iTYq7yBRawhNPh0V7nq19mitGCxD49o4pa+VtGt6+298M5a2DA2LDhvyftOXFqdNrbuwVN5KEeCQYtD7dAckQ/P6NSYcWV80giSKP8k5jtefgMYPKisAlnd7n7KQRsGfPdvfBVLJNewSuLjAdaAUp1XRx6Iu/FXTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DPru+EMd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DPru+EMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786361015; x=1817897015;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=AjAr5gjAkQ1Yp4bxsaEgjcFfiPlkVc5weZHWpMGWB5s=;
  b=DPru+EMdTfu+ij7GADMr8bbXaFoxC47iqAjDi8SGjUy3zFir+fKm7zsR
   iTvqpf6OsdN4f8i6BGn3KSi/kSsWAhTBEuKUyWlo6hy2X3UEa/NgOBX1v
   BxxFUFYYK+1Sr8MJfVYW31PJyYbb4nZzJGxnaPu2wvfuqMlwl3az0d9Io
   n+Jx306kNau9Eh5JQETQvF9OBo6EtpfKWimvtrszyknTfzE3IquIJ6Gre
   +zdNqaU6ASXzvsi7SghtRcWYAD3wOLYrhEHAFhACwWrGUOCsmClP4tLjS
   fGRn0lPTCgXRfaY60j0VEqnS2eGlv9lzg1vRRgg8L9/7tdRE/QJHXX+H0
   Q==;
X-CSE-ConnectionGUID: ZtIVA3FtSgartEHIy3eibg==
X-CSE-MsgGUID: tKBHExnvT4qjsvu4DAk5aw==
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="293272590"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 04:23:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 10 Aug 2026 04:23:26 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Aug 2026 04:23:23 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next v2 0/9] net: sparx5: add L3 unicast routing
 offload
Date: Mon, 10 Aug 2026 13:20:45 +0200
Message-ID: <20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA20eWoC/22NQQqDMBBFryKzbkoSNdSuvEcRkTjqQE1kkopFv
 HtD1l0+Hv/9EwIyYYBncQLjToG8S6BvBdhlcDMKGhODltpIraQI28BH3b/Lnv0nkptFY3RVP7A
 ay3GAtNsYJzpy8wUOo3B4ROiSWShEz998tqvsc9co/ae7KyHFZEurpDJyqpp2JcveLrTdrV+hu
 67rByxTUh3AAAAA
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add L3 unicast route offloading for IPv4 and IPv6 on Sparx5 and
LAN969x. This enables hardware-accelerated l3 routing between VLAN
upper interfaces on a bridge, with ECMP support.

This series covers the core unicast data path: FIB offload, nexthop
groups, ARP/NDP neighbour resolution, and router leg management.

Routes are programmed into the hardware LPM (Longest Prefix Match)
VCAP, with nexthops resolved through the hardware ARP table for ECMP
or inline VCAP actions for single nexthops.

The LPM VCAP also requires type_id-aware rule decoding, since it has
actionsets of identical length that differ only in their type_id
field.

Patch 1 fixes a latent bug in the VCAP rule-move algorithm that
becomes reachable once the LPM VCAP is added, since LPM is the first
VCAP to use rules of coprime size (2 and 3).

Patches 2-4 are the remaining preparatory commits for the shared VCAP
API. They add the LPM VCAP keysets and actionsets to the autogenerated
model for lan969x and sparx5, update the action-side rule decoder to
differentiate actionsets by type_id, and expose two helpers
(vcap_val_add_rule() and vcap_rule_mod_action_bit()) used by the LPM
driver.

Patch 5 adds autogenerated register macros for the L3 routing blocks
on sparx5 and lan969x.

Patch 6 adds the LPM VCAP implementation for sparx5 and lan969x.

Patches 7-9 add L3 unicast routing to sparx5 and lan969x. The router
code is split into three patches:

Patch 7 (infrastructure + legs): Router leg lifecycle tied to VLAN
uppers on a bridge, address event handling, base MAC tracking,
blackhole leg for blackhole routes, and the hardware enable sequence.

Patch 8 (FIB + nexthop + neighbour CRUD): This is a large patch.
Splitting it further is difficult because the neighbour and nexthop CRUD
is shared between the leg-teardown path and the neighbour-event path: leg
teardown flushes the legs neighbours and refreshes their dependent
nexthops, and the NETEVENT_NEIGH_UPDATE handler in patch 9 drives the
same helpers.

Patch 9 (neighbour events): Registers the netevent notifier for
NETEVENT_NEIGH_UPDATE used in ARP/NDP resolution, wiring up the final
piece.

The Super VCAP shared-register race reported on v1 is fixed separately by
commit d7a8d500d7e4 ("net: microchip: vcap: fix races on the shared Super
VCAP block"), which is now in net-next.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- Reworked neighbour lifetime: anchor neighbours to the router leg
  instead of the most-specific covering FIB entry (matching
  mlxsw/prestera). Fixes a neighbour-entry leak (memory + VMID + host
  VCAP rule + netdev reference) and lets the software LPM be removed
  entirely.
- Fixed a heap overflow in the fib6 nexthop prune path.
- Fixed a leak on the router_init() error path.
- Hardening: netns filtering and offload-ownership checks on the global
  notifiers, and a NETDEV_UNREGISTER leg-teardown backstop.
- Fixed do_div() misuse on a 32-bit value. Added the missing RCU
  annotation on in_dev->ifa_list.
- Zero-initialise the actionfield data in vcap_rule_mod_action_bit().
- Updated the sparx5_router.c header comment to describe the
  leg-anchored model.
- Link to v1: https://lore.kernel.org/r/20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com

---
Jens Emil Schulz Østergaard (9):
      net: microchip: vcap: fix rule move for rules of coprime size
      net: microchip: vcap: add lpm vcap to autogen vcap api
      net: microchip: vcap: make vcap actionset decoding type_id aware
      net: microchip: vcap: expose helpers in vcap api and update debugfs
      net: sparx5: add l3 routing registers
      net: sparx5: vcap: add lpm vcap implementation
      net: sparx5: add L3 router infrastructure and leg management
      net: sparx5: add L3 FIB, nexthop and neighbour entry management
      net: sparx5: add neighbour event handling for L3 routing

 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |    2 +
 .../microchip/sparx5/lan969x/lan969x_regs.c        |   20 +-
 .../microchip/sparx5/lan969x/lan969x_vcap_ag_api.c |  373 ++-
 .../microchip/sparx5/lan969x/lan969x_vcap_impl.c   |   12 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   13 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   44 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  691 ++++-
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   20 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   20 +-
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 3021 ++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.c |  373 ++-
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.h |    6 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  159 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.h   |    5 +
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h  |   94 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |  219 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |    4 +-
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |    6 +
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c |   13 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |   81 +-
 .../net/ethernet/microchip/vcap/vcap_model_kunit.c |    6 +-
 22 files changed, 5047 insertions(+), 137 deletions(-)
---
base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe
change-id: 20260210-sparx5_l3_routing-962458e4d3da

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

