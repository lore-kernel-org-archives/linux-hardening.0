Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F83624D4;
	Mon, 15 Jun 2026 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566739; cv=none; b=AsmEDtbBySFoHFEn7KYI68ZAVOY9ztMYZ2Cff22kMHWNOtNxtJfXL31DWNMLPI8d79XVTCinhQy1oFaoOvs4yOJCR2Pk9/RBg8hS713Nk7nw7VxOfTiujN3U36CZPj8I1YsVzDXz7dNrYywUP/IWvMAJEWKZSSUliv/6Oos+gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566739; c=relaxed/simple;
	bh=No9E8V7DCrIYHvIU4Dn3myu+sGqU8J+1MsbdPiUOG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5XwiwD20UftWZWb78FtptZf7VPnhI44AJTy4WbC6ujTmrdBp0AKncjfjf13ukJDP/8DTiSUp3yuh02o8O3qtUsKyL1bh4yJ9OYiJb/6tzk1knGNucK5ntxNfrgzhiHX+7tcSdir1oiC1wtpFmssU43ojOpFXUpUKbnB7URLEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSLgP3u0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSLgP3u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B378A1F00A3A;
	Mon, 15 Jun 2026 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566737;
	bh=a8TejqfIZEXjHrTsJ/7Fvs/0Ztw1Ie0aEXTMD/PuGEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FSLgP3u0As7J28bw0zEtsu5W82TvwySmTMKe/QdElfDsbosAISEek6WrfbNcevFck
	 Lcn+nd8PZJO19DDcbGAWOBKph5bp7H6EGXzAA8rBNJnu0HD7p6foW72FVm1DY6VuFk
	 hdKB0hBtUgt8a86yehidT9FaG/eX497A+bRQYZEXddHCqYHfIHcwzGqP5KrbV5L5Qg
	 52lU1KIzTJi+qf68QEu3ar7hD0EJQPRCb6XibV2HLRUwQM+6M+ijpdn75+Q/s7pRRj
	 fYpx4fuPuRkxvWYtnlTR1iTwgqleE8AHPOZ49DwVPp+wFkzc51tonaspyGWCFl+VNU
	 bhgexD8mNhS0w==
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: sparx5: add neighbour event handling for L3 routing
Date: Mon, 15 Jun 2026 16:38:55 -0700
Message-ID: <20260615233855.1042401-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-9-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-9-fc3c10160f49@microchip.com>
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

Register a netevent notifier to handle NETEVENT_NEIGH_UPDATE events.
This completes the L3 unicast forwarding data path by updating hardware
ARP table entries and linked nexthops when neighbours are resolved.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c

[ ... ]

> @@ -2525,6 +2525,104 @@ static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
> +static void sparx5_rr_neigh_event_work(struct work_struct *work)
> +{

[ ... ]

> +	if (entry->connected && entry_connected &&
> +	    ether_addr_equal(entry->hwaddr, hwaddr))
> +		goto out_mutex;
> +
> +	ether_addr_copy(entry->hwaddr, hwaddr);
> +	sparx5_rr_neigh_entry_update(sparx5, entry, entry_connected);

[Severity: High]
Does this code risk re-offloading an orphaned neighbour entry with a stale
VMID?

When a subnet route is deleted, the fib_entry is destroyed. This unlinks the
neigh_entries, sets neigh_entry->fib_entry to NULL, and un-offloads them.
However, if another nexthop still references this neighbour,
sparx5_rr_neigh_entry_put() skips destruction.

The interface's router leg might then be destroyed, freeing its VMID for
reuse.

If an ARP update arrives later, this code finds the orphaned neigh_entry and
calls sparx5_rr_neigh_entry_update() to offload it again. This could apply a
hardware VCAP rule using the potentially reassigned VMID.

Also, because this sets vrule_id_valid to true, when the referencing nexthop
is eventually deleted, sparx5_rr_neigh_entry_put() will refuse to destroy it.
Since fib_entry is NULL, it won't be found during module unload, permanently
leaking the memory and the netdevice tracker reference.

> +	sparx5_rr_nexthops_update_notify(sparx5, entry, entry_connected);
> +	if (!entry_connected)
> +		sparx5_rr_neigh_entry_put(sparx5, entry);
> +
> +out_mutex:
> +	mutex_unlock(&sparx5->router->lock);
> +out:
> +	neigh_release(n);
> +	kfree(net_work);
> +}

[ ... ]

> +static int sparx5_rr_netevent_event(struct notifier_block *nb,
> +				    unsigned long event, void *ptr)
> +{

[ ... ]

> +	switch (event) {
> +	case NETEVENT_NEIGH_UPDATE:
> +		n = ptr;
> +
> +		if (n->tbl->family != AF_INET && n->tbl->family != AF_INET6)
> +			return NOTIFY_DONE;
> +
> +		port = sparx5_port_dev_lower_find(n->dev);
> +		if (!port)
> +			return NOTIFY_DONE;
> +
> +		net_work = kzalloc_obj(*net_work, GFP_ATOMIC);
> +		if (!net_work)
> +			return NOTIFY_BAD;

[Severity: High]
Could returning NOTIFY_BAD on allocation failure interrupt the global
notification chain?

The NETEVENT_NEIGH_UPDATE event is broadcast to all registered listeners via
the netevent_notif_chain atomic notifier chain. Returning NOTIFY_BAD from the
notifier callback prematurely aborts the chain traversal.

If this allocation fails, it appears this driver will silently prevent all
subsequent subsystems and drivers from receiving the neighbour update, which
might cause system-wide stale ARP/NDP caches.

Should this return NOTIFY_DONE instead?

> +
> +		INIT_WORK(&net_work->work, sparx5_rr_neigh_event_work);
> +		net_work->sparx5 = router->sparx5;
> +		net_work->neigh = neigh_clone(n);
