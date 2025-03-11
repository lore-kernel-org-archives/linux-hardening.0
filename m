Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D961CD215;
	Tue, 11 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702021; cv=none; b=B6E9hc7nJmLvbNB4z6GeBUtcNVRrZx5sppAOWSp8Izc5I6w/PfHp17xRO8t0G0nP0GynUrPV//9m1KK26Vl92fjJ1VDSdADMpt8fuRxBhplnlg1tzBGuKiHCV8UU23lYa+zXtqITyD1+hz1lQPN+fl6lpeuuttGB8hwDhg1YAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702021; c=relaxed/simple;
	bh=b3D6rfSf4OXQDFRcpN32gyl8m6lS/+ZaLNjercmCQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSsn/JSXZwkWn/kymTih99Qi1p5mTI+Fm0Gzy3L5RfcXPtOziYnBm2npLTBnWo7ijCtbXfcK0Ef+MpbnXcxoJJYjMnv5lh70g0O/x4M69YeCpH88zsjSuG3d024GKij3pLHE95SqgvI/JYSn7rwuErT1T7G4AdKTogtL/KDK2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UOyj8i5s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UOyj8i5s"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7wI3P002107;
	Tue, 11 Mar 2025 14:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5W8z3U+N4BjAA+H86UEnGNKa+ovXio
	HYCGiGvZFiJG0=; b=UOyj8i5s4s50CZX8khMAhnHPHL9WdZNHgSX3MIc5fBSIQR
	dugtHhElFxj3qqjObRbIkmhkfE4rt4XDJKcl3+QeNzc6Re89Dpyt6/wK0irFuOId
	j4NjUld8ET7KAFfsnG6i7+ERcV30WgIxgrpGHcKJR2p3MPtAMGLCKR9xAFM9Px/H
	MfOmlfgQ4N1PmMlT5EHL4YuowT97XXE/daVy3vS0Po2swCsOhKaThYkFLlm8cdaw
	4aTd/52s+7yFguBqib7B2G/pItbarsns4rDPYXq10A9le/Ym/WvFBLiQjqfCvES0
	L1PdRN/lBNvDIVkYoEzlMQq27pJr69P9Uyt0fgBw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7g5v87f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:06:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCViwt024087;
	Tue, 11 Mar 2025 14:06:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyvp9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:06:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BE6Wf252953416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:06:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530FB20043;
	Tue, 11 Mar 2025 14:06:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C652004B;
	Tue, 11 Mar 2025 14:06:31 +0000 (GMT)
Received: from osiris (unknown [9.179.21.35])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 14:06:31 +0000 (GMT)
Date: Tue, 11 Mar 2025 15:06:30 +0100
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
Message-ID: <20250311140630.12846Eef-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
 <20250311133736.12846D42-hca@linux.ibm.com>
 <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4S0zIuxNoDUzIcyMCnnFiJt06R98PYVr
X-Proofpoint-ORIG-GUID: 4S0zIuxNoDUzIcyMCnnFiJt06R98PYVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=950 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110089

On Tue, Mar 11, 2025 at 01:42:01PM +0000, Lorenzo Stoakes wrote:
> > Just like for arm64, and x86_64 the s390 part is just adding the new
> > vm flag to the _install_mappings() call in vdso code. Otherwise there
> > is nothing to be considered.
> 
> No, they are not just adding a flag, they are enabling the sealing of
> system mappings, if a user chooses to make use of it, which already breaks
> a number of useland applications that rely on remapping these.
> 
> if the architecture code ever needs to unmap/remap these, then this breaks
> your architecture.
> 
> I think it would be sensible to clearly indicate that enabling this feature
> does not break the s390 architecture and you've confirmed that by checking
> the code and ensuring that nowhere does it rely upon doing this.
> 
> Likely that's the case, but I'd suggest you ought to make sure...
> 
> x86-64 and arm64 were checked for this and confirmed to not ever need this.
> 
> This is why we're restricting by architecture.

Ok, I was assuming more that whoever enables that config option knows
what he or she is doing. However as far as I know there is no s390
user space which relies on remapping vdso mappings.

When it comes to unmapping vdso: this would break user space since
commit df29a7440c4b ("s390/signal: switch to using vdso for sigreturn
and syscall restart") - there haven't been any reports.
