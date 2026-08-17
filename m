Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA13BE630;
	Mon, 17 Aug 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001236; cv=none; b=bw/EhoTxE+tjOl8uBhZ23VjtRo+d3/OLSUtmKP0p5HKu+srWewoezos7zN8xMltHKLpZhvR0zsUlGQgxUaOttKZUsaR3GCazRiT+O/D3abJug0dM137wvQfu4VGbHGKLtA+4utFMVKttth3p2j7FhIFGbnC6dvTBY3hHmPDa4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001236; c=relaxed/simple;
	bh=ZVk0q7anLJAUeKK+c8yMmU/wyzgJjZbj7/b5ijjcYeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrEwT2Q6qKSS4OU1H3C93xAWZiixyAYRNNUwd6RPJVNrxfz0nn5gG8pPuWOzLXlLlQXs3WZ4SwLv32WSrC1O9F86Ocw7KRF7ziMS/ByK5/dqkQEWBcidkovtJJamRi9HTqC6cqC5tLy4wAnD6Xm/ZT7VDI4+F3K+Y88Jx1U9SYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZD7ZD5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZD7ZD5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1707A1F00A3A;
	Mon, 17 Aug 2026 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001234;
	bh=nnxWEUAZfDBtEp1r6V4GV/4y5UUjY6QTewuwXNl2bfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dZD7ZD5LCMf0q8gFz7SrIp5q9hD7tU/9D24lCiJAh4nhE5XMWJUuWEdiv27XKlQ1m
	 8lcCqSHrtyT+bFStuuppYTgfARfB01WsGEgIZeDGMGOSOFZReDTI1C0YZMakbYzpzP
	 AXumDoos4/wgUTWnuh4YHawHvbA/JVtYJ2RC4abklkkn76PdAVthIztdEFnos5vWYU
	 MPJHO7Wp9XL4DkfXj7eUeZoBuV4AHQim6TJ57QD1WpICigyjQzxWaQitlGYSOHvWjp
	 P+Pd+byzM6AtLqij2loD52xHE6qWR3MawwI2zVay4lfhls+Og39PBBtICPAm6jSW7S
	 bYOXDZsV1KROA==
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
Subject: Re: [PATCH net-next v2 3/9] net: microchip: vcap: make vcap actionset decoding type_id aware
Date: Mon, 17 Aug 2026 14:13:53 -0700
Message-ID: <20260817211353.3633288-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810-sparx5_l3_routing-v2-3-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-3-59e68cc8c8ca@microchip.com>
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
net: microchip: vcap: make vcap actionset decoding type_id aware

This adds a helper, vcap_find_stream_type_id(), that pulls the type_id
bits out of stream[0] just after the typegroup bits, and uses it in
vcap_verify_actionstream_actionset() to compare the decoded type_id
against info->type_id instead of always returning true.  The code change
itself looks fine; the comment below is only about the commit message.

> net: microchip: vcap: make vcap actionset decoding type_id aware
>
> When reading a rule back from hardware, decoding has to identify which
> actionset the rule was written as. The existing logic was only aware of
> the actionset subword length, which cannot distinguish actionsets that
> share a subword length but differ in their type_id field. The LPM VCAP
> added in a following patch introduces this case: ARP_PTR, L3MC_PTR and
> ARP_ENTRY all occupy one subword and differ only by type_id.

[Severity: Low]
Should the sentence "The LPM VCAP added in a following patch introduces
this case: ARP_PTR, L3MC_PTR and ARP_ENTRY all occupy one subword and
differ only by type_id" be reworded?

Two details don't seem to match the tree.  First, there is no L3MC_PTR
symbol anywhere at this commit; grepping for L3MC under
drivers/net/ethernet/microchip/ only matches the unrelated register name
GA_ANA_L3_VLAN_ARP_L3MC_STICKY.  The one-subword LPM actionsets that do
exist are just these two, in sparx5_vcap_ag_api.c:

static const struct vcap_set lpm_actionfield_set[] = {
	[VCAP_AFS_ARP_PTR] = {
		.type_id = 0,
		.sw_per_item = 1,
		.sw_cnt = 12,
	},
	[VCAP_AFS_ARP_ENTRY] = {
		.type_id = 2,
		.sw_per_item = 1,
		.sw_cnt = 12,
	},
};

Second, the colliding actionset metadata is not added in a following
patch; lpm_actionfield_set, lpm_actionfield_set_map and the
sparx5_vcaps[VCAP_TYPE_LPM] entry that references them are already
present at this commit, added by the preceding "net: microchip: vcap: add
lpm vcap to autogen vcap api".  Only the sparx5/lan969x LPM driver
enablement lands later.

Could the message say the LPM actionset model is added by the preceding
patch, and drop the L3MC_PTR reference?  The premise that two actionsets
share sw_per_item = 1 and differ only in type_id does hold, so the change
itself still looks justified.
