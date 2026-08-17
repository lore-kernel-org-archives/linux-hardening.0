Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE34471CEA;
	Mon, 17 Aug 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001241; cv=none; b=sakFwGZkuLO01oO5vm2Io/U3hAawgAUirXsYAwiiTmMf+p7jgU4p3bj3IFesgkF7UXLsrJQ8zIbV1rPuX8dvjzWFG2ggCNIdx8SCMBVoSv5sTNvISM+6Kufq1lq/dSjI3fS/C8lWUhb5jr6qhdwJO/opD0ImR3avW5+oEWZY+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001241; c=relaxed/simple;
	bh=FV67wIHd9InxOzBOM8LFLiq2LxwV2f5O5+SNZnPhxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r77WFTpbOgW/8z9wKTnk6i6HkqSF9TVGfqY31FKN0N6+GBs+u4ZKBoetCEVD4FmJ3CiG8fDgttN/JGdJzBDV4kjQpPEzZjFVAkIJybpwL6HJ26kQ/nmPgckYs6qa/pN3uOLpkuZQsNSm+5wdFVmvniCC2xaT3qkkAYWA64zra08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbpro1aF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbpro1aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE851F00A3D;
	Mon, 17 Aug 2026 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001238;
	bh=UvNZH0bvsk+oouQgNxP+PZzPWXX4iSpi6H4cfAiBzbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cbpro1aFt8b4nZr4by4M5PXreKz8U8Q5klnlPZ5U4wFOd7ZBVrQF1UU1xk3MdBGSy
	 tWAUk8m1TLrfEpsF5PciWJEC4HlEmiGruzZRHO3kPzcJD/B2AQtcfpDXoQlMEoliI4
	 JuiHree2Cp25PJCSdVPuthrZuytKVDEh1X4RwlXubwqSytFt7LaZ8P9gGNL22chwdI
	 iFhYNJyz/lF0mXJ5EASQjFZf72qfXWG74unTAhub2ueO0pWgBoSlyrTU+b805XC/Vj
	 TpcrqnZjEZCEudwMP1W6x45e9ogiWAY372L+HVoz/Yrpc+10NIO0etsCgv/yuEjyWp
	 3qX5qgj7p5o2w==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	robert.marko@sartura.hr,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net: sparx5: add L3 router infrastructure and leg management
Date: Mon, 17 Aug 2026 14:13:57 -0700
Message-ID: <20260817211357.3633460-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-7-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-7-59e68cc8c8ca@microchip.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5: add L3 router infrastructure and leg management

This adds the sparx5 L3 router skeleton: notifiers for netdevice and
IPv4/IPv6 address events, the basic routing object types, and lifecycle
management for router legs (VMIDs) including a reserved blackhole leg.

A few questions about the leg lifecycle and the global router leg MAC
below.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> new file mode 100644
> index 0000000000000..d83cbb84c34e5
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> @@ -0,0 +1,1105 @@

[ ... ]

> +static int sparx5_lower_dev_walk(struct net_device *lower_dev,
> +				 struct netdev_nested_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (sparx5_netdevice_check(lower_dev)) {
> +		priv->data = (void *)netdev_priv(lower_dev);
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
Should this walk also check which switch instance owns the port it
finds?  sparx5_netdevice_check() in sparx5_netdev.c only compares the
shared ops pointer:

	return dev && (dev->netdev_ops == &sparx5_port_netdev_ops);

Every probed instance registers its own callbacks on the global
inetaddr/inet6addr/netdevice chains, so on a board with two instances
chip A's notifier sees a bridge whose only sparx5 lowers belong to chip
B.  Can that make sparx5_rr_dev_real_is_vlan_aware() return true on chip
A and let sparx5_rr_router_leg_create() allocate a VMID and enable an
RLEG on a chip that serves none of those ports?

The NETDEV_CHANGEADDR arm of sparx5_rr_netdevice_event() uses the same
helper, so it would also reprogram chip A's chip-global router leg base
MAC from an unrelated bridge's dev_addr.

struct sparx5_port already carries the sparx5 back-pointer, and
sparx5_port_bridge_join() performs exactly this per-instance comparison.

[ ... ]

> +static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
> +				  struct sparx5_rr_router_leg *leg)
> +{
> +	/* Associate Router leg VMID to VLAN */
> +	spx5_rmw(ANA_L3_VMID_CFG_VMID_SET(leg->vmid), ANA_L3_VMID_CFG_VMID,
> +		 sparx5, ANA_L3_VMID_CFG(leg->vid));
> +
> +	/* Enable Router leg for VLAN */
> +	spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(1),
> +		 ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
> +		 ANA_L3_VLAN_CFG(leg->vid));
> +
> +	/* Configure router leg */
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(1) |
> +		 ANA_L3_RLEG_CTRL_RLEG_EVID_SET(leg->vid) |
> +		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(1),
> +		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
> +		 ANA_L3_RLEG_CTRL_RLEG_EVID |
> +		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, sparx5,
> +		 ANA_L3_RLEG_CTRL(leg->vmid));
> +#else

[Severity: Low]
Is the CONFIG_IPV6 gating here consistent with the other IPv6 paths?
This is the only place that compiles out RLEG_IP6_UC_ENA, while
sparx5_rr_router_leg_create() unconditionally calls
sparx5_rr_lpm_link_local_create() (which installs an fe80::/64 rule with
VCAP_KF_IP6_XIP and LPM_PROTO() ETH_P_IPV6), sparx5_rr_router_init()
unconditionally registers the inet6addr and inet6addr validator
notifiers, and sparx5_rr_leg_hw_deinit() unconditionally clears the same
IP6 enable bit.

With CONFIG_IPV6=n, does that leave an LPM entry that can never match
occupying VCAP space, since no leg has IPv6 unicast lookup enabled?
Either dropping the #if or gating all IPv6 paths the same way would
avoid the mismatch.

[ ... ]

> +static struct sparx5_rr_router_leg *
> +sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
> +			    u16 vid)
> +{
> +	struct sparx5_rr_router_leg *leg;
> +
> +	leg = sparx5_rr_leg_alloc(sparx5, dev, vid);
> +	if (!leg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Prevent net device from being freed while we have added it to a
> +	 * router leg.
> +	 */
> +	netdev_hold(dev, &leg->dev_tracker, GFP_KERNEL);
> +
> +	/* While a router leg exists, add route to trap link-local traffic. */
> +	if (atomic_inc_return(&sparx5->router->legs_count) == 1) {
> +		if (sparx5_rr_lpm_link_local_create(sparx5))
> +			dev_warn(sparx5->dev,
> +				 "Failed to create link-local route\n");
> +	}

[Severity: Medium]
legs_count is already incremented when the rule install is attempted, so
if sparx5_rr_lpm_link_local_create() fails the counter stays non-zero
and no later leg creation retries the install.

sparx5_rr_lpm_arp_entry_create() can fail with -ENOMEM from
vcap_alloc_rule() or -ENOSPC from vcap_val_add_rule() when the LPM VCAP
is full, and in that case link_local.vrule_id_valid stays false.

Does the router then run for its whole lifetime without the IPv6
link-local trap that the file header describes ("All IPv6 link-local
traffic is explicitly trapped"), recovering only if every normal leg is
destroyed and a first leg is created again?  Should the error fail leg
creation, or at least be retried on the next leg creation?

> +
> +	list_add(&leg->leg_list_node, &sparx5->router->leg_list);
> +	sparx5_rr_leg_hw_init(sparx5, leg);

[Severity: Medium]
This arms the leg in hardware (ANA_L3_VLAN_CFG(vid).VLAN_RLEG_ENA and
ANA_L3_RLEG_CTRL(vmid) IP UC enables) without anything guaranteeing that
the chip-global router leg base MAC and RLEG_MAC_TYPE_SEL have been
programmed.

sparx5_rr_leg_base_mac_set() is reachable from exactly one place, the
NETDEV_CHANGEADDR arm of sparx5_rr_netdevice_event().  If the bridge is
created with an explicit MAC, br_stp_recalculate_bridge_id() in
net/bridge/br_stp_if.c bails out during br_add_if():

	/* user has chosen a value so keep it */
	if (br->dev->addr_assign_type == NET_ADDR_SET)
		return false;

so no qualifying NETDEV_CHANGEADDR is ever emitted, e.g. for:

	ip link add br0 type bridge address aa:bb:cc:dd:ee:ff
	ip link set eth0 master br0
	ip link add link br0 name br0.10 type vlan id 10
	ip addr add 10.0.0.1/24 dev br0.10

Would the leg then be enabled with the power-on ANA_L3/REW/EACL
RLEG_CFG values and MAC_TYPE_SEL != SPARX5_RLEG_USE_GLOBAL_BASE_MAC?
The commit message states:

  "There is a global router leg base MAC used for MAC rewrites by the
   chip. Here we use the bridge MAC."

Could the base MAC be derived from vlan_dev_real_dev(dev) at leg
creation time so that the claim holds regardless of how the bridge MAC
was assigned?

[ ... ]

> +static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
> +{
> +	struct net_device *vlan_rdev;
> +	/* Support l3 offloading for:
> +	 *	1) upper vlan interfaces for the bridge.
> +	 */
> +	if (is_vlan_dev(dev)) {
> +		if (netif_is_bridge_port(dev))
> +			return false;
> +
> +		vlan_rdev = vlan_dev_real_dev(dev);
> +		if (sparx5_netdevice_check(vlan_rdev))
> +			return false;
> +
> +		return netif_is_bridge_master(vlan_rdev) &&
> +		       br_vlan_enabled(vlan_rdev) &&
> +		       sparx5_port_dev_lower_find(vlan_rdev);
> +	}
> +
> +	return false;
> +}

[ ... ]

> +static int __sparx5_rr_inetaddr_event(struct sparx5 *sparx5,
> +				      struct net_device *dev,
> +				      unsigned long event)
> +{
> +	struct sparx5_rr_router_leg *leg;
> +	u16 vid;
> +
> +	if (!sparx5_rr_dev_real_is_vlan_aware(dev))
> +		return 0;

[Severity: Medium]
This mutable current-state predicate gates both leg creation and leg
teardown, since it is evaluated before the switch on event.  Every
sub-condition of sparx5_rr_dev_real_is_vlan_aware() can change at
runtime, and there is no NETDEV_CHANGEUPPER or bridge vlan_filtering
hook to re-evaluate it.

	ip link set eth0 master br0            # vlan_filtering 1
	ip link add link br0 name br0.10 type vlan id 10
	ip addr add 10.0.0.1/24 dev br0.10     # leg created
	ip link set br0 type bridge vlan_filtering 0
	ip addr del 10.0.0.1/24 dev br0.10     # NETDEV_DOWN

Does the last step return early here, so sparx5_rr_router_leg_destroy()
and therefore sparx5_rr_leg_hw_deinit() never run?  That would leave the
VMID allocated, the netdev reference held, legs_count elevated, and
ANA_L3_VLAN_CFG(vid).VLAN_RLEG_ENA plus the RLEG IP UC enables set for a
VLAN the kernel no longer treats as an L3 interface.  Repeating the
toggle would consume one VMID per round out of the 127 (lan969x) or 511
(sparx5) entry pool, with only the NETDEV_UNREGISTER backstop left to
clean up.

The same early return also means a valid configuration is never
offloaded if the address is added before the bridge becomes VLAN aware
or before a sparx5 port is enslaved.

> +
> +	/* Our basic case: ip addr/subnet added to vlan upper of
> +	 * bridge dev.
> +	 */
> +	switch (event) {
> +	case NETDEV_UP:
> +		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
> +		if (leg)
> +			return 0;
> +
> +		/* HW allows at most 1 leg per VLAN, but we do not need to
> +		 * lookup leg by vid, since the kernel does not allow multiple
> +		 * vlan devs with the same vid on top of a given device.
> +		 */
> +		vid = vlan_dev_vlan_id(dev);
> +
> +		leg = sparx5_rr_router_leg_create(sparx5, dev, vid);

[Severity: Medium]
The uniqueness argument in this comment holds per real device, but legs
are looked up by net_device while the hardware state they program is
indexed by VLAN id:

	ANA_L3_VMID_CFG(leg->vid)
	ANA_L3_VLAN_CFG(leg->vid)

Two different bridge masters can each carry a vid 10 upper.
sparx5_rr_dev_real_is_vlan_aware() accepts any vlan_filtering bridge
master that has a sparx5 port among its transitive lower devices, since
sparx5_port_dev_lower_find_rcu() uses netdev_walk_all_lower_dev_rcu(),
and sparx5_port_bridge_join()'s single-bridge -ENODEV veto only fires
for directly enslaved sparx5 port netdevs:

	ip link add link eth0 name eth0.5 type vlan id 5
	ip link set eth0.5 master br1          # br1 now qualifies
	ip addr add 10.0.0.1/24 dev br0.10
	ip addr add 10.1.0.1/24 dev br1.10

Can the second sparx5_rr_leg_hw_init() then overwrite the first leg's
ANA_L3_VMID_CFG(10) mapping, leaving its RLEG_CTRL/REW_RLEG_CTRL
programming orphaned?  And when either leg is destroyed,
sparx5_rr_leg_hw_deinit() clears ANA_L3_VLAN_CFG(10).VLAN_RLEG_ENA,
which would disable routing for the surviving leg.

[ ... ]

> +/* Called with RTNL. */
> +static int sparx5_rr_netdevice_event(struct notifier_block *nb,
> +				     unsigned long event, void *ptr)
> +{

[ ... ]

> +	switch (event) {
> +	case NETDEV_CHANGEADDR:
> +		/* Allow single bridge. Global router leg MAC tracks bridge mac. */
> +		if (netif_is_bridge_master(dev) && sparx5_port_dev_lower_find(dev)) {
> +			ether_addr_copy(mac, dev->dev_addr);
> +			sparx5_rr_leg_base_mac_set(sparx5, mac);
> +		}
> +		break;

[Severity: Medium]
The comment states the single-bridge assumption, but is it enforced
anywhere?  This arm accepts any bridge master that has a sparx5 lower
and overwrites the single global ANA_L3/REW/EACL router leg base MAC,
and __sparx5_rr_inetaddr_event() creates legs for VLAN uppers of any
qualifying bridge.

sparx5_port_bridge_join() returns -ENODEV only when a sparx5 port netdev
is directly enslaved into a second bridge, while
sparx5_port_dev_lower_find() walks lower devices recursively, so a
second bridge containing an intermediate device stacked on a sparx5 port
passes without ever reaching that check:

	ip link add link eth0 name eth0.5 type vlan id 5
	ip link set eth0.5 master br1

With legs offloaded for two bridges, the global base MAC becomes
whichever bridge most recently emitted NETDEV_CHANGEADDR.  Should the
restriction be rejected or at least reported, or documented in the
commit message?

There is also a stale case in the other direction: when the last sparx5
port leaves the bridge, sparx5_port_dev_lower_find() returns NULL, so a
later bridge MAC change is ignored and the programmed base MAC keeps
pointing at a MAC the bridge no longer has.

> +	case NETDEV_UNREGISTER:
> +		mutex_lock(&router->lock);
> +		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
> +		if (leg)
> +			sparx5_rr_router_leg_destroy(leg);
> +		mutex_unlock(&router->lock);
> +		break;
> +	}

[ ... ]

> +	/* Enable L3 UC routing on all ports. */
> +	spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA);
> +	if (is_sparx5(sparx5)) {
> +		spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA1);
> +		spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA2);
> +	}
> +
> +	/* Enable routing and global router options */
> +	spx5_rmw(ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(1) |

[ ... ]

> +void sparx5_rr_router_deinit(struct sparx5 *sparx5)
> +{
> +	struct sparx5_router *router = sparx5->router;
> +
> +	unregister_inet6addr_notifier(&router->inet6addr_nb);
> +	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
> +	unregister_netdevice_notifier(&router->netdevice_nb);
> +	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
> +	unregister_inetaddr_notifier(&router->inetaddr_nb);
> +	destroy_workqueue(router->sparx5_router_owq);
> +	sparx5_rr_router_legs_flush(sparx5);
> +	mutex_destroy(&router->lock);
> +	kfree(router);
> +}

[Severity: Low]
The chip-global routing state turned on by sparx5_rr_router_init()
(ANA_L3_L3_UC_ENA/ENA1/ENA2, ANA_L3_ROUTING_CFG.L3_ENA_MODE and the
redirect enables, ANA_ACL_VCAP_S2_MISC_CTRL.ACL_RT_SEL, plus
RLEG_MAC_TYPE_SEL from sparx5_rr_leg_base_mac_set()) has no counterpart
here or in the probe error unwind.  Should there be a matching disable
sequence?

Related: sparx5_rr_leg_hw_init() programs ANA_L3_VMID_CFG(leg->vid) and
REW_RLEG_CTRL(leg->vmid).RLEG_EVID, but sparx5_rr_leg_hw_deinit() clears
neither, so after the flush the VLAN table still points at VMIDs handed
back to the allocator.  sparx5_init_switchcore() skips sparx5_init_ram()
when HSCH_RESET_CFG.CORE_ENA is already set, so an unbind/re-bind cycle
starts with those stale VLAN to VMID mappings while vmid_mask is empty
again.
