Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C50472535;
	Mon, 17 Aug 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001243; cv=none; b=DknY3riMZwLve1BTnG1yVVEg31mo3Evr8+E6ITlLarEMq4q1rSZSNiOhnreZxH2N4jq/3nsdWDjASheRcJohTi5tUBCcT0jj7CcA0aJYvJMrX2cq/UEwf5Vdd+Yoa0J43/2GMieG9dxlc3aVePeFPWkNTsw3sIY1EHfFxhl3hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001243; c=relaxed/simple;
	bh=oXA5Kkescpkj/2Sjax6t3MPfOPNGMX8Ekxjk+5xJ3WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy42/fpViIbveSLqT2rc0zMNz87Kujt0s3UpyZuyCEWY3/0ap62XU3XrW7m85SRTC7Xbpm+A1oqrBfbtLBaPHomoWY6fr4BdH8dSy0cxJPe5CFeKy8gl05aOqQhh3XF/ovzlFw70CiydpRrlrMxAfngR30k7lAZexprowUvi61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK8DYUjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK8DYUjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A931F000E9;
	Mon, 17 Aug 2026 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001242;
	bh=jBcwTiXG8GYcLFIT6owml6CkINV+t6iQSd/lsiW8fZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FK8DYUjzFrnGyxxlECafHWHcXPc8N5o0Fy9m/5Pi36vzk4Rg0H7GzsmV3rj7gLcxP
	 j4QKGJwju1JgLbZ6Gk2Nx1xey2CQyb2uVPNrgG0VopC/B02O8ogWGExM5L5GkDFpgV
	 JrE2sDEAON+MpHLEA+DsjYoA3HXRTARPB94gKQsJkmZmtVubA+WyfA6XWdXVKe931M
	 Stwx1gmUbcKu+Utike2YrGE98wW1PncR02Uhlzr1JVDd41pkL5Zn0aCK+/CO/Rok3K
	 N1TmvHJc5OrdB5S2d8+igMCMbkRhopdOrzU1dq5cNtBz1HpjGCH7Q12+iNkBbta/uR
	 WHs/LyRRH2k6A==
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
Subject: Re: [PATCH net-next v2 9/9] net: sparx5: add neighbour event handling for L3 routing
Date: Mon, 17 Aug 2026 14:14:00 -0700
Message-ID: <20260817211400.3633528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-9-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-9-59e68cc8c8ca@microchip.com>
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
net: sparx5: add neighbour event handling for L3 routing

This adds a netevent notifier to sparx5 that queues NETEVENT_NEIGH_UPDATE
events to the router ordered workqueue, where the resolved MAC is written
into the driver neigh entry and pushed to the hardware ARP table and to
all linked nexthops. Unreachable neighbours tear down the hardware ARP
entry and mark the nexthops as unresolved.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> index 6d40d651180e6..5f6add84b0d6c 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c

[ ... ]

> @@ -2419,6 +2430,107 @@ static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
>  	return NOTIFY_BAD;
>  }
>  
> +static void sparx5_rr_neigh_event_work(struct work_struct *work)
> +{
> +	struct sparx5_rr_netevent_work *net_work =
> +		container_of(work, struct sparx5_rr_netevent_work, work);
> +	unsigned char hwaddr[ETH_ALEN] __aligned(2);
> +	struct sparx5 *sparx5 = net_work->sparx5;
> +	struct neighbour *n = net_work->neigh;
> +	struct sparx5_rr_neigh_key key = { };
> +	struct sparx5_rr_neigh_entry *entry;
> +	bool entry_connected;
> +	u8 nud_state, dead;
> +
> +	sparx5_rr_nb2neigh_key(n, &key);
> +
> +	/* Frames with link-local dip are trapped, so ignore the neighbour. */
> +	if (key.iaddr.version == SPARX5_IPV6 &&
> +	    ipv6_addr_type(&key.iaddr.ipv6) & IPV6_ADDR_LINKLOCAL)
> +		goto out;

[Severity: Medium]
Does the comment's justification cover neighbours that are used as
gateways rather than as destinations?

The trap rule installed by sparx5_rr_lpm_link_local_create() matches on
destination fe80::/64 only, and sparx5_rr_fib_info_should_ignore() only
skips routes whose destination is link-local:

	return fi->version == SPARX5_IPV6 &&
	       ipv6_addr_type(&fi->fe6_info.rt_arr[0]->fib6_dst.addr) &
		       (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL);

A route such as "ip -6 route add 2001:db8::/64 via fe80::1 dev vlanX" is
therefore still offloaded, and sparx5_rr_nexthop_init() sets
nh->neigh_tbl = &nd_tbl for every AF_INET6 gateway without a link-local
filter, so sparx5_rr_nexthop_neigh_init() creates a neigh entry for
fe80::1.

Since this work handler is the only writer of entry->hwaddr, can such a
nexthop ever obtain a MAC?  sparx5_rr_nexthop_egress_derive() would keep
nh->trapped set and program the zero MAC, so routes via a link-local
gateway (including RA-derived default routes) stay trapped to the CPU
while being reported as offloaded.

> +
> +	/* If n changes after this read section, we will get another neigh
> +	 * event, which is processed after the current one.
> +	 */
> +	read_lock_bh(&n->lock);
> +	ether_addr_copy(hwaddr, n->ha);
> +	nud_state = n->nud_state;
> +	dead = n->dead;
> +	read_unlock_bh(&n->lock);
> +
> +	mutex_lock(&sparx5->router->lock);
> +
> +	entry_connected = nud_state & NUD_VALID && !dead;
> +	entry = sparx5_rr_neigh_entry_lookup(sparx5, &key);
> +	if (!entry_connected && !entry)
> +		goto out_mutex;
> +
> +	if (!entry) {
> +		entry = sparx5_rr_neigh_entry_create(sparx5, &key);
> +		if (IS_ERR(entry))
> +			goto out_mutex;
> +	}

[Severity: Medium]
With this notifier being the only source of entry->hwaddr, how does an
already-resolved kernel neighbour get synchronized into a newly created
driver entry?

sparx5_rr_nexthop_neigh_init() only kicks ARP/NDP when the kernel
neighbour did not already exist, and never samples n->ha / n->nud_state:

	n = neigh_lookup(nh->neigh_tbl, &nh->gw_addr, dev);
	if (!n) {
		n = neigh_create(nh->neigh_tbl, &nh->gw_addr, dev);
		if (IS_ERR(n))
			return PTR_ERR(n);
		/* Start arp process */
		neigh_event_send(n, NULL);
	}

For a NUD_PERMANENT neighbour ("ip neigh add <gw> lladdr <mac> nud
permanent dev vlanX") no further NETEVENT_NEIGH_UPDATE is generated -
net/core/neighbour.c only emits netevents from __neigh_update(),
neigh_timer_handler() and neigh_cleanup_and_release(), and permanent
entries have no timer and are skipped by the GC work.  Does that leave
entry->hwaddr zero forever, so sparx5_rr_nexthop_egress_derive() keeps
nh->trapped set while the FIB entry is reported as offloaded?

The same applies when the event arrives before a router leg exists:
sparx5_rr_neigh_entry_create() returns ERR_PTR(-EINVAL) from

	leg = sparx5_rr_leg_find_by_dev(sparx5, key->dev);
	if (!leg)
		return ERR_PTR(-EINVAL);

and the event is dropped with no replay when the leg later appears.

For comparison, mlxsw_sp_nexthop_neigh_init() reads nud_state/dead under
n->lock and calls __mlxsw_sp_nexthop_neigh_update() at init time:

	read_lock_bh(&n->lock);
	nud_state = n->nud_state;
	dead = n->dead;
	read_unlock_bh(&n->lock);
	__mlxsw_sp_nexthop_neigh_update(nh, !(nud_state & NUD_VALID && !dead));

> +
> +	if (entry->connected && entry_connected &&
> +	    ether_addr_equal(entry->hwaddr, hwaddr))
> +		goto out_mutex;

[Severity: Medium]
Can this early exit permanently block a retry after a failed hardware
write?

sparx5_rr_neigh_entry_update() marks the entry connected before the
fallible hardware apply and only downgrades the offload marking:

	entry->connected = adding;

	if (adding) {
		err = sparx5_rr_neigh_entry_hw_apply(sparx5, entry);
		if (err)
			offloaded = false;

sparx5_rr_lpm_arp_entry_mod() can fail while the rule keeps the previous
DMAC:

	vrule = vcap_get_rule(vctrl, vrule_id);
	if (IS_ERR(vrule))
		return -EINVAL;

and sparx5_rr_lpm_arp_entry_create() can fail on rule allocation or
vcap_val_add_rule().

Since the new MAC has already been stored in entry->hwaddr and
entry->connected is true, every following NUD_VALID confirmation
(REACHABLE/STALE/DELAY) hits the test above and skips both the LPM/ARP
update and sparx5_rr_nexthops_update_notify().  For an IP that moves to a
new MAC (VRRP failover, VM migration), would hardware keep rewriting DMAC
to the old MAC with no trap and no further retry?

Would keying the skip on hw_route.vrule_id_valid (or propagating the
error from sparx5_rr_neigh_entry_update()) avoid that?

> +
> +	ether_addr_copy(entry->hwaddr, hwaddr);
> +	sparx5_rr_neigh_entry_update(sparx5, entry, entry_connected);
> +	sparx5_rr_nexthops_update_notify(sparx5, entry, entry_connected);
> +	if (!entry_connected)
> +		sparx5_rr_neigh_entry_put(sparx5, entry);

[Severity: High]
Should the MAC be committed into entry->hwaddr on the disconnect path as
well?

The kernel does not clear n->ha when a neighbour goes to NUD_FAILED or
dead - neigh_invalidate() only flushes arp_queue, and neigh->ha is only
overwritten when a new lladdr is supplied.  So for !entry_connected this
stores the last, now invalid MAC while entry->connected becomes false, and
nothing else ever zeroes entry->hwaddr.  sparx5_rr_neigh_entry_put() keeps
the entry alive while a nexthop still references it.

The only other consumer derives "resolved" purely from the MAC being
non-zero and ignores entry->connected:

	nh->trapped = !nh_neigh || is_zero_ether_addr(nh_neigh->hwaddr);

	if (nh_neigh) {
		memcpy(mac, nh_neigh->hwaddr, ETH_ALEN);

On ordinary route churn, sparx5_rr_entry_nexthop_group_update() builds and
programs the new group before releasing the old one:

	/* Prepare new group in SW representation */
	new_nh_grp = sparx5_rr_nexthop_group_create(sparx5, fib_entry);
	...
	err = sparx5_rr_fib_entry_hw_apply(sparx5, fib_entry);
	...
	sparx5_rr_nexthop_group_put(sparx5, old_nh_grp);

so sparx5_rr_nexthop_neigh_init() re-attaches to the surviving entry and
sparx5_rr_nexthop_egress_derive() then clears nh->trapped and installs the
dead MAC.  Does that leave traffic forwarded to a host that no longer
exists instead of trapped, with no path back to trapping since the kernel
never sees the traffic?

This also seems to differ from the commit message wording "mark linked
nexthops as unresolved so traffic traps to the CPU".

> +
> +out_mutex:
> +	mutex_unlock(&sparx5->router->lock);
> +out:
> +	neigh_release(n);
> +	kfree(net_work);
> +}
> +
> +/* Handle neighbour update events. Used to manage neigh_entries. Called in
> + * atomic context, with rcu_read_lock().
> + */
> +static int sparx5_rr_netevent_event(struct notifier_block *nb,
> +				    unsigned long event, void *ptr)
> +{

[ ... ]

> +		net_work = kzalloc_obj(*net_work, GFP_ATOMIC);
> +		if (!net_work)
> +			return NOTIFY_BAD;

[Severity: Low]
Would NOTIFY_DONE be a better return value here?

NETEVENT_NEIGH_UPDATE is delivered over the single system-wide atomic
chain:

net/core/netevent.c:call_netevent_notifiers() {
	return atomic_notifier_call_chain(&netevent_notif_chain, val, v);
}

and NOTIFY_BAD carries NOTIFY_STOP_MASK, which ends the traversal:

kernel/notifier.c:notifier_call_chain() {
	...
		if (ret & NOTIFY_STOP_MASK)
			break;
	...
}

So a driver-private GFP_ATOMIC failure suppresses the notification for
every listener registered after sparx5.  The same idiom exists in
mlxsw_sp_router_schedule_work(), so this is minor, but the failure looks
purely local and recoverable here.

> +
> +		INIT_WORK(&net_work->work, sparx5_rr_neigh_event_work);
> +		net_work->sparx5 = router->sparx5;
> +		net_work->neigh = neigh_clone(n);
> +		net_work->event = event;
> +		sparx5_rr_schedule_work(router->sparx5, &net_work->work);
> +
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_DONE;
> +};
> +

[ ... ]

> @@ -2855,6 +2972,8 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
>  	unregister_inetaddr_notifier(&r->inetaddr_nb);
>  err_unreg_fib_notifier:
>  	unregister_fib_notifier(&init_net, &r->fib_nb);
> +err_unreg_netevent_notifier:
> +	unregister_netevent_notifier(&r->netevent_nb);
>  err_workqueue_destroy:
>  	destroy_workqueue(r->sparx5_router_owq);
>  	sparx5_rr_fib_flush(sparx5);

[Severity: Low]
While looking at this unwind path, the neighbour hashtable is destroyed
before the legs that own entries in it are flushed:

err_neigh_ht_destroy:
	rhashtable_destroy(&r->neigh_ht);
err_blackhole_destroy:
	sparx5_rr_router_legs_flush(sparx5);

sparx5_rr_router_leg_destroy() walks leg->neigh_list and reaches
rhashtable_remove_fast() via sparx5_rr_neigh_entry_destroy() ->
sparx5_rr_neigh_entry_remove(), on a table whose bucket table has already
been freed.  sparx5_rr_router_deinit() uses the opposite order (legs
flush, WARN_ON(nelems), then rhashtable_destroy).

The dangerous state does not appear reachable today: neigh entries only
exist once a device leg exists, and legs are only created from the
inetaddr/inet6addr handlers registered after register_fib_notifier(),
which is the only registration here that realistically fails;
sparx5_rr_netdevice_event() always returns NOTIFY_OK, and the
inet6addr registrations only fail on duplicate registration.  This
ordering also comes from the earlier patch in the series that added the
FIB/nexthop/neighbour entry management, not from this patch, which only
adds one more producer of neigh entries.  Would it still be worth
matching the deinit order defensively?
