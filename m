Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5527425CF0;
	Wed, 26 Aug 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753135; cv=none; b=iVFD8BARwThcQs1RoOUTocYQe1p45aYORT/Ak0JetEkWktq0ZaKyE+skkAU01hIFdQUXhAymJaJNoH3cufAkxg8NfE/K94t30bHt4cckAlfyO/TvLA4UJCcLIJheK4U7hudbMfBldB3jHqDWFSvDQ0y8xh76TxC1M4txAaPejZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753135; c=relaxed/simple;
	bh=VvsitQo2K8SK19zb8OeAt0olRGzo1sZc+IAWuzCG9Ow=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/aVOWdXMpQs5cGpK1wznekJq59MtgpmcXrchbhfV4IVqXm7Mod+QpUBSn38+m+1VxHJ12JTx1o/7MLF/L+vOK2BWBRD7ydprjA7SIj6GLjvmZfAap5O8CSNM/+ALCDwk5yk5Gi/vPTCE7jI00g/jhnW9v3ucKqGwr8GwKfMaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vuDp+cZn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vuDp+cZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787753137; x=1819289137;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VvsitQo2K8SK19zb8OeAt0olRGzo1sZc+IAWuzCG9Ow=;
  b=vuDp+cZnZxXBuoi2ZQ7OVs6Nrfu1CAoWOdDjZD+KCtxXHE278f3forLB
   SKD1V4/OJPDitrLRoLi2prnH35WVjqOeyTYJ22d6X4F0NGrIBON9xC4cL
   cJ3QiztmwNaKDoXRPN1h4OHEsdSPPkFb6y2HC1DXg86svbxZpOwYAHatU
   8jQ3rx0iB8a/nKD1cCfiheKbwN6oi407kosBSe2ryBiEmFYjuqyVQTQ/l
   dqdHqsa83O4klhLPtS6dSpZE+WvtCNokhEC1a5QFB59JAUi4AdHmH+/iA
   IppaGPPmXUogshH5vyPfr+ZNoOnOX6zTPUhWo00vehDDI/k0majXTRjV5
   w==;
X-CSE-ConnectionGUID: Mtw0Sd6mQlSus1E+hzJr8g==
X-CSE-MsgGUID: Pp21ujkvSw29+C5WejzQFA==
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="294066659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2026 07:04:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 26 Aug 2026 07:04:23 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 26 Aug 2026 07:04:20 -0700
Message-ID: <a6742dddeb23b014fd6d2e00e4c5e8c7fd3dd444.camel@microchip.com>
Subject: Re: [PATCH net-next v2 7/9] net: sparx5: add L3 router
 infrastructure and leg management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>
Date: Wed, 26 Aug 2026 16:04:20 +0200
In-Reply-To: <20260817211357.3633460-1-kuba@kernel.org>
References: <20260810-sparx5_l3_routing-v2-7-59e68cc8c8ca@microchip.com>
	 <20260817211357.3633460-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-17 at 14:13 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: sparx5: add L3 router infrastructure and leg management
>=20
> This adds the sparx5 L3 router skeleton: notifiers for netdevice and
> IPv4/IPv6 address events, the basic routing object types, and lifecycle
> management for router legs (VMIDs) including a reserved blackhole leg.
>=20
> A few questions about the leg lifecycle and the global router leg MAC
> below.
>=20
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/dr=
ivers/net/ethernet/microchip/sparx5/sparx5_router.c
> > new file mode 100644
> > index 0000000000000..d83cbb84c34e5
> > --- /dev/null
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> > @@ -0,0 +1,1105 @@
>=20
> [ ... ]
>=20
> > +static int sparx5_lower_dev_walk(struct net_device *lower_dev,
> > +                              struct netdev_nested_priv *priv)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (sparx5_netdevice_check(lower_dev)) {
> > +             priv->data =3D (void *)netdev_priv(lower_dev);
> > +             ret =3D 1;
> > +     }
> > +
> > +     return ret;
> > +}
>=20
> [Severity: Medium]
> Should this walk also check which switch instance owns the port it
> finds?  sparx5_netdevice_check() in sparx5_netdev.c only compares the
> shared ops pointer:
>=20
>         return dev && (dev->netdev_ops =3D=3D &sparx5_port_netdev_ops);
>=20
> Every probed instance registers its own callbacks on the global
> inetaddr/inet6addr/netdevice chains, so on a board with two instances
> chip A's notifier sees a bridge whose only sparx5 lowers belong to chip
> B.  Can that make sparx5_rr_dev_real_is_vlan_aware() return true on chip
> A and let sparx5_rr_router_leg_create() allocate a VMID and enable an
> RLEG on a chip that serves none of those ports?
>=20
> The NETDEV_CHANGEADDR arm of sparx5_rr_netdevice_event() uses the same
> helper, so it would also reprogram chip A's chip-global router leg base
> MAC from an unrelated bridge's dev_addr.
>=20
> struct sparx5_port already carries the sparx5 back-pointer, and
> sparx5_port_bridge_join() performs exactly this per-instance comparison.
>=20

Yes, it should, and I have fixed it. For v3 I thread the instance through t=
he
walk and compare the back-pointer.

Your later comments about legs being keyed by net_device while their hardwa=
re
state is indexed by vid led to sparx5_rr_dev_real_is_vlan_aware() keying on
sparx5->hw_bridge_dev and the NETDEV_CHANGEADDR arm keying on whether that
bridge has legs. Both are inherently per-instance, so the code should handl=
e
the multi instance case properly.

> [ ... ]
>=20
> > +static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
> > +                               struct sparx5_rr_router_leg *leg)
> > +{
> > +     /* Associate Router leg VMID to VLAN */
> > +     spx5_rmw(ANA_L3_VMID_CFG_VMID_SET(leg->vmid), ANA_L3_VMID_CFG_VMI=
D,
> > +              sparx5, ANA_L3_VMID_CFG(leg->vid));
> > +
> > +     /* Enable Router leg for VLAN */
> > +     spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(1),
> > +              ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
> > +              ANA_L3_VLAN_CFG(leg->vid));
> > +
> > +     /* Configure router leg */
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(1) |
> > +              ANA_L3_RLEG_CTRL_RLEG_EVID_SET(leg->vid) |
> > +              ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(1),
> > +              ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
> > +              ANA_L3_RLEG_CTRL_RLEG_EVID |
> > +              ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, sparx5,
> > +              ANA_L3_RLEG_CTRL(leg->vmid));
> > +#else
>=20
> [Severity: Low]
> Is the CONFIG_IPV6 gating here consistent with the other IPv6 paths?
> This is the only place that compiles out RLEG_IP6_UC_ENA, while
> sparx5_rr_router_leg_create() unconditionally calls
> sparx5_rr_lpm_link_local_create() (which installs an fe80::/64 rule with
> VCAP_KF_IP6_XIP and LPM_PROTO() ETH_P_IPV6), sparx5_rr_router_init()
> unconditionally registers the inet6addr and inet6addr validator
> notifiers, and sparx5_rr_leg_hw_deinit() unconditionally clears the same
> IP6 enable bit.
>=20
> With CONFIG_IPV6=3Dn, does that leave an LPM entry that can never match
> occupying VCAP space, since no leg has IPv6 unicast lookup enabled?
> Either dropping the #if or gating all IPv6 paths the same way would
> avoid the mismatch.
>=20

It is not consistent, and yes it does. I am taking your first option and
dropping the #if.


> [ ... ]
>=20
> > +static struct sparx5_rr_router_leg *
> > +sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *=
dev,
> > +                         u16 vid)
> > +{
> > +     struct sparx5_rr_router_leg *leg;
> > +
> > +     leg =3D sparx5_rr_leg_alloc(sparx5, dev, vid);
> > +     if (!leg)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /* Prevent net device from being freed while we have added it to =
a
> > +      * router leg.
> > +      */
> > +     netdev_hold(dev, &leg->dev_tracker, GFP_KERNEL);
> > +
> > +     /* While a router leg exists, add route to trap link-local traffi=
c. */
> > +     if (atomic_inc_return(&sparx5->router->legs_count) =3D=3D 1) {
> > +             if (sparx5_rr_lpm_link_local_create(sparx5))
> > +                     dev_warn(sparx5->dev,
> > +                              "Failed to create link-local route\n");
> > +     }
>=20
> [Severity: Medium]
> legs_count is already incremented when the rule install is attempted, so
> if sparx5_rr_lpm_link_local_create() fails the counter stays non-zero
> and no later leg creation retries the install.
>=20
> sparx5_rr_lpm_arp_entry_create() can fail with -ENOMEM from
> vcap_alloc_rule() or -ENOSPC from vcap_val_add_rule() when the LPM VCAP
> is full, and in that case link_local.vrule_id_valid stays false.
>=20
> Does the router then run for its whole lifetime without the IPv6
> link-local trap that the file header describes ("All IPv6 link-local
> traffic is explicitly trapped"), recovering only if every normal leg is
> destroyed and a first leg is created again?  Should the error fail leg
> creation, or at least be retried on the next leg creation?
>=20

Correct on all of it, I will retry on next leg creation and return
the error here.

> > +
> > +     list_add(&leg->leg_list_node, &sparx5->router->leg_list);
> > +     sparx5_rr_leg_hw_init(sparx5, leg);
>=20
> [Severity: Medium]
> This arms the leg in hardware (ANA_L3_VLAN_CFG(vid).VLAN_RLEG_ENA and
> ANA_L3_RLEG_CTRL(vmid) IP UC enables) without anything guaranteeing that
> the chip-global router leg base MAC and RLEG_MAC_TYPE_SEL have been
> programmed.
>=20
> sparx5_rr_leg_base_mac_set() is reachable from exactly one place, the
> NETDEV_CHANGEADDR arm of sparx5_rr_netdevice_event().  If the bridge is
> created with an explicit MAC, br_stp_recalculate_bridge_id() in
> net/bridge/br_stp_if.c bails out during br_add_if():
>=20
>         /* user has chosen a value so keep it */
>         if (br->dev->addr_assign_type =3D=3D NET_ADDR_SET)
>                 return false;
>=20
> so no qualifying NETDEV_CHANGEADDR is ever emitted, e.g. for:
>=20
>         ip link add br0 type bridge address aa:bb:cc:dd:ee:ff
>         ip link set eth0 master br0
>         ip link add link br0 name br0.10 type vlan id 10
>         ip addr add 10.0.0.1/24 dev br0.10
>=20
> Would the leg then be enabled with the power-on ANA_L3/REW/EACL
> RLEG_CFG values and MAC_TYPE_SEL !=3D SPARX5_RLEG_USE_GLOBAL_BASE_MAC?
> The commit message states:
>=20
>   "There is a global router leg base MAC used for MAC rewrites by the
>    chip. Here we use the bridge MAC."
>=20
> Could the base MAC be derived from vlan_dev_real_dev(dev) at leg
> creation time so that the claim holds regardless of how the bridge MAC
> was assigned?
>=20

Yes, this is also right. For v3 the base  MAC is programmed from the VLANs
real device at leg creation, just before the leg is armed. The previous
checks have then ensured that the real device is a VLAN-aware bridge master
with a port of this instance below it. The driver only supports one bridge
as sparx5_port_bridge_join() rejects a second with -ENODEV.


> [ ... ]
>=20
> > +static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
> > +{
> > +     struct net_device *vlan_rdev;
> > +     /* Support l3 offloading for:
> > +      *      1) upper vlan interfaces for the bridge.
> > +      */
> > +     if (is_vlan_dev(dev)) {
> > +             if (netif_is_bridge_port(dev))
> > +                     return false;
> > +
> > +             vlan_rdev =3D vlan_dev_real_dev(dev);
> > +             if (sparx5_netdevice_check(vlan_rdev))
> > +                     return false;
> > +
> > +             return netif_is_bridge_master(vlan_rdev) &&
> > +                    br_vlan_enabled(vlan_rdev) &&
> > +                    sparx5_port_dev_lower_find(vlan_rdev);
> > +     }
> > +
> > +     return false;
> > +}
>=20
> [ ... ]
>=20
> > +static int __sparx5_rr_inetaddr_event(struct sparx5 *sparx5,
> > +                                   struct net_device *dev,
> > +                                   unsigned long event)
> > +{
> > +     struct sparx5_rr_router_leg *leg;
> > +     u16 vid;
> > +
> > +     if (!sparx5_rr_dev_real_is_vlan_aware(dev))
> > +             return 0;
>=20
> [Severity: Medium]
> This mutable current-state predicate gates both leg creation and leg
> teardown, since it is evaluated before the switch on event.  Every
> sub-condition of sparx5_rr_dev_real_is_vlan_aware() can change at
> runtime, and there is no NETDEV_CHANGEUPPER or bridge vlan_filtering
> hook to re-evaluate it.
>=20
>         ip link set eth0 master br0            # vlan_filtering 1
>         ip link add link br0 name br0.10 type vlan id 10
>         ip addr add 10.0.0.1/24 dev br0.10     # leg created
>         ip link set br0 type bridge vlan_filtering 0
>         ip addr del 10.0.0.1/24 dev br0.10     # NETDEV_DOWN
>=20
> Does the last step return early here, so sparx5_rr_router_leg_destroy()
> and therefore sparx5_rr_leg_hw_deinit() never run?  That would leave the
> VMID allocated, the netdev reference held, legs_count elevated, and
> ANA_L3_VLAN_CFG(vid).VLAN_RLEG_ENA plus the RLEG IP UC enables set for a
> VLAN the kernel no longer treats as an L3 interface.  Repeating the
> toggle would consume one VMID per round out of the 127 (lan969x) or 511
> (sparx5) entry pool, with only the NETDEV_UNREGISTER backstop left to
> clean up.
>=20
> The same early return also means a valid configuration is never
> offloaded if the address is added before the bridge becomes VLAN aware
> or before a sparx5 port is enslaved.
>=20

Confirmed. In v3 the teardown will only depend on whether a leg exists,
which is the drivers own state and cannot be changed underneath it.

Rather than tracking vlan_filtering transitions, I will refuse a 1 -> 0
transition while legs are offloaded. br_vlan_filter_toggle() honours the
error and rolls its own state back.

The transition in the other direction will just not lead to offloading,
and the fib/neighbour objects will say so. Honouring fully dynamic
vlan_filtering transitions would require a lot of complicated logic to
always build up state in the driver, and then be able to apply/revert all
of it in hardware as the vlan_filtering changes.

Instead, simply expecting the bridge to be created with the desired
vlan_filtering up front saves a lot of complication.

It looks like there is prior art here, with mlxsw refusing the transition
unconditionally for any bridge it has offloaded:

drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:mlxsw_sp_port_attr=
_br_vlan_set() {
        if (bridge_device->vlan_enabled =3D=3D vlan_enabled)
                return 0;

        netdev_err(bridge_device->dev, "VLAN filtering can't be changed for=
 existing bridge\n");
        return -EINVAL;
}


> > +
> > +     /* Our basic case: ip addr/subnet added to vlan upper of
> > +      * bridge dev.
> > +      */
> > +     switch (event) {
> > +     case NETDEV_UP:
> > +             leg =3D sparx5_rr_leg_find_by_dev(sparx5, dev);
> > +             if (leg)
> > +                     return 0;
> > +
> > +             /* HW allows at most 1 leg per VLAN, but we do not need t=
o
> > +              * lookup leg by vid, since the kernel does not allow mul=
tiple
> > +              * vlan devs with the same vid on top of a given device.
> > +              */
> > +             vid =3D vlan_dev_vlan_id(dev);
> > +
> > +             leg =3D sparx5_rr_router_leg_create(sparx5, dev, vid);
>=20
> [Severity: Medium]
> The uniqueness argument in this comment holds per real device, but legs
> are looked up by net_device while the hardware state they program is
> indexed by VLAN id:
>=20
>         ANA_L3_VMID_CFG(leg->vid)
>         ANA_L3_VLAN_CFG(leg->vid)
>=20
> Two different bridge masters can each carry a vid 10 upper.
> sparx5_rr_dev_real_is_vlan_aware() accepts any vlan_filtering bridge
> master that has a sparx5 port among its transitive lower devices, since
> sparx5_port_dev_lower_find_rcu() uses netdev_walk_all_lower_dev_rcu(),
> and sparx5_port_bridge_join()'s single-bridge -ENODEV veto only fires
> for directly enslaved sparx5 port netdevs:
>=20
>         ip link add link eth0 name eth0.5 type vlan id 5
>         ip link set eth0.5 master br1          # br1 now qualifies
>         ip addr add 10.0.0.1/24 dev br0.10
>         ip addr add 10.1.0.1/24 dev br1.10
>=20
> Can the second sparx5_rr_leg_hw_init() then overwrite the first leg's
> ANA_L3_VMID_CFG(10) mapping, leaving its RLEG_CTRL/REW_RLEG_CTRL
> programming orphaned?  And when either leg is destroyed,
> sparx5_rr_leg_hw_deinit() clears ANA_L3_VLAN_CFG(10).VLAN_RLEG_ENA,
> which would disable routing for the surviving leg.
>=20

Yes, this is a good catch. As far as I can tell, this configuration
is accepted, but not supported. br1 cannot work as a bridge on this
driver:
sparx5_set_rx_mode() only syncs the explicit multicast list for standalone =
ports
and ignores IFF_PROMISC and IFF_ALLMULTI entirely, so when br1 sets promisc=
uous
mode on eth0.5 and 8021q propagates that to eth0, nothing happens. A standa=
lone
port only delivers frames matching MAC table entries, so br1 never sees fra=
mes
for addresses it has not been told about. The VLAN demux itself is fine, si=
nce
vlan_do_receive() runs before rx_handler dispatch, but delivery to the CPU =
never
happens in the first place.

So this was never meant to be an accepted configuration. It is only accepte=
d
because the veto in sparx5_port_bridge_join() cannot see it.

Rather than add a vid uniqueness check, I am fixing the predicate, because =
the
weak test is the actual defect. Asking whether a sparx5 port exists somewhe=
re
below the bridge is true for a software bridge that merely has a vlan upper=
 of a
switch port enslaved, and such a bridge is not offloaded at all, so it must=
 never
host a leg.

I will also make sure legs are teared down when the last switch port leaves=
 the
bridge.

> [ ... ]
>=20
> > +/* Called with RTNL. */
> > +static int sparx5_rr_netdevice_event(struct notifier_block *nb,
> > +                                  unsigned long event, void *ptr)
> > +{
>=20
> [ ... ]
>=20
> > +     switch (event) {
> > +     case NETDEV_CHANGEADDR:
> > +             /* Allow single bridge. Global router leg MAC tracks brid=
ge mac. */
> > +             if (netif_is_bridge_master(dev) && sparx5_port_dev_lower_=
find(dev)) {
> > +                     ether_addr_copy(mac, dev->dev_addr);
> > +                     sparx5_rr_leg_base_mac_set(sparx5, mac);
> > +             }
> > +             break;
>=20
> [Severity: Medium]
> The comment states the single-bridge assumption, but is it enforced
> anywhere?  This arm accepts any bridge master that has a sparx5 lower
> and overwrites the single global ANA_L3/REW/EACL router leg base MAC,
> and __sparx5_rr_inetaddr_event() creates legs for VLAN uppers of any
> qualifying bridge.
>=20
> sparx5_port_bridge_join() returns -ENODEV only when a sparx5 port netdev
> is directly enslaved into a second bridge, while
> sparx5_port_dev_lower_find() walks lower devices recursively, so a
> second bridge containing an intermediate device stacked on a sparx5 port
> passes without ever reaching that check:
>=20
>         ip link add link eth0 name eth0.5 type vlan id 5
>         ip link set eth0.5 master br1
>=20
> With legs offloaded for two bridges, the global base MAC becomes
> whichever bridge most recently emitted NETDEV_CHANGEADDR.  Should the
> restriction be rejected or at least reported, or documented in the
> commit message?
>=20
> There is also a stale case in the other direction: when the last sparx5
> port leaves the bridge, sparx5_port_dev_lower_find() returns NULL, so a
> later bridge MAC change is ignored and the programmed base MAC keeps
> pointing at a MAC the bridge no longer has.
>=20


No, it was not enforced anywhere, and your second paragraph is the same roo=
t
cause as your previous comment: the recursive lower walk answers a weaker
question than the one that matters. Both arms now key on the bridge instead=
, so
the single-bridge restriction is enforced rather than assumed.


And I will make sure legs are cleaned up when the last switch port leaves t=
he
bridge.

Having legs on the bridge is exactly the condition under which the base MAC
is used for rewrites, so it is both the precise test and the one that
survives the bridge losing its ports.

> > +     case NETDEV_UNREGISTER:
> > +             mutex_lock(&router->lock);
> > +             leg =3D sparx5_rr_leg_find_by_dev(sparx5, dev);
> > +             if (leg)
> > +                     sparx5_rr_router_leg_destroy(leg);
> > +             mutex_unlock(&router->lock);
> > +             break;
> > +     }
>=20
> [ ... ]
>=20
> > +     /* Enable L3 UC routing on all ports. */
> > +     spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA);
> > +     if (is_sparx5(sparx5)) {
> > +             spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA1);
> > +             spx5_wr(~0, sparx5, ANA_L3_L3_UC_ENA2);
> > +     }
> > +
> > +     /* Enable routing and global router options */
> > +     spx5_rmw(ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(1) |
>=20
> [ ... ]
>=20
> > +void sparx5_rr_router_deinit(struct sparx5 *sparx5)
> > +{
> > +     struct sparx5_router *router =3D sparx5->router;
> > +
> > +     unregister_inet6addr_notifier(&router->inet6addr_nb);
> > +     unregister_inet6addr_validator_notifier(&router->inet6addr_valid_=
nb);
> > +     unregister_netdevice_notifier(&router->netdevice_nb);
> > +     unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb=
);
> > +     unregister_inetaddr_notifier(&router->inetaddr_nb);
> > +     destroy_workqueue(router->sparx5_router_owq);
> > +     sparx5_rr_router_legs_flush(sparx5);
> > +     mutex_destroy(&router->lock);
> > +     kfree(router);
> > +}
>=20
> [Severity: Low]
> The chip-global routing state turned on by sparx5_rr_router_init()
> (ANA_L3_L3_UC_ENA/ENA1/ENA2, ANA_L3_ROUTING_CFG.L3_ENA_MODE and the
> redirect enables, ANA_ACL_VCAP_S2_MISC_CTRL.ACL_RT_SEL, plus
> RLEG_MAC_TYPE_SEL from sparx5_rr_leg_base_mac_set()) has no counterpart
> here or in the probe error unwind.  Should there be a matching disable
> sequence?
>=20
> Related: sparx5_rr_leg_hw_init() programs ANA_L3_VMID_CFG(leg->vid) and
> REW_RLEG_CTRL(leg->vmid).RLEG_EVID, but sparx5_rr_leg_hw_deinit() clears
> neither, so after the flush the VLAN table still points at VMIDs handed
> back to the allocator.  sparx5_init_switchcore() skips sparx5_init_ram()
> when HSCH_RESET_CFG.CORE_ENA is already set, so an unbind/re-bind cycle
> starts with those stale VLAN to VMID mappings while vmid_mask is empty
> again.

Both correct, I will add both disable paths in v3.
