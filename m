Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3D319617;
	Fri, 18 Sep 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696981; cv=none; b=EcJ0xx/gIsoN43YwodW7Bc1cJj6gl65d+AQXxUAFj+lQQhXQndmRoO13/ccf7lRDhhlkHHuqokcqEy0rDNuZCoVNabstHIa+Ezen7ZFzUkh1GPl9x9tc5R+0cAboBp1ilMxEjIQaeCoMCHvIJauLL31X3Fx2jfI3ujen4dNwI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696981; c=relaxed/simple;
	bh=YX2X5YmARDNrcOgHPk72LiQfqcj7uPNPCetVbYtrMhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfg0vDEPTNzbSvSMeAcvmAU/1a185y89DhQ3MVgiLSRd0SE6tkk/mKKt6/U1FCVxnNTR6wqs0c4iQqySmapktBtwnMb9RREZKDNYK03bDpf3lyi/FayxZbm9hVgkbTfcMNW5yB16x3tnd2hB8g6AH7biLjL7lAUAZ80yJCvd1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XgXnJM0T; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XgXnJM0T"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HMQ6QE4109281;
	Thu, 17 Sep 2026 19:02:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=geFosgHb6vlCyU6ufD7beIf9t
	Aqr7hsT77kxbv1WTFc=; b=XgXnJM0Tg3OVcrgztD7x7Mks4UDzHufJDkM0wgzys
	VYgXpeaL5E2ptxLNcdSQmD+XVS852AXS6O10s4zz8JdGHXDq8mFk3aY7GYjwQxcs
	uEY2asalU9DpXwdABIB5KQ26yaGKvc8N6iH5raU8bRLk9+xfMJI4RW2ayhZhbe85
	yAi3UukSCcprvhshU/livYrwYEgmQb/9fdHTXHZiBxhYHcIa+EgTpWo2ivEtBGhw
	9grQtgtSbP+1LfvU7uVtlnzTZHzBqouPNEKVctqcrQgU+sXsKq2zy8+VVEkQ3Xu9
	axnNvj9dAJHENEYJ8Fxc+Yu4OJNU6oo+sXPPnLI1T3iEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4grs0e8xe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:02:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 19:02:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 19:02:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D7E403F7055;
	Thu, 17 Sep 2026 19:02:40 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:32:34 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Kees Cook <kees@kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Kees Cook
	<kees+treewide@kernel.org>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-af: Allocate ikpu2 with ARRAY_SIZE()
Message-ID: <aqybujD1TdU2wziP@rkannoth-OptiPlex-7090>
References: <20260917211409.i.425-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917211409.i.425-kees@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDAyNCBTYWx0ZWRfX/FKQL/Jgrz+N
 WeVAmTl/djfr90bt6RQwXAmpRQTR5f3M/g+4Oa+wjyIMXNg+mRydy7LvBrejvM1NIgEQ4smyv7e
 j1oPmVLnjKyX+jckgye6SK1q20oMNn8=
X-Authority-Analysis: v=2.4 cv=U6YHnuru c=1 sm=1 tr=0 ts=6aac9bc6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=KZ3UCWYt-kdRGBrMIHIA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: G-dUJ-2k_KYLD_Hi8X3rP5zvBGSptr1W
X-Proofpoint-ORIG-GUID: G-dUJ-2k_KYLD_Hi8X3rP5zvBGSptr1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDAyNCBTYWx0ZWRfXwSb+USgHAyHC
 vVtWKNaHrKkA8nfFcDlorMYCyRtskE/kQfezXqfDk3xzRfKpgDVTDYkcVfHXhZuxFcF6bIW6jrK
 tW5Spi//Iwx3ePn8+ZukRazr58+OwffKLGCOAQ0w7OhopZXgt1hZQk7AX0ENBAZg7w84QE2U7LK
 fKs+MDldrzrrnb44a7Fv1POXEcPjLXbmMIxA0TQTSVj97Eh8zntUkN61k5RamzeHUKubTYtx3KD
 rArrAfS59RXt53eL8dPy6zmAx1LxyCBwegN/OFT1xb+B0IHTCtVeCRQIihOCyqtYc73O21F6+1+
 Suk8pfaEQtyDe5Tq1jon3gH+lE5S0BN2gdOjRkOwHJXSShwARX6A11jocpohm6UbltLJfGB3Ym1
 t1Z2LlYf6Vw/I2X+RkUEnBBaF5YTpcn32OE9UvTNxLT6rwfG6d6B1sO2Bmk0Zzqp/UsOmn9mMX9
 yr+PlWLJ9GxwEUpkl/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01

On 2026-09-18 at 02:44:10, Kees Cook (kees@kernel.org) wrote:
> From: Kees Cook <kees+treewide@kernel.org>
>
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
>
> This is allocating room for a copy of ikpu_action_entries, which is an
> array of struct npc_kpu_profile_action, but it asked for a single object
> the size of the whole array, which would make the allocation type a
> pointer to the array rather than the "struct npc_kpu_profile_action *"
> being assigned. Allocate ARRAY_SIZE-many entries instead. The resulting
> allocation size is the same.
>
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -1959,8 +1959,9 @@ static int npc_apply_custom_kpu_from_fs(struct rvu *rvu,
>  	fw = rvu->kpu_fwdata;
>
>  	/* Binary blob contains ikpu actions entries at start of data[0] */
> -	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
> -				      sizeof(ikpu_action_entries),
> +	profile->ikpu2 = devm_kcalloc(rvu->dev,
> +				      ARRAY_SIZE(ikpu_action_entries),
> +				      sizeof(*profile->ikpu2),
>  				      GFP_KERNEL);
Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
