Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA619AA63;
	Tue, 11 Mar 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702897; cv=none; b=DHusyeplxhpbFEvfar/S4w9hCVxBLyp2WhfScpnyPLKp4gpsTXzPLBd3EH+ko+G4OUwAksYjvMCHLsmU3YM2ozyBMUJwdcQI0p9W4fer9BjZyQlN88uLNLH2VlIXUwLoygs+0AuBEJn182VPGtHDGq3pJ1a3rdp7YX2fm6QeYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702897; c=relaxed/simple;
	bh=3vu7/r9ZYXOnDQESpVnU4+c7VBGcFNQK+fIZJP7zUiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r52bsa1eQgoFg7PkCsqxZZB5Fza6F9KE9vj1+Qt4rWr2rDTbSqL9G+LVL7prHAcq9bif/lWN+MdZivmXTf1dF4X64yVQp++wSA2bS5J4KO2Brlu5+VqCQllQ0fM12jUOBbSLxfKh5kVNHYib1AL5XMppBXfYANAPkb9WP4G0i3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NS87e9Hu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NS87e9Hu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9hkle004865;
	Tue, 11 Mar 2025 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yxH128XxdZ/UKwOSclHlGQO4gSIsVn
	fgWzByxlVyMf0=; b=NS87e9Hu8S1dudL3FeZjVokuekhEcaaAKhtjIytQZsX4F/
	5KZAiiY/anko8RpU70NsY2ox5/hRNfo5Zl3Pfs0guQcNXJJOI+q1sNdyXMKSJpSf
	Ae+bl1D2GXveHHvGeP3sXo3jDvA1ZSKEj0DcJMdkeWfztAj6oQBkOfM5AZ0K8QHM
	KQ9KYPTfgUHUFt4RjR3hjWkUNhtLkZoj/Y8NVw3CCdZj7XwcdtZyEamJUi+LudeH
	TbkpJCv9rIwPrc+6Zl09K1Im1EEh+bO/yswpqeL5P0SpTJPV/64JQlcBb+qPeuTk
	7olSazADFuPLgP0apwzxX1MDMxUplX5f1z+RuEBQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qve48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:21:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDSQum027631;
	Tue, 11 Mar 2025 14:21:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkmhaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:21:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BELG9V22544774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:21:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9C820040;
	Tue, 11 Mar 2025 14:21:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4227E20043;
	Tue, 11 Mar 2025 14:21:16 +0000 (GMT)
Received: from osiris (unknown [9.179.21.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 14:21:16 +0000 (GMT)
Date: Tue, 11 Mar 2025 15:21:14 +0100
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
Message-ID: <20250311142114.12846Fd5-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
 <20250311133736.12846D42-hca@linux.ibm.com>
 <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
 <20250311140630.12846Eef-hca@linux.ibm.com>
 <6f106b28-7d5e-468f-8a94-e94357a950ee@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f106b28-7d5e-468f-8a94-e94357a950ee@lucifer.local>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MUlHuszvREW12eXE0On2tzLrxcgpdf3Y
X-Proofpoint-ORIG-GUID: MUlHuszvREW12eXE0On2tzLrxcgpdf3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=550 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110089

On Tue, Mar 11, 2025 at 02:09:30PM +0000, Lorenzo Stoakes wrote:
> > When it comes to unmapping vdso: this would break user space since
> > commit df29a7440c4b ("s390/signal: switch to using vdso for sigreturn
> > and syscall restart") - there haven't been any reports.
> 
> OK that seems to implicitly suggest that you're fine with sealing then?
> 
> I had a quick glance and it seemed fine for s390. I mean it's _weird_ to remap
> any of this stuff so it'd be the odd one out that does it (ppc _seems_ to in
> _some_ circumstances need it, for instance).
> 
> So I think we're good? :)

Yes, for s390 we are good.
