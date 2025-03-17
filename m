Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99A23C390;
	Mon, 17 Mar 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217759; cv=none; b=qj4F1rnWA1+zU2Pro6GTi2YviGkXshOkmCinsafMAqios0SYLxHC1Gdvmdr27ZosCEaUH6yMtkGfDpn/d8HIveZMmcT8voJxSwp9FXtVCZKYxhKnZ1/+r77axkIwKGOSuheLJPTMIA3oE0CBuRPt2tDAhMVAuWNvS/k0jlATDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217759; c=relaxed/simple;
	bh=CUqDm3QsuqdlfxMedch8RwSc+CB9pdZ/X3Y755ohyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6dRB4yv4MPwQRCoCzKFTzP/SCKnlnHRz0dughByuIPPvMBAmaxwda8sN5l41UoE07nySOMWepFk8iR+hrJZZv/kxMgU2oeV7oGQ+ahuApvt2wLqKsFXQEoh1Vo+VtB3LF2xe3hysRtIn8kgm43ILaCNJA2JsvrffakoUbOliOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ozjuKy7A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ozjuKy7A"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HCTBnD005637;
	Mon, 17 Mar 2025 13:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tcvQJTduYTRI0qKX+rTAvzhuwsPYIW
	7hEoY+w2AJkVk=; b=ozjuKy7ARgq6tfoYKsfi1ThwoGIwDU1S5stWDJuMcb7NYc
	ijsCQgHH/EbA/pxVejmIgKY2FDFb2vIIaCd5G4VtIIPhYptZdABi0GtgVPakrLSf
	wNn492pyOlsZNeCLrmu7ei5Gw3k4V1qt8Vsw32+JUduIfTbITE77f2tQJL9P8soF
	29wfq0XZYl94JmDYDdqY4oYAeveLvA4khRYE3XJ/B657ftVrfGirW2WXjT/zzy/K
	xn8ExMBx0KBUFP7WERPJKIxgnXqy0AE2xo8ZwswEiv16WIPPJehEJxsjYcIZJ6lg
	A8p9MB2vEwqn/0PaaEzUtMJFNDSSFP7w0Q6sxYWA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5tpbjjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:22:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HCwxKt024471;
	Mon, 17 Mar 2025 13:22:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dnckx7hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:22:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HDMLrI20119816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 13:22:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D6E02004B;
	Mon, 17 Mar 2025 13:22:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18B9C20049;
	Mon, 17 Mar 2025 13:22:21 +0000 (GMT)
Received: from osiris (unknown [9.179.24.138])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Mar 2025 13:22:21 +0000 (GMT)
Date: Mon, 17 Mar 2025 14:22:19 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, gor@linux.ibm.com, kees@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, svens@linux.ibm.com,
        thomas.weissschuh@linutronix.de
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
Message-ID: <20250317132219.21754Dd0-hca@linux.ibm.com>
References: <20250313000623.3192896-1-jeffxu@google.com>
 <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i1APNBDMbrZs1G2IEUkTX93hNZUzs9VX
X-Proofpoint-ORIG-GUID: i1APNBDMbrZs1G2IEUkTX93hNZUzs9VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=765 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170095

On Thu, Mar 13, 2025 at 03:25:46PM -0700, Jeff Xu wrote:
> > > diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > > new file mode 100644
> > > index 000000000000..8db637254de9
> > > --- /dev/null
> > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > > @@ -0,0 +1,30 @@
> > > +#
> > > +# Feature name:          mseal-system-mappings
> > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > +#         description:   arch supports mseal system mappings
> > > +#
...
> > I mean fine, but why not in the existing mseal documentation file where you
> > already document system mappings?
> >
> you mean adding s390 in the mseal.rst ? I thought Heiko was going to
> add that ? [1], maybe not ?
> 
> From the example given by Heiko [1] , arch-support.txt is the official
> way of documenting arch specific support. But adding these info in
> mseal.rst won't hurt.
> 
> > Anyway yeah, let's move that over there please.
> 
> I'm looking at Heiko's direction first to see if mseal.rst will be
> updated as part of the s390 patch, technically that belongs to Heiko's
> patch series. I can also add that if Heiko doesn't care :-)

Just sent a patch which does that. Sorry for the delay - I was offline
for a couple of days.
