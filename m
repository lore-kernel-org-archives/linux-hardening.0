Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD112505CA;
	Wed, 12 Mar 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794015; cv=none; b=KORVgvv2B61as7zdIiy4qy07jM7tb/CrjKkdcrGkUc/0S1eGGPLNuuU6uR1BIhZWedzQ+hCEs/xCdO5X0EgCYwVtKAuRvTc0LdVgWr8Yqvf7dLki0x9Wl0Q0gwxsdjz4xeaF4M1UBs+ZiaUUu6jFcOAl7ZeS5eoYu12RgTzgu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794015; c=relaxed/simple;
	bh=uWMXUuJdjNFPcXgYW0FLnqKEeb9+smRa/7n//Bl3ARk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEJihNvJ0tHtAgywUxjSZ8gE/sRukrm+AxSOaj92pg9Dm/BzVZgw6Xd8/IDJG+22ddo6qO34NtxNONNoUVTK5Gqhu2mmkhxNa9pGKXygJfZUeQ+zLtBRKUOqfGcc0CB6Zo1AT03/3S0Ai/yQhz/vPNDCpmYNAKK0uHXOR+Y5cBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6osIvGd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6osIvGd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE3Q2I023238;
	Wed, 12 Mar 2025 15:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VZ7ifWZBuEZlwJ/gbqhjVZwDwvUPlj
	6sC7oEJEnDm38=; b=P6osIvGdcWpwVdGfgcvVsgKATzdWsJwpWY+Z+PSX1vJONV
	ffzqYd+Nn5oJ5OMJ67+vcrS23fmguQdljpqe6i5W3KT9UuxleXXAkEx3CTFfOBjj
	qFAyBZh7hPN7BJHc76QdQbX2z1sTTHTyOGCc86C/nC1Kt/V6txweDrJJGq6nHgYF
	y4JVRNR+m+OwVm/EAEiBSkafAR4dmg81qT3ID3bJXg+reICncEUuwCK+7/Ep62fy
	wfXwdsihAfbKynCu/h2qt/0Wx4Aht3jGG6aPVDK7Sh0VvZzbszCtXeH79JNMzrDj
	jc1f8/QE2EIq2LPC7ctrAlQiIMann+8CXjmAbYKA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbpprhjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:39:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE1frV007468;
	Wed, 12 Mar 2025 15:39:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr4tmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:39:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFdmas18219500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:39:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C0962004D;
	Wed, 12 Mar 2025 15:39:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C287120040;
	Wed, 12 Mar 2025 15:39:47 +0000 (GMT)
Received: from osiris (unknown [9.171.49.190])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Mar 2025 15:39:47 +0000 (GMT)
Date: Wed, 12 Mar 2025 16:39:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
Message-ID: <20250312153946.10610B02-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <20250311123326.2686682-3-hca@linux.ibm.com>
 <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
 <CABi2SkXzqJ10NW3j1y-FtmrheDkqzL5QgMcN9UN6UvhbXFHCuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkXzqJ10NW3j1y-FtmrheDkqzL5QgMcN9UN6UvhbXFHCuQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iThVHiUBlsCRTPEGkrdgIkFIkJsnOiAK
X-Proofpoint-GUID: iThVHiUBlsCRTPEGkrdgIkFIkJsnOiAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=507 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120105

On Tue, Mar 11, 2025 at 03:12:55PM -0700, Jeff Xu wrote:
> One more thing: do you want to update mseal.rst to add s390 as
> supported architecture?
> 
> Currently in the mseal.rst:
>  "The following architectures currently support this feature: x86-64 and arm64."

Thanks, I missed that, however I'm wondering if it would make sense to add
mseal to the generic feature list instead (no, I am not volunteering to do
that :) ).

See Documentation/features/... and scripts/get_feat.pl
