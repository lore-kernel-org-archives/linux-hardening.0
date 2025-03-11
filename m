Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AE5680;
	Tue, 11 Mar 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700148; cv=none; b=s2U9jjzjz/2feMlpl8u9Npc37MG8H1Ct0gXIKwi1OY4dvGDMXWT7zaSxfjeq8h+sVxJqCpiN+QNTUUM3dLDg9+57Q6XF20S7IVqisvPhoE30VosHkoGCf7TTZsHp2FjVvjJkwu49HKh/BFtiv2U3rwrpK9Cl8j4mYF7KamoyEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700148; c=relaxed/simple;
	bh=GkcFE4LozpHKFxYYuNtMXyCbGTtq8p5Q/ljO4LAzDCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGfs9+qy7sBiXInSvkzuisZoHBsQ7mNawd+InengS0kZPlj+DkpdAb5mtQaIbrqR3vxmRAe1TdVpx03eLp3SWbJlNyEntGO9Bp3Oo79e8AF1dsjMMU02i7S9gZQTMKfmoKvwfuF1SnMvhht1ACBoFcPi/LNhi+ZCkMROFDg3kSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rO1cdg6t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rO1cdg6t"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7uSBG016551;
	Tue, 11 Mar 2025 13:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mr7/vg
	z6z9VChc4A6lC4P1SOGCYwupdTeYiYt187Y5A=; b=rO1cdg6t//szdZtK+tdw9o
	zrj/rQIPH/AKdyRI6rd7Aj71nfGhZ/Rq+T5zfiw98E0XAz+26jxep3aYqtC0MjKv
	+3ZDKEWuFgA6HUp8OcV7QiMlRG6hkFxFmrTZcdx2+ClUt0MW+35uUV91iZrTB4un
	3EoCbVsg6/SjCNcqfuQBkafwr53A1H1WOMt31IIq+dZLhnyo29RdQ8lDL1JTafqn
	mhn1DVYxFq5IijxR6QQYDQKgWPCZ0sVMLeBZBbcPSLAj/R6XyC+dtcnnarA4/eRq
	75D+FZKUmnnrxIRSiYQMMsof1KQjz40VSaYC7vxyluA+Iub8RI2BJVZdXDCH3rig
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp6c9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:33:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BAgfLe014460;
	Tue, 11 Mar 2025 13:33:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ekc40r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:33:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BDX1ds41419254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:33:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC1C420043;
	Tue, 11 Mar 2025 13:33:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E25020040;
	Tue, 11 Mar 2025 13:33:00 +0000 (GMT)
Received: from osiris (unknown [9.179.21.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 13:33:00 +0000 (GMT)
Date: Tue, 11 Mar 2025 14:32:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/2] mseal sysmap: generic vdso vvar mapping
Message-ID: <20250311133258.12846C3b-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <20250311123326.2686682-2-hca@linux.ibm.com>
 <20250311135542-574f3a8a-525f-4e84-9f04-c9d1ded0deef@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311135542-574f3a8a-525f-4e84-9f04-c9d1ded0deef@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SmyYxSi9cZdoEJKUXlm4nWhXpj0cG8wx
X-Proofpoint-ORIG-GUID: SmyYxSi9cZdoEJKUXlm4nWhXpj0cG8wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=470 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110086

On Tue, Mar 11, 2025 at 01:59:21PM +0100, Thomas Weißschuh wrote:
> Hi Heiko,
> 
> On Tue, Mar 11, 2025 at 01:33:25PM +0100, Heiko Carstens wrote:
> > With the introduction of the generic vdso data storage the VM_SEALED_SYSMAP
> > vm flag must be moved from the architecture specific
> > _install_special_mapping() call [1] [2] which maps the vvar mapping to
> > generic code.
> 
> I think this change should be part of the merge commit between the
> trees carrying the generic vdso data storage and mseal for system mappings.
> 
> https://lore.kernel.org/lkml/20250307151426.5f3c0c39@canb.auug.org.au/
> https://lore.kernel.org/lkml/20250311150847.5a63db36@canb.auug.org.au/

Yes, but Andrew added your patches into his tree and on top of that
the mseal patches:
https://lore.kernel.org/all/20250306235802.ff0f406acd0117bcfe927082@linux-foundation.org/
https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-unstable

When doing that the vvar bits got lost. I don't know what Andrew's
plans for the merge window are, but right now there is no merge commit
which could be fixed.
