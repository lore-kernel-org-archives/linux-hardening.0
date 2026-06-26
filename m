Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791343EA967;
	Fri, 26 Jun 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469013; cv=none; b=ZvU+6zy/qtTI+6Y8XM8qjDcaXv8bVPUvD5GZRTYHm6IJ9MMTnSC9qHdMvsWLWrdBsiLdK/54/Fg3m4trQdoiz0EcjJB4LOGYRqEuZDl7+a0+GTXAm/s18Yz0Gg7+aT+j7vzoHKO1TwGIfvcvWGYs2JVeFyaHhWITEHMFt8zx4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469013; c=relaxed/simple;
	bh=zNOQKVs7mFtzvW7ZL9QiUwGBwaYNwddOXYQ6SUFj9VE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7wRA51kY09p0F+Vh2nlbd56gbf8XVM2I0BA0nYJnWCYeYWPx0chMGZrRFbUp7iFmA7LpN0qXnXgbNXWdNnTeJyCGsXPfuf0DTcr9A5YCfK+HsdaeOGeS/+rBnwZjKEVWzb33ya/e5J24eZ45ABGgcON9GZy1aYFFUFq0qZpQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oGVUk05U; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oGVUk05U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782469012; x=1814005012;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zNOQKVs7mFtzvW7ZL9QiUwGBwaYNwddOXYQ6SUFj9VE=;
  b=oGVUk05U8tIeR6MK2vZaJY1QW6nEPQUYMklI8bC/4qRW7Dd07Z577PTG
   S5TN36DTeZ1JLBwWl/zA1ayZGMK4OOrjmE1aSmHsP0isZW2or8GQzInNP
   aISU/peC1pCTCTrnalD7E5uI17vJwpmrnYVfO+YH6jJzmL5Rm665XMyWN
   LtTL11VTh36pkY6ZqUBAXYYSrJGk2sp9Wb9Bp5501sflx4x75CAAAQqM2
   NyksdOsgOUVyREl8pduwGfY9v1JMFNzSFxgpCbO1K59e2ucgtn0RWaowZ
   ZUo5pq3zRa7mlRy+WmBr93yneeoerc+oF+Ba8bbHZFDagNueQFMVknIvd
   g==;
X-CSE-ConnectionGUID: 8bIlMgSjTJ2lCwvRkPA3WQ==
X-CSE-MsgGUID: 8LxoRXNIQeaKlQiHcqlfEw==
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="60080306"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2026 03:16:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 03:16:51 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 03:16:48 -0700
Message-ID: <ae037bec765ab2f660097edd61f02ec4d969098f.camel@microchip.com>
Subject: Re: [PATCH net-next 6/9] net: sparx5: vcap: add lpm vcap
 implementation
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Date: Fri, 26 Jun 2026 12:16:48 +0200
In-Reply-To: <20260615233849.1042290-1-kuba@kernel.org>
References: <20260612-sparx5_l3_routing-v1-6-fc3c10160f49@microchip.com>
	 <20260615233849.1042290-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 16:38 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: sparx5: vcap: add lpm vcap implementation
>=20
> Add the implementation for the LPM VCAP for lan969x and sparx5. The LPM
> VCAP has a static keyset configuration, and a single lookup dedicated to
> LPM, so this is straight forward, and many functions can use existing
> functionality.
>=20
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b=
/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > index 95b93e46a41dc..e25e759c24f60 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> > @@ -1083,6 +1146,46 @@ static void sparx5_vcap_es2_cache_write(struct s=
parx5 *sparx5,
> >       }
> >  }
> >=20
> > +static void sparx5_vcap_lpm_cache_write(struct sparx5 *sparx5,
> > +                                     struct vcap_admin *admin,
> > +                                     enum vcap_selection sel,
> > +                                     u32 start,
> > +                                     u32 count)
> > +{
> > +     u32 *keystr, *mskstr, *actstr;
> > +     int idx;
> > +
> > +     keystr =3D &admin->cache.keystream[start];
> > +     mskstr =3D &admin->cache.maskstream[start];
> > +     actstr =3D &admin->cache.actionstream[start];
> > +
> > +     switch (sel) {
> > +     case VCAP_SEL_ENTRY:
> > +             for (idx =3D 0; idx < count; ++idx) {
> > +                     /* Avoid 'match-off' by setting value & mask */
> > +                     spx5_wr(keystr[idx] & mskstr[idx], sparx5,
> > +                             VCAP_SUPER_VCAP_ENTRY_DAT(idx));
>=20
> [Severity: High]
> Are concurrent writes to the shared VCAP_SUPER_VCAP_ENTRY_DAT registers
> safe here without a global hardware lock across the different VCAP types?
>=20
> It looks like IS0 and IS2 rules are updated via vcap_add_rule() under the
> rtnl_lock(). However, the LPM rules are updated under the
> sparx5->router->lock inside a workqueue.
>=20
> Since both execution paths share the Super VCAP hardware block, could
> concurrent updates from TC (IS0/IS2) and routing (LPM) race on these shar=
ed
> cache registers, and also on VCAP_SUPER_CTRL in sparx5_vcap_super_update(=
),
> garbling the hardware command and corrupting the cache memory?
>=20

Very nice catch, I missed this. This is even reachable before this series
because the debugfs dump also uses these registers, and runs outside of
rtnl.

I will send a fix to net which replaces the per instance locks with a singl=
e
vcap_control global mutex.

> > +                     spx5_wr(~mskstr[idx], sparx5,
> > +                             VCAP_SUPER_VCAP_MASK_DAT(idx));
> > +             }
> > +             break;
>=20
> [ ... ]
>=20
> > @@ -1379,6 +1523,7 @@ static void sparx5_vcap_update(struct net_device =
*ndev,
> >       struct sparx5 *sparx5 =3D port->sparx5;
> >=20
> >       switch (admin->vtype) {
> > +     case VCAP_TYPE_LPM:
> >       case VCAP_TYPE_IS0:
> >       case VCAP_TYPE_IS2:
> >               sparx5_vcap_super_update(sparx5, cmd, sel, addr);

