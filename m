Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD323E6DFA;
	Mon, 17 Aug 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001235; cv=none; b=btPfO6Cwdwm9/n96mVtZSTSUAZfVyVSCioLLkJTsMEWjU1n++/x+hd9dXtvi3QUqjmYP2zqFKEVuzUE3pSPCGeXZjjwHgLnnJluptVIjqn4wy15Xm8IX1V4PQrURRwFHqegD6jCViL5LAQAzXt/SG6isGyhDY81VRaZ464CTM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001235; c=relaxed/simple;
	bh=HM3JZz/ovoLSTmVvoRShs/gGplzok9apybVRqt3HyaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8abHU6ZPOds2DFJROfata5TEsr1Kkf/ROyWUITgFUdqrzSKqbnUYg6ylxhOnZ/awX4eZd+Dz8BlhlDg83LcMCNorbk2padthWxiJbXPlsmNTpfnm8WC2n1jYgLNC8dhKXwffj/QfbnKPot2YA+L3wd3lD9WFjYdxI5HzvSKKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olxO1rMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olxO1rMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84991F000E9;
	Mon, 17 Aug 2026 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001233;
	bh=mm3hvT4aeyyCxbTRBeO5ywVBxWxJNoMgGy+q5pgZHTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olxO1rMmeg5p8l8iTU8CMNGQJmbsHAYG1h/8MUgHSJPV7Q7h67VFgyqMBLULrmOQe
	 SoWUzwhwUcpN+RwM/WwmX18Vol1zhao8FcfVpGNUFJtexRjovQXzwG68fSJm1JQGoa
	 3PxRWtdryDJJREXPP8ZOhNGRspz6qpai5IgoCT+y9e/9IwpgNLIUWfQT02bL5AYUln
	 cST5apKEmqFnfNQVXU9RFdUzSeRxMzzmAHfDNXrZq8hPYFkEmY8Cu+5FUEpRR1f0RR
	 N0pkhkOmsPLywQMKH6vYuK4JFReaHbp106dk2eShSiR2aQDnf5kCt/2r0H+iHhk2T0
	 ahNwmEY267PpQ==
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
Subject: Re: [PATCH net-next v2 1/9] net: microchip: vcap: fix rule move for rules of coprime size
Date: Mon, 17 Aug 2026 14:13:33 -0700
Message-ID: <20260817211333.3633182-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-1-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-1-59e68cc8c8ca@microchip.com>
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
net: microchip: vcap: fix rule move for rules of coprime size

This reworks the VCAP rule move logic so that insert and delete compute a
single uniform address offset, aligned to the LCM of the rule sizes in the
moved block, instead of per-rule "optimal" offsets. The goal is to keep the
software rule addresses in sync with what the hardware move command does,
which becomes necessary once rules of coprime sizes (2 and 3) appear with
the LPM VCAP.

One question about the delete algorithm description in the changelog.

> On delete:
>
> 1. Initialize HW memory at the deleted rule's addresses before
>    moving, since the moved block may not fully cover them due to
>    padding.
> 2. Reclaim any padding between rules in the block.

[Severity: Low]
Is step 2 accurate for the new implementation?  As far as I can tell the
padding that sits between rules inside the moved block is preserved, not
reclaimed, because a single offset is applied to every rule in the block:

drivers/net/ethernet/microchip/vcap/vcap_api.c:vcap_move_rules_sw() {
	list_for_each_entry_continue(pos, &admin->rules, list)
		pos->addr -= move->offset;
}

Since every rule in the block is shifted by the same move->offset, the gaps
between rules within the block are structurally invariant across the move.

What appears to be reclaimed is the deleted rule's own space plus the
padding adjacent to its position, and only down to block_lcm granularity.
In the delete path unaligned_offset is always negative (block_first->addr +
block_first->size <= ri->addr <= base_addr), so the truncating branch is
taken in vcap_move_from_block():

drivers/net/ethernet/microchip/vcap/vcap_api.c:vcap_move_from_block() {
	unaligned_offset = (block_first->addr + block_first->size) - base_addr;
	if (unaligned_offset > 0)
		move->offset =
			((unaligned_offset + (block_lcm - 1)) / block_lcm) *
			block_lcm;
	else
		move->offset = (unaligned_offset / block_lcm) * block_lcm;
}

Integer division truncating toward zero leaves up to block_lcm - 1 addresses
of the gap unreclaimed at the boundary.

Could the changelog wording be adjusted to describe what is actually
reclaimed, for example the deleted rule's addresses plus adjacent padding,
rounded down to the block LCM?

> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index 788c0728d7636..75c2ca54fddd2 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c

[ ... ]

> @@ -2106,12 +2108,63 @@ static u32 vcap_set_rule_id(struct vcap_rule_internal *ri)
>  	return ri->data.id;
>  }
>  
> +static void vcap_move_from_block(u32 base_addr,
> +				 struct vcap_rule_internal *block_first,
> +				 struct vcap_rule_internal *block_last,
> +				 int block_lcm, struct vcap_rule_move *move)
> +{
> +	int unaligned_offset;
> +
> +	if (!block_first || !block_last)
> +		return;
> +
> +	move->addr = block_last->addr;
> +	move->count = block_first->addr + block_first->size - block_last->addr;
> +	/* Integer division rounds toward zero. We want to round toward +inf
> +	 * for the positive case (insertion) to ensure enough room.
> +	 */
> +	unaligned_offset = (block_first->addr + block_first->size) - base_addr;
> +	if (unaligned_offset > 0)
> +		move->offset =
> +			((unaligned_offset + (block_lcm - 1)) / block_lcm) *
> +			block_lcm;
> +	else
> +		move->offset = (unaligned_offset / block_lcm) * block_lcm;
> +}
> +
> +static void vcap_move_rules_sw(struct vcap_admin *admin,
> +			       struct vcap_rule_internal *pos,
> +			       struct vcap_rule_move const *move)
> +{
> +	if (move->count == 0 || move->offset == 0)
> +		return;
> +
> +	list_for_each_entry_continue(pos, &admin->rules, list)
> +		pos->addr -= move->offset;
> +}

[ ... ]
-- 
pw-bot: cr
