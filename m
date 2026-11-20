Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159192;
	b=Ux3E/vBx8Md+L9i6/9rapsgw0fLRJ7ajVyjC3lEY7EdFFO2YGkDslPQUNc2xIG618XK2
	 s8sizL+cmbzZVBU1s2E/6czMiOo/uff2LE1/qoWiN1aPYQiJxJ++IBo4ouGyyOLJ5SBOV
	 F/KklN6WeXX7jEbJXaTvyLBzkuiN4ybIXb7TP7c/FdkrtpJoeikC6W6UQ2P9zFc/TuqQS
	 xrH4/IldqPPr5k0kBVJjX5qR/Idyeq1PrOx/Y3TWdk6tjJHvK9otOZXxIWqLO0NwTQgeL
	 IXMPitP1OHIrfnrNCAfAFFOwch55+idxwb6tm3QC+5XZ+pMpLmWMaeygnnGbp9i/ikQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159192;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=n2W9ZCbVVoNPmdewBS11YOnEJAFNDq3Tlc6gPAtTTl0=;
	b=Q0trlS3bTgUabega9s8MWTWku9SRP3xgvQ3d+7TdBFs8Rb8/ORbAAgv7TPJ7tRYSvTBw
	 UiInBerfBUThv3j7t6gJKj+P6RltlNkAszT/Lhx9z49PRCCnPoB5k6oTgsd3wbjfAtQ5l
	 /PrC6pBc9xx7t30yvkop0fjqxIYxuUDULBAiQORPN2VOKzElw9mLSXtyDUG5qkaL/C/G2
	 XfDe2C1xX6LioraWdK2nldi56k6VL8weWdFqX1BPMoMvBUP4biZtbxN+kPMIuDOgvELvY
	 rDJBGLt3K7XZQ8GsCafUvbHcLyqnWpSwGBFnBf879xfJHSKKMyrjpypi1aiLmN1qwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZZnNoGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C65606A32A;
	Fri, 20 Nov 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZZnNoGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388871F000C4;
	Fri, 20 Nov 2026 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795159192;
	bh=n2W9ZCbVVoNPmdewBS11YOnEJAFNDq3Tlc6gPAtTTl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GZZnNoGaCjPiI7bsTsmYMCUUt9kOh7QQRXTHzoCJhi7J5IOWdLnScVoI8H3g+7xOV
	 klP5Ka1JFpluxAiZe0rcE7Qx1GnfT3iZrLvQRoz+hqVj+oCUd09Rk/9ezN5xbEPwy1
	 /CPQYIOXYNV+yxiJhyWc+Ei5cyOAP7NUZeX5/HZsYa6xPuQPDEeFsekdrbd9H4XMZc
	 7O0s6icikWy6Hal+pq5wzp5glw95jWDvwwAN14S7yE8nDEeqxZ4s88Vs7NwLBJr1sD
	 l3Rt0UpT+oP2oGIwUwXUC/Y6/RfuQuQJhksPtBvFFvqIspcAl+mUb8rlxUnNp3Ul9K
	 3PaiSSUUrurAw==
Subject: Re: [PATCH net-next v3 3/3] net: sparx5: keep router legs in sync
 with the bridge
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, daniel.machon@microchip.com, Steen.Hegelund@microchip.com,
 kees@kernel.org, gustavoars@kernel.org, robert.marko@sartura.hr,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Date: Fri, 20 Nov 2026 07:19:50 +0000
Message-ID: <179515919073.3136.18115865975545072840@kernel.org>
In-Reply-To: <20261117-sparx5_l3_routing-v3-3-e680ed79c7dc@microchip.com>
References: <20261117-sparx5_l3_routing-v3-3-e680ed79c7dc@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] sparx5_rr_legs_reconcile() now walks
  netdev_for_each_upper_dev_rcu(sparx5->hw_bridge_dev, ...) from the…
- [Medium] Contrary to the commit message, a router leg can be lost while
  its upper is down.
- [Low] In sparx5_rr_router_init() the new comment says "The exported
  helpers use leg_list once sparx5->router is set".
- [Low] The function comment above sparx5_rr_bridge_legs_flush() still
  reads "Tear down the router legs of a bridge that is no longer…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but this patch
  extends the affected code.

--

net: sparx5: keep router legs in sync with the bridge

This commit makes the sparx5 L3 router legs follow later changes to the
bridge and the vlan upper. A leg is destroyed when vlan filtering is
disabled, when the bridge moves to a non-802.1Q protocol, when the upper
is linked to a master, or when the upper's MAC changes. Ingress routing
on a leg is limited to when the upper is up and the bridge carries the
vid tagged, and the reconcile now also creates legs for eligible uppers
of the offloaded bridge.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> index 26aeee17733cd..7412db7a6e7b4 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c

[ ... ]

> @@ -568,19 +650,66 @@ static void sparx5_rr_router_legs_flush(struct sparx5 *sparx5)

[ ... ]

> +void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
>  {
>  	struct sparx5_rr_router_leg *leg, *tmp;
> +	struct net_device *bridge, *dev;
>  	struct sparx5_router *router;
> +	struct list_head *iter;
>  
>  	ASSERT_RTNL();
>  
>  	router = sparx5->router;
> +	if (!router)
> +		return;
>  
>  	mutex_lock(&router->lock);
>  	list_for_each_entry_safe(leg, tmp, &router->leg_list, leg_list_node) {
> -		if (sparx5_rr_dev_addr_list_empty(leg->dev))
> +		if (sparx5_rr_dev_addr_list_empty(leg->dev) ||
> +		    !sparx5_rr_dev_real_is_vlan_aware(sparx5, leg->dev)) {
>  			sparx5_rr_router_leg_destroy(leg);
> +			continue;
> +		}

[Severity: Medium]
The commit message says:

  "A leg with an IPv4 address is kept while the upper is down, so it is
  available again when the interface comes back up."

Does this still hold if the bridge MAC changes while a NET_ADDR_STOLEN vlan
upper is down?

When the bridge sends NETDEV_CHANGEADDR, vlan_device_event() in
net/8021q/vlan.c skips uppers that are not IFF_UP. A down upper therefore
keeps the old MAC, and sparx5_rr_dev_real_is_vlan_aware() then fails here:

	if (dev->addr_assign_type != NET_ADDR_STOLEN ||
	    !ether_addr_equal(dev->dev_addr, vlan_rdev->dev_addr))
		return false;

On the next reconcile, the new check above destroys the down upper's IPv4
leg and frees its VMID.

Unrelated events can queue that reconcile: an inet6addr UP/DOWN on any vlan
device, a bridge vlan add or del, or the VLAN_FILTERING attr that is sent
when a sparx5 port joins. For example, a port with a lower MAC joins the
bridge. That queues the reconcile, and br_stp_recalculate_bridge_id()
changes the bridge MAC before the reconcile runs.

Suppose the bridge MAC then changes back before the upper comes up, for
example because the port leaves again or after ip link set br0 address
<old>. What recreates the leg then? The bridge NETDEV_CHANGEADDR in
sparx5_rr_netdevice_event() does not queue a reconcile, because
is_vlan_dev(bridge) is false:

	case NETDEV_CHANGEADDR:
		mutex_lock(&router->lock);
		if (sparx5_rr_bridge_has_legs(sparx5, dev))
			sparx5_rr_leg_base_mac_set(sparx5, dev->dev_addr);
		mutex_unlock(&router->lock);
		if (is_vlan_dev(dev))
			sparx5_rr_legs_reconcile_schedule(sparx5);

When the upper is later brought up, the MACs already match, so no
CHANGEADDR is sent. The NETDEV_UP case only refreshes an existing leg. The
IPv4 address already exists, so the validator does not run either. With
IPv6 disabled on the upper (disable_ipv6, or addr_gen_mode none), no
link-local NETDEV_UP arrives.

Wouldn't the upper then stay without a leg until something unrelated
triggers a reconcile?

Now take the case where the upper comes up while the bridge still has the
new MAC. vlan_dev_open()->vlan_dev_inherit_address() does queue a reconcile.
But if another upper has taken the freed VMID in the meantime, creating the
leg fails, and only a ratelimited warning is printed.

> +
> +		bridge = vlan_dev_real_dev(leg->dev);
> +		leg->vlan_present = sparx5_rr_bridge_vlan_present(bridge,
> +								  leg->vid);
> +		sparx5_rr_leg_hw_uc_update(sparx5, leg);
> +	}
> +
> +	bridge = sparx5->hw_bridge_dev;
> +	if (!bitmap_empty(sparx5->bridge_mask, SPX5_PORTS) && bridge) {
> +		netdev_for_each_upper_dev_rcu(bridge, dev, iter) {

[Severity: High]
Can this walk a bridge that has already been freed during driver removal?

The driver holds no reference on hw_bridge_dev. Only
sparx5_port_bridge_leave() clears hw_bridge_dev and bridge_mask, and it runs
from the main sparx5 netdevice notifier on NETDEV_CHANGEUPPER. Before this
patch, the reconcile walked only leg_list, whose entries hold netdev
references.

mchp_sparx5_remove() unregisters that notifier before the router notifiers:

	sparx5_unregister_notifier_blocks(sparx5);
	sparx5_rr_router_deinit(sparx5);

Suppose ip link del br0 runs in that window. del_nbp() unlinks the ports,
but hw_bridge_dev and bridge_mask stay set. The router notifiers are still
registered, so addrconf_ifdown() on the bridge's vlan uppers can, for
example, send inet6addr NETDEV_DOWN, and sparx5_rr_inet6addr_event() queues
legs_work. After rtnl_unlock(), netdev_run_todo() frees the bridge.

legs_work can then run, including during the drain in
sparx5_rr_router_deinit(), while sparx5->router is still set:

	destroy_workqueue(router->sparx5_router_owq);
	sparx5_rr_router_legs_flush(sparx5);
	sparx5_rr_router_hw_deinit(sparx5);
	sparx5->router = NULL;

The bridge_mask/hw_bridge_dev check passes on this stale state, and
netdev_for_each_upper_dev_rcu() reads the adj_list of the freed bridge.
Could a garbage dev then reach __sparx5_rr_inetaddr_event(), which may call
netdev_hold() on it and program hardware?

> +			if (!is_vlan_dev(dev) ||
> +			    sparx5_rr_dev_addr_list_empty(dev))
> +				continue;
> +			if (__sparx5_rr_inetaddr_event(sparx5, dev, NETDEV_UP,
> +						       NULL) && net_ratelimit())
> +				netdev_warn(dev,
> +					    "Failed to offload L3 router leg\n");
> +		}
>  	}
>  	mutex_unlock(&router->lock);
>  }
> @@ -681,6 +810,7 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
>  
>  	INIT_LIST_HEAD(&r->leg_list);
>  
> +	/* The exported helpers use leg_list once sparx5->router is set. */
>  	sparx5->router = r;
>  
>  	r->sparx5_router_owq = alloc_ordered_workqueue("sparx5_router_owq", 0);

[Severity: Low]
Is this comment complete? sparx5_rr_legs_reconcile_schedule() is now
exported and is also called from sparx5_rr_bridge_vlan_clear(). It checks
only sparx5->router, but it also uses router->sparx5_router_owq and
router->legs_work, which are set up after this assignment.

Teardown has the same gap. sparx5_rr_router_deinit() and the init error
path both destroy the workqueue before they clear sparx5->router.

Today this is safe only because of the call order: mchp_sparx5_probe()
registers the switchdev/netdevice notifiers after router init, and
mchp_sparx5_remove() unregisters them before router deinit.

Should this ordering dependency be documented? Alternatively, the pointer
could be published after alloc_ordered_workqueue() and INIT_WORK().

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
> index 46b3351f717ff..baa46d21e7bad 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
> @@ -152,6 +152,11 @@ static int sparx5_port_attr_set(struct net_device *dev, const void *ctx,
>  		sparx5_port_attr_ageing_set(port, attr->u.ageing_time);
>  		break;
>  	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
> +		/* L3 offload requires a VLAN aware bridge. */
> +		if (!attr->u.vlan_filtering)
> +			sparx5_rr_bridge_legs_flush(port->sparx5,
> +						    attr->orig_dev);

[Severity: Low]
This isn't a bug, but the comment above sparx5_rr_bridge_legs_flush() still
reads:

	/* Tear down the router legs of a bridge that is no longer offloaded. */

Here, and in the new SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL case, the
function is called for a bridge that is still offloaded, with hw_bridge_dev
and bridge_mask unchanged. Should that comment be updated?

[ ... ]

> @@ -448,6 +466,10 @@ static int sparx5_handle_port_vlan_add(struct net_device *dev,
>  		/* Flood broadcast to CPU */
>  		sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_BCAST),
>  				  dev->broadcast, v->vid);
> +		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
> +			sparx5_rr_bridge_vlan_clear(sparx5, dev, v->vid);
> +		else
> +			sparx5_rr_legs_reconcile_schedule(sparx5);
>  		return 0;
>  	}
>  

[ ... ]

> @@ -683,6 +705,7 @@ static int sparx5_handle_port_vlan_del(struct net_device *dev,
>  				     switchdev_blocking_nb);
>  
>  		sparx5_mact_forget(sparx5, dev->broadcast, vid);
> +		sparx5_rr_bridge_vlan_clear(sparx5, dev, vid);
>  		return 0;
>  	}

[Severity: High]
This is a pre-existing issue that this patch did not introduce, but the
patch extends the affected branches. The bridge-master paths of
sparx5_handle_port_vlan_add() and sparx5_handle_port_vlan_del() never check
dev == sparx5->hw_bridge_dev, or the netns. The switchdev blocking notifier
chain is global.

Can a software-only bridge in another namespace remove the broadcast entry
here? The bridge sends master VLAN add/del notifications for every bridge.
A user with CAP_NET_ADMIN only in its own user namespace can run:

  ip link add br0 type bridge
  bridge vlan add vid X dev br0 self
  bridge vlan del vid X dev br0 self

sparx5_mact_forget() then deletes the chip-wide (ff:ff:ff:ff:ff:ff, X)
entry that points at PGID_BCAST. PGID_BCAST is the only flood group that
sparx5_start() sets up with CPU copy enabled. After that, broadcasts on vid
X of the offloaded bridge no longer reach the CPU, so ARP fails for host
interfaces and for the router legs on that vid.

The new sparx5_rr_bridge_vlan_clear() and
sparx5_rr_legs_reconcile_schedule() calls are added to the same unfiltered
branches. Would an early check like this be appropriate?

	if (dev != sparx5->hw_bridge_dev)
		return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-sparx5_l3_routing-v3-0-e680ed79c7dc%40microchip.com
