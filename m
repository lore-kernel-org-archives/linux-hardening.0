Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32733C65E0;
	Mon, 17 Aug 2026 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001243; cv=none; b=qJjRmFlEqYtTuu8xotydKQHacBUXPYL69UViAoEwruKeMW2AoSuBD1oH5LxtbSihPF7+eiwYIpAn/vH2BKtysZ9WBwNpoJRU6uVdcMp/LHtlAseyFc3rQNqn0ojlJzzZ4fvMwM+dL673D0xLH2l1EupJa5jB0C7yUfCM7mxKIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001243; c=relaxed/simple;
	bh=Zf1nYijRAB0Q0/zVDgGanRBs58TtBpMAovEfgoKXHp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ6DFtfbHn99KZpAtcRH+QL6t8z3/5wO6OnZWzBH/4r1l3KPJpZpKTWibDUxe/FYvdjL2jxuzM/dDNFIj/y5GYQUjcvroviVg+VabN9T6JH4Nv2+ZzhHkcU8WPCLNqrv59SJATnlvBuIgZAzr6z6Hs3UprGCYdfc6rmhAz0I+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR0cIBTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR0cIBTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E06F1F00A3A;
	Mon, 17 Aug 2026 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001240;
	bh=HnV+KFrsp3EjkzXD0qLhT2V4LnzZvURLkqVx83K91cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JR0cIBTrlKwnD0g9VsA9MIfctBPDm8FRHGBltvfeEzpFdTS4FOeLdh0h+P2ONL0iY
	 nrnnxrGpLIyzJg4JYwMTN2oqD4YITfYSkzyipx2WYkPNZblHRSRpHNnYPxkkHoayXH
	 8kJ2cK1cGaSvromUi76+brtoh6JgThuIJ4cES/JCV9TYfRAktITpKhw7eCDDVjbv2q
	 +ZjK6EEHQ3yrxyTeyDudH5Cjh3UGXiLXOed/YYcnEmdiNT6p3x0hYZcChffcwfdA9+
	 acSJtxfefEEpwOQUs3axKR0Sf3yG5szzgkauQOkcvctHzub3Psy+qnRWqErQ67rvf9
	 YWYslPkSAVPcw==
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
Subject: Re: [PATCH net-next v2 8/9] net: sparx5: add L3 FIB, nexthop and neighbour entry management
Date: Mon, 17 Aug 2026 14:13:59 -0700
Message-ID: <20260817211359.3633493-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-8-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-8-59e68cc8c8ca@microchip.com>
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
net: sparx5: add L3 FIB, nexthop and neighbour entry management

This adds the data path for L3 unicast route offload on sparx5: FIB entry
lifecycle backed by LPM VCAP rules, nexthop group management using either
inline VCAP actions or the hardware ARP table for ECMP, and neighbour
entries anchored to router legs.  A few questions about the new code
below.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> index d83cbb84c34e5..6d40d651180e6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c

[ ... ]

> @@ -422,43 +715,1041 @@ static struct sparx5_port *sparx5_port_dev_lower_find(struct net_device *dev)
>  	port = sparx5_port_dev_lower_find_rcu(dev);
>  	rcu_read_unlock();
>  
> -	return port;
> +	return port;
> +}

[ ... ]

> +static int
> +sparx5_rr_nexthop_group_info_init(struct sparx5 *sparx5,
> +				  struct sparx5_rr_nexthop_group *nh_grp,
> +				  struct sparx5_rr_fib_info *fi)
> +{
> +	unsigned int nhs = sparx5_rr_fib_info_nhs(fi);
> +	struct sparx5_rr_nexthop_group_info *nhgi;
> +	struct sparx5_rr_nexthop *nh;
> +	int err, i;
> +
> +	nhgi = kzalloc_flex(*nhgi, nexthops, nhs);
> +	if (!nhgi)
> +		return -ENOMEM;
> +
> +	nh_grp->nhgi = nhgi;
> +	nhgi->grp = nh_grp;
> +	nhgi->atbl_offset_valid = false;
> +	nhgi->atbl_offset = 0;
> +	nhgi->count = nhs;

[Severity: High]
Is nhs bounded on the way in here?  nhgi->count is the u8 __counted_by
field for the nexthops flex array, and the only size check in the series
is in sparx5_rr_fib_info_should_offload():

	if (nhs > SPARX5_MAX_ECMP_SIZE)
		return false;

For the IPv6 append path that check only sees the delta carried by the
event, never the merged total (see the comment on sparx5_rr_fib6_append()
below), so repeated "ip -6 route append <prefix> nexthop via <gw>" grows
fib_entry->fi.fe6_info.nrt6 without limit.

At 256 accumulated nexthops nhgi->count wraps to 0 while the flex array
was allocated for 256 entries.  Then sparx5_rr_fib_entry_hw_apply() does:

		if (!nhgi->nexthops->gateway) {

which is a nexthops[0] access with __counted_by(count) == 0, i.e. a trap
on CONFIG_UBSAN_BOUNDS builds, and the ARP programming loop
"for (i = 0; i < nhgi->count; i++)" writes nothing at all.

> +
> +	for (i = 0; i < nhgi->count; i++) {
> +		struct fib_nh_common *fnhc;
> +
> +		nh = &nhgi->nexthops[i];

[ ... ]

> +static void sparx5_rr_arp_tbl_hw_addr_apply(struct sparx5 *sparx5,
> +					    unsigned char mac[ETH_ALEN],
> +					    u16 evmid, int offset)
> +{
> +	u32 mac_msb, mac_lsb;
> +
> +	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
> +
> +	spx5_rmw(ANA_L3_ARP_CFG_0_MAC_MSB_SET(mac_msb) |
> +		 ANA_L3_ARP_CFG_0_ARP_VMID_SET(evmid) |
> +		 ANA_L3_ARP_CFG_0_ARP_ENA_SET(1),
> +		 ANA_L3_ARP_CFG_0_ARP_ENA |
> +		 ANA_L3_ARP_CFG_0_ARP_VMID |
> +		 ANA_L3_ARP_CFG_0_MAC_MSB,
> +		 sparx5, ANA_L3_ARP_CFG_0(offset));
> +
> +	spx5_wr(mac_lsb, sparx5, ANA_L3_ARP_CFG_1(offset));
> +}
> +
> +static void sparx5_rr_arp_tbl_hw_addr_clear(struct sparx5 *sparx5, int offset)
> +{
> +	spx5_rmw(ANA_L3_ARP_CFG_0_ARP_ENA_SET(0), ANA_L3_ARP_CFG_0_ARP_ENA,
> +		 sparx5, ANA_L3_ARP_CFG_0(offset));
> +}

[Severity: Medium]
Should the two halves of the MAC be written in the other order here?
ARP_CFG_0 carries ARP_ENA and MAC_MSB and is written first, while the low
32 bits only land in ARP_CFG_1 afterwards, so the entry is enabled with
the new MSB combined with whatever LSB the slot still held.

sparx5_rr_arp_tbl_hw_addr_clear() only clears ARP_ENA and never touches
ARP_CFG_1, so that leftover LSB belongs to the previous owner of the slot.

When sparx5_rr_nexthop_neigh_update() reprograms a member of a live ECMP
group (reachable in this commit through
sparx5_rr_router_leg_destroy() -> sparx5_rr_nexthop_neigh_update()), do
frames hashing to that member get forwarded with a bogus DMAC of
new MSB : stale LSB during the window?

The same window also seems to defeat the "zero DMAC means trap" rule: with
MAC_MSB zeroed and ARP_ENA still 1, a non-zero stale LSB is left in
ARP_CFG_1, so the frame is forwarded instead of trapped.  Writing
ARP_CFG_1 before the ARP_CFG_0 write that sets ARP_ENA would close both.

[ ... ]

> +static void
> +sparx5_rr_fib_entry_offload_mark(struct sparx5 *sparx5,
> +				 struct sparx5_rr_fib_entry *fib_entry)
> +{
> +	bool offload, trap, offload_failed;
> +
> +	offload_failed = fib_entry->offload_fail;
> +	offload = !fib_entry->offload_fail;
> +	trap = !fib_entry->offload_fail && fib_entry->trap;
> +
> +	sparx5_rr_fib_info_offload_mark(sparx5, &fib_entry->fi, offload, trap,
> +					offload_failed);
> +}

[Severity: Medium]
Do the flags published here match what hardware actually does with the
traffic?

sparx5_rr_fib_entry_hw_apply() sets fib_entry->trap = false for
SPARX5_RR_FIB_TYPE_UNICAST and then, both for directly connected subnets
and for gateway nexthops with an unresolved neighbour MAC, installs an LPM
ARP entry with eth_zero_addr(mac) - which the file header documents as
"If the DMAC written to HW is all zero, the chip will trap the frame".

So "ip route add 10.0.0.0/24 via 10.1.1.1 dev br0.10" reaches
sparx5_rr_fib_entry_offload_mark() with offload_fail == false and
trap == false, and fib_alias_hw_flags_set() publishes RTM_F_OFFLOAD with
RTM_F_TRAP clear, while every packet is punted to the CPU.  Per the commit
message that is all gateway routes at this point in the series, since MAC
resolution only arrives with the next patch.

Going the other way, LOCAL/PROHIBIT/UNREACHABLE set trap = true while
offload_fail stays false, so those routes are reported as offloaded and
trapped at the same time.  mlxsw keeps the two mutually exclusive:

drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:mlxsw_sp_fib4_entry_hw_flags_set() {
	...
	fri.offload = should_offload;
	fri.trap = !should_offload;
	fri.offload_failed = false;
	...
}

The per-nexthop state that would answer this is already tracked in
sparx5_rr_nexthop_egress_derive():

	nh->trapped = !nh_neigh || is_zero_ether_addr(nh_neigh->hwaddr);

but it is never consulted by the flag computation.  Could nh->trapped feed
the reported trap flag?

[ ... ]

> +static int
> +sparx5_rr_fib_entry_update_arp_entry(struct sparx5 *sparx5,
> +				     struct sparx5_rr_fib_entry *fib_entry,
> +				     unsigned char mac[ETH_ALEN], u16 evmid)
> +{
> +	struct net_device *pdev = sparx5->router->port_dev;
> +	struct vcap_control *vctrl = sparx5->vcap_ctrl;
> +	u32 vrule_id = fib_entry->hw_route.vrule_id;
> +	struct vcap_rule *vrule;
> +	u32 mac_msb, mac_lsb;
> +	int err;
> +
> +	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
> +
> +	vrule = vcap_get_rule(vctrl, vrule_id);
> +	if (IS_ERR(vrule)) {
> +		fib_entry->hw_route.vrule_id_valid = false;
> +		return PTR_ERR(vrule);
> +	}

[Severity: Medium]
Is it safe to clear vrule_id_valid on any vcap_get_rule() failure?  The
lookup can fail on allocation while the rule is still programmed:

drivers/net/ethernet/microchip/vcap/vcap_api.c:vcap_decode_rule() {
	...
	ri = vcap_dup_rule(elem, elem->state == VCAP_RS_DISABLED);
	if (IS_ERR(ri))
		return ERR_CAST(ri);
	...
}

After that, sparx5_rr_fib_entry_destroy() skips vcap_del_rule() because
vrule_id_valid is false, so does the LPM rule stay in the TCAM matching
the prefix with a stale action?

Related: this function reads fib_entry->hw_route.vrule_id without ever
checking hw_route.vrule_id_valid, so a later update can
vcap_get_rule()/vcap_mod_rule() an id that vcap_alloc_rule() has since
handed to a different route's (or a neighbour host route's) rule.

> +
> +	switch (vrule->actionset) {
> +	case VCAP_AFS_ARP_ENTRY:

[ ... ]

> +	case VCAP_AFS_ARP_PTR:
> +		/* Convert arp_ptr to arp_entry */
> +		err = sparx5_rr_lpm_arp_entry_create(sparx5,
> +						     &fib_entry->key.addr,
> +						     fib_entry->key.prefix_len,
> +						     mac, evmid,
> +						     &fib_entry->hw_route);
> +		if (err)
> +			goto free_rule;
> +
> +		sparx5_rr_nh_grp_arp_tbl_grp_clear(sparx5, fib_entry->nh_grp);
> +		err = vcap_del_rule(vctrl, pdev, vrule_id);
> +		goto free_rule;

[Severity: Medium]
Should the ARP_PTR rule be deleted before its ARP table entries are
released?  sparx5_rr_nh_grp_arp_tbl_grp_clear() disables the entries and
returns the offsets to router->arp_tbl_mask while the ARP_PTR rule is
still installed, so hardware can keep matching it and dereferencing slots
that are disabled or already handed to another route.  The replacement
inline rule is already installed at this point, so deleting the old rule
first looks safe.

If vcap_del_rule() fails, does that inconsistency become permanent?

[ ... ]

> +static int sparx5_rr_lpm_arp_ptr_create(struct sparx5 *sparx5,
> +					struct sparx5_iaddr *addr,
> +					u32 prefix_len, u32 arp_offset_addr,
> +					u8 ecmp_size,
> +					struct sparx5_rr_hw_route *hw_route)
> +{

[ ... ]

> +	err |= vcap_rule_add_action_u32(rule, VCAP_AF_ECMP_CNT, ecmp_size - 1);

[Severity: High]
Is ecmp_size validated against the width of this action field anywhere?
VCAP_AF_ECMP_CNT is four bits:

drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c {
	[VCAP_AF_ECMP_CNT] = {
		.type = VCAP_FIELD_U32,
		.offset = 14,
		.width = 4,
	},
}

(same width in lan969x_vcap_ag_api.c, documented as W4 in vcap_ag_api.h),
and neither vcap_rule_add_action() nor the encoder range checks the value.

With 17 accumulated nexthops, ECMP_CNT = 16 & 0xF = 0 and hardware uses a
single ARP entry for a 17 member group.  With the u8 count wrap described
above, ecmp_size is 0 here, so ECMP_CNT gets (0 - 1) truncated to 0xF and
hardware forwards using 16 ARP table slots that this group never
initialised.

[ ... ]

> +static void sparx5_rr_fib_entry_destroy(struct sparx5 *sparx5,
> +					struct sparx5_rr_fib_entry *fib_entry)
> +{
> +	struct net_device *pdev = sparx5->router->port_dev;
> +	struct vcap_control *vctrl = sparx5->vcap_ctrl;
> +
> +	list_del(&fib_entry->fib_node);
> +	sparx5_rr_fib_entry_remove(sparx5, fib_entry);
> +	sparx5_rr_nexthop_group_put(sparx5, fib_entry->nh_grp);
> +	if (fib_entry->hw_route.vrule_id_valid)
> +		vcap_del_rule(vctrl, pdev, fib_entry->hw_route.vrule_id);
> +	sparx5_rr_fib_info_put(&fib_entry->fi);
> +	kfree(fib_entry);
>  }

[Severity: Medium]
Same ordering question as the ARP_PTR conversion above:
sparx5_rr_nexthop_group_put() disables the ARP entries and frees their
offsets in arp_tbl_mask before vcap_del_rule() removes the LPM rule that
still points at them.  Would deleting the VCAP rule first avoid the window
where an installed ARP_PTR rule references reallocated slots?

[Severity: Low]
Should this path also clear the hardware status flags it published
earlier?  There is no fib_alias_hw_flags_set()/fib6_info_hw_flags_set()
call with offload=false, trap=false, offload_failed=false, and
sparx5_rr_router_deinit() unregisters the FIB notifier and then calls
sparx5_rr_fib_flush().

After a driver unbind or module unload, do the routes that still exist in
init_net keep advertising RTM_F_OFFLOAD/RTM_F_TRAP in route dumps even
though their VCAP rules are gone?  mlxsw has
mlxsw_sp_fib4_entry_hw_flags_clear() and
mlxsw_sp_fib6_entry_hw_flags_clear() for this.

[ ... ]

> @@ -660,6 +1982,443 @@ static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
> +static bool sparx5_rr_fib_info_should_offload(struct sparx5 *sparx5,
> +					      struct sparx5_rr_fib_info *fi)
> +{
> +	u32 tb_id = sparx5_rr_fib_info_tb_id(fi);
> +	u8 type = sparx5_rr_fib_info_type(fi);
> +	int nhs = sparx5_rr_fib_info_nhs(fi);

[ ... ]

> +	if (!(tb_id == RT_TABLE_MAIN ||
> +	      tb_id == RT_TABLE_LOCAL))
> +		return false;

[ ... ]

> +	if (nhs > SPARX5_MAX_ECMP_SIZE)
> +		return false;

[ ... ]

> +static void sparx5_rr_fib4_event_work(struct work_struct *work)
> +{
> +	struct sparx5_fib_event_work *fib_work =
> +		container_of(work, struct sparx5_fib_event_work, work);
> +	struct sparx5 *sparx5 = fib_work->sparx5;
> +	int err;
> +
> +	mutex_lock(&sparx5->router->lock);
> +
> +	switch (fib_work->event) {
> +	case FIB_EVENT_ENTRY_REPLACE:
> +		err = sparx5_rr_fib_replace(sparx5, &fib_work->fi);
> +		if (err)
> +			dev_warn(sparx5->dev, "FIB replace failed, ip=%pI4l\n",
> +				 &fib_work->fi.fen4_info.dst);

[Severity: Low]
Should this be %pI4h rather than %pI4l?  fen4_info.dst is the host order
fib_trie key - this patch converts it explicitly elsewhere:

	key->addr.ipv4 = cpu_to_be32(dst);

and

	fri.dst = cpu_to_be32(fen4_info->dst);

lib/vsprintf.c's ip4_string() treats 'l' as unconditionally little endian
and 'h' as host order, so %pI4l prints the dotted quad reversed on big
endian builds.

[ ... ]

> +static int sparx5_rr_fib6_append(struct sparx5 *sparx5,
> +				 struct sparx5_rr_fib_info *fi)
> +{
> +	struct sparx5_rr_fib_entry *fib_entry;
> +	struct sparx5_rr_fib_key key;
> +	int err = 0;
> +
> +	if (sparx5_rr_fib_info_should_ignore(fi))
> +		return 0;
> +
> +	sparx5_rr_fib_info_to_fib_key(fi, &key);
> +
> +	fib_entry = sparx5_rr_fib_entry_lookup(sparx5, &key);
> +	if (!fib_entry)
> +		return 0;
> +
> +	/* Are we adding new nexthops which can not be offloaded */
> +	if (!sparx5_rr_fib_info_should_offload(sparx5, fi)) {
> +		err = -EINVAL;
> +		goto out_fib_mark_offload;
> +	}
> +
> +	/* Append new rt_arr data to fen6_info rt data */
> +	err = sparx5_rr_fib_entry_fib_info_add(fib_entry, fi);

[Severity: High]
Can the merged nexthop count exceed SPARX5_MAX_ECMP_SIZE here?
sparx5_rr_fib_info_should_offload() is called on the event's fi, whose
nrt6 is nsiblings + 1 - that is 1 for a plain
"ip -6 route append <prefix> nexthop via <gw>" - so the

	if (nhs > SPARX5_MAX_ECMP_SIZE)
		return false;

guard always passes, and sparx5_rr_fib_entry_fib6_info_add() then grows
f6i->nrt6 to old + new with no limit.

Would checking sparx5_rr_fib_info_nhs(&fib_entry->fi) + nhs against
SPARX5_MAX_ECMP_SIZE before the append be the right place to bound this?

[ ... ]

> +/* Handle fib events, which manage fib_entries. Called in atomic context, with
> + * rcu_read_lock().
> + */
> +static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
> +			       void *ptr)
> +{

[ ... ]

> +	if (event != FIB_EVENT_ENTRY_REPLACE &&
> +	    event != FIB_EVENT_ENTRY_DEL &&
> +	    event != FIB_EVENT_ENTRY_APPEND)
> +		return NOTIFY_DONE;

[Severity: Medium]
Are FIB rule events intentionally left out?  With this filter,
FIB_EVENT_RULE_ADD never reaches the driver, and there is no l3mdev/VRF
check when a leg is admitted:

	return netif_is_bridge_master(vlan_rdev) &&
	       br_vlan_enabled(vlan_rdev) &&
	       sparx5_port_dev_lower_find(vlan_rdev);

Meanwhile L3 unicast forwarding is enabled unconditionally per leg
(sparx5_rr_leg_hw_init() sets RLEG_IP4_UC_ENA/RLEG_IP6_UC_ENA, and
sparx5_rr_router_init() sets ANA_L3_ROUTING_CFG_L3_ENA_MODE plus
ANA_L3_L3_UC_ENA = ~0) while only RT_TABLE_MAIN/RT_TABLE_LOCAL routes are
programmed into the single LPM VCAP.

So after "ip rule add ... lookup <table>", or with a leg enslaved to a
VRF, does the kernel use the policy/VRF table while hardware keeps
forwarding from the main table LPM?  mlxsw watches FIB rule events to
abort offload in exactly this situation.  If this is a known limitation,
could the commit message mention it?

[ ... ]

> @@ -2813,10 +2813,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
>  		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
>  		 ANA_ACL_VCAP_S2_MISC_CTRL);
>  
> +	r->fib_nb.notifier_call = sparx5_rr_fib_event;
> +	err = register_fib_notifier(&init_net, &r->fib_nb, NULL, NULL);
> +	if (err)
> +		goto err_workqueue_destroy;

[Severity: Medium]
Is a dump-abort callback needed as the third argument here?  The initial
dump is delivered before the block joins the chain, and then:

net/core/fib_notifier.c:fib_dump_is_consistent() {
	...
	atomic_notifier_chain_unregister(&fn_net->fib_chain, nb);
	if (cb)
		cb(nb);
	return false;
	...
}

With cb == NULL, nothing discards the state built from an aborted pass:
entries created by sparx5_rr_fib4_event_work()/sparx5_rr_fib6_event_work()
stay in router->fib_ht/fib_list with live LPM VCAP rules and held
fib_info/fib6_info references.

If a route is deleted during the dump window, it can never get a
FIB_EVENT_ENTRY_DEL (the block was off the chain then, and the retried
dump no longer lists it), so does hardware keep forwarding or blackholing
that prefix until sparx5_rr_router_deinit()?

mlxsw passes mlxsw_sp_router_fib_dump_flush and netdevsim passes
nsim_fib_dump_inconsistent here.  Note that a callback would have to drain
the ordered workqueue first: sparx5_rr_fib_flush() takes no router->lock,
which is only safe today because it runs after destroy_workqueue().

>  	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
>  	err = register_inetaddr_notifier(&r->inetaddr_nb);
>  	if (err)
> -		goto err_workqueue_destroy;
> +		goto err_unreg_fib_notifier;

[ ... ]
