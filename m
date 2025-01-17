Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FD1FBE83;
	Fri, 17 Jan 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108922; cv=none; b=D9I4ImsN4Zzy8SL18zRlFRDwX1l+izB+O/A1//t/utuDOd5iXM6HvXHs0JJoBKw4AiT4Pm9MnKlu65STY9SlN9LCIam+17MoP7UvYFn0jzAaNjcYhdYjwBb4pWu6PmIGiLJRAKIE0BCW+Taq+dw3Z/3xDp4iGax3ly7M5q9LTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108922; c=relaxed/simple;
	bh=Xq1vfM1Dw7b5vPzAwTmlPIm82xcnU+h+rpbiF67cYSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4TMsO/TF9ji/lUYTe+lRlbZRt5QPc4WS5EZVWbFNnuC3qPUrIv9M/0CxUaGoc8XlHCiB63LNpmNZxbv0MRg327T/jjZjpQJ+b7GZ8KH5d5zbgiex9EerRJUseOrYLQhtApj70YVvpKv9npMHirMgHAYzRbj4+/F7jnqoQMkEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKOeGeGb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKOeGeGb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H85Zt6000477;
	Fri, 17 Jan 2025 10:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YMl2uammyGUZkli6LdYmcx3aBVbe0l
	XDhS5waMtFoDg=; b=qKOeGeGbxRzXlPjOVD3g8SuBuS3JX1t//g2Nq+wV/9Y0NM
	wVWEoBhc2GwulXrMvRpXoU9hoiiee+gk/MlSemaLuDWQSPh24YPIFqSNh+gmvUq+
	zrmzDjWdVYIXNmkt6H95GtwEVMBgnab3cXCO7guUhzv/4QBcuzgXMOpSpzV9brtg
	WGjoMMO+yskRkWzQjuUNg4bbpIYx1MItXyvbD5IBF06RGCsCsfkRhOg7v0eI1Le+
	Fy+Uxxmcd81rVVgrmG0RyEofGhQOaHNh1xUyhWN+F9eEF6k74RrSH/gReiW9QndZ
	HTVRbBZlAOs9B5AYZkHMVLzT8vdlBRYDVWPWkdtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3gjgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 10:14:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HA1aNF004031;
	Fri, 17 Jan 2025 10:14:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3gjg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 10:14:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7LdD5001110;
	Fri, 17 Jan 2025 10:14:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456ka5hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 10:14:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HAEWqj55837154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 10:14:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5DA201E1;
	Fri, 17 Jan 2025 10:14:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC236201E0;
	Fri, 17 Jan 2025 10:14:29 +0000 (GMT)
Received: from osiris (unknown [9.171.15.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jan 2025 10:14:29 +0000 (GMT)
Date: Fri, 17 Jan 2025 11:14:28 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
        jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
        peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
        dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
        Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au,
        Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <20250117101428.10714-A-hca@linux.ibm.com>
References: <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <202501151538.3E757401@keescook>
 <20250116052655.GA23894@lst.de>
 <202501161137.D76EE5CEC@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501161137.D76EE5CEC@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T7TjX-CnkmH_6KmMNkt-BPQvC-whKsbo
X-Proofpoint-GUID: AklqSMAcI8Nb8_dMc2O0gIEz8uWLGDpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=862
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170079

Hi Kees,

On Thu, Jan 16, 2025 at 11:40:37AM -0800, Kees Cook wrote:
> On Thu, Jan 16, 2025 at 06:26:55AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 15, 2025 at 03:52:23PM -0800, Kees Cook wrote:
> > > > You seem to be saying you're pushing an internal feature on upstream and
> > > > only care about internal use cases, this is not how upstream works, as
> > > > Matthew alludes to.
> > > 
> > > Internal? No. Chrome OS and Android. Linux runs more Android devices
> > > than everything else in the world combined -- this is not some random
> > > experiment.
> > 
> > All of which are tightly controlled by Google and not actually open
> > to users.  Which doesn't say they don't matter, but they matter a
> > lot less than fetures widely useful to the open not locked down
> > userbase of classic Linux.
> 
> I get your point. Though in my proposal it would be available to anyone
> without CRIU too, which is, for example, defconfig builds (excepting
> s390 and riscv).

Just looking from time to time into this discussion, so I didn't
follow everything. What makes s390 and riscv special here?
