Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233323EA83;
	Fri, 12 Jun 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267917; cv=none; b=aCKYf4sftuqnI6LVNzJWK/2bHZ6cYoip+NklG/aTKxe7ymSdRuUdUaTh3IIoOrmoiaeaMQbAN5po6Du+4ot6vaThT33mKIG6AkXxktyLjFnGqYPapnLA1yQAAjwccQxs9iSJMoTkXuY2GJEaGWbePH6k2fGswHP1rK8s34o6X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267917; c=relaxed/simple;
	bh=TNtDZ2rFubnaHt4bk3HI0rXm5kB9WhayB/Rz6IIN0KM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XWFaCCFEEj/bZLC9mwhMVV9Q9AWLU51ACpPkxxaXrWNy2Twxht11jfSoc9Mz7tm9HCNC4gJS1FoR1HKgKQ34rUG+xkS7rMyJ+GG4T4bD+Gsi1dTydY8o/q2a2EGZt591EzWAR2kCgMxDKBrdn3VbWYwL4OGhS7VKNEEFRUb+V0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F2/S+AWj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F2/S+AWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267916; x=1812803916;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=TNtDZ2rFubnaHt4bk3HI0rXm5kB9WhayB/Rz6IIN0KM=;
  b=F2/S+AWjy9l/hqo4wyEqsUYHYva2q+ww8GAZPEKbJOyVhd/k69i9R9YD
   iv+bC2HTzJq6Qmx/Uec6UQhQm6shlZh3IgVttBSJXhXeuXjU+5zAxQ+CY
   ERWbwUD+BuK0p0N4B36T1mAz7PzeBcwUIBwUfwoxCH70IzwJ5afT/sVQi
   ji+gKrVY1lxtxeP5GTO6h9S4Hi/EPk+52BQITZ78oOyGNnnYucqnMqOyf
   7KVv+KI/QSLMzE9oE4JXDFiCVgKQAIXF/JllTvHxj8PSE9s6ON3kT+NWQ
   ITfWBFxbxiV/PffVCYsya5jq7S5duUXFSEbN2bbbvTqvRoGXv0dD0tDR3
   A==;
X-CSE-ConnectionGUID: 8hGKh+9qS9m6l19lDwo2ow==
X-CSE-MsgGUID: IStHFf1JR2y7diaV1tomJg==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="59023654"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 05:38:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 05:38:34 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:31 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next 0/9] net: sparx5: add L3 unicast routing offload
Date: Fri, 12 Jun 2026 14:37:09 +0200
Message-ID: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHX9K2oC/x3MSwqAMAwA0atI1hZq/aBeRUSKjRqQKGmVgnh3i
 8u3mHnAoxB66LMHBG/ydHBCkWcwb5ZXVOSSwWjTaFNo5U8rsZ72cpLjCsSr6hpT1S1WrnQWUnc
 KLhT/5wCMQTHGAOP7frsORNJtAAAA
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

Patch 8 (FIB + nexthop + neighbour CRUD): This is a large patch, and
splitting it further is difficult due to the dependencies in FIB and
neighbour event paths. The destroy path for a FIB entry must update
neighbour state and notify nexthops, so neighbour CRUD functions are
called from both the FIB event path and the neighbour event path.

Patch 9 (neighbour events): Registers the netevent notifier for
NETEVENT_NEIGH_UPDATE used in ARP/NDP resolution, wiring up the final
piece.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
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
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   46 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  691 ++++-
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   20 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   20 +-
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 3095 ++++++++++++++++++++
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
 22 files changed, 5123 insertions(+), 137 deletions(-)
---
base-commit: f6033078a9e671e3c8b83d387b91591a6f6a54e7
change-id: 20260210-sparx5_l3_routing-962458e4d3da

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

