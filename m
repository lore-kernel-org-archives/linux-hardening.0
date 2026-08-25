Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0439479B;
	Tue, 25 Aug 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654158; cv=none; b=QOb/I0fYTtWyHMvyUHbvxRz05Uf+Wzgoqk3WcV+c3mop4lsU8Kr/rQ7bRzB+zcyT5DoLLUE5w6/fxKI0Y/NDBdyLo3Jq/XURiUkDPHoYxPU7KGLvmwxHCHuTeh+dQioGOv9s21+gDH8C82DaEnPdEC+8yKVAWnpy4uHpAL6p7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654158; c=relaxed/simple;
	bh=zM+UWTmbccd041ge3CNoM7JhSXgFO5eDHpVidNkX8WA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyXImChtGLVJkWDSDWyFzrxyQQI8+2SHGn/9p2E4cYFw3m1H/API45Cx3P9Ap2R1Oq2NUULTjRGI5nXe3oI2/0s70+FOcEgNuB+F5smRR0EfFN+Iih0dsw/05muV4n61uAxY11e/EgsZPDscZEmZR10xOV/rk2SmHUG1+eZT00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PjM/Y4St; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PjM/Y4St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787654156; x=1819190156;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zM+UWTmbccd041ge3CNoM7JhSXgFO5eDHpVidNkX8WA=;
  b=PjM/Y4St1PflDdcyjWmzOHzSI92vHMxqIGMAUpni5GONOLLDFQtABNrL
   6hlB302vQoJe/kRHlgOWn84Nx2pW8LWvffKFEzEq6jgnngjmuFr8SF0in
   RwPJEGF1sB88YDmvO6bNUjSHdHhwb5vm4JZck87/DHTAX/8O+Kt7drH3p
   5rMerqlEQTeyhA5Hu6VpXT3mfzGfl8GLsdAnFP4DqtRqfgpVfr+U4dJ/F
   ONEHSzVu0KUErQZCl5co3kRgQtrywlC+tAJK/uOqOAnuvaGrRZPYvUEfa
   Wpa07jR27qri5Ambtz2b5kAkc8AoiyGLJsU/xxPRrEH9EvaftO0151nND
   Q==;
X-CSE-ConnectionGUID: rxAGNm6IQ8eohggFuPa45A==
X-CSE-MsgGUID: pF6qGJetT+OCwW7ep9hU+Q==
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="62615109"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:35:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 25 Aug 2026 03:35:49 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 25 Aug 2026 03:35:46 -0700
Message-ID: <daecc0252ffc5502391be729c11c3a663fe5030a.camel@microchip.com>
Subject: Re: [PATCH net-next v2 3/9] net: microchip: vcap: make vcap
 actionset decoding type_id aware
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>
Date: Tue, 25 Aug 2026 12:35:46 +0200
In-Reply-To: <20260817211353.3633288-1-kuba@kernel.org>
References: <20260810-sparx5_l3_routing-v2-3-59e68cc8c8ca@microchip.com>
	 <20260817211353.3633288-1-kuba@kernel.org>
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
> net: microchip: vcap: make vcap actionset decoding type_id aware
>=20
> This adds a helper, vcap_find_stream_type_id(), that pulls the type_id
> bits out of stream[0] just after the typegroup bits, and uses it in
> vcap_verify_actionstream_actionset() to compare the decoded type_id
> against info->type_id instead of always returning true.  The code change
> itself looks fine; the comment below is only about the commit message.
>=20
> > net: microchip: vcap: make vcap actionset decoding type_id aware
> >=20
> > When reading a rule back from hardware, decoding has to identify which
> > actionset the rule was written as. The existing logic was only aware of
> > the actionset subword length, which cannot distinguish actionsets that
> > share a subword length but differ in their type_id field. The LPM VCAP
> > added in a following patch introduces this case: ARP_PTR, L3MC_PTR and
> > ARP_ENTRY all occupy one subword and differ only by type_id.
>=20
> [Severity: Low]
> Should the sentence "The LPM VCAP added in a following patch introduces
> this case: ARP_PTR, L3MC_PTR and ARP_ENTRY all occupy one subword and
> differ only by type_id" be reworded?
>=20
> Two details don't seem to match the tree.  First, there is no L3MC_PTR
> symbol anywhere at this commit; grepping for L3MC under
> drivers/net/ethernet/microchip/ only matches the unrelated register name
> GA_ANA_L3_VLAN_ARP_L3MC_STICKY.  The one-subword LPM actionsets that do
> exist are just these two, in sparx5_vcap_ag_api.c:
>=20
> static const struct vcap_set lpm_actionfield_set[] =3D {
>         [VCAP_AFS_ARP_PTR] =3D {
>                 .type_id =3D 0,
>                 .sw_per_item =3D 1,
>                 .sw_cnt =3D 12,
>         },
>         [VCAP_AFS_ARP_ENTRY] =3D {
>                 .type_id =3D 2,
>                 .sw_per_item =3D 1,
>                 .sw_cnt =3D 12,
>         },
> };
>=20
> Second, the colliding actionset metadata is not added in a following
> patch; lpm_actionfield_set, lpm_actionfield_set_map and the
> sparx5_vcaps[VCAP_TYPE_LPM] entry that references them are already
> present at this commit, added by the preceding "net: microchip: vcap: add
> lpm vcap to autogen vcap api".  Only the sparx5/lan969x LPM driver
> enablement lands later.
>=20
> Could the message say the LPM actionset model is added by the preceding
> patch, and drop the L3MC_PTR reference?  The premise that two actionsets
> share sw_per_item =3D 1 and differ only in type_id does hold, so the chan=
ge
> itself still looks justified.

Yes I will update the message, and remove the stale remarks.
