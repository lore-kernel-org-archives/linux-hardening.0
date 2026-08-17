Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B9471277;
	Mon, 17 Aug 2026 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001239; cv=none; b=LawJRW+2cEN4Jl6wgsBvjrbLM1Q5yoq04RbWrHwSG6jSDLy5KewF5BhLr3siTDNgeeYgMBmwYpmg5megcWu6Nt71xRcs5F/urBpbgEdgG7P/qK8K8iKka1t+dEPS8tZMq/A1GrbtDIspyt/W2gnZsXZCjPuZtWY/enCcIrnBbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001239; c=relaxed/simple;
	bh=wNbP9JYGeknuR3Aatcxc4heTNZbSCpT4sNfZY5+kKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuE91Mme+zNIQsHwPgjOpkCWeKkel6Z3cTLszm50Ba5kLYydcLW5V2rGXXNp3hGRpdywBDrbGK8ZNizxMHcJBqp+iJ57xpiBfRRu+Pa1Gf6/FEkcqx4tXCwW1sD9Q1mpIclqDSuQNmhfO14s6chNqThgzWxELdDxsl2rDLYO6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiAiTxn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiAiTxn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38051F000E9;
	Mon, 17 Aug 2026 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001237;
	bh=aRZFeV5QR5rLZxVBVxUNKNx9erPaKPc4qZpWpRNUFl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HiAiTxn23arJBmP8+7J8lqVwJTO4Ksmklgs77jNEjw8f2qcR5vZWlwTg3H+U8ZhoG
	 2TqSThKHL7a8agjktW6gXM3tlf5jQyKvU8PBYIQKYgdCd3BZWXNttCQ0Mcx9nkIuw8
	 6P4xO2wr/CvpEiagNhydZvTVziF0wTUioktYbdQua/O7RMeEtR0uRieRsI83ktMDak
	 Qrmnp9wk4fpRMKclEiX9seXccSxJ2LqpRU/s8oaIDv3JkTnTfh/fBf9GYpDkuxckKZ
	 wQsilg9/iiNpp1GiI5G39Hn8RpfXRm0B9cb6Z0a/Hz1wFewWWkW9l6FKcdtasT9YNx
	 ar1Xwdr6j9cTg==
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
Subject: Re: [PATCH net-next v2 6/9] net: sparx5: vcap: add lpm vcap implementation
Date: Mon, 17 Aug 2026 14:13:56 -0700
Message-ID: <20260817211356.3633381-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-6-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-6-59e68cc8c8ca@microchip.com>
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
net: sparx5: vcap: add lpm vcap implementation

This adds a VCAP_TYPE_LPM instance to the sparx5 and lan969x VCAP instance
tables and extends the per-vtype switches in sparx5_vcap_impl.c so the LPM
VCAP reuses the Super VCAP cache, update and move helpers.  On sparx5 the
IS0 CLM-0 instance drops from two Super VCAP blocks to one to make room.

A few questions below.

> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> index 543a1f2bf6bd9..6e6a1f833deac 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
> @@ -82,4 +82,16 @@ const struct sparx5_vcap_inst lan969x_vcap_inst_cfg[] = {
>  		.count = 1024,
>  		.ingress = false,
>  	},
> +	{
> +		.vtype = VCAP_TYPE_LPM,
> +		.vinst = 0,
> +		.map_id = 6,
> +		.lookups = SPARX5_LPM_LOOKUPS,
> +		.lookups_per_instance = SPARX5_LPM_LOOKUPS,
> +		.first_cid = SPARX5_VCAP_CID_LPM_L0,
> +		.last_cid = SPARX5_VCAP_CID_LPM_MAX,
> +		.blockno = 5,
> +		.blocks = 1,
> +		.ingress = true,
> +	},
>  };

[Severity: Low]
Does the commit message match what happens on lan969x?  The message says:

    "The LPM VCAP is allocated from the Super VCAP Blocks, which is shared
     amongst different VCAPs. All blocks are used, so we steal a block from
     IS0, which had 2 assigned."

The lan969x hunk here is purely additive.  Before the patch
lan969x_vcap_inst_cfg[] used blocks 0-4 (IS2-0 = 0, IS2-1 = 1, IS0-0 = 2,
IS0-1 = 3, IS0-2 = 4), each with .blocks = 1, and this new entry takes
block 5 without reducing anything.

So nothing is stolen from IS0 on lan969x, and "all blocks are used" does
not hold for that platform.  Could the message say where lan969x block 5
comes from?

Related to that: sparx5_vcap_block_alloc() derives the address range
directly from blockno without ever consulting VCAP_SUPER_CORE_CNT:

	admin->first_valid_addr = cfg->blockno * SUPER_VCAP_BLK_SIZE;
	admin->last_used_addr = admin->first_valid_addr +
		cfg->blocks * SUPER_VCAP_BLK_SIZE;

so for lan969x this maps addresses 15360..18431.  Is block 5 actually
present in the lan969x Super VCAP?  I could not confirm the lan969x core
count from the tree.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> index cf332de6bf736..20450462e2d80 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> @@ -54,8 +54,8 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] = {
>  		.lookups_per_instance = SPARX5_IS0_LOOKUPS / 3,
>  		.first_cid = SPARX5_VCAP_CID_IS0_L0,
>  		.last_cid = SPARX5_VCAP_CID_IS0_L2 - 1,
> -		.blockno = 8, /* Maps block 8-9 */
> -		.blocks = 2,
> +		.blockno = 8, /* Maps block 8 */
> +		.blocks = 1,
>  		.ingress = true,
>  	},
>  	{

[Severity: Low]
The message also says:

    "Since we statically assign blocks, this means IS0 has half the
     available address space for vcap rules, compared to before."

Is "IS0" the right scope here?  Only the CLM-0 instance changes; CLM-1
(blocks 6-7) and CLM-2 (blocks 4-5) keep two blocks each, so IS0 loses 1
of 6 blocks in total.

What actually halves is the address space of chains
SPARX5_VCAP_CID_IS0_L0..SPARX5_VCAP_CID_IS0_L2 - 1 (1000000-1199999),
which goes from 6144 to 3072 rule addresses.  Could the message be
narrowed to that range?

> @@ -124,6 +124,18 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] = {
>  		.count = 12288, /* Addresses according to datasheet */
>  		.ingress = false,
>  	},
> +	{
> +		.vtype = VCAP_TYPE_LPM,
> +		.vinst = 0,
> +		.map_id = 6,
> +		.lookups = SPARX5_LPM_LOOKUPS,
> +		.lookups_per_instance = SPARX5_LPM_LOOKUPS,
> +		.first_cid = SPARX5_VCAP_CID_LPM_L0,
> +		.last_cid = SPARX5_VCAP_CID_LPM_MAX,
> +		.blockno = 9,
> +		.blocks = 1,
> +		.ingress = true,
> +	},
>  };

[Severity: Medium]
This registers chain ids VCAP_CID_PREROUTING_L0 (6000000) through
SPARX5_VCAP_CID_LPM_MAX (6099999) as an ingress VCAP admin on both
platforms, but the per-vtype switches in sparx5_tc_flower.c were not
given a VCAP_TYPE_LPM arm.  Is that intentional?

Before the patch, sparx5_tc_flower() rejected chain 6000000 because no
admin matched:

	admin = vcap_find_admin(vctrl, fco->common.chain_index);
	if (!admin) {
		NL_SET_ERR_MSG_MOD(fco->common.extack, "Invalid chain");

Now the same request resolves to the LPM admin and continues into
sparx5_tc_flower_replace(), where sparx5_tc_add_rule_counter() falls
into its default arm:

	default:
		pr_err("%s:%d: vcap type: %d not supported\n",
		       __func__, __LINE__, admin->vtype);
		break;

That arm still returns 0, so does the rule end up being built without a
counter id?  And for an "action pass" filter, sparx5_tc_set_actionset()
hits its default arm and returns -EINVAL with a bare pr_err() and no
extack.  sparx5_tc_action_trap() has no LPM arm either.

So something like:

	tc filter add dev eth0 ingress chain 6000000 protocol ip \
	    flower dst_ip 10.0.0.0/8 action pass

now reaches those pr_err() calls from a netlink request, unratelimited,
and reports an opaque -EINVAL.  Should the tc-flower path reject the LPM
chain explicitly instead?  I checked at 010230ef1142 and VCAP_TYPE_LPM
never appears in sparx5_tc_flower.c, so nothing later in the series adds
these arms.

[Severity: Medium]
This isn't a bug introduced by this patch, but the new entry adds an
eighth iteration to a loop that leaks on failure.  In
sparx5_vcap_init(), sparx5->vcap_ctrl = ctrl is stored before the loop
and an allocation failure just returns:

	admin = sparx5_vcap_admin_alloc(sparx5, ctrl, cfg);
	if (IS_ERR(admin)) {
		err = PTR_ERR(admin);
		pr_err("%s:%d: vcap allocation failed: %d\n", __func__, __LINE__, err);
		return err;
	}

ctrl is not freed, mutex_destroy(&ctrl->lock) is not called, and the
vcap_admin objects already put on ctrl->list (each with three
STREAMSIZE cache buffers) are not unwound.

The caller cannot clean up either, because cleanup_ports sits below the
cleanup_vcap label in sparx5_main.c:

	err = sparx5_vcap_init(sparx5);
	if (err) {
		dev_err(sparx5->dev, "Failed to initialize VCAP\n");
		goto cleanup_ports;
	}
	...
	cleanup_vcap:
		sparx5_vcap_deinit(sparx5);
	cleanup_ports:
		sparx5_destroy_netdevs(sparx5);

so sparx5_vcap_deinit() never runs for this failure.  Should the failure
path unwind the admins allocated so far, or should the goto target be
cleanup_vcap?

[ ... ]

> @@ -195,6 +213,7 @@ static void _sparx5_vcap_range_init(struct sparx5 *sparx5,
>  	u32 size = count - 1;
>  
>  	switch (admin->vtype) {
> +	case VCAP_TYPE_LPM:
>  	case VCAP_TYPE_IS0:
>  	case VCAP_TYPE_IS2:
>  		spx5_wr(VCAP_SUPER_CFG_MV_NUM_POS_SET(0) |

[Severity: Medium]
This is a pre-existing issue, but the new LPM block now inherits it.
sparx5_vcap_block_init() calls this helper with one less than the number
of addresses in the range:

	_sparx5_vcap_range_init(sparx5, admin, admin->first_valid_addr,
				admin->last_valid_addr -
					admin->first_valid_addr);

The range is inclusive, as set up in sparx5_vcap_block_alloc():

	admin->first_valid_addr = cfg->blockno * SUPER_VCAP_BLK_SIZE;
	admin->last_used_addr = admin->first_valid_addr +
		cfg->blocks * SUPER_VCAP_BLK_SIZE;
	admin->last_valid_addr = admin->last_used_addr - 1;

and here size = count - 1 is programmed into VCAP_SUPER_CFG_MV_SIZE, so
the INITIALIZE shot clears MV_SIZE + 1 == count addresses.

That count is an address count is visible from the other user of the same
callback in vcap_api.c:

	vctrl->ops->init(ri->ndev, admin, ri->addr, ri->size);

where ri->size of 1 erases exactly one address.

Does this leave the address equal to admin->last_valid_addr uninitialized
at probe, even though it is handed out as a usable rule address?  For the
LPM instance that would be 30719 on sparx5 and 18431 on lan969x, i.e. a
row of the longest-prefix-match table used by the router in the later
"net: sparx5: add L3 FIB, nexthop and neighbour entry management" patch.

Would passing admin->last_valid_addr - admin->first_valid_addr + 1 (or
cfg->blocks * SUPER_VCAP_BLK_SIZE) be correct here?

[ ... ]
