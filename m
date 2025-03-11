Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28B78F5D;
	Tue, 11 Mar 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700276; cv=none; b=Px8+dC+vInRxX91KLFYgVFLsuX+26zMN5+PNt+LDBu+VU/DNxtCAjCZ4QOR4C85GIQyX1pXjvxeeKtS3rQalryMoqFmFloiFrQPCHkojzkQr7t0yHCUzplP2dXE0R4zo/Bb4cmBFZHje2T+FZEQ8FR6EVtqcdS9gY7dOReAYEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700276; c=relaxed/simple;
	bh=vMtFSGIfzr6HiyZrNZ57TvdsNiX98vzFydxHX92eMyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtYQQrfF4+261kybJ3CjRndszSIsV0nzr2ogD5XU8ymqDa8uqALlodyvEqhRfnjJ/sfPKg8tIATcJbrL43AmDbMDmbAW1N06GSccF5O+k9ibnDLI0W5QfIjN8Z8mjs7xBFkMo6dEnOpp6NWe6zzZwuQ52NeEGgTK8OJQsHorPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PvaCAfVG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PvaCAfVG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9O9BJ026567;
	Tue, 11 Mar 2025 13:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JJMEVRMgBysG/rCdU5xkas/lYQi1X1
	Or+Niq8x80GmQ=; b=PvaCAfVGCIetcTtPsGzyClf2gkop1ZbF8debTPYGGmoCa/
	zE3CFkUWcEWZqMKckJ66vWFVxBkGV490JtjrbA6mR0zg2TznGxRSMn31K304Lxmy
	/22kc//XQzcPDKa4xrq7hYQQCImktbO/c05jqTGSHpkRDBGDjRM6vrYS7JxURmY7
	iJRXOmYyGgCUDyC+AkSRhNLdlpnYPxYft6pHStMEdG0Y/y2dWEnnyaFlF2G841wW
	W9asmSZ7csJRoGyrMKNuLGakc6Xf/BRgSi0UoZsA3BT3/rsias/Tu516Kb0c7NRW
	MSHR66chT8+yJGgF0xcI16hrnlkrslFH7U+nz90Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7a1c4ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:37:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCBJrY006957;
	Tue, 11 Mar 2025 13:37:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907t4m2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:37:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BDbcEp50659614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:37:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CFAC20043;
	Tue, 11 Mar 2025 13:37:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACE520040;
	Tue, 11 Mar 2025 13:37:37 +0000 (GMT)
Received: from osiris (unknown [9.179.21.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 13:37:37 +0000 (GMT)
Date: Tue, 11 Mar 2025 14:37:36 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 0/2] mseal system mappings fix + s390
 enablement
Message-ID: <20250311133736.12846D42-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZhUvvsniQwUCumfJ9wijChu1grlkgigb
X-Proofpoint-GUID: ZhUvvsniQwUCumfJ9wijChu1grlkgigb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=181 malwarescore=0
 clxscore=1015 mlxscore=2 impostorscore=0 bulkscore=0 spamscore=2
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503110086

On Tue, Mar 11, 2025 at 01:02:47PM +0000, Lorenzo Stoakes wrote:
> On Tue, Mar 11, 2025 at 01:33:24PM +0100, Heiko Carstens wrote:
> > When rebasing the mseal series on top of the generic vdso data storage
> > the VM_SEALED_SYSMAP vm flag for the vvar mapping got lost. Add that again.
> 
> I'm confused by this? Some merge patch resolution thing?

See my other mail.

> > Also add s390 support for MSEAL_SYSTEM_MAPPINGS.
> 
> 'Also' = the whole thing this series does?
> 
> Can you confirm that s390 absolutely does not rely upon
> moving/manipulating/etc. the VDSO, VVAR, etc. mappings?
> 
> You should say that here.

Just like for arm64, and x86_64 the s390 part is just adding the new
vm flag to the _install_mappings() call in vdso code. Otherwise there
is nothing to be considered.
