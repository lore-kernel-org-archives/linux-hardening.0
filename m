Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65640DB4E;
	Tue, 25 Aug 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660366; cv=none; b=krN9gqVT4VABi9Vc5WipE6+s29nT+HnR04vtGQavy4FXQD0F0teliaWp77NI8mvvltdmCYw3Xu55J1KZZYEsUyuLzHUYPYjUQzYpnak18sjuTU2o7FLweQ7tKs58PHjI5U90UUK4+3r3aGI1e1rYLR4Bym1KCWPDE0MKRRmIkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660366; c=relaxed/simple;
	bh=FYsC8DgA1Qcwkk9W6T0ZLz8LdTRaGegCt9uOsbAu+X8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYLa3MT6ltTYWXHIDPQgi+mDCpK/j9cFERGyM23FsnzG+GqXSOas6J9WWvJ9rrMUNdjGtYSVReJWeWgwS/7Vi/hh7usFg1LTm368IwJDTocp5zIA5UsVZduDvXuzzp3owTgGela0/NWQWA1hLKKWAc8D5sWp2qqrs44KMPjC+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZkuFgPGM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZkuFgPGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787660365; x=1819196365;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FYsC8DgA1Qcwkk9W6T0ZLz8LdTRaGegCt9uOsbAu+X8=;
  b=ZkuFgPGMP9As1TCE8Tl3/qELCeTt3S5SvwlzLIqEmsPkO0Ka9R1O8Co6
   pkTs2opwH7tb3g+Qiwz3Y5+m36DsRtmpRweR8Nm1vafyhw6/JjoZnfwcH
   YRVAYf/uLZgJ+eZd+F2qRxJCN2UwYDOcgOCCfd9Ls0Y63phNPFh53MaQS
   HdPFBhmLAX9MgngcLX5usgenvy5bJryTSlS7qeAkaiZ2HH1USux4zOu56
   cJocJ85a91p+uTyj2ehtGbQcFlukkxauI5PlED2Ah77+2Z+KvXo3RPwZA
   fLYvbHq/xj71ABiQJNDfWE+oS7MGpEQzLjHNY16IAmjXABfOR0z4BPBcP
   g==;
X-CSE-ConnectionGUID: OcoNAIp0QwWYCGmy14uCdw==
X-CSE-MsgGUID: dCGvZRqeTJqqUvgshV0JHQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="294005104"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:19:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 25 Aug 2026 05:19:16 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 25 Aug 2026 05:19:13 -0700
Message-ID: <53617f6db747ad7eab76fedc806abd1968bfa7aa.camel@microchip.com>
Subject: Re: [PATCH net-next v2 6/9] net: sparx5: vcap: add lpm vcap
 implementation
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>
Date: Tue, 25 Aug 2026 14:19:12 +0200
In-Reply-To: <20260817211356.3633381-1-kuba@kernel.org>
References: <20260810-sparx5_l3_routing-v2-6-59e68cc8c8ca@microchip.com>
	 <20260817211356.3633381-1-kuba@kernel.org>
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
> net: sparx5: vcap: add lpm vcap implementation
>=20
> This adds a VCAP_TYPE_LPM instance to the sparx5 and lan969x VCAP instanc=
e
> tables and extends the per-vtype switches in sparx5_vcap_impl.c so the LP=
M
> VCAP reuses the Super VCAP cache, update and move helpers.  On sparx5 the
> IS0 CLM-0 instance drops from two Super VCAP blocks to one to make room.
>=20
> A few questions below.
>=20
> > diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap=
_impl.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> > index 543a1f2bf6bd9..6e6a1f833deac 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> > @@ -82,4 +82,16 @@ const struct sparx5_vcap_inst lan969x_vcap_inst_cfg[=
] =3D {
> >               .count =3D 1024,
> >               .ingress =3D false,
> >       },
> > +     {
> > +             .vtype =3D VCAP_TYPE_LPM,
> > +             .vinst =3D 0,
> > +             .map_id =3D 6,
> > +             .lookups =3D SPARX5_LPM_LOOKUPS,
> > +             .lookups_per_instance =3D SPARX5_LPM_LOOKUPS,
> > +             .first_cid =3D SPARX5_VCAP_CID_LPM_L0,
> > +             .last_cid =3D SPARX5_VCAP_CID_LPM_MAX,
> > +             .blockno =3D 5,
> > +             .blocks =3D 1,
> > +             .ingress =3D true,
> > +     },
> >  };
>=20
> [Severity: Low]
> Does the commit message match what happens on lan969x?  The message says:
>=20
>     "The LPM VCAP is allocated from the Super VCAP Blocks, which is share=
d
>      amongst different VCAPs. All blocks are used, so we steal a block fr=
om
>      IS0, which had 2 assigned."
>=20
> The lan969x hunk here is purely additive.  Before the patch
> lan969x_vcap_inst_cfg[] used blocks 0-4 (IS2-0 =3D 0, IS2-1 =3D 1, IS0-0 =
=3D 2,
> IS0-1 =3D 3, IS0-2 =3D 4), each with .blocks =3D 1, and this new entry ta=
kes
> block 5 without reducing anything.
>=20
> So nothing is stolen from IS0 on lan969x, and "all blocks are used" does
> not hold for that platform.  Could the message say where lan969x block 5
> comes from?
>=20
> Related to that: sparx5_vcap_block_alloc() derives the address range
> directly from blockno without ever consulting VCAP_SUPER_CORE_CNT:
>=20
>         admin->first_valid_addr =3D cfg->blockno * SUPER_VCAP_BLK_SIZE;
>         admin->last_used_addr =3D admin->first_valid_addr +
>                 cfg->blocks * SUPER_VCAP_BLK_SIZE;
>=20
> so for lan969x this maps addresses 15360..18431.  Is block 5 actually
> present in the lan969x Super VCAP?  I could not confirm the lan969x core
> count from the tree.

You are right on both counts, and the block accounting is correct even thou=
gh
the changelog describing it is not.

The two platforms differ in a way the message flattens into one story:

  platform   Super VCAP blocks   assigned before   LPM block   IS0 loses
  sparx5     10                  0-9, 2 per inst   9           yes
  lan969x    6                   0-4, 1 per inst   5           no

I will update the commit message to reflect the state of things on both spa=
rx5
and lan969x.

>=20
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b=
/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > index cf332de6bf736..20450462e2d80 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > @@ -54,8 +54,8 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] =
=3D {
> >               .lookups_per_instance =3D SPARX5_IS0_LOOKUPS / 3,
> >               .first_cid =3D SPARX5_VCAP_CID_IS0_L0,
> >               .last_cid =3D SPARX5_VCAP_CID_IS0_L2 - 1,
> > -             .blockno =3D 8, /* Maps block 8-9 */
> > -             .blocks =3D 2,
> > +             .blockno =3D 8, /* Maps block 8 */
> > +             .blocks =3D 1,
> >               .ingress =3D true,
> >       },
> >       {
>=20
> [Severity: Low]
> The message also says:
>=20
>     "Since we statically assign blocks, this means IS0 has half the
>      available address space for vcap rules, compared to before."
>=20
> Is "IS0" the right scope here?  Only the CLM-0 instance changes; CLM-1
> (blocks 6-7) and CLM-2 (blocks 4-5) keep two blocks each, so IS0 loses 1
> of 6 blocks in total.
>=20
> What actually halves is the address space of chains
> SPARX5_VCAP_CID_IS0_L0..SPARX5_VCAP_CID_IS0_L2 - 1 (1000000-1199999),
> which goes from 6144 to 3072 rule addresses.  Could the message be
> narrowed to that range?
>=20

Correct, "IS0" is too broad and the numbers you give are exact. Only the CL=
M-0
instance changes; CLM-1 keeps blocks 6-7 and CLM-2 keeps blocks 4-5, so IS0
goes from six blocks to five rather than losing half of anything.

The affected range is CLM-0's, first_cid SPARX5_VCAP_CID_IS0_L0 through
last_cid SPARX5_VCAP_CID_IS0_L2 - 1, so chains 1000000-1199999. With
SPARX5_IS0_LOOKUPS at 6 and lookups_per_instance at 6 / 3, that instance co=
vers
IS0 lookups 0 and 1, and its address space goes from 6144 to 3072.

I will fold this into the commit message as well.


> > @@ -124,6 +124,18 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg=
[] =3D {
> >               .count =3D 12288, /* Addresses according to datasheet */
> >               .ingress =3D false,
> >       },
> > +     {
> > +             .vtype =3D VCAP_TYPE_LPM,
> > +             .vinst =3D 0,
> > +             .map_id =3D 6,
> > +             .lookups =3D SPARX5_LPM_LOOKUPS,
> > +             .lookups_per_instance =3D SPARX5_LPM_LOOKUPS,
> > +             .first_cid =3D SPARX5_VCAP_CID_LPM_L0,
> > +             .last_cid =3D SPARX5_VCAP_CID_LPM_MAX,
> > +             .blockno =3D 9,
> > +             .blocks =3D 1,
> > +             .ingress =3D true,
> > +     },
> >  };
>=20
> [Severity: Medium]
> This registers chain ids VCAP_CID_PREROUTING_L0 (6000000) through
> SPARX5_VCAP_CID_LPM_MAX (6099999) as an ingress VCAP admin on both
> platforms, but the per-vtype switches in sparx5_tc_flower.c were not
> given a VCAP_TYPE_LPM arm.  Is that intentional?
>=20
> Before the patch, sparx5_tc_flower() rejected chain 6000000 because no
> admin matched:
>=20
>         admin =3D vcap_find_admin(vctrl, fco->common.chain_index);
>         if (!admin) {
>                 NL_SET_ERR_MSG_MOD(fco->common.extack, "Invalid chain");
>=20
> Now the same request resolves to the LPM admin and continues into
> sparx5_tc_flower_replace(), where sparx5_tc_add_rule_counter() falls
> into its default arm:
>=20
>         default:
>                 pr_err("%s:%d: vcap type: %d not supported\n",
>                        __func__, __LINE__, admin->vtype);
>                 break;
>=20
> That arm still returns 0, so does the rule end up being built without a
> counter id?  And for an "action pass" filter, sparx5_tc_set_actionset()
> hits its default arm and returns -EINVAL with a bare pr_err() and no
> extack.  sparx5_tc_action_trap() has no LPM arm either.
>=20
> So something like:
>=20
>         tc filter add dev eth0 ingress chain 6000000 protocol ip \
>             flower dst_ip 10.0.0.0/8 action pass
>=20
> now reaches those pr_err() calls from a netlink request, unratelimited,
> and reports an opaque -EINVAL.  Should the tc-flower path reject the LPM
> chain explicitly instead?  I checked at 010230ef1142 and VCAP_TYPE_LPM
> never appears in sparx5_tc_flower.c, so nothing later in the series adds
> these arms.
>=20

Not intentional, and yes, the tc-flower path should reject the LPM chain
explicitly. The LPM VCAP is meant to be system-only, owned by the router, a=
nd
not reachable from tc at all. v3 does that.

Rather than add VCAP_TYPE_LPM arms to those switches, v3 rejects the chain =
up
front, which also means the LPM range stays indistinguishable from a chain =
that
maps to no VCAP.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the new entry adds an
> eighth iteration to a loop that leaks on failure.  In
> sparx5_vcap_init(), sparx5->vcap_ctrl =3D ctrl is stored before the loop
> and an allocation failure just returns:
>=20
>         admin =3D sparx5_vcap_admin_alloc(sparx5, ctrl, cfg);
>         if (IS_ERR(admin)) {
>                 err =3D PTR_ERR(admin);
>                 pr_err("%s:%d: vcap allocation failed: %d\n", __func__, _=
_LINE__, err);
>                 return err;
>         }
>=20
> ctrl is not freed, mutex_destroy(&ctrl->lock) is not called, and the
> vcap_admin objects already put on ctrl->list (each with three
> STREAMSIZE cache buffers) are not unwound.
>=20
> The caller cannot clean up either, because cleanup_ports sits below the
> cleanup_vcap label in sparx5_main.c:
>=20
>         err =3D sparx5_vcap_init(sparx5);
>         if (err) {
>                 dev_err(sparx5->dev, "Failed to initialize VCAP\n");
>                 goto cleanup_ports;
>         }
>         ...
>         cleanup_vcap:
>                 sparx5_vcap_deinit(sparx5);
>         cleanup_ports:
>                 sparx5_destroy_netdevs(sparx5);
>=20
> so sparx5_vcap_deinit() never runs for this failure.  Should the failure
> path unwind the admins allocated so far, or should the goto target be
> cleanup_vcap?
>=20

Confirmed. The goto target should be cleanup_vcap. No extra unwind code is
needed, because sparx5_vcap_deinit() already does the right thing: it
NULL-guards ctrl, iterates ctrl->list with list_for_each_entry_safe so
a partial list is fine, frees all three cache buffers plus the admin via
sparx5_vcap_admin_free(), then destroys the mutex and frees ctrl. There is
no double-free risk either, since the admin that failed is already freed in=
side
sparx5_vcap_admin_alloc() before it returns ERR_PTR. And cleanup_vcap falls
through to cleanup_ports, so the netdevs are still destroyed.

I would rather not carry that in this series. It is a memory leak on a prob=
e
error path with nothing to do with L3 routing, it is pre-existing and belon=
gs
in the net tree.


> [ ... ]
>=20
> > @@ -195,6 +213,7 @@ static void _sparx5_vcap_range_init(struct sparx5 *=
sparx5,
> >       u32 size =3D count - 1;
> >=20
> >       switch (admin->vtype) {
> > +     case VCAP_TYPE_LPM:
> >       case VCAP_TYPE_IS0:
> >       case VCAP_TYPE_IS2:
> >               spx5_wr(VCAP_SUPER_CFG_MV_NUM_POS_SET(0) |
>=20
> [Severity: Medium]
> This is a pre-existing issue, but the new LPM block now inherits it.
> sparx5_vcap_block_init() calls this helper with one less than the number
> of addresses in the range:
>=20
>         _sparx5_vcap_range_init(sparx5, admin, admin->first_valid_addr,
>                                 admin->last_valid_addr -
>                                         admin->first_valid_addr);
>=20
> The range is inclusive, as set up in sparx5_vcap_block_alloc():
>=20
>         admin->first_valid_addr =3D cfg->blockno * SUPER_VCAP_BLK_SIZE;
>         admin->last_used_addr =3D admin->first_valid_addr +
>                 cfg->blocks * SUPER_VCAP_BLK_SIZE;
>         admin->last_valid_addr =3D admin->last_used_addr - 1;
>=20
> and here size =3D count - 1 is programmed into VCAP_SUPER_CFG_MV_SIZE, so
> the INITIALIZE shot clears MV_SIZE + 1 =3D=3D count addresses.
>=20
> That count is an address count is visible from the other user of the same
> callback in vcap_api.c:
>=20
>         vctrl->ops->init(ri->ndev, admin, ri->addr, ri->size);
>=20
> where ri->size of 1 erases exactly one address.
>=20
> Does this leave the address equal to admin->last_valid_addr uninitialized
> at probe, even though it is handed out as a usable rule address?  For the
> LPM instance that would be 30719 on sparx5 and 18431 on lan969x, i.e. a
> row of the longest-prefix-match table used by the router in the later
> "net: sparx5: add L3 FIB, nexthop and neighbour entry management" patch.
>=20
> Would passing admin->last_valid_addr - admin->first_valid_addr + 1 (or
> cfg->blocks * SUPER_VCAP_BLK_SIZE) be correct here?
>=20
> [ ... ]

Yes on all of it, and the +1 form is the one to use. The range is inclusive=
 so
its length is last_valid_addr - first_valid_addr + 1, the helper clears
MV_SIZE + 1 addresses as you say, and the result is that first_valid_addr
through last_valid_addr - 1 get cleared while last_valid_addr does not. 307=
19
on sparx5 and 18431 on lan969x are right.

Prefer last_valid_addr - first_valid_addr + 1 over
cfg->blocks * SUPER_VCAP_BLK_SIZE. The latter is only correct for the three
Super VCAP types and would be wrong for ES0 and ES2, which derive the range
from cfg->count, and sparx5_vcap_block_init() has no cfg argument anyway. N=
o
overflow risk from the +1 either: MV_SIZE is 16 bits and the widest instanc=
e is
two Super VCAP blocks, 6144 addresses.


The scope is wider than LPM or even sparx5. Every VCAP instance on both
platforms is affected, since the ES0 and ES2 arms reach the same helper thr=
ough
the same block_init. And lan966x_vcap_block_init() has the identical expres=
sion
feeding a __lan966x_vcap_range_init() that also does MV_SIZE_SET(count - 1)=
, so
lan966x has the same bug.


As with the sparx5_vcap_init() leak, I would rather not carry this in the
series. It is pre-existing, it affects lan966x as well as sparx5, and it wa=
nts
a fixes tag and the net tree.


