Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921492;
	b=gQ78nOpU/kMPvgI9BJNB68Qehpr2/b/isVC/ntg1OtmT8KMT5JxlUDFqP4JPaad/b/DN
	 oIJ6zcnQVTz9yCgB7Rcuprm2ueXffXP4sKwtyKWRu0PcLibwRpmXI+E5/xOeH5sGiFyCQ
	 fyK8+d5YFaTbJdqhViH01QNmUv7/mHg7VKjEHWUlldBOsKb6+FNma8WMwE8UDM0/Xu5+6
	 83nvCp7h34KVpwg6RkljBavYT7xc75HjFXaVy4MkGCobSGaXXit69aTnOVN0v81CsiacL
	 kzM/9LGBGFyESGEMQBIIXljvgR9w95YLBRuXa4p8oGtLOLApuiSa/8u7gKX6D/+blJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921492;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:CC:X-Mailer;
	bh=e1vk46c7RCm1gjOZ4YlKUJ7kGnT29iya4vcnrK/d6x0=;
	b=X/snTAIHtPSgJvrYZB7I41GpzMlxQ9PQlQBZStqR4s1AJiRdCUAh2VrO7vEj9ZObs63H
	 JvYvFcsuV5g46L/rmPAfBaumcdd3yPCeRSidX3MxBuse8dveYzEVnxn4frtyyoFodyIhP
	 aN2mL7wN++wJAk+kl/A0EfLkk7lNgKyOGNglV5Ac1W0Ll8MVwj+eBNy36fuQvv0RTXRqY
	 WGsBOuUTGt+jxpJsQ3YAqDe0U32g2YmMBHJm7Horx9UcACQGajx00gXSs3BwmxIMk72U+
	 Et77OYQJvYlTSBGOG+kemep1HuQkp07kgSTsCCVrK28C9v4Ysrw3n8qGjJBupAcs4Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=QrDEH3jn;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0530606A31C;
	Tue, 17 Nov 2026 13:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0530606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=QrDEH3jn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794921491; x=1826457491;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DkboOSEA4K1ZxnUPlMxr5deg62sLicMgLN4HTU1QD9U=;
  b=QrDEH3jnxeh1U/MiZGoGBaHknYOeXRTU3b7BbLmoBLEh9isu+YRhSCMP
   cBHDZkOsyWkoShyDt0ixvNpcHY/eB8JBewfOfwa+7i80sYvwQQGoKt/4M
   G6kdLrMr7yn1EHUKq5uqL/6y2CK4b7vx/7qg0wVcwccOvyyqaSCJa3TQV
   +0cYQFGo1HMtPb3F6Coxq9Svu8nAPFuNa+crLiPG4FLdESkxS9W7V+IYo
   ukb/SMNcNRr9YcTVj/vOmEKds7bIMBbpvbUyLJC4m3D6t9nd/cLH3O2J0
   /DpQ/SzBrNosNdhMcNQ52hsKIpMjsSf7yhfZV0AJhHnbMedaRkHQHwgd7
   g==;
X-CSE-ConnectionGUID: AxTgJ7i4SEe8mxlwVypmAQ==
X-CSE-MsgGUID: nY8/6bWzR9C/Masx+JuVmg==
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="65663131"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:18:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 06:18:10 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 17 Nov 2026 06:18:06 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next v3 0/3] net: sparx5: add router legs for L3
 routing offload
Date: Tue, 17 Nov 2026 14:17:36 +0100
Message-ID: <20261117-sparx5_l3_routing-v3-0-e680ed79c7dc@microchip.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPBT/GoC/23OTQqDMBAF4KtI1k3JjwbtqvcoRUIcdaAmkqTBI
 t69IZtCkVk9HvPN7CSARwjkVu3EQ8KAzuYgLxUxs7YTUBxyJoIJxQRnNKzab03/kr1374h2op0
 SddNCPchBk7y3ehhxK+aDWIjUwhbJMzczhuj8pxxLvPTFVVycuIlTRkcjDWdcsbHu7gsa78yM6
 9W4pYhJ/JT29LskstJ0oFpj2jz6XzmO4wvIkO8zBgEAAA==
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Daniel Machon <daniel.machon@microchip.com>,
	"Steen Hegelund" <Steen.Hegelund@microchip.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Eric Dumazet <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

This is the first series adding L3 unicast routing offload for IPv4
and IPv6 to Sparx5 and LAN969x. It adds the routing registers and
the router legs, the hardware interfaces where routing happens. No
route is offloaded yet. Routing is enabled in the chip, but with no LPM
rule a routed frame misses the lookup and is redirected to the CPU, so
the kernel keeps routing every frame in software.

The chips only route in VLAN aware mode. A router leg is created for a
direct VLAN upper of the offloaded bridge when it gets its first
address, provided the upper qualifies for hardware routing: a non-zero
vid, the bridge VLAN protocol, the bridge MAC and no master. Any other
configuration is routed in software as usual.

Patch 1 adds the register macros for the L3 routing blocks.

Patch 2 adds the router legs, their lifecycle on address events, the
global leg base MAC and the hardware enable sequence.

Patch 3 keeps the legs in sync with the bridge. A transition that would
leave the hardware and kernel routing differently drops the leg instead
of being refused, and the leg is recreated once the upper qualifies.
It also follows bridge MAC and vid changes and the upper going down, and
recreates the legs when a switch port joins the bridge again.

The plan for future series building on this one:

  2: track FIB entries and trap them to the CPU, with the LPM VCAP
  3: main and local table arbitration, FIB rule refusal and neighbour
     host routes
  4: forwarding through a single nexthop, ECMP and blackhole routes
  5: routes through nexthop objects

The Super VCAP shared-register race reported on v1 is fixed separately
by commit d7a8d500d7e4 ("net: microchip: vcap: fix races on the shared
Super VCAP block"), which is now in net-next.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v3:
- Split the series. The router code is now rebuilt as smaller series.
  This series keeps the registers and the router legs. The VCAP
  preparation moves to the second series.
- Tighten which device may carry a router leg: a direct VLAN upper of
  the bridge whose ports are offloaded, without a master of its own,
  with a non-zero vid, the bridge VLAN protocol and the bridge MAC.
- Follow the transitions that would leave the chip and kernel out of
  sync: enslaving a leg to any master, changing its MAC, and disabling
  vlan_filtering or changing the VLAN protocol on its bridge drop the
  leg, which is created again when the upper qualifies.
- Destroy a leg created from the address validator when the address add
  fails afterwards, and handle IPv6 address removal from a work embedded
  in the router rather than one allocated per event.
- Keep addresses when a leg cannot be created, and route that upper
  in software.
- Disable a leg as an ingress router leg while its upper is down or the
  bridge does not carry its vid.
- Flush the legs of a bridge when its last switch port leaves and
  recreate them on rejoin.
- Program the leg base MAC from the bridge MAC when a leg is created,
  not only when the bridge MAC changes.
- Enable unicast routing only on the switch ports, and restore the
  routing registers when the router is torn down.
- Carry on without offload when the router cannot initialise, rather
  than failing the probe, and skip the router without CONFIG_VLAN_8021Q.
- Remove the blackhole leg and the IPv6 link-local trap.
- Link to v2: https://lore.kernel.org/r/20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com

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
Jens Emil Schulz Østergaard (3):
      net: sparx5: add l3 routing registers
      net: sparx5: add L3 router legs
      net: sparx5: keep router legs in sync with the bridge

 drivers/net/ethernet/microchip/sparx5/Makefile     |   2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   1 +
 .../microchip/sparx5/lan969x/lan969x_regs.c        |  11 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  13 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  37 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 528 ++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  11 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  11 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 913 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |  30 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   2 +
 11 files changed, 1554 insertions(+), 5 deletions(-)
---
base-commit: 6ff4c5942a301675eb12e5b49d53a81e604624a1
change-id: 20260210-sparx5_l3_routing-962458e4d3da

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

