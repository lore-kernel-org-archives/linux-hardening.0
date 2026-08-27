Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD227603A;
	Thu, 27 Aug 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838489; cv=none; b=LJS74tkUsZe1h2qf/j1QPimzjuidsL6nXFpUnXFoiI42TkcG2S1nMdKZhxzfJQCf6ZpQJniMZOGQoJCmJmnnmIi720xl53OO/1UBTI0a1eWgE8O5mIOv+fdDVlRgHOBKeTRAlDoLTww1g9NNeHn2mVqEpfA15NbHecQEqtcuVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838489; c=relaxed/simple;
	bh=CRFg3EI1oCPtd8Vma/4rDZnZjlqkafjzj32aZbqpnco=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsqCEPqaNsHMxBGD0/97P8ipsDePLEooL7Wi7ZDJBh25i+jhfSPtAEuVJ4KBX5msh5gqKFWgCGN+GqWoy4JM09vx7kbevLG5jF/aiQBPiMnA8oaiqkSJZrS3Ce9zhKvTFo4JaJHFuJjL3pUvyxHEWV5EWp2pgA5epbwH6LA4V4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uAdgV5Sg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uAdgV5Sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787838490; x=1819374490;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CRFg3EI1oCPtd8Vma/4rDZnZjlqkafjzj32aZbqpnco=;
  b=uAdgV5SgJGqFSpTZv8nHh0N1bUJ+ioxLPE3bPHowBsAqHuXzpPMpUeqp
   r38nkTM5qtjRyScFYdi4ztAiyIygHcqaWCSNbs3v2A8nvhdZG+d6HLDOy
   2NeE3/B32VBzHvygIlIYmhJnz7WLLJ4e7X2tIq1jBGy+4M+Iv+mgVQ4Fe
   i4Qf3pXJXRVS4EblpujaFXKV8bpgpc60OUlLI/KUVjp0QON5sCC4Kf/6j
   CoFYVVk9MYaKqdzY0p1BL7n8RM1OMIEOUNjN//UCF2+29gIGtRrQFtFUG
   zysjqBLOHb1FCVAF9vYJX95xmQHNUPUxX8NPwZwL+YjD4OlmCigVc4gup
   Q==;
X-CSE-ConnectionGUID: aUIG+ODvTwOEVj7FVz0ESg==
X-CSE-MsgGUID: DE4g0wTrS7uiUwnFOOAabQ==
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="72575563"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 06:48:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 27 Aug 2026 06:48:05 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 27 Aug 2026 06:48:02 -0700
Message-ID: <86123c9a2e2c7cb8c8593613a6f374555f0ecafd.camel@microchip.com>
Subject: Re: [PATCH net-next v2 8/9] net: sparx5: add L3 FIB, nexthop and
 neighbour entry management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>
Date: Thu, 27 Aug 2026 15:48:01 +0200
In-Reply-To: <20260817211359.3633493-1-kuba@kernel.org>
References: <20260810-sparx5_l3_routing-v2-8-59e68cc8c8ca@microchip.com>
	 <20260817211359.3633493-1-kuba@kernel.org>
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
> net: sparx5: add L3 FIB, nexthop and neighbour entry management
>=20
> This adds the data path for L3 unicast route offload on sparx5: FIB entry
> lifecycle backed by LPM VCAP rules, nexthop group management using either
> inline VCAP actions or the hardware ARP table for ECMP, and neighbour
> entries anchored to router legs.  A few questions about the new code
> below.
>=20
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/dr=
ivers/net/ethernet/microchip/sparx5/sparx5_router.c
> > index d83cbb84c34e5..6d40d651180e6 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
>=20
> [ ... ]
>=20
> > @@ -422,43 +715,1041 @@ static struct sparx5_port *sparx5_port_dev_lowe=
r_find(struct net_device *dev)
> >       port =3D sparx5_port_dev_lower_find_rcu(dev);
> >       rcu_read_unlock();
> >=20
> > -     return port;
> > +     return port;
> > +}
>=20
> [ ... ]
>=20
> > +static int
> > +sparx5_rr_nexthop_group_info_init(struct sparx5 *sparx5,
> > +                               struct sparx5_rr_nexthop_group *nh_grp,
> > +                               struct sparx5_rr_fib_info *fi)
> > +{
> > +     unsigned int nhs =3D sparx5_rr_fib_info_nhs(fi);
> > +     struct sparx5_rr_nexthop_group_info *nhgi;
> > +     struct sparx5_rr_nexthop *nh;
> > +     int err, i;
> > +
> > +     nhgi =3D kzalloc_flex(*nhgi, nexthops, nhs);
> > +     if (!nhgi)
> > +             return -ENOMEM;
> > +
> > +     nh_grp->nhgi =3D nhgi;
> > +     nhgi->grp =3D nh_grp;
> > +     nhgi->atbl_offset_valid =3D false;
> > +     nhgi->atbl_offset =3D 0;
> > +     nhgi->count =3D nhs;
>=20
> [Severity: High]
> Is nhs bounded on the way in here?  nhgi->count is the u8 __counted_by
> field for the nexthops flex array, and the only size check in the series
> is in sparx5_rr_fib_info_should_offload():
>=20
>         if (nhs > SPARX5_MAX_ECMP_SIZE)
>                 return false;
>=20
> For the IPv6 append path that check only sees the delta carried by the
> event, never the merged total (see the comment on sparx5_rr_fib6_append()
> below), so repeated "ip -6 route append <prefix> nexthop via <gw>" grows
> fib_entry->fi.fe6_info.nrt6 without limit.
>=20
> At 256 accumulated nexthops nhgi->count wraps to 0 while the flex array
> was allocated for 256 entries.  Then sparx5_rr_fib_entry_hw_apply() does:
>=20
>                 if (!nhgi->nexthops->gateway) {
>=20
> which is a nexthops[0] access with __counted_by(count) =3D=3D 0, i.e. a t=
rap
> on CONFIG_UBSAN_BOUNDS builds, and the ARP programming loop
> "for (i =3D 0; i < nhgi->count; i++)" writes nothing at all.
>=20

This is correct. I will add the proper checks in the ipv6 case so we can
refuse configution which pushes the total size above the hardware limitatio=
n
of 16.

> > +
> > +     for (i =3D 0; i < nhgi->count; i++) {
> > +             struct fib_nh_common *fnhc;
> > +
> > +             nh =3D &nhgi->nexthops[i];
>=20
> [ ... ]
>=20
> > +static void sparx5_rr_arp_tbl_hw_addr_apply(struct sparx5 *sparx5,
> > +                                         unsigned char mac[ETH_ALEN],
> > +                                         u16 evmid, int offset)
> > +{
> > +     u32 mac_msb, mac_lsb;
> > +
> > +     sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
> > +
> > +     spx5_rmw(ANA_L3_ARP_CFG_0_MAC_MSB_SET(mac_msb) |
> > +              ANA_L3_ARP_CFG_0_ARP_VMID_SET(evmid) |
> > +              ANA_L3_ARP_CFG_0_ARP_ENA_SET(1),
> > +              ANA_L3_ARP_CFG_0_ARP_ENA |
> > +              ANA_L3_ARP_CFG_0_ARP_VMID |
> > +              ANA_L3_ARP_CFG_0_MAC_MSB,
> > +              sparx5, ANA_L3_ARP_CFG_0(offset));
> > +
> > +     spx5_wr(mac_lsb, sparx5, ANA_L3_ARP_CFG_1(offset));
> > +}
> > +
> > +static void sparx5_rr_arp_tbl_hw_addr_clear(struct sparx5 *sparx5, int=
 offset)
> > +{
> > +     spx5_rmw(ANA_L3_ARP_CFG_0_ARP_ENA_SET(0), ANA_L3_ARP_CFG_0_ARP_EN=
A,
> > +              sparx5, ANA_L3_ARP_CFG_0(offset));
> > +}
>=20
> [Severity: Medium]
> Should the two halves of the MAC be written in the other order here?
> ARP_CFG_0 carries ARP_ENA and MAC_MSB and is written first, while the low
> 32 bits only land in ARP_CFG_1 afterwards, so the entry is enabled with
> the new MSB combined with whatever LSB the slot still held.
>=20
> sparx5_rr_arp_tbl_hw_addr_clear() only clears ARP_ENA and never touches
> ARP_CFG_1, so that leftover LSB belongs to the previous owner of the slot=
.
>=20
> When sparx5_rr_nexthop_neigh_update() reprograms a member of a live ECMP
> group (reachable in this commit through
> sparx5_rr_router_leg_destroy() -> sparx5_rr_nexthop_neigh_update()), do
> frames hashing to that member get forwarded with a bogus DMAC of
> new MSB : stale LSB during the window?
>=20
> The same window also seems to defeat the "zero DMAC means trap" rule: wit=
h
> MAC_MSB zeroed and ARP_ENA still 1, a non-zero stale LSB is left in
> ARP_CFG_1, so the frame is forwarded instead of trapped.  Writing
> ARP_CFG_1 before the ARP_CFG_0 write that sets ARP_ENA would close both.
>=20
> [ ... ]
>=20

Also correct and both consequences follow. But i do not think swapping
the writes is quite enough. That would solve a disabled entry being enabled=
.
But a live entry with new MAC programmed, or live entry with a real MAC
being programmed to trap. But we can disable the entry during the update.
Disabled entries which are hit, get redirected to the CPU.

After both MAC registers have been programmed, we can enable the entry. Thi=
s
should solve all the cases.

> > +static void
> > +sparx5_rr_fib_entry_offload_mark(struct sparx5 *sparx5,
> > +                              struct sparx5_rr_fib_entry *fib_entry)
> > +{
> > +     bool offload, trap, offload_failed;
> > +
> > +     offload_failed =3D fib_entry->offload_fail;
> > +     offload =3D !fib_entry->offload_fail;
> > +     trap =3D !fib_entry->offload_fail && fib_entry->trap;
> > +
> > +     sparx5_rr_fib_info_offload_mark(sparx5, &fib_entry->fi, offload, =
trap,
> > +                                     offload_failed);
> > +}
>=20
> [Severity: Medium]
> Do the flags published here match what hardware actually does with the
> traffic?
>=20
> sparx5_rr_fib_entry_hw_apply() sets fib_entry->trap =3D false for
> SPARX5_RR_FIB_TYPE_UNICAST and then, both for directly connected subnets
> and for gateway nexthops with an unresolved neighbour MAC, installs an LP=
M
> ARP entry with eth_zero_addr(mac) - which the file header documents as
> "If the DMAC written to HW is all zero, the chip will trap the frame".
>=20
> So "ip route add 10.0.0.0/24 via 10.1.1.1 dev br0.10" reaches
> sparx5_rr_fib_entry_offload_mark() with offload_fail =3D=3D false and
> trap =3D=3D false, and fib_alias_hw_flags_set() publishes RTM_F_OFFLOAD w=
ith
> RTM_F_TRAP clear, while every packet is punted to the CPU.  Per the commi=
t
> message that is all gateway routes at this point in the series, since MAC
> resolution only arrives with the next patch.
>=20
> Going the other way, LOCAL/PROHIBIT/UNREACHABLE set trap =3D true while
> offload_fail stays false, so those routes are reported as offloaded and
> trapped at the same time.  mlxsw keeps the two mutually exclusive:
>=20
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:mlxsw_sp_fib4_entry=
_hw_flags_set() {
>         ...
>         fri.offload =3D should_offload;
>         fri.trap =3D !should_offload;
>         fri.offload_failed =3D false;
>         ...
> }
>=20
> The per-nexthop state that would answer this is already tracked in
> sparx5_rr_nexthop_egress_derive():
>=20
>         nh->trapped =3D !nh_neigh || is_zero_ether_addr(nh_neigh->hwaddr)=
;
>=20
> but it is never consulted by the flag computation.  Could nh->trapped fee=
d
> the reported trap flag?
>=20

No, they do not match, and yes it can. Both directions are as you describe:=
 a
gateway route with an unresolved neighbour is reported offloaded while ever=
y frame
is trapped, and LOCAL/PROHIBIT/UNREACHABLE are reported as offloaded and tr=
apped
simultaneously. nh->trapped is only ever read at one place today, as an
optimisation to skip a redundant hardware write:

        if (nh->trapped && !entry_connected)
                return;

so it never reaches the flags. I will fix the offload flags.


> [ ... ]
>=20
> > +static int
> > +sparx5_rr_fib_entry_update_arp_entry(struct sparx5 *sparx5,
> > +                                  struct sparx5_rr_fib_entry *fib_entr=
y,
> > +                                  unsigned char mac[ETH_ALEN], u16 evm=
id)
> > +{
> > +     struct net_device *pdev =3D sparx5->router->port_dev;
> > +     struct vcap_control *vctrl =3D sparx5->vcap_ctrl;
> > +     u32 vrule_id =3D fib_entry->hw_route.vrule_id;
> > +     struct vcap_rule *vrule;
> > +     u32 mac_msb, mac_lsb;
> > +     int err;
> > +
> > +     sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
> > +
> > +     vrule =3D vcap_get_rule(vctrl, vrule_id);
> > +     if (IS_ERR(vrule)) {
> > +             fib_entry->hw_route.vrule_id_valid =3D false;
> > +             return PTR_ERR(vrule);
> > +     }
>=20
> [Severity: Medium]
> Is it safe to clear vrule_id_valid on any vcap_get_rule() failure?  The
> lookup can fail on allocation while the rule is still programmed:
>=20
> drivers/net/ethernet/microchip/vcap/vcap_api.c:vcap_decode_rule() {
>         ...
>         ri =3D vcap_dup_rule(elem, elem->state =3D=3D VCAP_RS_DISABLED);
>         if (IS_ERR(ri))
>                 return ERR_CAST(ri);
>         ...
> }
>=20
> After that, sparx5_rr_fib_entry_destroy() skips vcap_del_rule() because
> vrule_id_valid is false, so does the LPM rule stay in the TCAM matching
> the prefix with a stale action?
>=20
> Related: this function reads fib_entry->hw_route.vrule_id without ever
> checking hw_route.vrule_id_valid, so a later update can
> vcap_get_rule()/vcap_mod_rule() an id that vcap_alloc_rule() has since
> handed to a different route's (or a neighbour host route's) rule.
>=20

This is correct, I will check vrule_id_valid, and stop clearing it on error=
.

> > +
> > +     switch (vrule->actionset) {
> > +     case VCAP_AFS_ARP_ENTRY:
>=20
> [ ... ]
>=20
> > +     case VCAP_AFS_ARP_PTR:
> > +             /* Convert arp_ptr to arp_entry */
> > +             err =3D sparx5_rr_lpm_arp_entry_create(sparx5,
> > +                                                  &fib_entry->key.addr=
,
> > +                                                  fib_entry->key.prefi=
x_len,
> > +                                                  mac, evmid,
> > +                                                  &fib_entry->hw_route=
);
> > +             if (err)
> > +                     goto free_rule;
> > +
> > +             sparx5_rr_nh_grp_arp_tbl_grp_clear(sparx5, fib_entry->nh_=
grp);
> > +             err =3D vcap_del_rule(vctrl, pdev, vrule_id);
> > +             goto free_rule;
>=20
> [Severity: Medium]
> Should the ARP_PTR rule be deleted before its ARP table entries are
> released?  sparx5_rr_nh_grp_arp_tbl_grp_clear() disables the entries and
> returns the offsets to router->arp_tbl_mask while the ARP_PTR rule is
> still installed, so hardware can keep matching it and dereferencing slots
> that are disabled or already handed to another route.  The replacement
> inline rule is already installed at this point, so deleting the old rule
> first looks safe.
>=20
> If vcap_del_rule() fails, does that inconsistency become permanent?
>=20

Yes to both. I will reorder these for v3.

> [ ... ]
>=20
> > +static int sparx5_rr_lpm_arp_ptr_create(struct sparx5 *sparx5,
> > +                                     struct sparx5_iaddr *addr,
> > +                                     u32 prefix_len, u32 arp_offset_ad=
dr,
> > +                                     u8 ecmp_size,
> > +                                     struct sparx5_rr_hw_route *hw_rou=
te)
> > +{
>=20
> [ ... ]
>=20
> > +     err |=3D vcap_rule_add_action_u32(rule, VCAP_AF_ECMP_CNT, ecmp_si=
ze - 1);
>=20
> [Severity: High]
> Is ecmp_size validated against the width of this action field anywhere?
> VCAP_AF_ECMP_CNT is four bits:
>=20
> drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c {
>         [VCAP_AF_ECMP_CNT] =3D {
>                 .type =3D VCAP_FIELD_U32,
>                 .offset =3D 14,
>                 .width =3D 4,
>         },
> }
>=20
> (same width in lan969x_vcap_ag_api.c, documented as W4 in vcap_ag_api.h),
> and neither vcap_rule_add_action() nor the encoder range checks the value=
.
>=20
> With 17 accumulated nexthops, ECMP_CNT =3D 16 & 0xF =3D 0 and hardware us=
es a
> single ARP entry for a 17 member group.  With the u8 count wrap described
> above, ecmp_size is 0 here, so ECMP_CNT gets (0 - 1) truncated to 0xF and
> hardware forwards using 16 ARP table slots that this group never
> initialised.
>=20

It was not validated anywhere, no. Both of the scenarios are prevented in v=
3 by
the nexthop group bounded added for your earlier comment, since ecmp_size i=
s now
confined to 1..16.

> [ ... ]
>=20
> > +static void sparx5_rr_fib_entry_destroy(struct sparx5 *sparx5,
> > +                                     struct sparx5_rr_fib_entry *fib_e=
ntry)
> > +{
> > +     struct net_device *pdev =3D sparx5->router->port_dev;
> > +     struct vcap_control *vctrl =3D sparx5->vcap_ctrl;
> > +
> > +     list_del(&fib_entry->fib_node);
> > +     sparx5_rr_fib_entry_remove(sparx5, fib_entry);
> > +     sparx5_rr_nexthop_group_put(sparx5, fib_entry->nh_grp);
> > +     if (fib_entry->hw_route.vrule_id_valid)
> > +             vcap_del_rule(vctrl, pdev, fib_entry->hw_route.vrule_id);
> > +     sparx5_rr_fib_info_put(&fib_entry->fi);
> > +     kfree(fib_entry);
> >  }
>=20
> [Severity: Medium]
> Same ordering question as the ARP_PTR conversion above:
> sparx5_rr_nexthop_group_put() disables the ARP entries and frees their
> offsets in arp_tbl_mask before vcap_del_rule() removes the LPM rule that
> still points at them.  Would deleting the VCAP rule first avoid the windo=
w
> where an installed ARP_PTR rule references reallocated slots?
>=20

Yes, same issue and same fix. sparx5_rr_nexthop_group_put() reaches
sparx5_rr_nh_grp_arp_tbl_grp_clear(), which both disables the entries and c=
alls
sparx5_rr_arp_tbl_grp_free() to release them in arp_tbl_mask, so the orderi=
ng
matters here exactly as it does in the conversion path.

> [Severity: Low]
> Should this path also clear the hardware status flags it published
> earlier?  There is no fib_alias_hw_flags_set()/fib6_info_hw_flags_set()
> call with offload=3Dfalse, trap=3Dfalse, offload_failed=3Dfalse, and
> sparx5_rr_router_deinit() unregisters the FIB notifier and then calls
> sparx5_rr_fib_flush().
>=20
> After a driver unbind or module unload, do the routes that still exist in
> init_net keep advertising RTM_F_OFFLOAD/RTM_F_TRAP in route dumps even
> though their VCAP rules are gone?  mlxsw has
> mlxsw_sp_fib4_entry_hw_flags_clear() and
> mlxsw_sp_fib6_entry_hw_flags_clear() for this.
>=20


They do, and this is fixed in v3 using the mlxsw helpers as reference.

> [ ... ]
>=20
> > @@ -660,6 +1982,443 @@ static bool sparx5_rr_dev_real_is_vlan_aware(str=
uct net_device *dev)
> > +static bool sparx5_rr_fib_info_should_offload(struct sparx5 *sparx5,
> > +                                           struct sparx5_rr_fib_info *=
fi)
> > +{
> > +     u32 tb_id =3D sparx5_rr_fib_info_tb_id(fi);
> > +     u8 type =3D sparx5_rr_fib_info_type(fi);
> > +     int nhs =3D sparx5_rr_fib_info_nhs(fi);
>=20
> [ ... ]
>=20
> > +     if (!(tb_id =3D=3D RT_TABLE_MAIN ||
> > +           tb_id =3D=3D RT_TABLE_LOCAL))
> > +             return false;
>=20
> [ ... ]
>=20
> > +     if (nhs > SPARX5_MAX_ECMP_SIZE)
> > +             return false;
>=20
> [ ... ]
>=20
> > +static void sparx5_rr_fib4_event_work(struct work_struct *work)
> > +{
> > +     struct sparx5_fib_event_work *fib_work =3D
> > +             container_of(work, struct sparx5_fib_event_work, work);
> > +     struct sparx5 *sparx5 =3D fib_work->sparx5;
> > +     int err;
> > +
> > +     mutex_lock(&sparx5->router->lock);
> > +
> > +     switch (fib_work->event) {
> > +     case FIB_EVENT_ENTRY_REPLACE:
> > +             err =3D sparx5_rr_fib_replace(sparx5, &fib_work->fi);
> > +             if (err)
> > +                     dev_warn(sparx5->dev, "FIB replace failed, ip=3D%=
pI4l\n",
> > +                              &fib_work->fi.fen4_info.dst);
>=20
> [Severity: Low]
> Should this be %pI4h rather than %pI4l?  fen4_info.dst is the host order
> fib_trie key - this patch converts it explicitly elsewhere:
>=20
>         key->addr.ipv4 =3D cpu_to_be32(dst);
>=20
> and
>=20
>         fri.dst =3D cpu_to_be32(fen4_info->dst);
>=20
> lib/vsprintf.c's ip4_string() treats 'l' as unconditionally little endian
> and 'h' as host order, so %pI4l prints the dotted quad reversed on big
> endian builds.
>=20

Correct on both counts, fixed for v3.

> [ ... ]
>=20
> > +static int sparx5_rr_fib6_append(struct sparx5 *sparx5,
> > +                              struct sparx5_rr_fib_info *fi)
> > +{
> > +     struct sparx5_rr_fib_entry *fib_entry;
> > +     struct sparx5_rr_fib_key key;
> > +     int err =3D 0;
> > +
> > +     if (sparx5_rr_fib_info_should_ignore(fi))
> > +             return 0;
> > +
> > +     sparx5_rr_fib_info_to_fib_key(fi, &key);
> > +
> > +     fib_entry =3D sparx5_rr_fib_entry_lookup(sparx5, &key);
> > +     if (!fib_entry)
> > +             return 0;
> > +
> > +     /* Are we adding new nexthops which can not be offloaded */
> > +     if (!sparx5_rr_fib_info_should_offload(sparx5, fi)) {
> > +             err =3D -EINVAL;
> > +             goto out_fib_mark_offload;
> > +     }
> > +
> > +     /* Append new rt_arr data to fen6_info rt data */
> > +     err =3D sparx5_rr_fib_entry_fib_info_add(fib_entry, fi);
>=20
> [Severity: High]
> Can the merged nexthop count exceed SPARX5_MAX_ECMP_SIZE here?
> sparx5_rr_fib_info_should_offload() is called on the event's fi, whose
> nrt6 is nsiblings + 1 - that is 1 for a plain
> "ip -6 route append <prefix> nexthop via <gw>" - so the
>=20
>         if (nhs > SPARX5_MAX_ECMP_SIZE)
>                 return false;
>=20
> guard always passes, and sparx5_rr_fib_entry_fib6_info_add() then grows
> f6i->nrt6 to old + new with no limit.
>=20
> Would checking sparx5_rr_fib_info_nhs(&fib_entry->fi) + nhs against
> SPARX5_MAX_ECMP_SIZE before the append be the right place to bound this?
>=20

Yes it can, and this is the same defect as your counted_by comment on
sparx5_rr_nexthop_group_info_init() and your ECMP_CNT comment on
sparx5_rr_lpm_arp_ptr_create(). It is bounded in v3.


> [ ... ]
>=20
> > +/* Handle fib events, which manage fib_entries. Called in atomic conte=
xt, with
> > + * rcu_read_lock().
> > + */
> > +static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned lon=
g event,
> > +                            void *ptr)
> > +{
>=20
> [ ... ]
>=20
> > +     if (event !=3D FIB_EVENT_ENTRY_REPLACE &&
> > +         event !=3D FIB_EVENT_ENTRY_DEL &&
> > +         event !=3D FIB_EVENT_ENTRY_APPEND)
> > +             return NOTIFY_DONE;
>=20
> [Severity: Medium]
> Are FIB rule events intentionally left out?  With this filter,
> FIB_EVENT_RULE_ADD never reaches the driver, and there is no l3mdev/VRF
> check when a leg is admitted:
>=20
>         return netif_is_bridge_master(vlan_rdev) &&
>                br_vlan_enabled(vlan_rdev) &&
>                sparx5_port_dev_lower_find(vlan_rdev);
>=20
> Meanwhile L3 unicast forwarding is enabled unconditionally per leg
> (sparx5_rr_leg_hw_init() sets RLEG_IP4_UC_ENA/RLEG_IP6_UC_ENA, and
> sparx5_rr_router_init() sets ANA_L3_ROUTING_CFG_L3_ENA_MODE plus
> ANA_L3_L3_UC_ENA =3D ~0) while only RT_TABLE_MAIN/RT_TABLE_LOCAL routes a=
re
> programmed into the single LPM VCAP.
>=20
> So after "ip rule add ... lookup <table>", or with a leg enslaved to a
> VRF, does the kernel use the policy/VRF table while hardware keeps
> forwarding from the main table LPM?  mlxsw watches FIB rule events to
> abort offload in exactly this situation.  If this is a known limitation,
> could the commit message mention it?
>=20

I think this is right. VRF is intentionally not implemented here, but
more works needs to be done to properly refuse the configurations. A leg
will not be admitted on an l3mdev slave, and moving an already offloaded le=
g
into an l3mdev is refused, since NETDEV_PRECHANGEUPPER can be vetoed on the=
 linking
path.

This is a similar strategy as with vlan_filtering transitions. Refuse a tra=
nsition
that would break a live offload, and simply do not offload a configuration =
that was
already in that state.


> [ ... ]
>=20
> > @@ -2813,10 +2813,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5=
)
> >                ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
> >                ANA_ACL_VCAP_S2_MISC_CTRL);
> >=20
> > +     r->fib_nb.notifier_call =3D sparx5_rr_fib_event;
> > +     err =3D register_fib_notifier(&init_net, &r->fib_nb, NULL, NULL);
> > +     if (err)
> > +             goto err_workqueue_destroy;
>=20
> [Severity: Medium]
> Is a dump-abort callback needed as the third argument here?  The initial
> dump is delivered before the block joins the chain, and then:
>=20
> net/core/fib_notifier.c:fib_dump_is_consistent() {
>         ...
>         atomic_notifier_chain_unregister(&fn_net->fib_chain, nb);
>         if (cb)
>                 cb(nb);
>         return false;
>         ...
> }
>=20
> With cb =3D=3D NULL, nothing discards the state built from an aborted pas=
s:
> entries created by sparx5_rr_fib4_event_work()/sparx5_rr_fib6_event_work(=
)
> stay in router->fib_ht/fib_list with live LPM VCAP rules and held
> fib_info/fib6_info references.
>=20
> If a route is deleted during the dump window, it can never get a
> FIB_EVENT_ENTRY_DEL (the block was off the chain then, and the retried
> dump no longer lists it), so does hardware keep forwarding or blackholing
> that prefix until sparx5_rr_router_deinit()?
>=20
> mlxsw passes mlxsw_sp_router_fib_dump_flush and netdevsim passes
> nsim_fib_dump_inconsistent here.  Note that a callback would have to drai=
n
> the ordered workqueue first: sparx5_rr_fib_flush() takes no router->lock,
> which is only safe today because it runs after destroy_workqueue().
>=20
> >       r->inetaddr_nb.notifier_call =3D sparx5_rr_inetaddr_event;
> >       err =3D register_inetaddr_notifier(&r->inetaddr_nb);
> >       if (err)
> > -             goto err_workqueue_destroy;
> > +             goto err_unreg_fib_notifier;
>=20

Yes, I think this is needed. I will add a fib dump flush.

> [ ... ]

